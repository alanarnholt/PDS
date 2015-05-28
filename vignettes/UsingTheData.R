## ---- echo = FALSE, message = FALSE--------------------------------------
options(useFancyQuotes="UTF-8")
knitr::opts_chunk$set(comment = NA, message = FALSE, warning = FALSE, prompt = TRUE)

## ------------------------------------------------------------------------
library(PDS)

## ----eval = FALSE--------------------------------------------------------
#  system.file(package = "PDS")

## ------------------------------------------------------------------------
gapminder[1:5, 'incomeperperson']  # Show first five rows for incomeperperson
gapminder[1:5, 1:4]  # Show the first five rows for variables 1 through 4

## ----eval = FALSE--------------------------------------------------------
#  install.packages("dplyr")

## ----eval = FALSE--------------------------------------------------------
#  if (packageVersion("devtools") < 1.6) {
#    install.packages("devtools")
#  }
#  devtools::install_github("hadley/lazyeval")
#  devtools::install_github("hadley/dplyr")

## ------------------------------------------------------------------------
library(dplyr)
nesarc <- tbl_df(NESARC) %>% 
  filter(!is.na(CHECK321) & !is.na(AGE) & CHECK321 ==1 & AGE <= 25)
dim(nesarc)

## ----label = "SUB1"------------------------------------------------------
NESARCsub1 <- tbl_df(NESARC) %>%
  filter(S3AQ1A == 1 & CHECK321 == 1 & S3AQ3B1 == 1 & AGE <= 25)
dim(NESARCsub1)

## ----label = "SUB2"------------------------------------------------------
NESARCsub2 <- NESARC[NESARC$S3AQ1A == 1 & NESARC$CHECK321 == 1 & 
                       NESARC$S3AQ3B1 == 1 & NESARC$AGE <= 25, ]
dim(NESARCsub2)

## ----label = "SUB3"------------------------------------------------------
NESARCsub3 <- subset(NESARC, subset = S3AQ1A == 1 & CHECK321 == 1 & 
                       S3AQ3B1 == 1 & AGE <= 25)
dim(NESARCsub3)

## ----label = "RENAME"----------------------------------------------------
NESARC[1:5, 1:5]  # Show first 5 rows and first 5 columns of NESARC
NESARCtbl <- tbl_df(NESARC) %>% 
  rename(UniqueID = IDNUM, EthanolConsumption = ETOTLCA2, Ethnicity = ETHRACE2A, 
         SmokingFrequency = S3AQ3B1, Age = AGE, MajorDepression = MAJORDEPLIFE, Sex = SEX, 
         DysthymiaLifetime = DYSLIFE, TobaccoDependence = TAB12MDX, DailyCigsSmoked = S3AQ3C1) %>% 
  select(UniqueID, EthanolConsumption, Ethnicity, SmokingFrequency, Age, MajorDepression, 
         DysthymiaLifetime, TobaccoDependence, DailyCigsSmoked, S3AQ1A, CHECK321, 
         SmokingFrequency, Sex)  
NESARCtbl

## ----label = "CodeMissing"-----------------------------------------------
NESARCtbl$SmokingFrequency[NESARCtbl$SmokingFrequency == 9] <- NA
summary(NESARCtbl$SmokingFrequency)  # Note that 9 still appears
NESARCtbl$SmokingFrequency <- factor(NESARCtbl$SmokingFrequency)[, drop = TRUE]
summary(NESARCtbl$SmokingFrequency)  # Unused level no longer appears

## ----label = "Freq"------------------------------------------------------
NESARCtbl$SmokingFrequency <- factor(NESARCtbl$SmokingFrequency, 
                                     labels = c("Every Day", "5 to 6 Days/week", 
                                                "3 to 4 Days/week", "1 to 2 Days/week", 
                                                "2 to 3 Days/month", "Once a month or less"))
summary(NESARCtbl$SmokingFrequency)
xtabs(~SmokingFrequency, data = NESARCtbl) # Note how the NA's are not printed

## ----label = "ggSmoke"---------------------------------------------------
library(ggplot2)
ggplot(data = NESARCtbl, aes(x = SmokingFrequency)) + 
  geom_bar(fill = "lightgray") + 
  labs(x = "Smoking Frequency") +
  theme_bw() 

## ----label = "ggSmoke2", fig.width = 6, fig.height = 6-------------------
ggplot(data = na.omit(NESARCtbl[ , "SmokingFrequency", drop = FALSE]), aes(x = SmokingFrequency)) + 
  geom_bar(fill = "lightgray") + 
  labs(x = "Smoking Frequency") +
  theme_bw() +
  theme(axis.text.x  = element_text(angle = 55, hjust = 1.0)) 

## ----label = "CollapseHS"------------------------------------------------
NESARC$HS_DEGREE <- factor(ifelse(NESARC$S1Q6A %in% c("1", "2", "3", "4", "5", "6", "7"), 
                                  "No", "Yes"))
summary(NESARC$HS_DEGREE)

## ----label = "CUT1"------------------------------------------------------
NESARC$AGEfac <- cut(NESARC$AGE, breaks = c(18, 30, 50, Inf), 
                     labels = c("Young Adult", "Adult", "Older Adult"), 
                     include.lowest = TRUE)
