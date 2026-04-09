# Plots TSST Anticipation
# last edited 2026_04_09 by Isabell Int-Veen

rm(list=ls())

# Load packages -----------------------------------------------------------

library(haven)
library(tidyverse)
library(dplyr)
library(tidyr)
library(stringr)
library(cowplot)


# Load data ---------------------------------------------------------------

# setwd("Q:/NAS/Ehlis_Auswertung/Laufwerk_S/AG-Mitglieder/David/Artikel/TSST Anticipation/Auswertung") # set working directory 
dat <- read_sav("2026_01_27_Gesamtdaten_TSSTAnticipation.sav") # read data


# Plot stress -------------------------------------------------------------

# filter participants according to Mahalanobis distances calculated in SPSS 
dat_filtered <- dat %>%
  filter(!(ID %in% c(14, 45, 48, 137, 53, 134, 23)))

dat_long <- dat_filtered %>%
  pivot_longer(
    cols = starts_with("Stress_"),  
    names_to = "Timepoint",         
    values_to = "Stress"            
  ) %>%
  mutate(
    Timepoint = as.numeric(str_extract(Timepoint, "\\d+")),
    Group = factor(Group, levels = c(1, 2), labels = c("HC", "DP"))
  )

time_labels <- c(
  "baseline", "post\nrest1", "post\nCTL1", "post\nCTL2", "post\nTSST",
  "post\nrest2", "30min\npost TSST", "45min\npost TSST", "60min\npost TSST"
)

group_colors <- c("HC" = "#00676f", "DP" = "#9b7b00") 

# Line Plot 
pA <- ggplot(dat_long, aes(x = Timepoint, y = Stress, color = Group, group = Group)) +
  stat_summary(fun = mean, geom = "line", size = 1.2) +       
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.2, size = 0.8) +  # Error Bars
  stat_summary(fun = mean, geom = "point", size = 2) +
  scale_x_continuous(breaks = 1:9, labels = time_labels) +
  scale_color_manual(values = group_colors) +
  coord_cartesian(ylim = c(0, 80)) +
  labs(
    x = "condition",
    y = "stress in %",
    color = "group"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    panel.grid = element_blank(),
    axis.line = element_line(color = "black"),
    axis.ticks = element_line(color = "black"),
    legend.title = element_text(size = 14),
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 14),
    plot.title = element_blank()
  ); pA




# Plot Positive affect -------------------------------------------------------------

# filter participants according to Mahalanobis distances calculated in SPSS 
dat_filtered <- dat %>%
  filter(!(ID %in% c(49)))

dat_long <- dat_filtered %>%
  select(Subject, Group, PA1, PA2) %>%
  pivot_longer(
    cols = c(PA1, PA2),
    names_to = "Timepoint",
    values_to = "Score"
  ) %>%
  mutate(
    Timepoint = factor(Timepoint,
                       levels = c("PA1", "PA2"),
                       labels = c("post\nrest1", "post\nTSST")),
    Group = factor(Group, levels = c(1, 2), labels = c("HC", "DP"))
  )

group_colors <- c("HC" = "#00676f", "DP" = "#9b7b00") 

# Line Plot 
pB <- ggplot(dat_long, aes(x = Timepoint, y = Score, color = Group, group = Group)) +
  stat_summary(fun = mean, geom = "line", size = 1.2) +       
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.1, size = 0.8) + 
  stat_summary(fun = mean, geom = "point", size = 3) +         
  scale_color_manual(values = group_colors) +
  coord_cartesian(ylim = c(22, 33)) +  
  labs(
    x = "condition",
    y = "positive affect",
    color = "group"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    panel.grid = element_blank(),               
    axis.line = element_line(color = "black"),  
    axis.ticks = element_line(color = "black"), 
    legend.title = element_text(size = 14),
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 14),
    plot.title = element_blank()
  ); pB




# Plot Negative affect -------------------------------------------------------------

# filter participants according to Mahalanobis distances calculated in SPSS 
dat_filtered <- dat %>%
  filter(!(ID %in% c(141, 49)))

