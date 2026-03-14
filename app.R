library(shiny)
library(bslib)
library(dplyr)
library(ggplot2)
library(DT)
library(readr)
library(scales)

# ---- Data ----------------------------------------------------------------

diet_df <- read_csv("data/cleaned_price_of_healthy_diet.csv", show_col_types = FALSE)

regions   <- c("All", sort(unique(na.omit(diet_df$region))))
years     <- sort(unique(diet_df$year))
cost_cats <- c("All", sort(unique(na.omit(diet_df$cost_category))))

region_colors <- c(
  "Africa"        = "#C0392B",
  "Americas"      = "#2471A3",
  "Asia"          = "#D4860A",
  "Europe"        = "#1A3A6B",
  "North America" = "#1E8BC3",
  "Oceania"       = "#E67E22",
  "South America" = "#17A589"
)

# ---- UI ------------------------------------------------------------------

ui <- page_sidebar(
  title = "Global Cost of a Healthy Diet",
  theme = bs_theme(
    version   = 5,
    bootswatch = "flatly",
    base_font  = font_google("Inter")
  ),

  sidebar = sidebar(
    width = 240,

    sliderInput(
      "year_range", "Year Range",
      min   = min(years),
      max   = max(years),
      value = c(min(years), max(years)),
      sep   = "",
      step  = 1
    ),

    selectInput(
      "region", "Region",
      choices  = regions,
      selected = "All"
    ),

    selectInput(
      "cost_cat", "Cost Category",
      choices  = cost_cats,
      selected = "All"
    ),

    hr(),
    actionButton(
      "reset", "Reset Filters",
      class = "btn-outline-danger btn-sm w-100"
    ),
    p(
      "PPP-adjusted USD. Source: FAO / World Bank.",
      style = "font-size:11px; color:#94a3b8; margin-top:10px; line-height:1.5;"
    )
  ),

  # KPI value boxes
  layout_columns(
    value_box(
      title = "Countries",
      value = textOutput("n_countries"),
      theme = "primary"
    ),
    value_box(
      title = "Avg Cost / Day",
      value = textOutput("avg_cost"),
      theme = "info"
    ),
    value_box(
      title = "Min Cost / Day",
      value = textOutput("min_cost"),
      theme = "success"
    ),
    value_box(
      title = "Max Cost / Day",
      value = textOutput("max_cost"),
      theme = "warning"
    ),
    col_widths = c(3, 3, 3, 3)
  ),

  # Charts row
  layout_columns(
    card(
      card_header("Average Cost by Region (USD/day)"),
      plotOutput("bar_chart", height = "300px")
    ),
    card(
      card_header("Average Cost Over Time by Region"),
      plotOutput("trend_chart", height = "300px")
    ),
    col_widths = c(6, 6)
  ),

  # Data table
  card(
    card_header("Filtered Data"),
    DTOutput("data_table")
  )
)

# ---- Server --------------------------------------------------------------

