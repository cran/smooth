## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.align="center",
  fig.height=4,
  fig.width=6,
  fig.path='Figs/',
  fig.show='hold',
  warning=FALSE,
  message=FALSE
)

## ----load_libraries, message=FALSE, warning=FALSE-----------------------------
require(greybox)
require(smooth)

## ----ETSMMM-------------------------------------------------------------------
testModel <- adam(AirPassengers, "MMM", lags=c(1,12), distribution="dnorm",
                  h=12, holdout=TRUE)
summary(testModel)
plot(forecast(testModel,h=12,interval="prediction"))

## ----ETSMMMPrint--------------------------------------------------------------
testModel

## ----ETSMMMForecast-----------------------------------------------------------
plot(forecast(testModel,h=18,interval="simulated"))

## ----ETSMMMPlots--------------------------------------------------------------
par(mfcol=c(3,4))
plot(testModel,which=c(1:11))
par(mfcol=c(1,1))
plot(testModel,which=12)

## ----ETSLoss------------------------------------------------------------------
lossFunction <- function(actual, fitted, B){
  return(sum(abs(actual-fitted)^3))
}
testModel <- adam(BJsales, "AAN", silent=FALSE, loss=lossFunction,
                  h=12, holdout=TRUE)
testModel

## ----ETSDGNorm----------------------------------------------------------------
testModel <- adam(BJsales, "MMN", silent=FALSE, distribution="dgnorm", shape=3,
                  h=12, holdout=TRUE)

## ----ETSSelection-------------------------------------------------------------
testModel <- adam(AirPassengers, "ZXZ", lags=c(1,12), silent=FALSE,
                  h=12, holdout=TRUE)
testModel

## ----ETSCombination-----------------------------------------------------------
testModel <- adam(AirPassengers, "CXC", lags=c(1,12),
                  h=12, holdout=TRUE)
testForecast <- forecast(testModel,h=18,interval="semiparametric", level=c(0.9,0.95))
testForecast
plot(testForecast)

## ----ETSInterval--------------------------------------------------------------
forecast(testModel,h=18,interval="semiparametric", level=c(0.9,0.95,0.99), side="upper")

## ----GUMData------------------------------------------------------------------
set.seed(41)
ordersGUM <- c(1,1,1)
lagsGUM <- c(1,48,336)
initialGUM1 <- -25381.7
initialGUM2 <- c(23955.09, 24248.75, 24848.54, 25012.63, 24634.14, 24548.22, 24544.63, 24572.77,
                 24498.33, 24250.94, 24545.44, 25005.92, 26164.65, 27038.55, 28262.16, 28619.83,
                 28892.19, 28575.07, 28837.87, 28695.12, 28623.02, 28679.42, 28682.16, 28683.40,
                 28647.97, 28374.42, 28261.56, 28199.69, 28341.69, 28314.12, 28252.46, 28491.20,
                 28647.98, 28761.28, 28560.11, 28059.95, 27719.22, 27530.23, 27315.47, 27028.83,
                 26933.75, 26961.91, 27372.44, 27362.18, 27271.31, 26365.97, 25570.88, 25058.01)