dat_long <- dat_filtered %>%
  select(Subject, Group, NA1, NA2) %>%
  pivot_longer(
    cols = c(NA1, NA2),
    names_to = "Timepoint",
    values_to = "Score"
  ) %>%
  mutate(
    Timepoint = factor(Timepoint,
                       levels = c("NA1", "NA2"),
                       labels = c("post\nrest1", "post\nTSST")),
    Group = factor(Group, levels = c(1, 2), labels = c("HC", "DP"))
  )

group_colors <- c("HC" = "#00676f", "DP" = "#9b7b00") 

# Line Plot
pC <- ggplot(dat_long, aes(x = Timepoint, y = Score, color = Group, group = Group)) +
  stat_summary(fun = mean, geom = "line", size = 1.2) +       
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.1, size = 0.8) + 
  stat_summary(fun = mean, geom = "point", size = 3) +         
  scale_color_manual(values = group_colors) +
  coord_cartesian(ylim = c(13, 32)) +  
  labs(
    x = "condition",
    y = "negative affect",
    color = "group"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    panel.grid = element_blank(),               
    axis.line = element_line(color = "black"),  
    axis.ticks = element_line(color = "black"), 
    legend.title = element_text(size = 14),
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 14),
    plot.title = element_blank()
  ); pC



# Plot state rumination -------------------------------------------------------------

# no multivariate outliers according to Mahalanobis distances calculated in SPSS 
dat_long <- dat %>%
  select(Subject, Group, staterum_rest1_totalscore, staterum_rest2_totalscore) %>%
  pivot_longer(
    cols = c(staterum_rest1_totalscore, staterum_rest2_totalscore),
    names_to = "Timepoint",
    values_to = "Score"
  ) %>%
  mutate(
    Timepoint = factor(Timepoint,
                       levels = c("staterum_rest1_totalscore", "staterum_rest2_totalscore"),
                       labels = c("rest1", "rest2")),
    Group = factor(Group, levels = c(1, 2), labels = c("HC", "DP"))
  )

group_colors <- c("HC" = "#00676f", "DP" = "#9b7b00") 

# Line Plot 
pD <- ggplot(dat_long, aes(x = Timepoint, y = Score, color = Group, group = Group)) +
  stat_summary(fun = mean, geom = "line", size = 1.2) +       
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.1, size = 0.8) + 
  stat_summary(fun = mean, geom = "point", size = 3) +         
  scale_color_manual(values = group_colors) +
  coord_cartesian(ylim = c(1, 4)) +  
  labs(
    x = "condition",
    y = "state rumination",
    color = "group"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    panel.grid = element_blank(),               
    axis.line = element_line(color = "black"),  
    axis.ticks = element_line(color = "black"), 
    legend.title = element_text(size = 14),
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 14),
    plot.title = element_blank()
  ); pD


# Plot cortisol -----------------------------------------------------------

# filter participants according to Mahalanobis distances calculated in SPSS 
dat_filtered <- dat %>%
  filter(!(ID %in% c(1, 14, 38, 48, 31, 41, 8, 32, 53, 39, 13, 30, 35, 34, 36, 50, 73, 5, 7, 67, 66, 85, 115)))

dat_long <- dat_filtered %>%
  select(Subject, Group, korrigiert_Cortisol_Konzentration.1, korrigiert_Cortisol_Konzentration.2, korrigiert_Cortisol_Konzentration.3, korrigiert_Cortisol_Konzentration.4, korrigiert_Cortisol_Konzentration.5) %>%
  pivot_longer(
    cols = c(korrigiert_Cortisol_Konzentration.1, korrigiert_Cortisol_Konzentration.2, korrigiert_Cortisol_Konzentration.3, korrigiert_Cortisol_Konzentration.4, korrigiert_Cortisol_Konzentration.5),
    names_to = "Timepoint",
    values_to = "Score"
  ) %>%
  mutate(
    Timepoint = factor(Timepoint,
                       levels = c("korrigiert_Cortisol_Konzentration.1", "korrigiert_Cortisol_Konzentration.2", 
                                  "korrigiert_Cortisol_Konzentration.3", "korrigiert_Cortisol_Konzentration.4", 
                                  "korrigiert_Cortisol_Konzentration.5"),
                       labels = c("post\nrest1", "0 min", "15 min", "30 min", "60 min")),
    Group = factor(Group, levels = c(1, 2), labels = c("HC", "DP"))
  )

