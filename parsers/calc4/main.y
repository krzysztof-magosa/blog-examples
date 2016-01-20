%{
#include <stdio.h>
#include <string.h>

double variables[256];

void yyerror(const char *str) {
    fprintf(stderr, "error: %s\n", str);
}

int yywrap() {
    // it means that we parse only one file
    // and there is no next one
    return 1;
}

int main(void) {
    memset(variables, 0, sizeof(variables));
    yyparse();
}
%}

%union {
    double dval;
    char cval;
}

%token <dval> T_NUM
%token <cval> T_LETTER
%token T_NL T_EQ

%left T_ADD T_SUB U_NEG
%left T_DIV T_MUL
%token U_NEG
%right T_POW

%type <dval> case
%%

list
    : line
    | list line

line
    : T_NL
    | case T_NL               { printf("Result = %f\n", $1); }
    | T_LETTER T_EQ case T_NL { variables[$1] = $3; }

case
    : T_NUM              { $$ = $1; }
    | T_LETTER           { $$ = variables[$1]; }
    | case T_ADD case    { $$ = $1 + $3; }
    | case T_SUB case    { $$ = $1 - $3; }
    | case T_DIV case    { $$ = $1 / $3; }
    | case T_MUL case    { $$ = $1 * $3; }
    | case T_POW case    { $$ = pow($1, $3); }
    | T_SUB case %prec U_NEG { $$ = -$2; }

%%
