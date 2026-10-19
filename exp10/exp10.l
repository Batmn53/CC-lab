/* Experiment 10: Parser for "FOR" loop statements - Lexer */

%{
#include <stdio.h>
#include "y.tab.h"
%}

%%

"for"                   { return FOR; }
"<="                    { return LE; }
">="                    { return GE; }
"=="                    { return EQ; }
"!="                    { return NE; }
"++"                    { return INC; }
"--"                    { return DEC; }
"+="                    { return ADD_ASSIGN; }
"-="                    { return SUB_ASSIGN; }

[0-9]+                  { return NUM; }
[a-zA-Z_][a-zA-Z0-9_]*  { return ID; }

[ \t\r\n]               { /* Skip whitespace */ }
.                       { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
