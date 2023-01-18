## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(fig.width=6, fig.height=4, fig.path='Figs/', fig.show='hold',
                      warning=FALSE, message=FALSE)

## ----load_libraries, message=FALSE, warning=FALSE-----------------------------
require(smooth)
require(greybox)

## ----es_N2457-----------------------------------------------------------------
ourModel <- es(BJsales, h=12, holdout=TRUE, silent=FALSE)
ourModel

## ----es_N2457_with_interval---------------------------------------------------
plot(forecast(ourModel, h=12, interval="prediction"))

## ----es_N2457_reuse_model-----------------------------------------------------
es(BJsales, model=ourModel, h=12, holdout=FALSE)

## ----es_N2457_modelType-------------------------------------------------------
modelType(ourModel)

## ----es_N2457_actuals---------------------------------------------------------
actuals(ourModel)

## ----es_N2457_reuse_model_parts-----------------------------------------------
# Provided initials
es(BJsales, model=modelType(ourModel),
   h=12, holdout=FALSE,
   initial=ourModel$initial)
# Provided persistence
es(BJsales, model=modelType(ourModel),
   h=12, holdout=FALSE,
   persistence=ourModel$persistence)

## ----es_N2457_set_initial-----------------------------------------------------
es(BJsales, model=modelType(ourModel),
   h=12, holdout=FALSE,
   initial=200)

## ----es_N2457_aMSTFE----------------------------------------------------------
es(BJsales, h=12, holdout=TRUE, loss="MSEh", bounds="a", ic="BIC")

## ----es_N2457_combine---------------------------------------------------------
es(BJsales, model="CCN", h=12, holdout=TRUE)

## ----es_N2457_pool------------------------------------------------------------
# Select the best model in the pool
es(BJsales, model=c("ANN","AAN","AAdN","MNN","MAN","MAdN"),
   h=12, holdout=TRUE)
# Combine the pool of models
es(BJsales, model=c("CCC","ANN","AAN","AAdN","MNN","MAN","MAdN"),
   h=12, holdout=TRUE)

## ----es_N2457_xreg_create-----------------------------------------------------
x <- BJsales.lead

## ----es_N2457_xreg------------------------------------------------------------
es(BJsales, model="ZZZ", h=12, holdout=TRUE,
   xreg=x)

## ----es_N2457_xreg_expanded_select--------------------------------------------
es(BJsales, model="ZZZ", h=12, holdout=TRUE,
   xreg=xregExpander(x), regressors="use")

## ----es_N2457_xreg_select-----------------------------------------------------
es(BJsales, model="ZZZ", h=12, holdout=TRUE,
   xreg=xregExpander(x), regressors="select")

## ----es_N2457_M3, eval=FALSE--------------------------------------------------
#  es(Mcomp::M3$N2457, silent=FALSE)

