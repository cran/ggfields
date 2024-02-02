## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.ext = "svg",
  dev = "svg"
)

## ----init, message = FALSE, fig.width = 7, fig.height = 5, out.width = "50%"----
library(ggplot2)
library(ggfields)
library(stars)
theme_set(theme_light())
data("seawatervelocity")

p <-
  ggplot() +
  geom_fields(
    aes(radius = as.numeric(v),
        angle  = as.numeric(angle)),
    seawatervelocity[,3:11,6:11],
    max_radius = grid::unit(1.5, "cm")) +
  labs(radius  = "v [m/s]") +
  ## We have to increase the 'keywidth' as otherwise `max_radius` won't fit:
  guides(radius = guide_legend(keywidth = grid::unit(1.5, "cm")))
p

## ----onekey, message = FALSE, fig.width = 7, fig.height = 5, out.width = "50%"----
p +
  aes(col = as.numeric(v), linewidth = as.numeric(v)) +
  ## Let's give the aesthetics all the same name
  labs(col = "v [m/s]", linewidth = "v [m/s]") +
  ## Make sure that the colour aesthetic uses the same guide as radius ("legend")
  scale_colour_viridis_c(guide = "legend") +
  ## Make sure all keys have the same width
  guides(colour    = guide_legend(keywidth = grid::unit(1.5, "cm")),
         linewidth = guide_legend(keywidth = grid::unit(1.5, "cm")))


## ----components, message = FALSE, fig.show = 'hide'---------------------------
ggplot() +
  geom_fields(aes(radius = as.numeric(pythagoras(vo, uo)),
                  angle  = atan2(as.numeric(vo), as.numeric(uo))),
              seawatervelocity)

