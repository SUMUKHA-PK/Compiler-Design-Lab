#include<stdio.h>

#include "tableStructure1.h"
#include "comments.h"

int symbolTableSize = 1000;
int constantTableSize = 1000;

// Initially, ID = -1
// ID of global scope = 0   -- Important
int currTableID = -1;
int start = 0;

ScopeTable *GlobalScopeTable = NULL;
ScopeTable *CurrScopeTable = NULL;

void initScopeTable() {

    GlobalScopeTable = (ScopeTable *)malloc(sizeof(ScopeTable));
    
    strncpy(GlobalScopeTable->scopeName, "global", 6);

    for(unsigned i = 0; i < symbolTableSize; i++)
        GlobalScopeTable->symbolTable[i] = NULL;
    
    for(unsigned i = 0; i < constantTableSize; i++)
        GlobalScopeTable->constantTable[i] = NULL;
    
    // ID is always 0
    GlobalScopeTable->ID = 0;

    // I don't have parent and siblings.
    // I am the god scope in a given source file
    GlobalScopeTable->parent = NULL;
    GlobalScopeTable->prev = NULL;
    GlobalScopeTable->next = NULL;

    // I can only have a children
    // But I don't have any children in the beginning
    for(unsigned i = 0; i < 100; i++)
        GlobalScopeTable->child[i] = NULL;
    
    GlobalScopeTable->childCount = 0;
    
    // Initialization
    CurrScopeTable = GlobalScopeTable;
}

// Creating a new Scope Table
ScopeTable* createNewScopeTable(char *name) {

    ScopeTable* newTable = (ScopeTable *)malloc(sizeof(ScopeTable));
    strncpy(newTable->scopeName, name, strlen(name));
    newTable->parent = NULL;
    newTable->prev = NULL;
    newTable->next = NULL;

    for(unsigned i = 0; i < 100; i++)
        newTable->child[i] = NULL;
    
    newTable->childCount = 0;

    return newTable;
}

void createNewScope(char *name) {
    ScopeTable *newTable = createNewScopeTable(name);
    
    CurrScopeTable->child[CurrScopeTable->childCount] = newTable;
    newTable->parent = CurrScopeTable;
    
    // If CurrScopeTable already has children, do the following.
    if(CurrScopeTable->childCount != 0) {
        CurrScopeTable->child[CurrScopeTable->childCount-1]->next = newTable;
        newTable->prev = CurrScopeTable->child[CurrScopeTable->childCount-1];
    }

    CurrScopeTable->childCount++;

    // Change scope to newTable
    CurrScopeTable = newTable;
}


void gotoParentScope() {
    if(CurrScopeTable != GlobalScopeTable)
        CurrScopeTable = CurrScopeTable->parent;
}

// All SymbolTable and ScopeTable related routines start from here
// When symbols are scanned, only it's value, type and lineNumber are known.
// Other attributes will be populated while parsing

symbolToken* createsymbolToken(char *name, char *datatype, int lineNumber) {
    symbolToken *item = (symbolToken *)malloc(sizeof(symbolToken));
    strncpy(item->name, name, sizeof(item->name));
    strncpy(item->datatype, datatype, sizeof(item->datatype));
    item->line = lineNumber;
    item->next = NULL;
    strncpy(item->type, "\0", sizeof(item->type));

    return item;
}

int hash(unsigned char * s){
	unsigned long hashVar = 5381;
	int c;

    while (c = *s++)
        hashVar = (((hashVar << 5) + hashVar) + c)%1000;

    return hashVar;
}

void updateSymbolTokenType(char *name, char *type) {

    symbolToken *ptr = getCurrentSymbolPtr(name);
    strncpy(ptr->type, type, sizeof(ptr->type));

}


void insertsymbolTokenWithType(char *name, char *type, char *datatype, int lineNumber, int table) {

    symbolToken *item = insertsymbolToken(name, datatype, lineNumber, table);
    strncpy(item->type, type, sizeof(item->type));
}


symbolToken* insertsymbolToken(char *name, char *datatype, int lineNumber, int table) {

    int hashIndex = hash(name);

    symbolToken *item = createsymbolToken(name, datatype, lineNumber);

    if(!strcmp(name, "int") || !strcmp(name, "float") || !strcmp(name, "char") || !strcmp(name, "double") || !strcmp(name, "void")) 
        strncpy(item->datatype, name, sizeof(item->datatype));

    if(table == SYMBOLTABLE) {
        symbolToken *temp = CurrScopeTable->symbolTable[hashIndex];
        while(temp != NULL && temp->next != NULL)
            temp = temp->next;
        
        if(temp == NULL)
            CurrScopeTable->symbolTable[hashIndex] = item;
        else
            temp->next = item;
    }
    else {
        symbolToken *temp = CurrScopeTable->constantTable[hashIndex];
        while(temp != NULL && temp->next != NULL)
            temp = temp->next;
        
        if(temp == NULL)
            CurrScopeTable->constantTable[hashIndex] = item;
        else
            temp->next = item;
    }

    return item;
}


// Used for function names
symbolToken* getPtrFromParentScope(char *name) {
     int hashIndex = hash(name);

    symbolToken *ptr = CurrScopeTable->parent->symbolTable[hashIndex];

    if(!strcmp(ptr->name, name)) {
        return ptr;
    }
  
    if(ptr->next != NULL) {
        ptr = ptr->next;
        if(!strcmp(ptr->name, name))
            return ptr;
    }
}


symbolToken* getCurrentSymbolPtr(char *name) {

    int hashIndex = hash(name);

    symbolToken *ptr = CurrScopeTable->symbolTable[hashIndex];

    if(!strcmp(ptr->name, name)) {
        return ptr;
    }
  
    if(ptr->next != NULL) {
        ptr = ptr->next;
        if(!strcmp(ptr->name, name))
            return ptr;
    }

    return NULL;
}

void printSymbolTable(int table,symbolToken **symbolTable){
	int i;
    int tableSize;
	if(table==SYMBOLTABLE) {
		tableSize = symbolTableSize;
	}
	else {
		tableSize = constantTableSize;
	} 
	
	for(i=0;i<tableSize;i++){
		symbolToken * temp;
		temp = symbolTable[i];
		while(temp!=NULL){
			printf("%-20s%20s%20s%20d\n",temp->name,temp->datatype,temp->type,temp->line);
			temp=temp->next;
		}
	}
}

extern void printScopeTables(ScopeTable *CST) {

    if(CST == NULL)
        return;
    
    printf("\n\n\nScope: %s\n", CST->scopeName);
    printf("Symbol Table: \n");
    printSymbolTable(SYMBOLTABLE, CST->symbolTable);
    printf("Constant Table: \n");
    printSymbolTable(CONSTANTTABLE, CST->constantTable);

    for(unsigned i = 0; i < 100; i++)
        printScopeTables(CST->child[i]);
}

int findInSymbolTable(char * value,char *type){
    
    ScopeTable *table = CurrScopeTable;
    int hashIndex = hash(value);
    int f = 0;
    symbolToken * temp = table->symbolTable[hashIndex];
    while(temp!=NULL){
        if(!strcmp(temp->value,value)&&!strcmp(temp->type,type)){
            f=1;
            break;
        }
        temp=temp->next;
    }
    return f;
}