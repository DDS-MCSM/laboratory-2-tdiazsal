#******************************************************************************#
#                                                                              #
#                          Lab 2 - CPE Standard                                #
#                                                                              #
#              Arnau Sangra Rocamora - Data Driven Securty                     #
#                                                                              #
#******************************************************************************#

#Library Requeriement xml2
if(!require("xml2")){
  install.packages("xml2")
  library("xml2")
}
#Library Requeriement tidyr
if(!require("tidyr")){
  install.packages("tidyr")
  library("tidyr")
}

#Define URI Document XML
cpe.file <- "./official-cpe-dictionary_v2.3.xml"


GetCPEItems <- function(cpe.raw) {
  cpe <- NewCPEItem()
  cpe.raw <- xml2::xml_find_all(cpe.raw)

  # transform the list to data frame

  # return data frame
}

CleanCPEs <- function(cpes){

  # data manipulation

  return(data.frame())
}

ParseCPEData <- function(cpe.file) {

  # load cpes as xml file
  cpes <- xml2::read_xml(x = cpe.file)

  # get CPEs
  cpes <- GetCPEItems(cpes)

  # transform, clean, arrange parsed cpes as data frame
  df <- CleanCPEs(cpes)

  # return data frame
  return(df)
}
