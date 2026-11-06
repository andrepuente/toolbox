#Simnulation for the sporophilas


library(ohun)
library(factoextra)
library(FactoMineR)
library(dplyr)
library(soundgen)
library(seewave)

#Set wd
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
files <-"audios"
files<-list.files(files, full.names = TRUE)

#Modulation spectrum ----
results <-list()
for (i in seq_along(files)) {
  
  output <- modulationSpectrum(
    files[i], amRes=NULL,windowLength = 0.2, step=2, plot= F,
    roughRange = 100)
  
  results[[i]]<-  as.data.frame(output$summary)
}
modulationsp<-bind_rows(results)


#Analyze function ----
results1 <-list()

for (i in seq_along(files)) {
  output <- analyze(
    files[i], pitchMethods = c("dom"),loudness = NULL,
    roughness = NULL, nFormants = 0)
  
  results1[[i]]<-  as.data.frame(output$summary)
}
analisis<-bind_rows(results1)



datos <-data.frame(modulations, analisis)

summary(datos)



# Choose a single file to look at MS and spectrogram---

list(files)

aa <- 1

#MS 
modulationSpectrum(
  files[aa],windowLength = 1, step=2)

#Spectrogram
spectrogram(files[aa],windowLength = 15)



