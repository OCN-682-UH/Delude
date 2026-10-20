
df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

head(df)


df <- df |>
  mutate(a = (a- min(a, na.rm=T)) / (max(a, na.rm=T) - min(a, na.rm=T)))

head(df)

rescale01 <- function(x) {
  value <- (x = (x- min(x, na.rm=T)) / (max(x, na.rm=T) - min(x, na.rm=T)))
  return(value)
}


#or use Across

df |>
  mutate(across(everything(), rescale01))

head(df)

#converting units with functions

temp_C <- (temp_F - 32) * 5 / 9

F_to_C <- function(x) {
  #code goes here
  value <- ((x - 32) * 5 / 9)
  return(value)
}

Met2Kelv <- function(temp_c) {
  #code goes here
  temp_k <- (temp_c + 273.15)
  return(temp_k)
}

library(palmerpenguins)
library(PNWColors)

pal <- pnw_palette("Lake", 3, type = "discrete")

ggplot(penguins, aes(x = body_mass_g, y = bill_length_mm, color = island)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_color_manual("Island", values = pal) +
  theme_bw()


my_plot = function(data, x, y) {
  pal <- pnw_palette("Lake", 3, type = "discrete")
  
  ggplot(data, aes(x = {{x}}, y = {{y}}, color = island)) +
    geom_point() +
    geom_smooth(method = "lm") +
    scale_color_manual("Island", values = pal) +
    theme_bw()
}

my_plot(penguins, x = bill_length_mm, y = body_mass_g) +
  labs(x = "Bill Length", y= "Body Mass")

a=6
b=5

if(a>b){
  f<-20
} else {
  f <-10
}

f

my_plot = function(data, x, y, lines = T) {
  pal <- pnw_palette("Lake", 3, type = "discrete")
  
  if(lines == T) {
  ggplot(data, aes(x = {{x}}, y = {{y}}, color = island)) +
    geom_point() +
    geom_smooth(method = "lm") +
    scale_color_manual("Island", values = pal) +
    theme_bw()
  } else {
      ggplot(data, aes(x = {{x}}, y = {{y}}, color = island)) +
        geom_point() +
        scale_color_manual("Island", values = pal) +
        theme_bw()
    }
}

my_plot(penguins, x = bill_length_mm, y = body_mass_g, lines = F)

