# R Tutorial

# This tutorial provides an overview of R's basic data manipulation functionality
# This is an executable R file; run it in R to better understand what it does.
# for all the gory details, see the R language definition:
# https://cran.r-project.org/doc/manuals/r-release/R-lang.pdf
# advanced R by Hadley Wickham is a great resource
# http://adv-r.had.co.nz/

# Use R for:
# - data manipulation
# - data analysis
# - graphing
# - tables out to excel or latex
#// - web scraping

# In this tutorial:
# Basics: import data (package 'foreign'), browse dataset (subset, head, View, str()), create variables, [commands to explore data]
# functions, apply statements
# dplyr: pipes, merge/append, grouped operations, etc.
# regression
# tables to latex
# graphing: ggplot2

# Properties of R
# "functional" programming language: ideally little or no "state", vectorized code
# there are many ways to do the same thing; this makes R flexible but difficult to learn
# the period "." is not an operator, and is often used in object names.  ex: data.frame

# Finding help
# if you know the command name, type "?command.name" at the R prompt
# if you know the approximate command name, type "?approximate.command.name" at the R prompt
# when using google, include "+R" in your search query to return results containing the string "R"
# ex: viewing documentation for the 'tidyr' package, which can be used to reshape datasets
# google: "+R CRAN tidyr"; click the first link: "CRAN - Package tidyr" for the package overview
# "Reference manual: tidyr.pdf" includes descriptions for all commands in the package
# "Vignettes: Tidy data" providex examples of how to use the package

# Installing packages
# to install, type install.packages('package.name') at the R prompt ">"
# ex: install.packages('dplyr')
# once installed, these packages can be loaded by typing "require('package.name')"
# ex: require('dplyr')

# Miscellaneous
# - There are no block comments in R.  
# - Highlight a block of code and press "control-shift-c" to comment out the whole thing
# - in Rstudio, run a block of code by highlighting it and pressing Cmd-Return (Mac) or Ctrl-Return (Windows and Linux) 
# - in Rstudio, to run the entire program, press Cmd-Shift-Return (Mac) or Ctrl-Shift-Return (Windows and Linux)

# Editorializing
# - give your saved datasets the same name as the R file that created them
# - if you are using lots of loops, you are doing something wrong
# - keep variable names short and informative
# - when creating new variables, indicate relationships to other variables with names
# - ex: the variable "height.max" could store the maximum value of "height"



##########
# Basics

# remove all datasets, functions, etc. from R session memory
rm(list=ls())

# to install packages, type at the R prompt:
# install.packages('case.sensitive.package.name')

# load any required packages 
# if these packages are not installed on your system, you can download them using install.packages()
require(dplyr)
require(tidyr)
require(ggplot2)
require(stargazer)

# to view the working directory
getwd()
# to change working directory 
# setwd('~/your/file/path/here')

# a vector is an array of elements that are all the same type (eg numeric, string, logical)
# create a vector, v
v <- c(1,2,3,4,5)
# view v, the first element of v, and the first three elements of v
# multiple commands on the same line can be separated by a semicolon
v; v[1]; v[1:3]

# operations are performed on every element of the vector
v + 5; v > 2; v %in% c(1,3)
# operations on a single element can be performed as well
v[1] <- v[1] + 5
v

# an equivalent way to define v
v <- 1:5
# create a vector of 10 zeros:
v.a <- rep(0, 10)
# concatenate v and v.a
# objects of the same type can be concatenated with the c() command.  Notice that v was originally defined this way.
v.concatenated <- c(v, v.a)

# objects of different types can be combined as a list
# in this case, a numeric vector, a string vector, and a logical type
list.a <- list(v, c('stuff', 'and', 'nonsense'), TRUE)
# notice that list.a[2] returns a list, whereas list.a[[2]] returns the contents of the 2nd element (a vector)
list.a; list.a[2]; list.a[[2]]; list.a[[2]][3]
# to see the "structure" of the object
str(list.a)

# create another list
list.b <- list(c('other stuff'), FALSE)

# we can make a list of lists
list.c <- list(list.a, list.b)
# or concatenate the two lists into a third list
list.d <- c(list.a, list.b)
str(list.c); str(list.d)

# regular expressions are for pattern matching in strings
# regular expressions are an extensive topic in their own right
# cheat sheet: http://web.mit.edu/hackl/www/lab/turkshop/slides/regex-cheatsheet.pdf
# examples in R: http://stat545.com/block022_regular-expression.html
animal.names <- c('ant', 'bear', 'cat', 'dog', 'deer')
# return all animal names that begin with the letter 'd'
grep('^d', animal.names, value=TRUE)
# return a vector indicating whether the animal name ends with the letter 't'
grepl('t$', animal.names)
# return all animal names that contain a or e
grep('a|e', animal.names, value=TRUE)

