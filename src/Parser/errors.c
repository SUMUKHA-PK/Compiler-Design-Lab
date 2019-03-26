#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include "comments.h"
#include "errors.h"

#define RED   "\x1B[31m"
#define RESET "\x1B[0m"

// This C file has definitions of all functions declared in errors.h

extern void bwOrOperandsTypeError(char *type1, char *type2, int lineno) {

    printf("\n\nError in Line %d. ", lineno);
    printf("There cannot be bitwise-or operation between operands of types %s and %s\n", type1, type2);
    dontPrint=1;
   // exit(1);
}

extern void bwXorOperandsTypeError(char *type1, char *type2, int lineno) {

    printf("\n\nError in Line %d. ", lineno);
    printf("There cannot be bitwise-xor operation between operands of types %s and %s\n", type1, type2);
    dontPrint=1;
    //exit(1);
}

extern void bwAndOperandsTypeError(char *type1, char *type2, int lineno) {

    printf("\n\nError in Line %d. ", lineno);
    printf("There cannot be bitwise-and operation between operands of types %s and %s\n", type1, type2);
    dontPrint=1;
    // exit(1);
}

extern void modOperandsTypeError(char *type1, char *type2, int lineno) {

    printf("\n\nError in Line %d. ", lineno);
    printf("Mod doesn't work if any of the operands is float or string_literal. Types of operands are %s and %s\n", type1, type2);
    dontPrint=1;
    // exit(1);
}   

extern void mulOperandsTypeError(char *type1, char *type2, int lineno) {
    printf("\n\nError in Line %d. ", lineno);
    printf("Multiplication doesn't work if any of the operands is a string literal. Types of operands are %s and %s\n", type1, type2);
    dontPrint=1;
    // exit(1);
}

extern void divOperandsTypeError(char *type1, char *type2, int lineno) {
    printf("\n\nError in Line %d. ", lineno);
    printf("Division doesn't work if any of the operands is a string literal. Type of operands are %s and %s\n", type1, type2);
    dontPrint=1;
    // exit(1);
}

extern void addOperandsTypeError(char *type1, char *type2, int lineno) {
    printf("\n\nError in Line %d. ", lineno);
    printf("Addition doesn't work if any of the operands is a string literal. Types of operands are %s and %s\n", type1, type2);
    dontPrint=1;
    // exit(1);
}

extern void subOperandsTypeError(char *type1, char *type2, int lineno) {
    printf("\n\nError in Line %d. ", lineno);
    printf("Subtraction doesn't work if any of the operands is a string literal. Types of operands are %s and %s\n", type1, type2);
    dontPrint=1;
    // exit(1);
}

extern void relOperandsTypeError(char *type1, char *type2, int lineno) {
    printf("\n\nError in Line %d. ", lineno);
    printf("Relational operators do not work on string literals. Type of operands are %s and %s\n", type1, type2);
    dontPrint=1;
    // exit(1);
}

extern void logOperandsTypeError(char *type1, char *type2, int lineno) {
    printf("\n\nError in Line %d. ", lineno);
    printf("Logical Operators do not work on string literals. Type of operands are %s and %s\n", type1, type2);
    dontPrint=1;
    // exit(1);
}

extern void assOperandsTypeError(char *type1, char *type2, int lineno) {
    printf("\n\nError in Line %d. ", lineno);
    printf("String literals cannot be used for assignment operation. Type of operands = %s and %s\n", type1, type2);
    dontPrint=1;
    // exit(1);
}

extern void exprInvalidError(char *type, int lineno) {
    printf("\n\nError in Line %d. ", lineno);
    printf("Expressions cannot be string literals");
    dontPrint=1;
    // exit(1);
}

extern void typeMismatchError(char *type1, char *type2, int lineno){

    printf( RED "\n\nError in Line %d. ", lineno);
    printf("Type mismatch LHS: %s and RHS: %s\n", type1, type2);
    printf(RESET);
    dontPrint=1;
    // exit(1);
}

extern void variableNotDeclaredError(char *type1,char *type2, int lineno){

    printf(RED "\n\nError in Line %d. ", lineno);
    printf("Variable not declared of type : %s and value %s\n", type1,type2);
    printf(RESET);
    dontPrint=1;
    // exit(1);
}

extern void redeclarationError(char *type1,char *type2, int lineno){

    printf(RED "\n\nError in Line %d. ", lineno);
    printf("Variable redeclared of type : %s and value %s\n", type1,type2);
    printf(RESET);
    dontPrint=1;
    // exit(1);
}

extern void returnTypeMisMatchError(char *type1,char *type2, char * returnType, int lineno){

    printf(RED "\n\nError in Line %d. ", lineno);
    printf("Invalid return type %s for function of type : %s and value %s\n",returnType, type1,type2);
    printf(RESET);
    dontPrint=1;
    // exit(1);
}

extern void tooLessArgumentsError(int lineno){

    printf(RED "\n\nError in Line %d. ", lineno);
    printf("Too few arguments!\n");
    printf(RESET);
    dontPrint=1;
    // exit(1);
}

extern void tooManyArgumentsError(int lineno){

    printf(RED "\n\nError in Line %d. ", lineno);
    printf("Too many arguments!\n");
    printf(RESET);
    dontPrint=1;
    // exit(1);
}

extern void argumentTypeMismatchError(char *type1,char *type2, int lineno){

    printf(RED "\n\nError in Line %d. ", lineno);
    printf("Argument mismatch: Argument in declaration of type : %s and in definition of type %s\n", type1,type2);
    printf(RESET);
    dontPrint=1;
    // exit(1);
}
