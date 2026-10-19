/* Experiment 2: Count comments, keywords, identifiers, words, lines and spaces */

%{
#include <stdio.h>
#include <string.h>

int comments = 0;
int keywords = 0;
int identifiers = 0;
int words = 0;
int lines = 1;
int spaces = 0;
%}

/* Definitions */
KEYWORD     (int|float|char|double|void|if|else|while|for|return|break|continue|switch|case|default|struct)
IDENTIFIER  [a-zA-Z_][a-zA-Z0-9_]*

%%

\/\/[^\n]*              { comments++; }
\/\*([^*]|\*+[^*/])*\*+\/ { 
    /* Multi-line comment */
    comments++;
    for(int i = 0; yytext[i] != '\0'; i++) {
        if(yytext[i] == '\n') lines++;
    }
}

{KEYWORD}               { keywords++; words++; }
{IDENTIFIER}            { identifiers++; words++; }
[0-9]+                  { words++; }
[ ]                     { spaces++; }
\t                      { spaces += 4; }
\n                      { lines++; }
.                       { /* Ignore other characters */ }

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
        printf("Reading from standard input (or pass a filename as argument):\n");
    }

    yylex();

    printf("\n--- Counts Summary ---\n");
    printf("Comments    : %d\n", comments);
    printf("Keywords    : %d\n", keywords);
    printf("Identifiers : %d\n", identifiers);
    printf("Words       : %d\n", words);
    printf("Lines       : %d\n", lines);
    printf("Spaces      : %d\n", spaces);

    return 0;
}
