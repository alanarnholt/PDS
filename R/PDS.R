#' The PDS Package
#' 
#' Data sets for \emph{Passion Driven Statistics}
#' @name PDS-package
#' @docType package
#' @title The PDS Package
#' @keywords package
NULL
#####################################################################################
#' @name AddHealth
#' @title Adolescent to Adult Health (Wave I)
#' @aliases AddHealth
#' @docType data
#' @description The National Longitudinal Study of Adolescent to Adult Health (Add Health) is a longitudinal study of a nationally representative sample of adolescents in grades 7-12 in the United States during the 1994-95 school year. 
#' @format A data frame with 6504 observations on 2829 variables
#' @source \url{http://www.cpc.unc.edu/projects/addhealth}
#' @details See the code books in inst/CodeBooks for details
#' @examples
#' dim(AddHealth)
#' @keywords datasets
"AddHealth"
#####################################################################################
#' @name gapminder
#' @title Country level statistics
#' @aliases gapminder
#' @docType data
#' @description Country level statistics
#' @source \url{http://www.gapminder.org}
#' @details See the code books in inst/CodeBooks for details
#' @examples
#' dim(gapminder)
#' @keywords datasets
"gapminder"
#####################################################################################
#' @name marscrater_pds
#' @title Mars Craters
#' @aliases marscrater_pds
#' @docType data
#' @description marscrater
#' @format A data frame with 384343 observations on 10 variables
#' @details See the code books in inst/CodeBooks for details
#' @examples
#' dim(marscrater_pds)
#' @keywords datasets
"marscrater_pds"
#####################################################################################
#' @name NESARC
#' @title National Epidemiologic Survey on Alcohol and Related Conditions
#' @aliases NESARC
#' @docType data
#' @description NESARC
#' @format A data frame with 43093 observations on 3008 variables
#' @details See the code books in inst/CodeBooks for details
#' @source \url{http://pubs.niaaa.nih.gov/publications/AA70/AA70.htm}
#' @examples
#' dim(NESARC)
#' @keywords datasets
"NESARC"
#####################################################################################
#' @name frustration
#' @title Frustation by Academic Major
#' @aliases frustration
#' @docType data
#' @description Frustation by Academic Major
#' @source \url{https://oli.cmu.edu/jcourse/workbook/activity/page?context=434b8ad280020ca60166a71faa2caf60}
#' @examples
#' boxplot(Frustration.Score ~ Major, data = frustration)
#' @keywords datasets
"frustration"
#####################################################################################
#' @name signdist
#' @title Sign Distance
#' @aliases signdist
#' @docType data
#' @description For n=30 drivers, the driver's age and the maximum distance at which the driver can read a highway sign at night. 
#' @source \url{https://oli.cmu.edu/jcourse/workbook/activity/page?context=434b8b4980020ca60017028aafe3258a}
#' @examples
#' plot(Distance ~ Age, data = signdist)
#' @keywords datasets
"signdist"

