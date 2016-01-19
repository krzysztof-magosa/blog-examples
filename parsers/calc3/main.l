%{
#include <stdio.h>
#include "y.tab.h"
%}

%%
[0-9]+                  yylval = atoi(yytext); return T_INT;
\+                      return T_ADD;
-                       return T_SUB;
\/                      return T_DIV;
\*                      return T_MUL;
\*\*                    return T_POW;
\n                      return T_NL;
%%
