#ifndef _TABLE_STRUCTURE_H
#define _TABLE_STRUCTURE_H 1

#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#define RED   "\x1B[31m"
#define RESET "\x1B[0m"
#define GREEN "\x1B[32m"
#define BLUE  "\x1B[34m"

extern int symbolTableSize, constantTableSize;

// Structure of a symbol
typedef struct symbol {
	char value[100];
	char type[100];
	int line;
	struct symbol* next; 
} symbolToken;

// Representation of a set of tables for a scope
typedef struct table {
	symbolToken * symbolTable[1000];  
	symbolToken * constantTable[1000];
	char * funcData[100];
	int ID; 
	struct table * parent;
	struct table * next;
} Tables;

// Hardcoded TableSize value. 0
extern int TableSize, currTableID;

// Initializes the 2 tables - allocates memory to 2 tables.
extern void initTable(Tables* table);

// Print a give table
// table = 0 => print symbolTable
// table = 1 => print constantTable
extern void printTable(int table,Tables* tableP);

extern void printTables();

// The awesome hash function
int hash(unsigned char * s);

// Creates, initialises a symbol and returns a pointer to it.
extern symbolToken* createsymbolToken(char *value, char *type, int lineNumber);

// Inserts a given symbol into a specified table.
extern void insertsymbolToken(char *value, char *type, int lineNumber, int tableno);

extern void incrementTableScope();

extern void returnToParentScope();

int deleteFromHashTable(char * value,char *type);
int findInHashTable(char * value,char *type);

#endif // _TABLE_STRUCTURE_H