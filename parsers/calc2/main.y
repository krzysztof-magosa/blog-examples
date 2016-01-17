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

%token T_INT T_NL

%left T_ADD T_SUB
%left T_DIV T_MUL
%%

list
    : line
    | list line

line
    : T_NL
    | case T_NL          { printf("Result = %d\n", $1); }

case
    : T_INT              { $$ = $1; }
    | case T_ADD case    { $$ = $1 + $3; }
    | case T_SUB case    { $$ = $1 - $3; }
    | case T_DIV case    { $$ = $1 / $3; }
    | case T_MUL case    { $$ = $1 * $3; }

%%
