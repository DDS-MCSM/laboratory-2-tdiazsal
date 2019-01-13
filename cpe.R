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

#Download cpe file if not extis
if (!file.exists(cpe.file))
{
  compressed_cpes_url <- "https://nvd.nist.gov/feeds/xml/cpe/dictionary/official-cpe-dictionary_v2.3.xml.zip"
  cpes_filename <- "cpes.zip"
  download.file(compressed_cpes_url, cpes_filename)
  unzip(zipfile = cpes_filename)
}

GetCPEItems <- function(xmlDocument) {
  cpe.raw <- xml2::xml_find_all(xmlDocument, "//d1:cpe-item")
  cpe.title <- xml_text(xml_find_all(cpe.raw, "./d1:title[@xml:lang='en-US']/text()"))
  cpe.name <- xml_text(xml_find_all(cpe.raw, "./@name"))
  cpe.cpe23 <- xml_text(xml_find_all(cpe.raw, "./cpe-23:cpe23-item/@name"))

  # Transform the list to data frame
  df <- data.frame(title = cpe.title,
                   cpe = cpe.cpe23,
                   name = cpe.name,
                   stringsAsFactors = F)



  # return data frame
  return(df);
}


CleanCPEs <- function(cpes){
  #data manipulation - Separate properties
  cpeColumns <- c("standard", "cpeversion", "part",
                  "vendor", "product","version",
                  "update", "edition", "language",
                  "edition_sw","target_sw", "target_host",
                  "other")

  cpes <- tidyr::separate(data = cpes, col = cpe, into = cpeColumns, sep = "(?<=[^\\\\]):", remove = F)
  cpes$standard <- as.factor(cpes$standard)
  cpes$cpeversion <- as.factor(cpes$cpeversion)
  cpes$part <- as.factor(cpes$part)
  cpes$vendor <- as.factor(cpes$vendor)
  cpes$language <- as.factor(cpes$language)
  cpes$target_sw <- as.factor(cpes$target_sw)
  cpes$target_host <- as.factor(cpes$target_host)
  cpes$product <- as.factor(cpes$product)
  cpes$version <- as.factor(cpes$version)
  cpes$update <- as.factor(cpes$update)
  cpes$edition <- as.factor(cpes$edition)
  cpes$edition_sw <- as.factor(cpes$edition_sw)

  return(cpes)
}

ParseCPEData <- function() {
  # load cpes as xml file
  cpes <- xml2::read_xml(x = cpe.file)

  # get CPEs
  cpes <- GetCPEItems(cpes)

  # transform, clean, arrange parsed cpes as data frame
  df <- CleanCPEs(cpes)

  # return data frame
  return(df)

}


