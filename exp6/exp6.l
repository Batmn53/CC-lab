/* Experiment 6: Conversion of decimal to hexadecimal number in a file (LEX) */

%{
#include <stdio.h>
#include <stdlib.h>
%}

DIGIT   [0-9]+

%%

{DIGIT}     { 
                int num = atoi(yytext);
                printf("%X", num); 
            }
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
        printf("Reading from input.txt or standard input...\n");
        FILE *fp = fopen("input.txt", "r");
        if (fp) yyin = fp;
    }

    yylex();
    return 0;
}
