%{
#include <stdio.h>
#include "y.tab.h"
%}

%%
[0-9]+(\.[0-9]+)?       yylval.dval = atof(yytext); return T_NUM;
[a-zA-Z]                yylval.cval = yytext[0]; return T_LETTER;
=                       return T_EQ;
\+                      return T_ADD;
-                       return T_SUB;
\/                      return T_DIV;
\*                      return T_MUL;
\*\*                    return T_POW;
\n                      return T_NL;
[ \t]
%%
