%{
    #include<stdio.h>
    #include<string.h>
    extern char *yytext;
    extern int yylineno;

    void yyerror(const char *s);
    char typeVar[100];
    int comm = -1;
%}

%union{
    struct{
        char type[100];
        char val[100];
        int num;
        float floatNum;
        char charLit;
    }symattrib;
}

%token <symattrib> INT
%token <symattrib> FLOAT
%token <symattrib> RETURN
%token <symattrib> IDENTIFIER
%token <symattrib> NUM_INTEGER
%token IF
%token ELSE
%token <symattrib> NUM_FLOAT
%token BREAK

%type <symattrib> ext_dec
%type <symattrib> ext_dec_1
%type <symattrib> ext_dec_2
%type <symattrib> ext_dec_3
%type <symattrib> constants
%type <symattrib> type
%start start

%%

start:  start_unit
|   start start_unit
;

start_unit: pre_proc | function | ext_dec 
;

pre_proc: '#' IDENTIFIER '<' IDENTIFIER '.' IDENTIFIER '>'
;

ext_dec: type ext_dec_1 ';'     
;

ext_dec_1: IDENTIFIER ext_dec_2     {
                                        strcpy($1.type,typeVar);printf("%s %s %s\n",$1.type,$1.val,yytext);
    
                                    }   
;

ext_dec_2: ',' ext_dec_1
|   '=' constants ext_dec_3 {strcpy($$.val,$2.val);strcpy($$.type,$2.type);}
|
;

ext_dec_3: ',' ext_dec_1
|
;

constants: NUM_INTEGER
|   NUM_FLOAT
;

type: INT   {strcpy(typeVar,$1.type);strcpy($$.type,$1.type);}
|   FLOAT   {strcpy(typeVar,$1.type);strcpy($$.type,$1.type);}
;

function: type IDENTIFIER '(' parameters ')' '{' func_stuff '}'  
;

func_stuff: func_stuff_1 ret_type
;

func_stuff_1: ext_dec func_stuff_1
|   if_else
;

ret_type: return ';'
;

return: RETURN 
|   RETURN vars
;

parameters: type IDENTIFIER par_dec
|
;

par_dec: ',' parameters
|
;

vars: NUM_INTEGER
| NUM_FLOAT
;

if_else: IF '(' statements ')' '{' if_else_1 '}' if_else_2
;

if_else_2: ELSE if_else 
|   ELSE '{' if_else_1 '}'
|
;

if_else_1: ext_dec
| dec
| operations
| BREAK ';'
;

dec: IDENTIFIER '=' constants ';'
;

statements: IDENTIFIER operators statements_1
;

statements_1:  vars
|   IDENTIFIER
;

operators: '&''&'
|   '!''='
|   '>''='
|   '<'
|   '*'
|   '+'
;

operations: IDENTIFIER '=' operations_1 operators operations_1 ';'
;

operations_1: IDENTIFIER
|   constants
;

%%

void yyerror(const char *c){
    printf("Error: %s at token %s in line %d\n",c,yytext,yylineno);
}

extern int yylex();

int main(){
    if(!yyparse()){
        printf("Parsing complete!\n");
    }
    else{
        printf("Parsing error!\n");
    }
}