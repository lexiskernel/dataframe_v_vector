library(Rcpp)
sourceCpp('string_length.cpp')


#string_vector <- createStringVector()

string_length <- stringLength('tosha')


animal <- c('koala', 'hedgehog', 'sloth', 'panda')
animals_frame <- data.frame(animal)
n <- 1
animals_frame_n <- do.call("rbind", replicate(n, animals_frame, simplify = FALSE))

animals_frame_n['length'] <- 'length'

start <- Sys.time()
for (i in 1:nrow(animals_frame_n)) { 
  
  row <- animals_frame_n['animal'][i,]
  animals_frame_n['length'][i,] <- stringLength(row)
  print(stringLength(row))
    
}

end <- Sys.time()

frame_time_cpp <- difftime(start, end, units="secs")

start <- Sys.time()
for (i in 1:nrow(animals_frame_n)) { 
  
  row <- animals_frame_n['animal'][i,]
  animals_frame_n['length'][i,] <- nchar(row)
  print(stringLength(row))
  
}

end <- Sys.time()


frame_time_R <- difftime(start, end, units="secs")


p <- as.data.frame(c(frame_time_cpp, frame_time_R))


start <- Sys.time()

r <- animals_frame_n['animal']
animals_frame_lengths <- stringLength_vector(r)


end <- Sys.time()


frame_time_R <- difftime(start, end, units="secs")



animals_frame_n_vector <- as.vector(animals_frame_n['animal'])
animals_frame_n_vector[[1]][1]


animals_length <- vector()
animals_length <- c('l','l','l','l')

start <- Sys.time()
for (i in 1:length(animals_frame_n_vector[[1]])) { 
  
  row <- animals_frame_n_vector[[1]][i]
  animals_length[[i]] <- nchar(row)
  print(stringLength(row))
  
}

end <- Sys.time()


frame_time_R_vector <- difftime(start, end, units="secs")






