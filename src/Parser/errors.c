#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include "comments.h"
#include "errors.h"

#define RED   "\x1B[31m"
#define RESET "\x1B[0m"

// This C file has definitions of all functions declared in errors.h

extern void logOrOperandsTypeError(char *type1, char *type2, int lineno) {

    printf("\n\nError in Line %d. ", lineno);
    printf("There cannot be bitwise-or operation between operands of types %s and %s\n", type1, type2);
    dontPrint=1;
}

extern void logXorOperandsTypeError(char *type1, char *type2, int lineno) {

    printf("\n\nError in Line %d. ", lineno);
    printf("There cannot be bitwise-xor operation between operands of types %s and %s\n", type1, type2);
    dontPrint=1;
}

extern void logAndOperandsTypeError(char *type1, char *type2, int lineno) {

    printf("\n\nError in Line %d. ", lineno);
    printf("There cannot be bitwise-and operation between operands of types %s and %s\n", type1, type2);
    dontPrint=1;
}

extern void modOperandsTypeError(char *type1, char *type2, int lineno) {

    printf("\n\nError in Line %d. ", lineno);
    printf("Mod doesn't work if any of the operands is float. Types of operands are %s and %s\n", type1, type2);
    dontPrint=1;
}   

extern void typeMismatchError(char *type1, char *type2, int lineno){

    printf( RED "\n\nError in Line %d. ", lineno);
    printf("Type mismatch LHS: %s and RHS: %s\n", type1, type2);
    printf(RESET);
    dontPrint=1;
}

extern void variableNotDeclaredError(char *type1,char *type2, int lineno){

    printf(RED "\n\nError in Line %d. ", lineno);
    printf("Variable not declared of type : %s and value %s\n", type1,type2);
    printf(RESET);
    dontPrint=1;
}

extern void redeclarationError(char *type1,char *type2, int lineno){

    printf(RED "\n\nError in Line %d. ", lineno);
    printf("Variable redeclared of type : %s and value %s\n", type1,type2);
    printf(RESET);
    dontPrint=1;
}

extern void returnTypeMisMatchError(char *type1,char *type2, char * returnType, int lineno){

    printf(RED "\n\nError in Line %d. ", lineno);
    printf("Invalid return type %s for function of type : %s and value %s\n",returnType, type1,type2);
    printf(RESET);
    dontPrint=1;
}

