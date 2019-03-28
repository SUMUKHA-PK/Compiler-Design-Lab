#include<stdio.h>

#include "tableStructure.h"
#include "comments.h"

int symbolTableSize  = 1000;
int constantTableSize = 1000;
int TableSize = 1000;
int currTableID = -1;
int start = 0;

Tables * currTable = NULL, *headTable = NULL;

void initTable(Tables* table){

    symbolTableSize  = 1000;
    constantTableSize = 1000;
    
	for(int i=0;i<TableSize;i++){
		table->symbolTable[i]=NULL;
		table->constantTable[i] = NULL;
	}
}

int getCurrTableID(){
    return currTableID;
}

// Cues the creation of a new table pointer, maintains that as the curr pointer
void incrementTableScope(){
    Tables *newTable = (Tables*)malloc(sizeof(Tables));
    initTable(newTable);
    // Main scope
    if(currTableID == -1){
        newTable->ID = currTableID+1;
        currTableID = newTable->ID;
        currTable = newTable;
        newTable->parent = NULL;
        newTable->next = NULL;
        headTable = newTable;
        
    }
    // Internal scope
    else{
        newTable->ID = currTableID+1;
        currTableID = newTable->ID;
        newTable->parent = currTable;
        currTable->next = newTable;
        currTable = newTable;
        newTable->next = NULL;
    }
}

// Accesses parent of the current table and sets that to current status
void returnToParentScope(){
    currTable = currTable->parent;
    currTableID = currTable->ID;
}

void printTable(int table,Tables * tableP){
	int i;
	if(table==0) {
		int tableSize = symbolTableSize;
	}
	else {
		int tableSize = constantTableSize;
	} 
	
	for(i=0;i<TableSize;i++){
		symbolToken * temp;
		if(table==0) temp = tableP->symbolTable[i];
		else temp = tableP->constantTable[i];
		while(temp!=NULL){
			printf("%-10s%10s%20d\n",temp->value,temp->type,temp->line);
			temp=temp->next;
		}
	}
}

void printTables(){  
    Tables * temp = headTable;
    while(temp!=NULL){

        printf("\n-----------------------------------------------------------------\n");
        printf("\n--------------------------Scope starting-------------------------\n");
        printf("\n-----------------------------------------------------------------\n");

        printf(GREEN "\n\nSYMBOL TABLE" RESET);
        printf("\n-----------------------------------------------------------------\n");
        printf(BLUE "%-20s%10s%24s\n","VALUE","TYPE","LINE NUMBER" RESET);
        printf("-----------------------------------------------------------------\n");
        printTable(0,temp);

        printf(GREEN "\n\nCONSTANT TABLE" RESET);
        printf("\n-----------------------------------------------------------------\n");
        printf(BLUE "%-20s%10s%24s\n","VALUE","TYPE","LINE NUMBER" RESET);
        printf("-----------------------------------------------------------------\n");
        printTable(1,temp);

        printf("\n-----------------------------------------------------------------\n");
        printf("\n--------------------------Scope complete-------------------------\n");
        printf("\n-----------------------------------------------------------------\n");
        
        temp=temp->next;
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

    if(start==0){
        incrementTableScope();
        start=1;
    }

    Tables * table = currTable;
    int hashIndex = hash(value);

    symbolToken *item = createsymbolToken(value, type, lineNumber);

    if(tableno == 0)
    {
        symbolToken * temp = table->symbolTable[hashIndex];
        while(temp!=NULL && temp->next!=NULL)
            temp = temp->next;

        if(temp == NULL)
            table->symbolTable[hashIndex] = item;
        else
            temp->next = item;
    }
    else
    {
        symbolToken * temp = table->constantTable[hashIndex];
        while(temp!=NULL && temp->next!=NULL)
            temp = temp->next;

        if(temp == NULL)
            table->constantTable[hashIndex] = item;
        else
            temp->next = item;
    }
    
}

//f=0 -> not found  ;  f=1--> found
int findInHashTable(char * value,char *type){
    
    Tables * table = currTable;
    int hashIndex = hash(value);
    int f = 0;
    if(ifIf==0){
        symbolToken * temp = table->symbolTable[hashIndex];
        while(temp!=NULL){
            if(!strcmp(temp->value,value)){
                f=1;
                strcpy(type,temp->type);
                break;
            }
            temp=temp->next;
        }
        return f;
    }
    else{
        printTable(0,table);
        while(table!=NULL){
            printTable(0,table);
            symbolToken * temp = table->symbolTable[hashIndex];
            while(temp!=NULL){
                if(!strcmp(temp->value,value)){
                    f=1;
                    strcpy(type,temp->type);
                    break;
                }
                temp=temp->next;
            }
            table=table->parent;
        }
        return f;
    }
}

int deleteFromHashTable(char * value,char *type){

    Tables * table = currTable;
    int hashIndex = hash(value);
    symbolToken * temp = table->symbolTable[hashIndex];
    symbolToken * temp1 = temp;
    while(temp!=NULL){
        if(!strcmp(temp->value,value)&&!strcmp(temp->type,type)){
            temp1->next = temp->next;
            int l = temp->line;
            free(temp);
            return l;
        }
        temp1=temp;
        temp=temp->next;
    }
}