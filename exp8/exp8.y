/* Experiment 8: Postfix Expression Evaluation - YACC */

%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);

int stack[100];
int top = -1;

void push(int val) {
    stack[++top] = val;
}

int pop() {
    return stack[top--];
}
%}

%token NUM

%%

input:
    /* empty */
    | input line
    ;

line:
    '\n'
    | expr '\n'     { 
                        if (top >= 0) {
                            printf("Postfix Evaluation Result = %d\n", pop()); 
                        }
                    }
    ;

expr:
    expr expr '+'   { 
                        int b = pop(); 
                        int a = pop(); 
                        push(a + b); 
                    }
    | expr expr '-' { 
                        int b = pop(); 
                        int a = pop(); 
                        push(a - b); 
                    }
    | expr expr '*' { 
                        int b = pop(); 
                        int a = pop(); 
                        push(a * b); 
                    }
    | expr expr '/' { 
                        int b = pop(); 
                        int a = pop(); 
                        if (b == 0) {
                            yyerror("Division by zero");
                            push(0);
                        } else {
                            push(a / b);
                        }
                    }
    | NUM           { push($1); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter postfix expression separated by space (e.g., 5 3 + 2 *):\n");
    return yyparse();
}
