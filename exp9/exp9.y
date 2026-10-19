/* Experiment 9: Desk calculator with error recovery - YACC */

%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%union {
    double dval;
}

%token <dval> NUMBER
%type <dval> expr

%left '+' '-'
%left '*' '/'
%right UMINUS

%%

input:
    /* empty */
    | input line
    ;

line:
    '\n'
    | expr '\n'       { printf("\tResult = %g\n", $1); }
    | error '\n'      { 
                        /* Error Recovery: discard bad tokens until newline and reset parser */
                        yyerrok; 
                        printf("\tRecovered from error. Please enter next expression:\n"); 
                      }
    ;

expr:
    NUMBER                  { $$ = $1; }
    | expr '+' expr         { $$ = $1 + $3; }
    | expr '-' expr         { $$ = $1 - $3; }
    | expr '*' expr         { $$ = $1 * $3; }
    | expr '/' expr         { 
                              if ($3 == 0) {
                                  yyerror("Division by zero");
                                  $$ = 0;
                              } else {
                                  $$ = $1 / $3; 
                              }
                            }
    | '(' expr ')'          { $$ = $2; }
    | '-' expr %prec UMINUS { $$ = -$2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax/Semantic Error: %s\n", s);
}

int main() {
    printf("--- Experiment 9: Desk Calculator with Error Recovery ---\n");
    printf("Enter expressions (e.g., 4 * (2 + 3) or deliberate errors like 4++5):\n");
    return yyparse();
}
