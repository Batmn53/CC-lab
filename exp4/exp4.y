/* Experiment 4: Introduction to YACC tool, and format to write YACC code */

/* =======================================================
   SECTION 1: DECLARATIONS & DEFINITIONS
   ======================================================= */
%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

/* Token declarations */
%token NUMBER

/* Operator precedence & associativity */
%left '+' '-'
%left '*' '/'

%%
/* =======================================================
   SECTION 2: GRAMMAR RULES & ACTIONS
   ======================================================= */

lines:
    /* empty */
    | lines expr '\n'     { printf("Valid Expression! Value = %d\n", $2); }
    | lines '\n'
    ;

expr:
    NUMBER               { $$ = $1; }
    | expr '+' expr      { $$ = $1 + $3; }
    | expr '-' expr      { $$ = $1 - $3; }
    | expr '*' expr      { $$ = $1 * $3; }
    | expr '/' expr      { 
                            if ($3 == 0) {
                                yyerror("Division by zero");
                                $$ = 0;
                            } else {
                                $$ = $1 / $3;
                            }
                         }
    | '(' expr ')'       { $$ = $2; }
    ;

%%
/* =======================================================
   SECTION 3: C AUXILIARY ROUTINES
   ======================================================= */

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("--- Experiment 4: YACC Tool Structure Demo ---\n");
    printf("Enter arithmetic expressions (e.g., 2+3*4) and press Enter:\n");
    return yyparse();
}
