#define CHAR 	    1
#define INT     	2
#define FLOAT       3
#define DOUBLE      4

// Keywords supporting Datatypes
#define SHORT		5
#define UNSIGNED	6
#define LONG		7


// Single-line comment 

#define SL_COMMENT   8


// To be pre-processed data

#define PRE_PROC     9


// Control statements

#define RETURN      10
#define IF          11
#define ELSE        12
#define WHILE       13


// Punctuators

#define L_FLOWER_BRKT 14
#define R_FLOWER_BRKT 15
#define L_PAREN      16
#define R_PAREN      17
#define SEMICOLON   18


// Operators


// Arithmetic operators

#define AR_PLUS        19
#define AR_MINUS       20
#define AR_MUL         21
#define AR_DIV         22
#define AR_MOD         23

// Relational Operators

#define REL_LESSTHAN    24
#define REL_LESSEQUAL   25
#define REL_EQUAL       26
#define REL_GREATERTHAN 27
#define REL_GREATEQUAL  28
#define REL_NOTEQUAL    29

// Logical Operators

#define LOG_AND      30
#define LOG_OR       31
#define LOG_COMPARE     32

// Bitwise operators

#define BITWISE_AND  33
#define BITWISE_OR   34
#define BITWISE_XOR  35


#define NUM_INTEGER		36

#define NUM_FLOAT       37

#define IDENTIFIER	38

#define STRING		39

#define NEWLINE		40

#define TAB			41

#define MUL_COMMENT_A 42
#define MUL_COMMENT_B 43

#define SINGLE_QUOTE 44

#define TOTALNUMBER 44

#include<stdio.h>

int main() {

    char strings[TOTALNUMBER][20];
    for(unsigned i = 0; i < TOTALNUMBER; i++) {
        memset(strings[i], '\0', 100);
    }

    // Basic datatypes
    strncpy(strings[CHAR], "char", 4);
    strncpy(strings[INT], "int", 3);
    strncpy(strings[FLOAT], "float", 5);
    strncpy(strings[DOUBLE], "double", 6);

    // Keywords supporting datatypes
    strncpy(strings[SHORT], "short", 5);
    strncpy(strings[UNSIGNED], "unsigned", 8);
    strncpy(strings[LONG], "long", 4);

    // Control keywords
    strncpy(strings[RETURN], "return", 6);
    strncpy(strings[IF], "if", 2);
    strncpy(strings[ELSE], "else", 4);
    strncpy(strings[WHILE], "while", 5);
    
    // Flower brackets
    strncpy(strings[L_FLOWER_BRKT], "{", 1);
    strncpy(strings[R_FLOWER_BRKT], "}", 1);
    
    // Parentheses
    strncpy(strings[L_PAREN], "(", 1);
    strncpy(strings[R_PAREN], ")", 1);
    
    // Semicolon
    strncpy(strings[SEMICOLON], ";", 1);
    
    // Arithmetic operators
    strncpy(strings[AR_PLUS], "+", 1);
    strncpy(strings[AR_MINUS], "-", 1);
    strncpy(strings[AR_MUL], "*", 1);
    strncpy(strings[AR_DIV], "/", 1);
    strncpy(strings[AR_MOD], "%%", 1);
    
    // Relational Operators
    strncpy(strings[REL_LESSTHAN], "<", 1);
    strncpy(strings[REL_LESSEQUAL], "<=", 2);
    strncpy(strings[REL_EQUAL], "=", 1);
    strncpy(strings[REL_GREATERTHAN], ">", 1);
    strncpy(strings[REL_GREATEQUAL], ">=", 2);
    strncpy(strings[REL_NOTEQUAL], "!=", 2);
    
    // Logical Operators
    strncpy(strings[LOG_AND], "&&", 2);
    strncpy(strings[LOG_OR], "||", 2);
    strncpy(strings[LOG_COMPARE], "==", 2);
    
    // Bitwise operators
    strncpy(strings[BITWISE_AND], "&", 1);
    strncpy(strings[BITWISE_OR], "|", 1);
    strncpy(strings[BITWISE_XOR], "^", 1);


    




}