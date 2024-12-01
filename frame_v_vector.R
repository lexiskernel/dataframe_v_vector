library(tigris)

counties <- list_counties('georgia')

county_names <- data.frame(counties$county)
names(county_names) <- c("county_name")

multipliers <- c(1, 2, 4, 8, 16, 32, 64, 128, 512, 1024, 2048, 4096, 8192, 16384)

process_times_frames <- list()
process_times_vectors <- list()

for (r in 1:length(multipliers)) { 
  
  #replicate dataframe n times
  n <- multipliers[r]
  county_names_n <- do.call("rbind", replicate(n, county_names, simplify = FALSE))
  
  ##process dataframe column
  name_lengths <- list()
  
  start <- Sys.time()
  for (i in 1:nrow(county_names_n)) { 
    
    county <- county_names_n[i,]
    print(county)
    name_lengths[[i]] <- nchar(county)
    
   }
  end <- Sys.time()
  
  frame_process_time <- difftime(end, start, units="secs")
  
  process_times_frames[[r]] <- frame_process_time
  
  ##process vector
  county_names_n_vector <- as.vector(county_names_n['county_name'])
  
  name_lengths <- list()
  
  start <- Sys.time()
  for (i in 1:length(county_names_n_vector[[1]])) { 
    
    county <- county_names_n_vector[[1]][i]
    print(county)
    name_lengths[[i]] <- nchar(county)
    
   }
  end <- Sys.time()
  
  vector_process_time <- difftime(end, start, units="secs")
  
  process_times_vectors[[r]] <- vector_process_time
  
  
  }
