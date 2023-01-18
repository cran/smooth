## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(fig.width=6, fig.height=4, fig.path='Figs/', fig.show='hold',
                      warning=FALSE, message=FALSE)

## ----load_libraries, message=FALSE, warning=FALSE-----------------------------
require(smooth)

## ----ces_N2457----------------------------------------------------------------
ces(BJsales, h=12, holdout=TRUE, silent=FALSE)

## ----auto_ces_N2457-----------------------------------------------------------
auto.ces(BJsales, h=12, holdout=TRUE, interval="p", silent=FALSE)

## ----auto_ces_N2457_optimal---------------------------------------------------
auto.ces(BJsales, h=12, holdout=TRUE, initial="o", interval="sp")

## ----es_N2457_xreg_create-----------------------------------------------------
x <- cbind(rnorm(length(BJsales),50,3),rnorm(length(BJsales),100,7))

## ----auto_ces_N2457_xreg_simple-----------------------------------------------
auto.ces(BJsales, h=12, holdout=TRUE, xreg=x, regressors="select", interval="p")

