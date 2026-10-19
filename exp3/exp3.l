/* Experiment 3: Count number of words starting with "A" */

%{
#include <stdio.h>
int count_A = 0;
%}

%%

[A][a-zA-Z0-9]*    {
    count_A++;
    printf("Found word starting with 'A': %s\n", yytext);
}

[a-zA-Z0-9]+       { /* Skip other words */ }
[ \t\n]+           { /* Skip whitespace */ }
.                  { /* Skip punctuation and other characters */ }

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
        printf("Enter text (Ctrl+D / Ctrl+Z to finish):\n");
    }

    yylex();
    printf("\nTotal words starting with 'A': %d\n", count_A);
    return 0;
}
