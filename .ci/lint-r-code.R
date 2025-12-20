
library(lintr)

FILES_TO_LINT <- list.files(
    path = getwd()
    , pattern = "\\.r$"
    , all.files = TRUE
    , ignore.case = TRUE
    , full.names = TRUE
    , recursive = TRUE
    , include.dirs = FALSE
)
FILES_TO_LINT <- append(
    FILES_TO_LINT
    , c(
        "assignments/extra-credit.Rmd"
        , "assignments/final_project.Rmd"
        , "code/programming-supplement.Rmd"
    )
)

# text to use for pipe operators from packages like 'magrittr'
pipe_text <- paste0(
    "For consistency and the sake of being explicit, this project's code "
    , "does not use the pipe operator."
)

# text to use for functions that should only be called interactively
interactive_text <- paste0(
    "Functions like '?', 'help', and 'install.packages()' should only be used "
    , "interactively, not in package code."
)

LINTERS_TO_USE <- list(
    "absolute_path"          = lintr::absolute_path_linter()
    , "any_duplicated"       = lintr::any_duplicated_linter()
    , "any_is_na"            = lintr::any_is_na_linter()
    , "assignment"           = lintr::assignment_linter()
    , "backport"             = lintr::backport_linter()
    , "boolean_arithmetic"   = lintr::boolean_arithmetic_linter()
    , "braces"               = lintr::brace_linter()
    , "class_equals"         = lintr::class_equals_linter()
    , "commas"               = lintr::commas_linter()
    , "conjunct_test"        = lintr::conjunct_test_linter()
    , "duplicate_argument"   = lintr::duplicate_argument_linter()
    , "empty_assignment"     = lintr::empty_assignment_linter()
    , "equals_na"            = lintr::equals_na_linter()
    , "fixed_regex"          = lintr::fixed_regex_linter()
    , "for_loop_index"       = lintr::for_loop_index_linter()
    , "function_left"        = lintr::function_left_parentheses_linter()
    , "function_return"      = lintr::function_return_linter()
    , "implicit_assignment"  = lintr::implicit_assignment_linter()
    , "infix_spaces"         = lintr::infix_spaces_linter()
    , "inner_combine"        = lintr::inner_combine_linter()
    , "is_numeric"           = lintr::is_numeric_linter()
    , "lengths"              = lintr::lengths_linter()
    , "length_levels"        = lintr::length_levels_linter()
    , "length_test"          = lintr::length_test_linter()
    , "line_length"          = lintr::line_length_linter(length = 120L)
    , "literal_coercion"     = lintr::literal_coercion_linter()
    , "matrix"               = lintr::matrix_apply_linter()
    , "missing_argument"     = lintr::missing_argument_linter()
    , "numeric_leading_zero" = lintr::numeric_leading_zero_linter()
    , "outer_negation"       = lintr::outer_negation_linter()
    , "package_hooks"        = lintr::package_hooks_linter()
    , "paren_body"           = lintr::paren_body_linter()
    , "paste"                = lintr::paste_linter()
    , "quotes"               = lintr::quotes_linter()
    , "redundant_equals"     = lintr::redundant_equals_linter()
    , "regex_subset"         = lintr::regex_subset_linter()
    , "routine_registration" = lintr::routine_registration_linter()
    , "scalar_in"            = lintr::scalar_in_linter()
    , "semicolon"            = lintr::semicolon_linter()
    , "seq"                  = lintr::seq_linter()
    , "spaces_inside"        = lintr::spaces_inside_linter()
    , "spaces_left_parens"   = lintr::spaces_left_parentheses_linter()
    , "sprintf"              = lintr::sprintf_linter()
    , "string_boundary"      = lintr::string_boundary_linter()
    , "todo_comments"        = lintr::todo_comment_linter(c("todo", "fixme", "to-do"))
    , "trailing_blank"       = lintr::trailing_blank_lines_linter()
    , "trailing_white"       = lintr::trailing_whitespace_linter()
    , "true_false"           = lintr::T_and_F_symbol_linter()
    , "unnecessary_concatenation" = lintr::unnecessary_concatenation_linter()
    , "unnecessary_lambda"        = lintr::unnecessary_lambda_linter()
    , "unreachable_code"          = lintr::unreachable_code_linter()
    , "vector_logic"              = lintr::vector_logic_linter()
    , "whitespace"                = lintr::whitespace_linter()
)

noquote(paste0(length(FILES_TO_LINT), " R files need linting"))

results <- NULL

for (r_file in FILES_TO_LINT) {

    this_result <- lintr::lint(
        filename = r_file
        , linters = LINTERS_TO_USE
        , cache = FALSE
    )

    print(
        sprintf(
            "Found %i linting errors in %s"
            , length(this_result)
            , r_file
        )
        , quote = FALSE
    )

    results <- c(results, this_result)

}

issues_found <- length(results)

noquote(paste0("Total linting issues found: ", issues_found))

if (issues_found > 0L) {
    print(results)
}

quit(save = "no", status = issues_found)
