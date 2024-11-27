#We manually changed a number of parameters in the code: Excel sheets, columns, labels on the histogram.


library(readxl)
wj1 <- read_excel("~/Downloads/MSCWJ-1.xlsx",1) #Сhange the numbers 1,2, etc. to switch between the sheets of the Excel file.
df2 <- read_excel("~/Downloads/DF2.xlsx",1)
xpa <- read_excel("~/Downloads/XPA.xlsx",1)

# Firstly, we conduct Hartigans’ dip test for unimodality or multimodality with dip.test() function available in diptest package (Maechler, 2021)
# Maechler, M. (2021). diptest: Hartigan’s Dip Test Statistic for Unimodality – Corrected. R package version 0.76-0.

#Select one of the lines of code with the required cells
data <- wj1[,1] # choose your column
data <- df2[,1]
data <- xpa[,3]

data <- dplyr::pull(data)
data <- na.omit(data)

hist(data, # histogram
     breaks = 20,
     col="lightblue", # column color
     border="black",
     prob = TRUE, # show densities instead of frequencies
     xlab = "Mean speed, microns per hour",
     main = "DF-2 passages  8") # MSCWJ-1 passages  6, 15, 26, 31
                              # DF-2 passages  8, 14, 21, 28
                                # XPA passages  3, 13, 19

lines(density(data), # density plot
      lwd = 2, # thickness of line
      col = "red")

library(diptest)
dip.test(data)

# Secondly, we use is.modal() function available in LaplacesDemon package (Statisticat, 2021).
# Statisticat, LLC. (2021). LaplacesDemon: Complete Environment for Bayesian Inference. Bayesian-Inference.com. R package version 16.1.6.

library(LaplacesDemon)
is.unimodal(data)
is.multimodal(data)
is.bimodal(data)
is.trimodal(data)
Modes(data)$modes