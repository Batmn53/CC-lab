/* Experiment 10: Parser for "FOR" loop statements - YACC */

%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
int valid = 1;
%}

%token FOR ID NUM LE GE EQ NE INC DEC ADD_ASSIGN SUB_ASSIGN

%%

start:
    for_loop {
        if (valid) {
            printf("\n>>> Parsing Successful: Valid FOR Loop statement! <<<\n");
        }
    }
    ;

for_loop:
    FOR '(' init ';' condition ';' step ')' body
    ;

init:
    /* empty */
    | expr
    | init ',' expr
    ;

condition:
    /* empty */
    | expr
    ;

step:
    /* empty */
    | expr
    | step ',' expr
    ;

expr:
    ID '=' expr
    | ID ADD_ASSIGN expr
    | ID SUB_ASSIGN expr
    | ID INC
    | ID DEC
    | INC ID
    | DEC ID
    | simple_expr
    ;

simple_expr:
    simple_expr relop simple_expr
    | simple_expr '+' simple_expr
    | simple_expr '-' simple_expr
    | simple_expr '*' simple_expr
    | simple_expr '/' simple_expr
    | '(' expr ')'
    | ID
    | NUM
    ;

relop:
    '<' | '>' | LE | GE | EQ | NE
    ;

body:
    stmt
    | '{' stmt_list '}'
    | '{' '}'
    ;

stmt_list:
    stmt
    | stmt_list stmt
    ;

stmt:
    ';'
    | expr ';'
    | for_loop
    ;

%%

void yyerror(const char *s) {
    valid = 0;
    fprintf(stderr, "\nSyntax Error: Invalid FOR loop syntax (%s)\n", s);
}

int main() {
    printf("--- Experiment 10: Parser for FOR Loop Statements ---\n");
    printf("Enter a 'for' loop (e.g. for (i = 0; i < 10; i++) { a = a + 1; }):\n");
    yyparse();
    return 0;
}
