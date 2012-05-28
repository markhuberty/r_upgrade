## Install script to install suite of R packages
## Uses CRAN task views to get large swaths of packages; add others via
## install.packages() if desired.
repo="http://cran.cnr.berkeley.edu"

install.packages("ctv", dependencies=TRUE,
                 repos=repo
                 )

library(ctv)

install.views(c("Econometrics", 
                "SocialSciences", 	
                "Spatial", 	
                "TimeSeries", 
                "Cluster", 
                "Graphics", 
                "HighPerformanceComputing",
                "gR",
                "NaturalLanguageProcessing"
                ),
              repos=repo
              )


