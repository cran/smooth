## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(fig.width=6, fig.height=4, fig.path='Figs/', fig.show='hold',
                      warning=FALSE, message=FALSE)

## ----load_libraries, message=FALSE, warning=FALSE-----------------------------
require(smooth)

## ----ces_N2457----------------------------------------------------------------
ces(BJsales, h=12, holdout=TRUE, silent=FALSE)

## ----auto_ces_N2457-----------------------------------------------------------
auto.ces(AirPassengers, h=12, holdout=TRUE, silent=FALSE)

## ----auto_ces_N2457_optimal---------------------------------------------------
ces(BJsales, h=12, holdout=TRUE, initial="back")

## ----es_N2457_xreg_create-----------------------------------------------------
BJData <- cbind(y=BJsales, x=BJsales.lead)
cesModel <- ces(BJData, h=12, holdout=TRUE, regressors="use")

## -----------------------------------------------------------------------------
forecast(cesModel, h=12, interval="pred") |> plot()