summary(NESARC$AGEfac)

## ----label = "CUT2"------------------------------------------------------
NESARC$S3AQ3C1fac <- cut(NESARC$S3AQ3C1, breaks = c(0, 5, 10, 15, 20, 100), 
                         include.lowest = TRUE)
summary(NESARC$S3AQ3C1fac)

## ----label = "Agg1"------------------------------------------------------
NESARC$DepressLife <- factor(ifelse( (NESARC$MAJORDEPLIFE == 1 | NESARC$DYSLIFE == 1), "Yes", "No"))
summary(NESARC$DepressLife)

## ----label = "PANIC"-----------------------------------------------------
NESARC$PPpanic <- factor(ifelse( (NESARC$APANDX12 == 1 | NESARC$APANDXP12 == 1 | 
                                    NESARC$PANDX12 == 1 | NESARC$PANDXP12 == 1 ), "Yes", "No"))
summary(NESARC$PPpanic)

## ----label = "DEPsym"----------------------------------------------------
NESARC$AllDeprSymp <- factor(ifelse( (NESARC$S4AQ4A1 == 1 & NESARC$S4AQ4A2 == 1 & 
                                        NESARC$S4AQ4A3 == 1 & NESARC$S4AQ4A4 == 1 & 
                                        NESARC$S4AQ4A5 == 1 & NESARC$S4AQ4A6 == 1 & 
                                        NESARC$S4AQ4A7 == 1 & NESARC$S4AQ4A8 == 1 & 
                                        NESARC$S4AQ4A9 == 1 & NESARC$S4AQ4A10 == 1 & 
                                        NESARC$S4AQ4A11 == 1 & NESARC$S4AQ4A12 == 1 & 
                                        NESARC$S4AQ4A13 == 1 & NESARC$S4AQ4A14 == 1 & 
                                        NESARC$S4AQ4A15 == 1 & NESARC$S4AQ4A16 == 1 & 
                                        NESARC$S4AQ4A17 == 1 & NESARC$S4AQ4A18 == 1 & 
                                        NESARC$S4AQ4A19 == 1), "Yes", "No"))
summary(NESARC$AllDeprSymp)

## ----label = "CompositeFactor"-------------------------------------------
mysum <- function(x){sum(x == 1)}
myadd <- function(x){apply(x, 1, mysum)}
ndf <- NESARC %>%
  select(contains("S4AQ4A"))
nDS <- myadd(ndf)
ndf <- cbind(ndf, nDS)
xtabs(~nDS, data = ndf)    

## ----label = "Mutate"----------------------------------------------------
MINI <- tbl_df(NESARC) %>% 
  select(S1Q24FT, S1Q24IN, S1Q24LB, SEX) %>% 
  filter(S1Q24FT < 99, S1Q24IN < 99, S1Q24LB < 999) %>% 
  mutate(Inches = (S1Q24FT*12 + S1Q24IN),
         Sex = factor(SEX, labels = c("Male", "Female"))) %>% 
  rename(Weight = S1Q24LB)
MINI

## ------------------------------------------------------------------------
summary(NESARCtbl$SmokingFrequency)
levels(NESARCtbl$SmokingFrequency)
table(as.numeric(NESARCtbl$SmokingFrequency))

## ------------------------------------------------------------------------
NESARCtbl$DaysSmoke <- as.numeric(NESARCtbl$SmokingFrequency)
NESARCtbl$DaysSmoke[NESARCtbl$DaysSmoke == 1] <- 30
NESARCtbl$DaysSmoke[NESARCtbl$DaysSmoke == 2] <- 4*5.5
NESARCtbl$DaysSmoke[NESARCtbl$DaysSmoke == 3] <- 4*3.5
NESARCtbl$DaysSmoke[NESARCtbl$DaysSmoke == 4] <- 4*1.5
NESARCtbl$DaysSmoke[NESARCtbl$DaysSmoke == 5] <- 2.5
NESARCtbl$DaysSmoke[NESARCtbl$DaysSmoke == 6] <- 1
# Using dplyr again
NESARCtbl <- NESARCtbl %>% 
  mutate(TotalCigsSmoked = DaysSmoke*DailyCigsSmoked)
proportions <- quantile(NESARCtbl$TotalCigsSmoked, na.rm = TRUE)
proportions
NESARCtbl$CigsSmokedFac <- cut(NESARCtbl$TotalCigsSmoked, breaks = proportions, 
                               include.lowest = TRUE)
NESARCtbl

## ------------------------------------------------------------------------
NESARCtbl <- NESARCtbl %>% 
  filter(S3AQ1A == 1 & CHECK321 == 1 & SmokingFrequency == "Every Day" & Age <= 25)
dim(NESARCtbl)
str(NESARCtbl)
summary(NESARCtbl)

## ----label = "EDAquan"---------------------------------------------------
library(ggplot2)
ggplot(data = NESARCtbl, aes(x = EthanolConsumption) ) + 
  geom_histogram(binwidth = 1, fill = "pink") + 
  theme_bw() +
  labs(x = "Ethanol Consumption")
