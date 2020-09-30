# Coding Club Workshop 1 - R Basics
# Learning how to import and explore data, and make graphs about Edinburgh's biodiversity
# Written by Mara Fischer 30/09/2020 University of Edinburgh#

getwd()

#Import data set
read.csv('edidiv.csv')
edidiv <- read.csv("C:/Users/maraf/OneDrive - University of Edinburgh/Uni/Year 4/Data Science/Tutorial 1/edidiv.csv")

# Check data
head(edidiv)                # Displays the first few rows
tail(edidiv)                # Displays the last rows
str(edidiv)                 # Tells you whether the variables are continuous, integers, categorical or characters

# CHanging variable type from character to factor
head(edidiv$taxonGroup) # Displays first few rows of this column only
class(edidiv$taxonGroup) # Tells you what type of variable it is
edidiv$taxonGroup <- as.factor(edidiv$taxonGroup) # Transform character values in taxongroup into factor values: original edidiv$taxonGroup gets overwritten
edidiv$taxonGroup # Now a factor with 11 levels

# Calculate species richness
# Split data set into taxonomic groups

summary(edidiv$taxonGroup)
Beetle <- filter(edidiv, taxonGroup == "Beetle")
# The first argument of the function is the data frame, the second argument is the condition you want to filter on. Because we only want the beetles here, we say: the variable taxonGroup MUST BE EXACTLY (==) Beetle - drop everything else from the dataset. (R is case-sensitive so it's important to watch your spelling! "beetle" or "Beetles" would not have worked here.)
Bird <- filter(edidiv, taxonGroup == "Bird")
Butterfly <- filter(edidiv, taxonGroup == "Butterfly")
Dragonfly <- filter(edidiv, taxonGroup == "Dragonfly")
Flowering.Plants <- filter(edidiv, taxonGroup == "Flowering.Plants")
Fungus <- filter(edidiv, taxonGroup == "Fungus")
Hymenopteran <- filter(edidiv, taxonGroup == "Hymenopteran")
Lichen <- filter(edidiv, taxonGroup == "Lichen")
Liverwort <- filter(edidiv, taxonGroup == "Liverwort")
Mammal <- filter(edidiv, taxonGroup == "Mammal")
Mollusc <- filter(edidiv, taxonGroup == "Mollusc")

# To calculate species richness combine two functions: unique(), which identifies different species, and length(), which counts them
a <- length(unique(Beetle$taxonName)) 
b <- length(unique(Bird$taxonName))
a # no of distinct beetle species in the record
b # no of distinct bird species in the record
# You can choose whatever names you want for your objects
# Repeat for all other taxa
c <- length(unique(Butterfly$taxonName))
d <- length(unique(Dragonfly$taxonName))
e <- length(unique(Flowering.Plants$taxonName))
f <- length(unique(Fungus$taxonName))
g <- length(unique(Hymenopteran$taxonName))
h <- length(unique(Lichen$taxonName))
i <- length(unique(Liverwort$taxonName))
j <- length(unique(Mammal$taxonName))
k <- length(unique(Mollusc$taxonName))

# Create a vector and plot it
# Vector = one-dimensional 
# use c() function; stands for concatenate, or chain if that makes it easier to remember
# add labels with the names()function, so that the values are not coming out of the blue
biodiv <- c(a,b,c,d,e,f,g,h,i,j,k)     # We are chaining together all the values; pay attention to the object names you have calculated and their order
names(biodiv) <- c("Beetle",
                   "Bird",
                   "Butterfly",
                   "Dragonfly",
                   "Flowering.Plants",
                   "Fungus",
                   "Hymenopteran",
                   "Lichen",
                   "Liverwort",
                   "Mammal",
                   "Mollusc")

# Create barplot
barplot(biodiv, xlab = 'Taxa', ylab = 'Number of species', ylim = c(0,600), cex.names= 1.5, cex.axis=1.5, cex.lab=1.5)
dev.off()
help(barplot)     # For help with the barplot() function
help(par)         # For help with plotting in general
# The cex code increases the font size when greater than one (and decreases it when less than one).
png("Species_richness.png", width=1600, height=600)
help(png)

# Creating and plotting a data frame
# Data frames are tables of values: they have a two-dimensional structure with rows and columns, where each column can have a different data type.

# Creating an object called "taxa" that contains all the taxa names
taxa <- c("Beetle",
          "Bird",
          "Butterfly",
          "Dragonfly",
          "Flowering.Plants",
          "Fungus",
          "Hymenopteran",
          "Lichen",
          "Liverwort",
          "Mammal",
          "Mollusc")

# Turning this object into a factor, i.e. a categorical variable
taxa_f <- factor(taxa)

# Combining all the values for the number of species in an object called richness
richness <- c(a,b,c,d,e,f,g,h,i,j,k)

# Creating the data frame from the two vectors
biodata <- data.frame(taxa_f, richness)

# Saving the file
write.csv(biodata, file="biodata.csv")  
# it will be saved in your working directory

png("barplot2.png", width=1600, height=600)
barplot(biodata$richness, names.arg=c("Beetle",
                                      "Bird",
                                      "Butterfly",
                                      "Dragonfly",
                                      "Flowering.Plants",
                                      "Fungus",
                                      "Hymenopteran",
                                      "Lichen",
                                      "Liverwort",
                                      "Mammal",
                                      "Mollusc"),
        xlab="Taxa", ylab="Number of species", ylim=c(0,600))
dev.off()

# Bird wingspan challenge
read.csv('wingspan.csv')

wingspan <- read.csv("C:/Users/maraf/OneDrive - University of Edinburgh/Uni/Year 4/Data Science/Tutorial 1/wingspan.csv")
head(wingspan)
tail(wingspan)
str(wingspan)
summary(wingspan$bird_sp)
summary(wingspan$wingspan)

# Group measurements of wingspan for each species
sparrow <- filter(wingspan, bird_sp == "sparrow")
kingfisher <- filter(wingspan, bird_sp == "kingfisher")
eagle <- filter(wingspan, bird_sp == "eagle")
hummingbird <- filter(wingspan, bird_sp == "hummingbird")

# Creating vector of wingspan
sparrow_span <- c(sparrow$wingspan)
kingfisher_span <- c(kingfisher$wingspan)
eagle_span <- c(eagle$wingspan)
hummingbird_span <- c(hummingbird$wingspan)

# Calculate mean wingspan for each species
sparrow_mean <- mean(sparrow_span)
kingfisher_mean <- mean(kingfisher_span)
eagle_mean <- mean(eagle_span)
hummingbird_mean <- mean(hummingbird_span)

#Group all means into one vector
mean_span <- c(sparrow_mean,kingfisher_mean,eagle_mean, hummingbird_mean)
names(mean_span) <- c("sparrow", "kingfisher", "eagle", "hummingbird")

barplot(mean_span, xlab = 'Bird species', ylab = 'Mean wingspan (cm)', ylim = c(0,200), cex.names= 1.5, cex.axis=1.5, cex.lab=1.5)

png("Wingspan_plot2.png", width = 1600, height = 600)
barplot(mean_span, xlab = 'Bird species', ylab = 'Mean wingspan (cm)', ylim = c(0,200), cex.names= 1.5, cex.axis=1.5, cex.lab=1.5)
dev.off()
