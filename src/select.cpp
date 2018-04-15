// [[Rcpp::interfaces(r, cpp)]]

#include <Rcpp.h>
#include <dplyr/main.h>
//
#include <tools/utils.h>
//
using namespace Rcpp;
using namespace dplyr;


SEXP select_list(const List& l, const SymbolVector& keep, const SymbolVector& new_names) {
  IntegerVector positions = keep.match_in_table(l.names());
  int n = keep.size();
  List res(n);
  for (int i = 0; i < n; i++) {
    int pos = positions[i];
    if (pos < 1 || pos > l.size()) {
      std::stringstream s;
      if (pos == NA_INTEGER) {
        s << "NA";
      } else {
        s << pos;
      }
      stop("invalid column index : %d for variable: '%s' = '%s'",
           s.str(), new_names[i].get_utf8_cstring(), keep[i].get_utf8_cstring());
    }
    res[i] = l[ pos - 1 ];
  }
  copy_most_attributes(res, l);
  res.names() = new_names;
  return res;
}


inline void check_valid_colnames_list( const List& l) {
  CharacterVector names(l.names());
  if( any( duplicated(names) ).is_true() ){
    stop("found duplicated column name");
  }
}

// [[Rcpp::export]]
List select_list_impl(List l, CharacterVector vars) {
  check_valid_colnames_list(l);
  return select_list(l, SymbolVector(vars), SymbolVector(vars.names()));
}























