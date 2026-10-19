/* Experiment 8: Postfix Expression Evaluation (C implementation) */

#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

#define MAX 100

int stack[MAX];
int top = -1;

void push(int val) {
    if (top >= MAX - 1) {
        printf("Stack Overflow\n");
        exit(1);
    }
    stack[++top] = val;
}

int pop() {
    if (top < 0) {
        printf("Invalid Postfix Expression\n");
        exit(1);
    }
    return stack[top--];
}

int evaluatePostfix(char *exp) {
    for (int i = 0; exp[i] != '\0'; i++) {
        if (isspace(exp[i])) continue;

        if (isdigit(exp[i])) {
            int num = 0;
            while (isdigit(exp[i])) {
                num = num * 10 + (exp[i] - '0');
                i++;
            }
            i--;
            push(num);
        } else {
            int val2 = pop();
            int val1 = pop();
            switch (exp[i]) {
                case '+': push(val1 + val2); break;
                case '-': push(val1 - val2); break;
                case '*': push(val1 * val2); break;
                case '/': 
                    if (val2 == 0) {
                        printf("Error: Division by zero\n");
                        exit(1);
                    }
                    push(val1 / val2); 
                    break;
                default:
                    printf("Error: Unknown operator %c\n", exp[i]);
                    exit(1);
            }
        }
    }
    return pop();
}

int main() {
    char exp[MAX];
    printf("Enter postfix expression (e.g., 5 3 + 2 *): ");
    if (fgets(exp, sizeof(exp), stdin)) {
        int result = evaluatePostfix(exp);
        printf("Result = %d\n", result);
    }
    return 0;
}
