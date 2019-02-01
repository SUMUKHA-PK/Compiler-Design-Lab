%{
    #include<stdio.h>
%}

%token CHAR
%token INT
%token FLOAT
%token DOUBLE
%token SHORT
%token UNSIGNED
%token LONG

%token RETURN
%token IF
%token ELSE
%token WHILE
%token L_FLOWER_BRKT    
%token R_FLOWER_BRKT
%token L_PAREN
%token R_PAREN
%token STRING 

%token IDENTIFIER
%token NUM_INTEGER 
%token NUM_FLOAT

%left REL_LESSEQUAL REL_GREATEQUAL REL_EQUAL REL_NOTEQUAL REL_LESSTHAN REL_GREATERTHAN
%left AR_PLUS AR_MINUS AR_MUL AR_DIV AR_MOD BITWISE_XOR BITWISE_AND BITWISE_OR
%left LOG_AND LOG_OR
%start ED

%%
    ED: E {printf("Valid Expression\n\n");}
    ;
    E:    E AR_PLUS E
        | NUM_INTEGER
    ;
%%

void yyerror(){
    printf("Invalid Expression\n");
}

int main()
{
    printf("Enter expression: ");
    if(!yyparse())
        printf("\nParsing complete\n");
    else
        printf("\nParsing failed\n");

}
