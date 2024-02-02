## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.ext = "svg",
  dev = "svg"
)

## ----init---------------------------------------------------------------------
north_arrows <-
  expand.grid(
    x = seq(-5, 15, length.out = 10),
    y = seq(89.85, 89.9, length.out = 10)
  ) |>
  sf::st_as_sf(coords = c("x", "y"), crs = 4326) |>
  sf::st_make_grid() |>
  stars::st_as_stars(nx = 10, ny = 10) |>
  dplyr::mutate(angle = 0*(2*pi/360))

## ----angle_lonlat-------------------------------------------------------------
library(ggfields)
library(ggplot2)
theme_set(theme_light())

ggplot() +
  geom_fields(data = north_arrows, aes(angle = angle), radius = 1)

## ----angle_diff---------------------------------------------------------------
no_correction <-
    geom_fields(data = north_arrows, aes(angle = angle, col = "no correction"), radius = 1,
              .angle_correction = NULL,
              max_radius = ggplot2::unit(0.7, "cm"))

p <-
  ggplot() +
  theme(legend.position = "top") +
  labs(colour = NULL)

p +
  no_correction +
  geom_fields(data = north_arrows, aes(angle = angle, col = "corrected"), radius = 1,
              max_radius = ggplot2::unit(0.7, "cm")) +
  scale_colour_manual(values = c(`no correction` = "red", corrected = "green")) +
  coord_sf(crs = 32631)

## ----custom_corr--------------------------------------------------------------
custom_correct <- function(data, panel_params, coord) {
  data |> dplyr::mutate(angle_correction = pi/2)
}

no_correction[[1]]$geom_params$max_radius <-
  ggplot2::unit(0.3, "cm")

p +
  no_correction +
  geom_fields(data = north_arrows, aes(angle = angle, col = "custom correction"),
              radius = 1, .angle_correction = custom_correct,
              max_radius = ggplot2::unit(0.3, "cm")) +
  scale_colour_manual(values = c(`no correction` = "red",
                                 `custom correction` = "orange"))


