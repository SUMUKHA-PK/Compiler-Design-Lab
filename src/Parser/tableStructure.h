#ifndef _TABLE_STRUCTURE_H
#define _TABLE_STRUCTURE_H 1

#include<stdio.h>
    #include<stdlib.h>
    #include<string.h>

int symbolTableSize = 0,constantTableSize=0;
    
// Hardcoded TableSize value. 0
int TableSize = 1000;


// Structure of a symbol
typedef struct symbol {
	char value[100];
	char type[100];
	int line;
	struct symbol* next; 
} symbolToken;

// 2 Tables are defined: symbolTable and constantTable
symbolToken * symbolTable[1000];
symbolToken * constantTable[1000];

// Initializes the 2 tables - allocates memory to 2 tables.
void initTables();

// Print a give table
// table = 0 => print symbolTable
// table = 1 => print constantTable
void printTable(int table);


// The awesome hash function
int hash(unsigned char * s);

// Creates, initialises a symbol and returns a pointer to it.
symbolToken* createsymbolToken(char *value, char *type, int lineNumber);

// Inserts a given symbol into a specified table.
void insertsymbolToken(char *value, char *type, int lineNumber, int tableno);
  

#endif // _TABLE_STRUCTURE_H