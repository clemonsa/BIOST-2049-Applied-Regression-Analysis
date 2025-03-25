# Assuming DA2 has already been read in using `read.csv`

DA2 <- DA2[order(DA2$newppm), ]

fit <- lm(bloodtol ~ newppm, data = DA2)

## mspline
library(splines)

bspline <- bs(DA2$newppm, knots = c(200, 400, 600, 800, 1000)) # knots must be manually determined
fit_spline1 <- lm(DA2$bloodtol ~ bspline)
y_spline1 <- predict(fit_spline1)

library(ggplot2)

p <- ggplot(DA2, aes(x = newppm, y = bloodtol))

p + geom_point(colour = "darkblue") +
  geom_line(aes(x = newppm, y = y_spline1), colour = "darkgreen") + 
  geom_smooth(method = "lm", se = F, colour = "purple") +
  labs(x = "newppm", y = "Component Plus Residual", title = "Smoother: mspline") +
  theme_bw()

## loess


p + geom_point(colour = "darkblue") +
  geom_smooth(method = "loess", se = F,colour = "darkgreen") +
  geom_smooth(method = "lm", se = F, colour = "purple") +
  labs(x = "newppm", y = "Component Plus Residual", title = "Smoother: loess") +
  theme_bw()



