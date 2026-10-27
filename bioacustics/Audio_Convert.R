#Code meant for turning all the mp3s to wavs, single channel, and run normalization on all of them 

library(av)
library(tuneR)

setwd("")
inputdir<-("")
outputdir <-("")

files<-list.files(getwd(), pattern = c("\\.mp3$","\\wav$"), full.names = TRUE)


failed <- character()

for (i in seq_along(files)) {
  
  file_name <- tools::file_path_sans_ext(basename(files[i]))
  wav_output_path <- file.path(outputdir, paste0(file_name, ".wav"))
 
  if (file.size(files[i]) == 0) {
    message("Empty file, skipping: ", files[i])
    failed <- c(failed, files[i])
    next
  }
  
  tryCatch({
    av::av_audio_convert(files[i], output = wav_output_path,
                         format = "wav", channels = 1)
    
    wave_obj <- readWave(wav_output_path)
    normalized_wave <- normalize(wave_obj, unit = "1", level = 1)
    writeWave(normalized_wave, filename = wav_output_path)
    
  }, error = function(e) {
    message("FAILED: ", files[i], " -> ", conditionMessage(e))
    failed <<- c(failed, files[i])
    if (file.exists(wav_output_path)) file.remove(wav_output_path)
  })
}

failed
  


