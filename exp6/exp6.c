/* Experiment 6: Conversion of decimal to hexadecimal number in a file (Pure C) */

#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    const char *filename = (argc > 1) ? argv[1] : "input.txt";
    FILE *fin = fopen(filename, "r");
    if (!fin) {
        printf("Error: Could not open input file '%s'\n", filename);
        return 1;
    }

    int ch;
    while ((ch = fgetc(fin)) != EOF) {
        if (isdigit(ch)) {
            int num = 0;
            while (isdigit(ch)) {
                num = num * 10 + (ch - '0');
                ch = fgetc(fin);
            }
            printf("%X", num);
            if (ch != EOF) {
                ungetc(ch, fin);
            }
        } else {
            putchar(ch);
        }
    }

    fclose(fin);
    return 0;
}