initialGUM3 <- c(23920.16, 23026.43, 22812.23, 23169.52, 23332.56, 23129.27, 22941.20, 22692.40,
                 22607.53, 22427.79, 22227.64, 22580.72, 23871.99, 25758.34, 28092.21, 30220.46,
                 31786.51, 32699.80, 33225.72, 33788.82, 33892.25, 34112.97, 34231.06, 34449.53,
                 34423.61, 34333.93, 34085.28, 33948.46, 33791.81, 33736.17, 33536.61, 33633.48,
                 33798.09, 33918.13, 33871.41, 33403.75, 32706.46, 31929.96, 31400.48, 30798.24,
                 29958.04, 30020.36, 29822.62, 30414.88, 30100.74, 29833.49, 28302.29, 26906.72,
                 26378.64, 25382.11, 25108.30, 25407.07, 25469.06, 25291.89, 25054.11, 24802.21,
                 24681.89, 24366.97, 24134.74, 24304.08, 25253.99, 26950.23, 29080.48, 31076.33,
                 32453.20, 33232.81, 33661.61, 33991.21, 34017.02, 34164.47, 34398.01, 34655.21,
                 34746.83, 34596.60, 34396.54, 34236.31, 34153.32, 34102.62, 33970.92, 34016.13,
                 34237.27, 34430.08, 34379.39, 33944.06, 33154.67, 32418.62, 31781.90, 31208.69,
                 30662.59, 30230.67, 30062.80, 30421.11, 30710.54, 30239.27, 28949.56, 27506.96,
                 26891.75, 25946.24, 25599.88, 25921.47, 26023.51, 25826.29, 25548.72, 25405.78,
                 25210.45, 25046.38, 24759.76, 24957.54, 25815.10, 27568.98, 29765.24, 31728.25,
                 32987.51, 33633.74, 34021.09, 34407.19, 34464.65, 34540.67, 34644.56, 34756.59,
                 34743.81, 34630.05, 34506.39, 34319.61, 34110.96, 33961.19, 33876.04, 33969.95,
                 34220.96, 34444.66, 34474.57, 34018.83, 33307.40, 32718.90, 32115.27, 31663.53,
                 30903.82, 31013.83, 31025.04, 31106.81, 30681.74, 30245.70, 29055.49, 27582.68,
                 26974.67, 25993.83, 25701.93, 25940.87, 26098.63, 25771.85, 25468.41, 25315.74,
                 25131.87, 24913.15, 24641.53, 24807.15, 25760.85, 27386.39, 29570.03, 31634.00,
                 32911.26, 33603.94, 34020.90, 34297.65, 34308.37, 34504.71, 34586.78, 34725.81,
                 34765.47, 34619.92, 34478.54, 34285.00, 34071.90, 33986.48, 33756.85, 33799.37,
                 33987.95, 34047.32, 33924.48, 33580.82, 32905.87, 32293.86, 31670.02, 31092.57,
                 30639.73, 30245.42, 30281.61, 30484.33, 30349.51, 29889.23, 28570.31, 27185.55,
                 26521.85, 25543.84, 25187.82, 25371.59, 25410.07, 25077.67, 24741.93, 24554.62,
                 24427.19, 24127.21, 23887.55, 24028.40, 24981.34, 26652.32, 28808.00, 30847.09,
                 32304.13, 33059.02, 33562.51, 33878.96, 33976.68, 34172.61, 34274.50, 34328.71,
                 34370.12, 34095.69, 33797.46, 33522.96, 33169.94, 32883.32, 32586.24, 32380.84,
                 32425.30, 32532.69, 32444.24, 32132.49, 31582.39, 30926.58, 30347.73, 29518.04,
                 29070.95, 28586.20, 28416.94, 28598.76, 28529.75, 28424.68, 27588.76, 26604.13,
                 26101.63, 25003.82, 24576.66, 24634.66, 24586.21, 24224.92, 23858.42, 23577.32,
                 23272.28, 22772.00, 22215.13, 21987.29, 21948.95, 22310.79, 22853.79, 24226.06,
                 25772.55, 27266.27, 28045.65, 28606.14, 28793.51, 28755.83, 28613.74, 28376.47,
                 27900.76, 27682.75, 27089.10, 26481.80, 26062.94, 25717.46, 25500.27, 25171.05,
                 25223.12, 25634.63, 26306.31, 26822.46, 26787.57, 26571.18, 26405.21, 26148.41,
                 25704.47, 25473.10, 25265.97, 26006.94, 26408.68, 26592.04, 26224.64, 25407.27,
                 25090.35, 23930.21, 23534.13, 23585.75, 23556.93, 23230.25, 22880.24, 22525.52,
                 22236.71, 21715.08, 21051.17, 20689.40, 20099.18, 19939.71, 19722.69, 20421.58,
                 21542.03, 22962.69, 23848.69, 24958.84, 25938.72, 26316.56, 26742.61, 26990.79,
                 27116.94, 27168.78, 26464.41, 25703.23, 25103.56, 24891.27, 24715.27, 24436.51,
                 24327.31, 24473.02, 24893.89, 25304.13, 25591.77, 25653.00, 25897.55, 25859.32,
                 25918.32, 25984.63, 26232.01, 26810.86, 27209.70, 26863.50, 25734.54, 24456.96)
y <- sim.gum(orders=ordersGUM, lags=lagsGUM, nsim=1, frequency=336, obs=3360,
             measurement=rep(1,3), transition=diag(3), persistence=c(0.045,0.162,0.375),
             initial=rbind(initialGUM1,initialGUM2,initialGUM3))$data

## ----ETSMultiFreq-------------------------------------------------------------
testModel <- adam(y, "MMdM", lags=c(1,48,336), initial="backcasting",
                  silent=FALSE, h=336, holdout=TRUE)
testModel

## ----ETSMultiFreq10000--------------------------------------------------------
testModel <- adam(y, "MMdM", lags=c(1,48,336), initial="backcasting",
                  silent=FALSE, h=336, holdout=TRUE, maxeval=10000)
testModel

## ----ETSMultiFreqB, eval=FALSE, echo=TRUE-------------------------------------
# testModel$B

## ----ETSMultiFreqBReused------------------------------------------------------
testModel <- adam(y, "MMdM", lags=c(1,48,336), initial="backcasting",
                  silent=FALSE, h=336, holdout=TRUE, B=testModel$B)
testModel

## ----ETSMultiFreqBeta---------------------------------------------------------
testModel <- adam(y, "MMdM", lags=c(1,48,336), initial="backcasting",
                  silent=TRUE, h=336, holdout=TRUE, persistence=list(beta=0.1))
testModel

## ----ETSMultiFreqOccurrence---------------------------------------------------
testModel <- adam(rpois(120,0.5), "MNN", silent=FALSE, h=12, holdout=TRUE,
                  occurrence="odds-ratio")
testModel

## ----ADAMETSvES---------------------------------------------------------------
adamModel <- adam(AirPassengers, "CCC",
                  h=12, holdout=TRUE)
esModel <- es(AirPassengers, "CCC",
              h=12, holdout=TRUE)
