## ---- echo = FALSE, message = FALSE--------------------------------------
knitr::opts_chunk$set(comment = NA, message = FALSE, warning = FALSE, prompt = TRUE)

## ------------------------------------------------------------------------
library(PDS)

## ------------------------------------------------------------------------
gapminder[1:5, 'incomeperperson']

## ----eval = FALSE--------------------------------------------------------
#  install.packages("dplyr")

## ----eval = FALSE--------------------------------------------------------
#  if (packageVersion("devtools") < 1.6) {
#    install.packages("devtools")
#  }
#  devtools::install_github("hadley/lazyeval")
#  devtools::install_github("hadley/dplyr")

## ----label = "RENAME"----------------------------------------------------
library(dplyr)
NESARC[1:5, 1:5]  # Show first 5 rows and first 5 columns of NESARC
NESARCtbl <- tbl_df(NESARC) %>% 
  rename(UniqueID = IDNUM, EthanolConsumption = ETOTLCA2, Ethnicity = ETHRACE2A) %>% 
  select(UniqueID, EthanolConsumption, Ethnicity)  
NESARCtbl

## ---- echo=FALSE, results='asis'-----------------------------------------
knitr::kable(head(NESARCtbl, 5))

## ---- echo=FALSE, results='asis'-----------------------------------------
pander::pandoc.table(head(NESARCtbl, 5))

## ---- fig.show='hold'----------------------------------------------------
plot(1:10, main ="Basic Plot", pch = 19, col ="red")
plot(10:1, xlab = "", ylab ="", col = "green", pch = 19)

## ---- fig.show = 'hold', fig.cap = "Basic plot in case you wondered"-----
plot(1:10, main ="Basic Plot", pch = 19, col ="red")

## ---- echo=FALSE, results='asis'-----------------------------------------
knitr::kable(head(mtcars, 10))

## ------------------------------------------------------------------------
1:10

