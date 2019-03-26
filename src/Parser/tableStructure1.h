#ifndef _TABLE_STRUCTURE_H
#define _TABLE_STRUCTURE_H 1

#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#define RED   "\x1B[31m"
#define RESET "\x1B[0m"
#define GREEN "\x1B[32m"
#define BLUE  "\x1B[34m"

enum {
    SYMBOLTABLE, 
    CONSTANTTABLE,
};

enum {
    DECLARATION,
    DEFINITION,
};

extern int symbolTableSize, constantTableSize;

// A symbol and all it's details.
struct symbol {
    char name[100];    // Name of keyword/identifier, value of constant
    char type[100];     // can be var, array, func, keyword
    char datatype[100]; // can be int, float, char
    union {
        char value[100];    // For var - init value(default=0)
        char size[100];     // For array - size
        char param_name[100][100];
        char param_type[100][100];   // For func - parameter list
    };  // The union variables may not be used if tokens are datatypes
    int line;
    struct symbol *next;
};

typedef struct symbol symbolToken;

// In Global scope, there are only 2 tables.
// 1. For declarations - functions, variables, arrays
// 2. For function definitions - several of them

// One table for one scope
struct table {
    char scopeName[100];
    symbolToken *symbolTable[1000];
    symbolToken *constantTable[1000];
    int ID;
    struct table *parent;
    struct table *prev;
    struct table *next;
    struct table *child[100];
    unsigned childCount;
};

typedef struct table ScopeTable;

extern ScopeTable *CurrScopeTable;

// All routines related to Scopes, Symbol Tables

// Spawns 1 Table - for global scope - file-level scope
// In the beginning, there is only global scope
extern ScopeTable *GlobalScopeTable;

extern void initScopeTable();

extern void createNewScope(char *name);

extern void gotoParentScope();

// Print a give table
// table = 0 => print symbolTable
// table = 1 => print constantTable
// extern void printTable(int table,Tables* tableP);


extern symbolToken* getCurrentSymbolPtr(char *);


// The awesome hash function
extern int hash(unsigned char *s);

// Creates, initialises a symbol and returns a pointer to it.
extern symbolToken* createsymbolToken(char *name, char *type, int lineNumber);

// Inserts a given symbol into a specified table.
extern symbolToken* insertsymbolToken(char *name, char *type, int lineNumber, int tableno);

extern void insertsymbolTokenWithType(char *name, char *type, char *datatype, int lineNumber, int table);

extern void updatesymbolTokenType(char *name, char *type);

// Creates a new ScopeTable for a new scope
extern void incrementTableScope();

// When the current scope ends, this routine is called to return to parent scope
extern void returnToParentScope();

extern void printScopeTables(ScopeTable *);

int findInSymbolTable(char * value,char *type);


#endif  // _TABLE_STRUCTURE_H