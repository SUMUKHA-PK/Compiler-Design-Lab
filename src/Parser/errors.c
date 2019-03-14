#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include "errors.h"

// This C file has definitions of all functions declared in errors.h

extern void logOrOperandsTypeError(char *type1, char *type2, int lineno) {

    printf("Error in Line %d.", lineno);
    printf("There cannot be bitwise-or operation between operands of types %s and %s\n", type1, type2);
}

extern void logXorOperandsTypeError(char *type1, char *type2, int lineno) {

    printf("Error in Line %d.", lineno);
    printf("There cannot be bitwise-xor operation between operands of types %s and %s\n", type1, type2);
}

extern void logAndOperandsTypeError(char *type1, char *type2, int lineno) {

    printf("Error in Line %d.\n", lineno);
    printf("There cannot be bitwise-and operation between operands of types %s and %s\n", type1, type2);
}

extern void modOperandsTypeError(char *type1, char *type2, int lineno) {

    printf("Error in Line %d.\n", lineno);
    printf("Mod doesn't work if any of the operands is float. Types of operands are %s and %s\n", type1, type2);
}   