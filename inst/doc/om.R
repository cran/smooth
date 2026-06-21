## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(fig.width=6, fig.height=4, fig.path='Figs/', fig.show='hold',
                      warning=FALSE, message=FALSE)
library(smooth)

## ----data---------------------------------------------------------------------
set.seed(41)
y <- ts(c(rpois(20, 0.25), rpois(20, 0.5), rpois(20, 1),
          rpois(20, 2),    rpois(20, 3),    rpois(20, 5)))

## ----etsManual----------------------------------------------------------------
omETS <- om(y, model="MNN", occurrence="odds-ratio", h=10, holdout=TRUE)
omETS
plot(omETS, 7)

## ----etsAuto------------------------------------------------------------------
omETSAuto <- om(y, occurrence="odds-ratio", h=10, holdout=TRUE)
omETSAuto

## ----iETS---------------------------------------------------------------------
adam(y, "MNN", occurrence=omETS, h=10, holdout=TRUE, silent=FALSE)

## ----arima--------------------------------------------------------------------
omARIMA <- om(y, model="NNN",
              orders=list(ar=1, i=0, ma=1),
              occurrence="odds-ratio", h=10, holdout=TRUE)
omARIMA
plot(omARIMA, 7)

## ----regression---------------------------------------------------------------
data(Seatbelts)
highDeaths <- as.integer(Seatbelts[, "DriversKilled"] > median(Seatbelts[, "DriversKilled"]))
ySeat <- ts(cbind(highDeaths, law=Seatbelts[, "law"]), start=c(1969, 1), frequency=12)
omReg <- om(ySeat, model="NNN",
            occurrence="odds-ratio", regressors="use",
            h=12, holdout=TRUE)
omReg
plot(omReg, 7)

## ----omg----------------------------------------------------------------------
omgModel <- omg(y, modelA="MNN", modelB="ANN", h=10, holdout=TRUE)
omgModel
plot(omgModel, 7)

## ----autoOmAll----------------------------------------------------------------
autoOmModel <- auto.om(y, model="MNN", h=10, holdout=TRUE)
autoOmModel

## ----autoOmARIMA--------------------------------------------------------------
autoOmARIMA <- auto.om(y, model="MNN",
                       orders=list(ar=2, i=1, ma=2, select=TRUE),
                       h=10, holdout=TRUE)
autoOmARIMA

## ----autoOmSubset-------------------------------------------------------------
autoOmSubset <- auto.om(y, model="MNN",
                        occurrence=c("fixed", "odds-ratio", "inverse-odds-ratio"),
                        h=10, holdout=TRUE)
autoOmSubset

