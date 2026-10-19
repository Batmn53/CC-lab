/* Experiment 1: Introduction to LEX tool, metadata and patterns */

%{
#include <stdio.h>
int num_count = 0, word_count = 0;
%}

/* Metadata / Regular Definitions */
DIGIT       [0-9]
LETTER      [a-zA-Z]
NUMBER      {DIGIT}+
WORD        {LETTER}+
WHITESPACE  [ \t\n]

%%

{NUMBER}        { num_count++; printf("[Number: %s]\n", yytext); }
{WORD}          { word_count++; printf("[Word: %s]\n", yytext); }
{WHITESPACE}    { /* Ignore whitespace */ }
.               { printf("[Special Char: %s]\n", yytext); }

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter input (Ctrl+D / Ctrl+Z to end):\n");
    yylex();
    printf("\n--- Summary ---\n");
    printf("Total Words: %d\n", word_count);
    printf("Total Numbers: %d\n", num_count);
    return 0;
}
