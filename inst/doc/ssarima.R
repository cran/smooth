## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(fig.width=6, fig.height=4, fig.path='Figs/', fig.show='hold',
                      warning=FALSE, message=FALSE)

## ----load_libraries, message=FALSE, warning=FALSE-----------------------------
require(smooth)

## ----ssarima_N2457------------------------------------------------------------
ssarima(AirPassengers, h=12, silent=FALSE)

## ----ssarima_N2457_orders-----------------------------------------------------
ssarima(AirPassengers, orders=list(ar=c(0,1),i=c(1,0),ma=c(1,1)), lags=c(1,12), h=12)

## ----auto_ssarima_N2457-------------------------------------------------------
auto.ssarima(AirPassengers, h=12)

## ----auto_ssarima_N1683-------------------------------------------------------
auto.ssarima(AirPassengers, h=12, initial="backcasting")
auto.ssarima(AirPassengers, h=12, initial="optimal")

## ----ssarima_N2457_orders_multiple_seasonalities, eval=FALSE------------------
#  ssarima(AirPassengers, orders=list(ar=c(0,0,1),i=c(1,0,0),ma=c(1,1,1)), lags=c(1,6,12), h=12, silent=FALSE)

## ----es_N2457_xreg_create-----------------------------------------------------
x <- cbind(rnorm(length(AirPassengers),50,3),rnorm(length(AirPassengers),100,7))

## ----auto_ssarima_N2457_xreg--------------------------------------------------
ourModel <- auto.ssarima(AirPassengers, h=12, holdout=TRUE, xreg=x)

## ----auto_ssarima_N2457_xreg_update-------------------------------------------
ssarima(AirPassengers, model=ourModel, h=12, holdout=FALSE, xreg=x, interval=TRUE)

## ----auto_ssarima_N2457_combination-------------------------------------------
ssarima(AirPassengers, h=12, holdout=FALSE, interval=TRUE, combine=TRUE)

## ----mssarima_N2457_orders_multiple_seasonalities-----------------------------
msarima(AirPassengers, orders=list(ar=c(0,0,1),i=c(1,0,0),ma=c(1,1,1)),lags=c(1,6,12),h=12, silent=FALSE)