group_colors <- c("HC" = "#00676f", "DP" = "#9b7b00") 

# Line Plot 
pE <- ggplot(dat_long, aes(x = Timepoint, y = Score, color = Group, group = Group)) +
  stat_summary(fun = mean, geom = "line", size = 1.2) +       
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.1, size = 0.8) + 
  stat_summary(fun = mean, geom = "point", size = 3) +         
  scale_color_manual(values = group_colors) +
  coord_cartesian(ylim = c(0.1, 0.5)) +  
  labs(
    x = "condition",
    y = "cortisol",
    color = "group"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    panel.grid = element_blank(),               
    axis.line = element_line(color = "black"),  
    axis.ticks = element_line(color = "black"), 
    legend.title = element_text(size = 14),
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 14),
    plot.title = element_blank()
  ); pE


# merge all plots: manipulation check 

pBpC <- plot_grid(
  pB, pC,
  ncol = 2,
  labels = c("B", "C"),
  label_size = 16,
  align = "h"
); pBpC

pDpE <- plot_grid(
  pD, pE,
  ncol = 2,
  rel_widths = c(1, 2),  
  labels = c("D", "E"),
  label_size = 16,
  align = "h"
); pDpE


combined_plot <- plot_grid(
  pA, pBpC, pDpE,
  ncol = 1,
  labels = c("A", "", ""),
  label_size = 16
); combined_plot

ggsave("FigureS9.png", width = 12, height = 15, dpi = 600)







# Plot fNIRS window 1 ----------------------------------------------------------------

# no multivariate outliers according to Mahalanobis distances calculated in SPSS 

dat_long <- dat %>%
  pivot_longer(
    cols = ends_with("_anticipation"),
    names_to = c("Timepoint", "ROI"),
    names_pattern = "^(CTL1|CTL2|Arith)_([^_]+)_Cui_anticipation$",
    values_to = "Value"
  ) %>%
  mutate(
    Timepoint = factor(
      Timepoint,
      levels = c("CTL1", "CTL2", "Arith"),
      labels = c("CTL1", "CTL2", "Arith")
    ),
    ROI = factor(
      ROI,
      levels = c("lIFG",  "rIFG", "lDLPFC", "rDLPFC", "SAC")
    ),
    Group = factor(
      Group,
      levels = c(1, 2),
      labels = c("HC", "DP")
    )
  )

group_colors <- c("HC" = "#00676f", "DP" = "#9b7b00") 

ggplot(
  dat_long,
  aes(x = Timepoint, y = Value, color = Group, group = Group)
) +
  stat_summary(fun = mean, geom = "line", size = 1.2) +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.2, size = 0.8) +
  stat_summary(fun = mean, geom = "point", size = 2) +
  scale_x_discrete(
    labels = c(
      "CTL1"  = "CTL1",
      "CTL2"  = "CTL2",
      "Arith" = "TSST"
    )
  ) +
  scale_color_manual(values = group_colors) +
  labs(
    x = "condition",
    y = expression(O[2]*Hb),
    color = "group"
  ) +
  theme_minimal(base_size = 14) +
  coord_cartesian(ylim = c(-0.3, 0.1)) +  
  theme(
    panel.grid = element_blank(),
    axis.line = element_line(color = "black"),
    axis.ticks = element_line(color = "black"),
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 14),
    strip.text = element_text(size = 14, face = "bold"),
    
    legend.position = "right"
  )

ggsave(
  "Figure6.png",
  width = 5,
  height = 4,
  dpi = 300
)


# Plot window 2 and window 2 ----------------------------------------------------

# no multivariate outliers according to Mahalanobis distances calculated in SPSS 

