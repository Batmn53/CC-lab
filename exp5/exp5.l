/* Experiment 5: Conversion of lowercase to uppercase and vice versa */

%{
#include <stdio.h>
#include <ctype.h>
%}

%%

[a-z]       { printf("%c", toupper(yytext[0])); }
[A-Z]       { printf("%c", tolower(yytext[0])); }
.           { printf("%c", yytext[0]); }
\n          { printf("\n"); }

%%

int yywrap() {
    return 1;
}

int main(int argc, char *argv[]) {
    if (argc > 1) {
        FILE *fp = fopen(argv[1], "r");
        if (!fp) {
            printf("Error opening file %s\n", argv[1]);
            return 1;
        }
        yyin = fp;
    } else {
        printf("Enter string to toggle case (Ctrl+D / Ctrl+Z to finish):\n");
    }

    yylex();
    return 0;
}
