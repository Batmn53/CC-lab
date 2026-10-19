/* Experiment 8: Postfix Expression Evaluation - Lexer */

%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

%%

[0-9]+      { yylval = atoi(yytext); return NUM; }
[-+*/]      { return yytext[0]; }
[ \t]       { /* Ignore whitespace */ }
\n          { return '\n'; }
.           { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
