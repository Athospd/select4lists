#' @useDynLib select4lists
#' @importFrom Rcpp sourceCpp
#' @importFrom dplyr select
#' @importFrom dplyr select_
#' @importFrom dplyr rename_
#' @importFrom dplyr rename
#' @importFrom rlang caller_env
NULL

#' Select/rename list's elements by name
#'
#' `select.list()` keeps only the variables you mention; `rename.list()`
#' keeps all variables. See `help(select, package = "dplyr")`` for further details.
#'
#' @export
select.list <- function(.list, ...) {
  # Pass via splicing to avoid matching vars_select() arguments
  vars <- tidyselect::vars_select(names(.list), !!!quos(...))
  select_list_impl(.list, vars)
}

#' @rdname select.list
#' @export
select_.list <- function(.list, ..., .dots = list()) {
  dots <- dplyr:::compat_lazy_dots(.dots, rlang::caller_env(), ...)
  dplyr::select(.list, !!!dots)
}

#' @rdname select.list
#' @export
rename.list <- function(.list, ...) {
  vars <- tidyselect::vars_rename(names(.list), !!!quos(...))
  select_list_impl(.list, vars)
}

#' @rdname select.list
#' @export
rename_.list <- function(.list, ..., .dots = list()) {
  dots <- dplyr:::compat_lazy_dots(.dots, rlang::caller_env(), ...)
  dplyr::rename(.list, !!!dots)
}
