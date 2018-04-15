// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#ifndef RCPP_select4lists_RCPPEXPORTS_H_GEN_
#define RCPP_select4lists_RCPPEXPORTS_H_GEN_

#include <dplyr.h>
#include <Rcpp.h>

namespace select4lists {

    using namespace Rcpp;

    namespace {
        void validateSignature(const char* sig) {
            Rcpp::Function require = Rcpp::Environment::base_env()["require"];
            require("select4lists", Rcpp::Named("quietly") = true);
            typedef int(*Ptr_validate)(const char*);
            static Ptr_validate p_validate = (Ptr_validate)
                R_GetCCallable("select4lists", "_select4lists_RcppExport_validate");
            if (!p_validate(sig)) {
                throw Rcpp::function_not_exported(
                    "C++ function with signature '" + std::string(sig) + "' not found in select4lists");
            }
        }
    }

    inline List select_list_impl(List l, CharacterVector vars) {
        typedef SEXP(*Ptr_select_list_impl)(SEXP,SEXP);
        static Ptr_select_list_impl p_select_list_impl = NULL;
        if (p_select_list_impl == NULL) {
            validateSignature("List(*select_list_impl)(List,CharacterVector)");
            p_select_list_impl = (Ptr_select_list_impl)R_GetCCallable("select4lists", "_select4lists_select_list_impl");
        }
        RObject rcpp_result_gen;
        {
            RNGScope RCPP_rngScope_gen;
            rcpp_result_gen = p_select_list_impl(Shield<SEXP>(Rcpp::wrap(l)), Shield<SEXP>(Rcpp::wrap(vars)));
        }
        if (rcpp_result_gen.inherits("interrupted-error"))
            throw Rcpp::internal::InterruptedException();
        if (rcpp_result_gen.inherits("try-error"))
            throw Rcpp::exception(Rcpp::as<std::string>(rcpp_result_gen).c_str());
        return Rcpp::as<List >(rcpp_result_gen);
    }

}

#endif // RCPP_select4lists_RCPPEXPORTS_H_GEN_