############### Data Wrangling Practice ##################################3

library(tidyverse)


#see example data set
head(iris)
dim(iris)
str(iris)
summary(iris)


# Data Wrangling cheadtseat with dplyr and tidyr --------------------------

#convert data to tbl class
data <- tbl_df(iris)
class(data)
class(iris)

#see summary of data
str(iris)
glimpse(iris)
View(iris)


#Piping
#   y %>% f(x, ., z) is the same as f(x, y, z )
filter(data, Sepal.Length == 5.1)
data %>% filter(Sepal.Length == 5.1)
data %>% filter(., Sepal.Length == 5.1)

iris %>%
  group_by(Species) %>%
  summarise(avg = mean(Sepal.Width)) %>%
  arrange(avg)

#create tbl data frame
class(data_frame(a = 1:3, b = 4:6))

#arrange data according to variable
arrange(mtcars, mpg)
arrange(mtcars, desc(mpg))
class(tbl_df(mtcars))

#rename variables/columns
head(rename(mtcars, mpg_test2 = mpg))


# Subsetting observations (rows) --------------------------------------------------------------

dplyr::filter(iris, Sepal.Length > 7)
#Extract rows that meet logical criteria.

iris
dplyr::distinct(iris)
#Remove duplicate rows.

dim(dplyr::sample_frac(iris, 0.5, replace = TRUE))
#Randomly select fraction of rows.

dplyr::sample_n(iris, 10, replace = TRUE)
#Randomly select n rows.

dplyr::slice(iris, 10:15)
#Select rows by position.

dplyr::top_n(storms, 2, date)
#Select and order top n entries (by group if grouped data).


# subsetting variables (columns) ------------------------------------------

#select(df, columns)
dplyr::select(iris, Sepal.Width, Petal.Length, Species)

select(iris, contains("."))
#Select columns whose name contains a character string.

select(iris, ends_with("Length"))
#Select columns whose name ends with a character string.

select(iris, everything())
#Select every column.

select(iris, matches(".t."))
#Select columns whose name matches a regular expression.

select(iris, num_range("x", 1:5))
#Select columns named x1, x2, x3, x4, x5.

select(iris, one_of(c("Species", "Genus")))
#Select columns whose names are in a group of names.

select(iris, starts_with("Sepal"))
#Select columns whose name starts with a character string.

select(iris, Sepal.Length:Petal.Width)
#Select all columns between Sepal.Length and Petal.Width (inclusive).

select(iris, -Species)
#Select all columns except Species.


# summarize data ----------------------------------------------------------

dplyr::summarise(iris, avg = mean(Sepal.Length))
#Summarise data into single row of values.

dplyr::summarise_each(iris, funs(mean))
#Apply summary function to each column.

dplyr::count(iris, Species, wt = Sepal.Length)
#Count number of rows with each unique value of variable (with or without weights).

first(iris)
length(first(iris))
head(iris)

last(iris)

nth(iris, 1)
nth(iris, 5)

n(iris, Species)
n(iris$Sepal.Length)

n_distinct(iris$Sepal.Length)

IQR(iris$Sepal.Length)

min(iris$Sepal.Length)

max(iris$Sepal.Length)

mean(iris$Sepal.Length)

median(iris$Sepal.Length)

sd(iris$Sepal.Length)


# Group Data --------------------------------------------------------------

group_by(iris, Species)
ungroup(iris)

iris %>% group_by(Species) %>% summarise(avg = mean(Sepal.Length))
iris %>% group_by(Species) %>% mutate(leangthwidth = Sepal.Length + Sepal.Width)


# Make new variables ------------------------------------------------------

dplyr::mutate(iris, sepal = Sepal.Length + Sepal.Width)
#Compute and append one or more new columns.

head(iris)
head(dplyr::mutate_each(iris, funs(min_rank)))
dplyr::mutate_each(iris, funs(min_rank))
#Apply window function to each column.

dplyr::transmute(iris, sepal = Sepal.Length + Sepal.Width)
#Compute one or more new columns. Drop original columns.

dplyr::mutate_each(iris, funs(min_rank))
percent_rank(iris$Sepal.Length)
lead(iris$Sepal.Length) #skip first value
lag(iris$Sepal.Length)
dense_rank(iris$Sepal.Length) #ranks no gaps
row_number(iris$Sepal.Length)
ntile(iris$Sepal.Length, 2) #bins vector
cume_dist(iris$Sepal.Length) #cummulative distribution
cumsum(iris$Sepal.Length) #cumulative sum


# Combine data sets -------------------------------------------------------

a <- data.frame(x1 = c("A", "B", "C"), x2  = c(1, 2, 3) )
b <- data.frame(x1 = c("A", "B", "D"), x3  = c(T, F, T) )

dplyr::left_join(a, b, by = "x1")
#Join matching rows from b to a.

dplyr::right_join(a, b, by = "x1")
#Join matching rows from a to b.

dplyr::inner_join(a, b, by = "x1")
#Join data. Retain only rows in both sets.

dplyr::full_join(a, b, by = "x1")
#Join data. Retain all values, all rows.

dplyr::semi_join(a, b, by = "x1")
#All rows in a that have a match in b.

dplyr::anti_join(a, b, by = "x1")
#All rows in a that do not have a match in b.

y <- data.frame(x1 = c("A", "B", "C"), x2  = c(1, 2, 3) )
z <- data.frame(x1 = c("B", "C", "D"), x2  = c(2, 3, 4) )

dplyr::intersect(y, z)
#Rows that appear in both y and z.

dplyr::union(y, z)
#Rows that appear in either or both y and z.

dplyr::setdiff(y, z)
#Rows that appear in y but not z.

dplyr::bind_rows(y, z)
#Append z to y as new rows.

dplyr::bind_cols(y, z)
#Append z to y as new columns.
#Caution: matches rows by position.