# "apply" statements apply a function to each element of a vector or list, and return a vector or list of results
# sapply returns a vector; lapply returns a list
# apply statements should be used rather than for loops.

# test whether each element in a list is a logical type
is.logical(TRUE); is.logical('string')
sapply(list.d, is.logical)



##########
# Data Frames

# in this tutorial we will create data rather than import it
# see ?read.table for commands to importing text files, including .csv files
# the 'foreign' package enables R to import data from Stata (.dta), SAS (.sas7bdat), and SPSS (.sav), among others
# https://cran.r-project.org/web/packages/foreign/foreign.pdf

# a data.frame is the object in which to store a dataset.
# a data.frame is a set of columns of equal length, which are all vectors
# columns can have different types, but as vectors, all elements in a column must have the same type
# create a toy data.frame
d <- data.frame(group=c('a', 'a', 'a', 'a', 'b', 'b', 'b', 'c', 'c'),
                age=c(5, 7, 6, 8, 9, 10, 13, 60, 49),
                gender=c('male', 'male', 'male', 'female', 'female', 'female', 'female', 'male', NA),
                stringsAsFactors=FALSE)

d.group.d <- data.frame(group=c('d', 'd', 'd', 'd'),
                        age=c(35, 29, 32, 40),
                        gender=c('male', 'male', 'female', 'female'),
                        stringsAsFactors=FALSE)

d.color <- data.frame(group=c('a', 'a', 'b', 'b', 'c', 'c', 'd'),
                      gender=c('male', 'female', 'male', 'female', 'male', 'female', 'male'),
                      color=c('blue', 'pink', 'blue', 'pink', 'blue', 'pink', 'blue'),
                      stringsAsFactors=FALSE)


# a 'factor' variable in R is an encoding for a string variable. 
# in the gender variable, R will no longer remember 9 strings of 'male' or 'female'
# instead it will have two strings 'male' and 'female', and associate these with factors 1 and 2.  
# this can save memory, but the datasets in this tutorial are too small to bother

# view the dataset
d
# view the first 6 (by default) rows of the dataset
head(d)
# view the first two rows of the dataset
head(d, 2)
# equivalently
d[1:2, ]

# create a new variable, in this case an index of row numbers
d$index <- 1:nrow(d)
# equivalently
d['index'] <- 1:nrow(d)
# remove the index variable
d$index <- NULL
# view variable names in d
names(d)

# as before, operations are performed on every element in a vector
d$age > 8
# test for missing values
is.na(d$gender)
any(is.na(d$age))
# view a subset of the rows
d[d$age > 8 & d$gender == 'female', ]
# view a subset of the columns
d[, c('group', 'age')]
# view a subset of rows and a subset of columns
d[d$gender=='female', c('group', 'age')]

# append the observations for group d to the 'd' data.frame
# this 'base R' rbind() command will only work on data.frames with the same number of columns.
# this can be done more efficiently and flexibly for large datasets using the bind_rows() command from dplyr
d <- rbind(d, d.group.d)
  
# merge the 'color' variable onto data for the four groups
# this can be done more efficiently and using sql merging concepts using the 'join' commands from dplyr
# in merge syntax, 'd' is the 'x' dataset; 'd.color' is the 'y' dataset
# by default, only elements appearing in both datasets would be kept in the merged dataset
# indicating all.x=TRUE puts all elements originally in 'd' into the merged dataset
d <- merge(d, d.color, by=c('group', 'gender'), all.x=TRUE)


# view the number of observations by characteristic
table(d$group)
table(d$group, d$gender)
# specify the object (d) you are working with once
with(d, table(group, gender))
# re-create the table on a subset of the data
with(d[d$age >=7, ], table(group, gender))
# check for missing values
table(d$group, d$gender, useNA=c('ifany'))

# save the frequency data from the table as a data.frame
d.table <- as.data.frame(table(d$group, d$gender, useNA=c('ifany')), stringsAsFactors=FALSE)
d.table
# rename columns in d.table
names(d.table) <- c('group', 'gender', 'freq')
# 'reshape' the data back to the format seen in the onscreen table with a command from package tidyr
d.table.spread <- spread(d.table, gender, freq)
d.table.spread


# create a variable conditional on the values of other variables
d$young.male <- ifelse(d$age < 10 & d$gender=='male', 'young.male', 'not.young.male')

# to create a dummy variable for each category in 'group':
# first, select unique elements in d$group
cols <- unique(d$group)
# second, assign 
d[paste0('dummy.', cols)] <- lapply(cols, function(col) as.numeric(d$group==col))

