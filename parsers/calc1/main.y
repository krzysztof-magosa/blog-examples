%{
#include <stdio.h>
#include <string.h>

void yyerror(const char *str) {
    fprintf(stderr, "error: %s\n", str);
}

int yywrap() {
    // it means that we parse only one file
    // and there is no next one
    return 1;
}

int main(void) {
    yyparse();
}
%}

%token T_INT T_ADD T_SUB T_DIV T_MUL

%%

list
    : case
    | list case

case
    : T_INT T_ADD T_INT    { printf("%d\n", $1 + $3); }
    | T_INT T_SUB T_INT    { printf("%d\n", $1 - $3); }
    | T_INT T_DIV T_INT    { printf("%d\n", $1 / $3); }
    | T_INT T_MUL T_INT    { printf("%d\n", $1 * $3); }

%%
