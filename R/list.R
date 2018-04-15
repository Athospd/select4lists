#' @useDynLib select4lists
#' @importFrom Rcpp sourceCpp
#' @importFrom dplyr select
#' @importFrom dplyr select_
#' @importFrom dplyr rename_
#' @importFrom dplyr rename
#' @importFrom rlang caller_env
#' @importFrom rlang quos
#' @importFrom tidyselect vars_select
NULL

#' Select/rename list's elements by name
#'
#' `select.data()` keeps only the elements you mention; `rename.data()`
#' keeps all elements. The list must be named. See `help(select, package = "dplyr")`` for further details.
#'
#' @export
select.list <- function(.data, ...) {
  # Pass via splicing to avoid matching vars_select() arguments
  vars <- vars_select(names(.data), !!!quos(...))
  select_list_impl(.data, vars)
}

#' @rdname select.data
#' @export
select_.list <- function(.data, ..., .dots = list()) {
  dots <- dplyr:::compat_lazy_dots(.dots, caller_env(), ...)
  dplyr::select(.data, !!!dots)
}

#' @rdname select.data
#' @export
rename.list <- function(.data, ...) {
  vars <- tidyselect::vars_rename(names(.data), !!!quos(...))
  select_list_impl(.data, vars)
}

#' @rdname select.data
#' @export
rename_.list <- function(.data, ..., .dots = list()) {
  dots <- dplyr:::compat_lazy_dots(.dots, caller_env(), ...)
  dplyr::rename(.data, !!!dots)
}