server <- function(input, output, session) {

  # Reactive calc: the filtered dataset that drives all outputs
  filtered <- reactive({
    df <- diet_df |>
      filter(
        year >= input$year_range[1],
        year <= input$year_range[2]
      )

    if (input$region != "All") {
      df <- df |> filter(region == input$region)
    }

    if (input$cost_cat != "All") {
      df <- df |> filter(cost_category == input$cost_cat)
    }

    df
  })

  # Reset all filters back to defaults
  observeEvent(input$reset, {
    updateSliderInput(session, "year_range", value = c(min(years), max(years)))
    updateSelectInput(session, "region",   selected = "All")
    updateSelectInput(session, "cost_cat", selected = "All")
  })

  # KPI: number of unique countries
  output$n_countries <- renderText({
    format(length(unique(filtered()$country)), big.mark = ",")
  })

  # KPI: average cost per day
  output$avg_cost <- renderText({
    m <- mean(filtered()$cost_healthy_diet_ppp_usd, na.rm = TRUE)
    if (is.nan(m)) return("N/A")
    paste0("$", round(m, 2))
  })

  # KPI: minimum cost per day
  output$min_cost <- renderText({
    m <- min(filtered()$cost_healthy_diet_ppp_usd, na.rm = TRUE)
    if (is.infinite(m)) return("N/A")
    paste0("$", round(m, 2))
  })

  # KPI: maximum cost per day
  output$max_cost <- renderText({
    m <- max(filtered()$cost_healthy_diet_ppp_usd, na.rm = TRUE)
    if (is.infinite(m)) return("N/A")
    paste0("$", round(m, 2))
  })

  # Output 1: Bar chart of average cost by region
  output$bar_chart <- renderPlot({
    df <- filtered()

    if (nrow(df) == 0) {
      return(
        ggplot() +
          annotate("text", x = 0.5, y = 0.5, label = "No data for current filters.",
                   color = "#94a3b8", size = 5) +
          theme_void()
      )
    }

    agg <- df |>
      group_by(region) |>
      summarise(
        avg_cost = mean(cost_healthy_diet_ppp_usd, na.rm = TRUE),
        .groups  = "drop"
      ) |>
      arrange(avg_cost)

    ggplot(agg, aes(x = reorder(region, avg_cost), y = avg_cost, fill = region)) +
      geom_col(width = 0.65, show.legend = FALSE) +
      geom_text(
        aes(label = paste0("$", round(avg_cost, 2))),
        hjust  = -0.12,
        size   = 3.6,
        color  = "#2d3748",
        fontface = "bold"
      ) +
      scale_fill_manual(values = region_colors, na.value = "#adb5bd") +
      scale_y_continuous(
        labels = dollar_format(),
        expand = expansion(mult = c(0, 0.18))
      ) +
      coord_flip() +
      labs(x = NULL, y = "Average Cost (USD/day)") +
      theme_minimal(base_size = 12) +
      theme(
        panel.grid.major.y = element_blank(),
        panel.grid.minor   = element_blank(),
        axis.text          = element_text(color = "#4a5568"),
        axis.title.x       = element_text(color = "#718096", size = 11),
        plot.background    = element_rect(fill = "white", color = NA)
      )
  })

  # Output 2: Line trend chart of average cost over time, grouped by region
  output$trend_chart <- renderPlot({
    df <- filtered()

    if (nrow(df) == 0) {
      return(
        ggplot() +
          annotate("text", x = 0.5, y = 0.5, label = "No data for current filters.",
                   color = "#94a3b8", size = 5) +
          theme_void()
      )
    }

    trend <- df |>
      group_by(year, region) |>
      summarise(
        avg_cost = mean(cost_healthy_diet_ppp_usd, na.rm = TRUE),
        .groups  = "drop"
      )

    ggplot(trend, aes(x = year, y = avg_cost, color = region, group = region)) +
      geom_line(linewidth = 1.1) +
      geom_point(size = 2.2) +
      scale_color_manual(values = region_colors, na.value = "#adb5bd") +
      scale_y_continuous(labels = dollar_format()) +
      scale_x_continuous(breaks = years) +
      labs(x = "Year", y = "Average Cost (USD/day)", color = "Region") +
      theme_minimal(base_size = 12) +
      theme(
        axis.text.x     = element_text(angle = 35, hjust = 1, color = "#4a5568"),
        axis.text.y     = element_text(color = "#4a5568"),
        axis.title      = element_text(color = "#718096", size = 11),
        legend.position = "right",
        legend.text     = element_text(size = 10),
        panel.grid.minor = element_blank(),
        plot.background  = element_rect(fill = "white", color = NA)
      )
  })

  # Output 3: Interactive data table
  output$data_table <- renderDT({
    df <- filtered() |>
      select(country, region, year, cost_healthy_diet_ppp_usd, cost_category) |>
      rename(
        Country          = country,
        Region           = region,
        Year             = year,
        "Cost (USD/day)" = cost_healthy_diet_ppp_usd,
        "Cost Category"  = cost_category
      )

    datatable(
      df,
      options  = list(pageLength = 10, scrollX = TRUE, autoWidth = TRUE),
      rownames = FALSE,
      class    = "stripe hover"
    ) |>
      formatCurrency(columns = "Cost (USD/day)", currency = "$", digits = 2)
  })
}

shinyApp(ui, server)
