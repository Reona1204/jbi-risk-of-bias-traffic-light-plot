library(tidyverse)
rob_dat <- tribble(
  ~Study, ~`Selection bias`, ~`Measurement bias`, ~`Confounding and temporality`, ~`Missing data`, ~`Reporting bias`, ~`Overall risk`,
  "Bakker et al. (2016)", "Moderate", "Low", "High", "Moderate", "Low", "High",
  "Tims et al. (2015)", "Moderate", "Low", "Moderate", "Moderate", "Low", "Moderate",
  "Petrou et al. (2012)", "Moderate", "Low", "Moderate", "Moderate", "Low", "Moderate",
  "Dubbelt et al. (2019)", "High", "Moderate", "High", "Moderate", "Low", "High",
  "Tims et al. (2013)", "Moderate", "Moderate", "Moderate", "Moderate", "Low", "Moderate",
  "Bakker et al. (2012)", "Moderate", "Low", "High", "Moderate", "Low", "High",
  "Moreira et al. (2022)", "Moderate", "Low", "High", "Moderate", "Low", "High",
  "De Beer et al. (2016)", "Moderate", "Moderate", "High", "Moderate", "Low", "High",
  "Petrou et al. (2018)", "Moderate", "Low", "Moderate", "Moderate", "Low", "Moderate",
  "Muttar et al. (2024)", "Moderate", "Moderate", "High", "Low", "Low", "High",
  "Sakuraya et al. (2017)", "Moderate", "Low", "High", "Low", "Low", "Moderate"
)
rob_long <- rob_dat %>%
  pivot_longer(
    cols = -Study,
    names_to = "Domain",
    values_to = "Risk"
  )
study_order <- rev(c(
  "Bakker et al. (2016)",
  "Tims et al. (2015)",
  "Petrou et al. (2012)",
  "Dubbelt et al. (2019)",
  "Tims et al. (2013)",
  "Bakker et al. (2012)",
  "Moreira et al. (2022)",
  "De Beer et al. (2016)",
  "Petrou et al. (2018)",
  "Muttar et al. (2024)",
  "Sakuraya et al. (2017)"
))
rob_long <- rob_long %>%
  mutate(
    Study = factor(Study, levels = study_order),
    Domain = factor(
      Domain,
      levels = c(
        "Selection bias",
        "Measurement bias",
        "Confounding and temporality",
        "Missing data",
        "Reporting bias",
        "Overall risk"
      )
    ),
    Risk = factor(Risk, levels = c("Low", "Moderate", "High")),
    Symbol = case_when(
      Risk == "Low" ~ "+",
      Risk == "Moderate" ~ "–",
      Risk == "High" ~ "×"
    ),
    x = c(1, 2, 3, 4, 5, 6)[as.numeric(Domain)],
    y = as.numeric(Study)
  )
risk_colors <- c(
  "Low" = "#93C5A1",
  "Moderate" = "#EFD47A",
  "High" = "#D98C8C"
)
rob_long <- rob_long %>%
  mutate(x_plot = x + 0.8)

top_header <- tibble(
  x = c(1, 2, 3, 4, 5, 6) + 0.8,
  y = 11.75,
  label = c("D1", "D2", "D3", "D4", "D5", "Overall")
)

left_header <- tibble(
  x = -0.25,
  y = 1:11,
  label = study_order
)

legend_df <- tibble(
  x = c(9.15, 9.15, 9.15),
  y = c(6.4, 5.75, 5.1),
  Risk = factor(c("Low", "Moderate", "High"), levels = c("Low", "Moderate", "High")),
  Symbol = c("+", "–", "×"),
  Label = c("Low", "Moderate", "High")
)

domain_note <- tibble(
  x = -0.95,
  y = c(0.10, -0.22, -0.54, -0.86, -1.18, -1.50),
  label = c(
    "Domains:",
    "D1: Selection bias",
    "D2: Measurement bias",
    "D3: Confounding and temporality",
    "D4: Missing data",
    "D5: Reporting bias"
  ),
  face = c("bold", "plain", "plain", "plain", "plain", "plain")
)
p <- ggplot() +
  # Main white cells
  geom_tile(
    data = rob_long,
    aes(x = x_plot, y = y),
    fill = "white",
    color = "#CFCFCF",
    linewidth = 0.8,
    width = 0.98,
    height = 0.98
  ) +
  # Colored circles
  geom_point(
    data = rob_long,
    aes(x = x_plot, y = y, fill = Risk),
    shape = 21,
    size = 6.4,
    stroke = 0.65,
    color = "#444444"
  ) +
  # Symbols
  geom_text(
    data = rob_long,
    aes(x = x_plot, y = y, label = Symbol),
    size = 4.8,
    fontface = "bold",
    color = "#222222"
  ) +
  # Top gray headers
  geom_tile(
    data = top_header,
    aes(x = x, y = y),
    fill = "#C9C9C9",
    color = "#8C8C8C",
    linewidth = 0.8,
    width = 0.98,
    height = 0.52
  ) +
geom_text(
  data = top_header,
  aes(x = x, y = y, label = label),
  size = 4.2,
  color = "#222222"
) +
  # Left gray study boxes
  geom_tile(
    data = left_header,
    aes(x = x, y = y),
    fill = "#C9C9C9",
    color = "#8C8C8C",
    linewidth = 0.8,
    width = 3.1,
    height = 0.98
  ) +
  geom_text(
    data = left_header,
    aes(x = x, y = y, label = label),
    size = 4.1,
    color = "#222222"
  ) +
  # Top title
  annotate("text", x = 4.3, y = 12.35, label = "Risk of bias", size = 5.2) +
  # Left vertical label
  annotate("text", x = -2.25, y = 6.0, label = "Study", angle = 90, size = 4.8) +
  # Custom legend title
  annotate("text", x = 9.15, y = 7.05, label = "Judgement", hjust = 0, size = 4.7) +
  # Custom legend circles
  geom_point(
    data = legend_df,
    aes(x = x, y = y, fill = Risk),
    shape = 21,
    size = 6.4,
    stroke = 0.65,
    color = "#444444"
  ) +
  geom_text(
    data = legend_df,
    aes(x = x, y = y, label = Symbol),
    size = 4.6,
    fontface = "bold",
    color = "#222222"
  ) +
  geom_text(
    data = legend_df,
    aes(x = x + 0.38, y = y, label = Label),
    hjust = 0,
    size = 4.2,
    color = "black"
  ) +
  # Bottom domain explanation
  geom_text(
    data = domain_note,
    aes(x = x, y = y, label = label, fontface = face),
    inherit.aes = FALSE,
    hjust = 0,
    size = 3.8,
    color = "black"
  ) +
  scale_fill_manual(values = risk_colors, drop = FALSE) +
  coord_cartesian(
    xlim = c(-2.25, 10.6),
    ylim = c(-1.7, 12.45),
    clip = "off"
  ) +
  theme_void() +
  theme(
    legend.position = "none",
    plot.margin = margin(18, 26, 18, 18),
    plot.background = element_rect(fill = "white", colour = NA)
  )

print(p)