"adam:"
adamModel
"es():"
esModel

## ----ARIMA022-----------------------------------------------------------------
testModel <- adam(BJsales, "NNN", silent=FALSE, orders=c(0,2,2),
                  h=12, holdout=TRUE)
testModel

## ----ARIMADLNorm--------------------------------------------------------------
testModel <- adam(AirPassengers, "NNN", silent=FALSE, lags=c(1,12),
                  orders=list(ar=c(1,1),i=c(1,1),ma=c(2,2)), distribution="dlnorm",
                  h=12, holdout=TRUE)
testModel

## ----ARIMADrift---------------------------------------------------------------
testModel <- adam(AirPassengers, "NNN", silent=FALSE, lags=c(1,12), constant=TRUE,
                  orders=list(ar=c(1,1),i=c(1,1),ma=c(2,2)), distribution="dnorm",
                  h=12, holdout=TRUE)
testModel

## ----ARIMABProvided-----------------------------------------------------------
testModel <- adam(AirPassengers, "NNN", silent=FALSE, lags=c(1,12),
                  orders=list(ar=c(1,1),i=c(1,1),ma=c(2,2)), distribution="dnorm",
                  arma=list(ar=c(0.1,0.1), ma=c(-0.96, 0.03, -0.12, 0.03)),
                  h=12, holdout=TRUE)
testModel

## ----ARIMAInitials------------------------------------------------------------
testModel <- adam(AirPassengers, "NNN", silent=FALSE, lags=c(1,12),
                  orders=list(ar=c(1,1),i=c(1,1),ma=c(2,0)), distribution="dnorm",
                  initial=list(arima=AirPassengers[1:24]),
                  h=12, holdout=TRUE)
testModel

## ----ADAMX1-------------------------------------------------------------------
BJData <- cbind(BJsales,BJsales.lead)
testModel <- adam(BJData, "AAN", h=18, silent=FALSE)

## ----ADAMXLags----------------------------------------------------------------
BJData <- cbind(as.data.frame(BJsales),as.data.frame(xregExpander(BJsales.lead,c(-7:7))))
colnames(BJData)[1] <- "y"
testModel <- adam(BJData, "ANN", h=18, silent=FALSE, holdout=TRUE, formula=y~xLag1+xLag2+xLag3)
testModel

## ----ADAMXSelect--------------------------------------------------------------
testModel <- adam(BJData, "ANN", h=18, silent=FALSE, holdout=TRUE, regressors="select")

## ----ADAMXARIMA---------------------------------------------------------------
testModel <- adam(BJData, "NNN", h=18, silent=FALSE, holdout=TRUE, regressors="select", orders=c(0,1,1))

## ----ADAMARIMA-ETS------------------------------------------------------------
BJData <- BJData[,c("y",names(testModel$initial$xreg))];
testModel <- adam(BJData, "NNN", h=18, silent=TRUE, holdout=TRUE, orders=c(0,1,1),
                  initial=testModel$initial, arma=testModel$arma)
testModel
names(testModel$initial)[1] <- names(testModel$initial)[[1]] <- "level"
testModel2 <- adam(BJData, "ANN", h=18, silent=TRUE, holdout=TRUE,
                   initial=testModel$initial, persistence=testModel$arma$ma+1)
testModel2

## ----ADAMXAdapt---------------------------------------------------------------
testModel <- adam(BJData, "ANN", h=18, silent=FALSE, holdout=TRUE, regressors="adapt")
testModel$persistence

## ----ADAMMixture--------------------------------------------------------------
testModel <- adam(BJData, "AAN", h=18, silent=FALSE, holdout=TRUE, orders=c(1,0,0))
summary(testModel)

## ----ADAMMixtureBackcasting---------------------------------------------------
testModel <- adam(BJData, "AAN", h=18, silent=TRUE, holdout=TRUE, initial="backcasting")
summary(testModel)

## ----AutoADAM-----------------------------------------------------------------
testModel <- auto.adam(BJsales, "XXX", silent=FALSE,
                       distribution=c("dnorm","dlaplace","ds"),
                       h=12, holdout=TRUE)
testModel

## ----AutoADAMParallel, eval=FALSE, echo=TRUE----------------------------------
# testModel <- auto.adam(BJsales, "ZZZ", silent=FALSE, parallel=TRUE,
#                        h=12, holdout=TRUE)

## ----AutoADAMETSARIMA---------------------------------------------------------
testModel <- auto.adam(BJsales, "AAN", orders=list(ar=2,i=0,ma=0), silent=TRUE,
                       distribution=c("dnorm","dlaplace","ds","dgnorm"),
                       h=12, holdout=TRUE)
testModel

## ----AutoADAMETSARIMASelect---------------------------------------------------
testModel <- auto.adam(BJsales, "XXN", orders=list(ar=2,i=2,ma=2,select=TRUE),
                       distribution="default", silent=FALSE,
                       h=12, holdout=TRUE)
testModel

## ----AutoADAMETSOutliers------------------------------------------------------
testModel <- auto.adam(AirPassengers, "PPP", silent=FALSE, outliers="use",
                       distribution="default",
                       h=12, holdout=TRUE)
testModel