ggplot(data = NESARCtbl, aes(x = EthanolConsumption) ) + 
  geom_density(fill = "pink") + 
  theme_bw() +
  labs(x = "Ethanol Consumption")

## ----label = "EDAqual"---------------------------------------------------
ggplot(data = NESARCtbl, aes(x = Ethnicity)) +
  geom_bar(fill = c("snow", "brown4", "red", "yellow", "tan"), color = "black") + 
  theme_bw() 

## ------------------------------------------------------------------------
NESARCtbl$TobaccoDependence <- factor(NESARCtbl$TobaccoDependence, 
                         labels = c("No Nicotine Dependence", "Nicotine Dependence"))
xtabs(~TobaccoDependence, data = NESARCtbl)
NESARCtbl$TobaccoDependence <- factor(NESARCtbl$TobaccoDependence, 
                         levels = c("Nicotine Dependence", "No Nicotine Dependence"))
xtabs(~TobaccoDependence, data = NESARCtbl)
NESARCtbl$Ethnicity <- factor(NESARCtbl$Ethnicity, 
                              labels = c("Caucasian", "African American", 
                                         "Native American", "Asian", "Hispanic"))
NESARCtbl$Sex <- factor(NESARCtbl$Sex, labels = c("Male", "Female"))
table(NESARCtbl$Sex)
NESARCtbl$Sex <- factor(NESARCtbl$Sex, levels = c("Female", "Male"))
table(NESARCtbl$Sex)
NESARCtbl$SmokingFrequency <- factor(NESARCtbl$SmokingFrequency, 
                         levels = c("Once a month or less", "2 to 3 Days/month", "1 to 2 Days/week",  
                                    "3 to 4 Days/week", "5 to 6 Days/week", "Every Day"))
NESARCtbl$MajorDepression <- factor(NESARCtbl$MajorDepression, 
                                    labels = c("No Depression", "Yes Depression"))
ggplot(data = NESARCtbl, aes(x = Ethnicity)) +
  geom_bar(fill = c("snow", "brown4", "red", "yellow", "tan"), color = "black") + 
  theme_bw() + 
  theme(axis.text.x  = element_text(angle = 55, hjust = 1)) + 
  labs(x = "")

## ----label = "ggSmoke2A", fig.width = 6, fig.height = 4------------------
T1 <- xtabs(~ TobaccoDependence + MajorDepression, data = NESARCtbl)
T1
ggplot(data = NESARCtbl, aes(x = MajorDepression, fill = TobaccoDependence)) +
  geom_bar() + 
  theme_bw()
T2 <- prop.table(T1, 2)
T2
ggplot(data = NESARCtbl, aes(x = MajorDepression, fill = TobaccoDependence)) +
  geom_bar(position = "fill") + 
  labs(x = "", y = "Fraction", 
       title = "Fraction of young adult daily smokers\nwith and without nicotine addiction\nby depression status") +
  theme_bw() +
  scale_fill_manual(values = c("red", "pink"), name = "Tobacco Addiction Status")
###
ggplot(data = NESARCtbl, aes(x = MajorDepression, fill = TobaccoDependence)) +
  geom_bar(position = "fill") + 
  labs(x = "", y = "Fraction", 
       title = "Fraction of young adult daily smokers\nwith and without nicotine addiction\nby depression status") +
  theme_bw() +
  scale_fill_manual(values = c("red", "pink"), name = "Tobacco Addiction Status") + 
  facet_grid(Sex ~ .)

## ----fig.width = 6.5, fig.height = 7.5-----------------------------------
ggplot(data = NESARCtbl, aes(x = MajorDepression, fill = TobaccoDependence)) +
  geom_bar(position = "fill") + 
  labs(x = "", y = "Fraction", 
       title = "Fraction of young adult daily smokers\nwith and without nicotine addiction\nby depression status") +
  theme_bw() +
  scale_fill_manual(values = c("red", "pink"), name = "Tobacco Addiction Status") + 
  facet_grid(Ethnicity ~ Sex) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## ----label = "mergeAddHealth"--------------------------------------------
library(dplyr)
AddHealthW4 <- tbl_df(addhealth_public4) %>% 
  rename(AID = aid)
AddHealthW1and4 <- left_join(AddHealthW4, AddHealth)
dim(AddHealthW1and4)

## ---- echo = FALSE, results = 'asis'-------------------------------------
knitr::kable(NESARCtbl[1300:1305, c("EthanolConsumption", "Sex", "MajorDepression")], 
             align = c("c","c","c"), caption = "Three Selected Columns")

## ---- echo = FALSE, results = 'asis'-------------------------------------
knitr::kable(NESARCtbl[1300:1305, c("EthanolConsumption", "Sex", "MajorDepression")], 
             align = c("c","c","c"), caption = "Three Selected Columns", col.names = c("Ethanol Consuption", "Gender", "Depression"))

## ---- echo=FALSE, results='asis'-----------------------------------------
pander::pandoc.table(NESARCtbl[1300:1305, c("EthanolConsumption", "Sex", "MajorDepression")],
                     caption = "Three Selected Columns")

