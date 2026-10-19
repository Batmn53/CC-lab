/* Experiment 7: Test lines ending with "COM" */

%{
#include <stdio.h>
int count = 0;
%}

%%

.*(COM|com)\r?\n   { 
    count++; 
    printf("[Line ending with COM]: %s", yytext); 
}

.*\r?\n            { /* Other lines: ignore or echo */ }

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
        printf("Enter lines (or pass input.txt as argument):\n");
    }

    yylex();
    printf("\nTotal lines ending with 'COM': %d\n", count);
    return 0;
}
