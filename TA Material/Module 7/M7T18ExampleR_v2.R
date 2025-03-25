df <-  read.csv("medpar.csv")

df$white <- factor(df$white)
df$hmo <- factor(df$hmo)
df$type <- factor(df$type)
df$age80 <- factor(df$age80)
df$age80 <- factor(df$age80)
df$died <- factor(df$died)

fit_nb = glm.nb(los ~ hmo + white + type, data = df)


lincom(fit_nb, linfct = "white1 + hmo1 + type3 = 0", exp = T)

lincom(fit_nb, linfct = "white1 + type3 - type2 = 0", exp = T)