dat_long <- dat %>%
  pivot_longer(
    cols = ends_with("_trialstandard"),
    names_to = c("Timepoint", "ROI"),
    names_pattern = "^(CTL1|CTL2|Arith)_([^_]+)_Cui_trialstandard$",
    values_to = "Value"
  ) %>%
  mutate(
    Timepoint = factor(
      Timepoint,
      levels = c("CTL1", "CTL2", "Arith"),
      labels = c("CTL1", "CTL2", "Arith")
    ),
    ROI = factor(
      ROI,
      levels = c("lIFG",  "rIFG", "lDLPFC", "rDLPFC", "SAC")
    ),
    Group = factor(
      Group,
      levels = c(1, 2),
      labels = c("HC", "DP")
    )
  )


group_colors <- c("HC" = "#00676f", "DP" = "#9b7b00") 

pA <- ggplot(
  dat_long,
  aes(x = Timepoint, y = Value, color = Group, group = Group)
) +
  stat_summary(fun = mean, geom = "line", size = 1.2) +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.2, size = 0.8) +
  stat_summary(fun = mean, geom = "point", size = 2) +
  scale_x_discrete(
    labels = c(
      "CTL1"  = "CTL1",
      "CTL2"  = "CTL2",
      "Arith" = "TSST"
    )
  ) +
  scale_color_manual(values = group_colors) +
  labs(
    x = "condition",
    y = expression(O[2]*Hb),
    color = "group"
  ) +
  theme_minimal(base_size = 14) +
  coord_cartesian(ylim = c(-0.05, 0.5)) +  
  theme(
    panel.grid = element_blank(),
    axis.line = element_line(color = "black"),
    axis.ticks = element_line(color = "black"),
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 14),
    strip.text = element_text(size = 14, face = "bold"),
    
    legend.position = "right"
  )

dat_long <- dat %>%
  pivot_longer(
    cols = ends_with("_trialnoanticipation"),
    names_to = c("Timepoint", "ROI"),
    names_pattern = "^(CTL1|CTL2|Arith)_([^_]+)_Cui_trialnoanticipation$",
    values_to = "Value"
  ) %>%
  mutate(
    Timepoint = factor(
      Timepoint,
      levels = c("CTL1", "CTL2", "Arith"),
      labels = c("CTL1", "CTL2", "Arith")
    ),
    ROI = factor(
      ROI,
      levels = c("lIFG",  "rIFG", "lDLPFC", "rDLPFC", "SAC")
    ),
    Group = factor(
      Group,
      levels = c(1, 2),
      labels = c("HC", "DP")
    )
  )


group_colors <- c("HC" = "#00676f", "DP" = "#9b7b00") 

pB <- ggplot(
  dat_long,
  aes(x = Timepoint, y = Value, color = Group, group = Group)
) +
  stat_summary(fun = mean, geom = "line", size = 1.2) +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.2, size = 0.8) +
  stat_summary(fun = mean, geom = "point", size = 2) +
  scale_x_discrete(
    labels = c(
      "CTL1"  = "CTL1",
      "CTL2"  = "CTL2",
      "Arith" = "TSST"
    )
  ) +
  scale_color_manual(values = group_colors) +
  labs(
    x = "condition",
    y = expression(O[2]*Hb),
    color = "group"
  ) +
  theme_minimal(base_size = 14) +
  coord_cartesian(ylim = c(-0.05, 0.5)) +  
  theme(
    panel.grid = element_blank(),
    axis.line = element_line(color = "black"),
    axis.ticks = element_line(color = "black"),
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 14),
    strip.text = element_text(size = 14, face = "bold"),
    
    legend.position = "right"
  )

combined_plot <- plot_grid(
  pA, pB,
  ncol = 2,                
  rel_widths = c(1, 1),    
  labels = c("A", "B"),    
  label_size = 16,
  align = "h"              
); combined_plot 

ggsave(
  "Figure3.png",
  combined_plot,
  width = 10,
  height = 4,
  dpi = 300
)

