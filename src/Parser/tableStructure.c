#include<stdio.h>

#include "tableStructure.h"

 symbolTableSize  = 1000;
 constantTableSize = 1000;
TableSize = 1000;

void initTables(){

    symbolTableSize  = 1000;
    constantTableSize = 1000;
    

	for(int i=0;i<TableSize;i++){
		symbolTable[i]=NULL;
		constantTable[i] = NULL;
	}
}

void printTable(int table){
	int i;
	if(table==0) {
		int tableSize = symbolTableSize;
	}
	else {
		int tableSize = constantTableSize;
	} 
	
	for(i=0;i<TableSize;i++){
		symbolToken * temp;
		if(table==0) temp = symbolTable[i];
		else temp = constantTable[i];
		while(temp!=NULL){
			printf("%-10s%10s%20d\n",temp->value,temp->type,temp->line);
			temp=temp->next;
		}
	}
}

int hash(unsigned char * s){
	unsigned long hashVar = 5381;
	int c;

    while (c = *s++)
        hashVar = (((hashVar << 5) + hashVar) + c)%1000;

    return hashVar;
}

symbolToken* createsymbolToken(char *value, char *type, int lineNumber){
    symbolToken *item = (symbolToken*)malloc(sizeof(symbolToken));
    strcpy(item->value, value);
    strcpy(item->type, type);
    item->line = lineNumber;
    item->next = NULL;

    return item;
}

void insertsymbolToken(char *value, char *type, int lineNumber, int tableno){
    int hashIndex = hash(value);

    symbolToken *item = createsymbolToken(value, type, lineNumber);

    if(tableno == 0)
    {
        symbolToken * temp = symbolTable[hashIndex];
        while(temp!=NULL && temp->next!=NULL)
            temp = temp->next;

        if(temp == NULL)
            symbolTable[hashIndex] = item;
        else
            temp->next = item;
    }

    else
    {
        symbolToken * temp = constantTable[hashIndex];
        while(temp!=NULL && temp->next!=NULL)
            temp = temp->next;

        if(temp == NULL)
            constantTable[hashIndex] = item;
        else
            temp->next = item;
    }
    
}