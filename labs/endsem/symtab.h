#include<stdio.h>


typedef struct symTabItem
{
    char value[100];
    char token[100];
    int line;
    struct symTabItem* next;
}symItem;


// typedef struct table
// {
//     symItem* symbolTable[1000];
//     symItem* constTable[1000];
//     struct table* parent;
//     struct table* next;
// }Tables;

symItem* createSymbolToken(char* value, char* token, int line){
    symItem* item = (symItem*)malloc(sizeof(symItem));
    strcpy(item->token,token);
    strcpy(item->value,value);
    item->line = line;
    item->next = NULL;
    return item;
}

void initTables(){

}

extern int flag,comm;

void insertSymbolToken(char * value, char * token, int line){
    symItem* tempToken = createSymbolToken(value,token,line);

}

int hash(const char *s){
    unsigned int hash = 5381;
    int c;

    while(c= *s++)
        hash = (((hash<<5)+hash)+c)%1000;

    return hash;
}