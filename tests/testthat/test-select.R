context("Select from named lists")


test_that("select doesn't fail if some names missing", {
  l1 <- list(x = 1:10, y = 1:10, z = 1:10)
  l2 <- setNames(l1, c("x", "y", ""))

  expect_equal(select(l1, x), list(x = 1:10))
  expect_equal(select(l2, x), list(x = 1:10))
})


# Empty selects -------------------------------------------------

test_that("select with no args returns nothing", {
  l1 <- list(x = 1:10, y = 1:10, z = 1:10)
  empty <- select(l1)
  expect_equal(length(empty), 0)
})

test_that("select excluding all vars returns nothing", {
  mtcars_as_list <- as.list(mtcars)
  expect_equal(length(select(mtcars_as_list, -(mpg:carb))), 0)
  expect_equal(length(select(mtcars_as_list, dplyr::starts_with("x"))), 0)
  expect_equal(length(select(mtcars_as_list, -dplyr::matches("."))), 0)
})

test_that("negating empty match returns everything", {
  l1 <- list(x = 1:3, y = 3:1)
  expect_equal(select(l1, -dplyr::starts_with("xyz")), l1)
})

# Select variables -----------------------------------------------
test_that("rename() handles data pronoun", {
  expect_identical(dplyr::rename(list(x = 1), y = .data$x), list(y = 1))
})

test_that("select succeeds in presence of raw columns (#1803)", {
  l1 <- list(a = 1:3, b = as.raw(1:3))
  expect_identical(select(l1, a), l1["a"])
  expect_identical(select(l1, b), l1["b"])
  expect_identical(select(l1, -b), l1["a"])
})

test_that("arguments to select() don't match vars_select() arguments", {
  l1 <- list(a = 1)
  expect_identical(select(l1, var = a), list(var = 1))
  expect_identical(select(l1, exclude = a), list(exclude = 1))
  expect_identical(select(l1, include = a), list(include = 1))
})

test_that("arguments to rename() don't match vars_rename() arguments (#2861)", {
  l1 <- list(a = 1)
  expect_identical(dplyr::rename(l1, var = a), list(var = 1))
  expect_identical(dplyr::rename(l1, strict = a), list(strict = 1))
})

test_that("can select() with .data pronoun (#2715)", {
  mtcars_as_list <- as.list(mtcars)
  expect_identical(select(mtcars_as_list, .data$cyl), select(mtcars_as_list, cyl))
})

test_that("can select() with character vectors", {
  mtcars_as_list <- as.list(mtcars)
  expect_identical(select(mtcars_as_list, "cyl", !!"disp", c("cyl", "am", "drat")), mtcars_as_list[c("cyl", "disp", "am", "drat")])
})

test_that("rename() to UTF-8 column names", {
  skip_on_os("windows") # needs an rlang update? #3049
  l1 <- list(a = 1) %>% dplyr::rename("\u5e78" := a)

  expect_equal(colnames(l1), "\u5e78")
})

test_that("select() treats NULL inputs as empty", {
  mtcars_as_list <- as.list(mtcars)
  expect_identical(select(mtcars_as_list, cyl), select(mtcars_as_list, NULL, cyl, NULL))
})

test_that("can select() or rename() with strings and character vectors", {
  mtcars_as_list <- as.list(mtcars)
  vars <- c(foo = "cyl", bar = "am")

  expect_identical(select(mtcars_as_list, !!!vars), select(mtcars_as_list, foo = cyl, bar = am))
  expect_identical(select(mtcars_as_list, !!vars), select(mtcars_as_list, foo = cyl, bar = am))

  expect_identical(dplyr::rename(mtcars_as_list, !!!vars), dplyr::rename(mtcars_as_list, foo = cyl, bar = am))
  expect_identical(dplyr::rename(mtcars_as_list, !!vars), dplyr::rename(mtcars_as_list, foo = cyl, bar = am))
})

test_that("odd object types are retrieved successfully", {
  lista <- list(a = c(1,2,3), aff = c("plim", "plom"), jeferson = head(iris,2))

  expect_identical(select(lista, jeferson), lista["jeferson"])
})


# context("Select from unnamed lists")

# Unnamed lists -----------------------------------------------

# test_that("can select() from or rename() unnamed lists with integers", {
#   l1 <- list(c(1,2,3), c("a", "b", "c", "d"), c(TRUE, FALSE))
#   vars <- c(foo = 1, bar = 2)
#
#   expect_identical(select(l1, 1), l1[1])
#   expect_identical(select(l1, 1, 3), l1[c(1, 3)])
#   expect_identical(select(l1, 3:2), l1[3:2])
#   expect_identical(select(l1, -1), l1[-1])
#   expect_identical(select(l1, -1, -3), l1[-c(1, 3)])
#   expect_identical(select(l1, -(3:2)), l1[-(3:2)])
#
#   expect_identical(rename(l1, !!!vars), rename(l1, foo = 1, bar = 2))
#   expect_identical(rename(l1, !!vars), rename(l1, foo = 1, bar = 2))
# })
#
# test_that("select() from unnamed lists with either positive and negative integers gives an error", {
#   l1 <- list(c(1,2,3), c("a", "b", "c", "d"), c(TRUE, FALSE))
#
#   expect_error(select(l1, -1:2))
#   expect_error(select(l1, -1, 2))
# })
#
# test_that("select excluding all vars returns nothing", {
#   mtcars_as_list <- as.list(mtcars)
#   names(mtcars_as_list) <- NULL
#
#   expect_equal(length(select(mtcars_as_list, -(1:11))), 0)
#   expect_equal(length(select(mtcars_as_list, starts_with("x"))), 0)
#   expect_equal(length(select(mtcars_as_list, -matches("."))), 0)
# })
#
# test_that("select with no args returns nothing", {
#   l1 <- list(1:10, 1:10, 1:10)
#   empty <- select(l1)
#   expect_equal(length(empty), 0)
# })




#
#
#
# S3method(rename,list)
# S3method(rename_,list)
# S3method(select,list)
# S3method(select_,list)
# export(rename.list)
# export(rename_.list)
# export(select.list)
# export(select_.list)
# importFrom(Rcpp,sourceCpp)
# importFrom(dplyr,rename)
# importFrom(dplyr,rename_)
# importFrom(dplyr,select)
# importFrom(dplyr,select_)
# importFrom(rlang,caller_env)
# useDynLib(select4lists)