# to refer only to dummy variables
d[, grep('dummy.', names(d))]

# apply function to all dummy variables
dummy <- grep('dummy.', names(d), value=TRUE)
dummy.2 <- paste0(dummy, '.2')

# multiply all existing dummy variables by 2
# notice that the function of multiplying by 2 is implicitly defined in the apply statement
d[dummy.2] <- lapply(d[, dummy], function(x) 2*x)

# larger and reusable functions can be defined on their own
# this function adds 'white noise' to every element in a vector
jiggle <- function(x) {
  x.jiggle <- sapply(x, function(y) y + rnorm(1, sd=.1))
  return(x.jiggle)
}

dummy.jiggle <- paste0(dummy, '.jiggle')

# create jiggled dummy variables, 
d[dummy.jiggle] <- lapply(d[, dummy.2], jiggle)
# equivalently
d[dummy.jiggle] <- lapply(d[, dummy.2], function(x) sapply(x, function(y) y + rnorm(1, sd=.1)))

# delete all 'jiggle' dummy variables
# '.' is a special regex character; \\. tells the regex engine to match a text '.'
d[, grep('\\.jiggle$', names(d))] <- NULL
# delete all '.2$' dummy variables, and 'young.male'
d[, grep('2$', names(d))] <- NULL
d$young.male <- NULL

##########
# dplyr

# dplyr is a package used to perform advanced data manipulation on data.frame like objects.
# dplyr contains many functions that take a data.frame as input, and return a data.frame as output
# dplyr cheat sheet: https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf

# a functional programming language needs a clean way to compose functions
# writing compositions of the form g(f(x)) gets messy with multiple functions and parameters
# functional programs can easily begin to look like this: h(g(f(w), x), y, z)
# introducing pipes (%>% in R) enables cleaner composition of functions
# "x %>% f(y)" is equivalent to "f(x, y)"
# with pipes, h(g(f(w), x), y, z) becomes w %>% f(.,) %>% g(., x) %>% h(., y, z)
# ".," can be explicitly included to indicate which argument is being piped in to the function.

# use dplyr to find:
# 1. the age of the oldest person in each group, 
# 2. the number of people in each group
# 3. rank people in each group by age
d.ranks <- d %>%
  group_by(group) %>%
  mutate(age.max = max(age),
         num.people = n(),
         age.rank=dense_rank(-age))

# find the second oldest person in each group
# notice that d.ranks retains its group_by() attributes from above; there is no need to run group_by() again
d.ranks <- d.ranks %>%
  mutate(age.2ndoldest = max(ifelse(age.rank==(num.people-1), age, 0)))

# notice that d.ranks has inherited characteristics of a data.frame, but now has more 
# to group by multiple groups (group and gender, for example), type "group_by(group, gender)"
d.ranks
str(d.ranks)



##########
# regression

# stargazer is a package that formats regression output as a latex table
# the content of the regressions will make no sense; they are simply to demonstrate syntax
# note that string variables should be converted into factors before being used in a regression formula
# a:b denotes an interaction of a and b
cols <- c('group', 'gender')
d[paste0(cols, '.')] <- lapply(d[cols], factor)

reg.d <- lm(age ~ group. + gender. + group.:gender., data=d)
reg.subset <- lm(age ~ group. + gender. + group.:gender., data=d[d$group %in% c('a', 'b', 'c'), ])

reg.table <- stargazer(reg.d, reg.subset, align=TRUE, title='Nonsensical Regressions',
                       no.space=TRUE, keep=c('group.', 'gender.', 'group.:gender.'),
                       digits=2, column.labels=c('Groups a - d', 'Groups a - c'))
reg.file<-file("executable_R_tutial_table.tex")
reg.file.lines <- c('\\documentclass[10pt]{article}', 
                    '\\usepackage{dcolumn}',
                    '\\usepackage{longtable}',
                    '\\usepackage{geometry}',
                    '\\usepackage{amsmath}',
                    '\\geometry{margin=.5cm}',
                    '\\begin{document}',
                    reg.table,
                    '\\end{document}')
writeLines(reg.file.lines, reg.file)
# system('pdflatex executable_R_tutorial_table.tex', invisible=TRUE)



##########
# ggplot2

# ggplot2 provides a powerful, flexible, and logically consistent syntax to create graphs in R.
# gg stands for 'grammar of graphics'
# this tutorial is concise and useful:
# http://tutorials.iq.harvard.edu/R/Rgraphics/Rgraphics.html
# for more detail, the R graphics cookbook can be read here: 
# http://www.cookbook-r.com/Graphs/
# for less detail, use this cheat sheet:
# https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf
