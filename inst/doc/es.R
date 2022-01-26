## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(fig.width=6, fig.height=4, fig.path='Figs/', fig.show='hold',
                      warning=FALSE, message=FALSE)

## ----load_libraries, message=FALSE, warning=FALSE-----------------------------
require(smooth)
require(greybox)

## ----es_N2457-----------------------------------------------------------------
es(BJsales, h=12, holdout=TRUE, silent=FALSE)

## ----es_N2457_with_interval---------------------------------------------------
es(BJsales, h=12, holdout=TRUE, interval=TRUE, silent=FALSE)

## ----es_N2457_save_model------------------------------------------------------
ourModel <- es(BJsales, h=12, holdout=TRUE, silent="all")

## ----es_N2457_reuse_model-----------------------------------------------------
es(BJsales, model=ourModel, h=12, holdout=FALSE, interval="np", level=0.93)

## ----es_N2457_modelType-------------------------------------------------------
modelType(ourModel)

## ----es_N2457_actuals---------------------------------------------------------
actuals(ourModel)

## ----es_N2457_reuse_model_parts-----------------------------------------------
es(BJsales, model=modelType(ourModel), h=12, holdout=FALSE, initial=ourModel$initial, silent="graph")
es(BJsales, model=modelType(ourModel), h=12, holdout=FALSE, persistence=ourModel$persistence, silent="graph")

## ----es_N2457_set_initial-----------------------------------------------------
es(BJsales, model=modelType(ourModel), h=12, holdout=FALSE, initial=1500, silent="graph")

## ----es_N2457_aMSTFE----------------------------------------------------------
es(BJsales, h=12, holdout=TRUE, loss="aTMSE", bounds="a", ic="BIC", interval=TRUE)

## ----es_N2457_combine---------------------------------------------------------
es(BJsales, model="CCN", h=12, holdout=TRUE, silent="graph")

## ----es_N2457_pool------------------------------------------------------------
es(BJsales, model=c("ANN","AAN","AAdN","ANA","AAA","AAdA"), h=12, holdout=TRUE, silent="graph")
es(BJsales, model=c("CCC","ANN","AAN","AAdN","ANA","AAA","AAdA"), h=12, holdout=TRUE, silent="graph")

## ----es_N2457_xreg_create-----------------------------------------------------
x <- cbind(rnorm(length(BJsales),50,3),rnorm(length(BJsales),100,7))

## ----es_N2457_xreg------------------------------------------------------------
es(BJsales, model="ZZZ", h=12, holdout=TRUE, xreg=x)

## ----es_N2457_xreg_select-----------------------------------------------------
es(BJsales, model="ZZZ", h=12, holdout=TRUE, xreg=x, xregDo="select")

## ----es_N2457_xreg_expanded_select--------------------------------------------
es(BJsales, model="ZZZ", h=12, holdout=TRUE, xreg=xregExpander(x), xregDo="select")

## ----es_N2457_xreg_formula----------------------------------------------------
formula(ourModel)

## ----es_N2457_M3, eval=FALSE--------------------------------------------------
#  es(M3$N2457, interval=TRUE, silent=FALSE)

