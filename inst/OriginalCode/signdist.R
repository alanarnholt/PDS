site <- "http://mathfaculty.fullerton.edu/mori/Math120/Data/ascii/signdist.txt"
signdist <- read.table(site, header = TRUE, sep = "")
rm(site)
save.image(file="./data/signdist.Rdata")
