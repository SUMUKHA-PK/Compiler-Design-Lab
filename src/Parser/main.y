%{

    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>

    #include "tableStructure.h"

    #include "comments.h"

    extern int yylex();

    #define RED   "\x1B[31m"

    void yyerror(const char *s);

    extern char *yytext;
    extern int yylineno;	

    int sl_flag = -1, mul_comment_flag = 0, start_multi = 0, invalid_mul_comment = 0;

    char type[100];

%}

%locations


%union {
    struct sym {
            union {
                char val[200];
                int int_value;
                float float_value;
                double double_value;
            };
    } symAttrib;
}

%token <symAttrib> VOID CHAR INT FLOAT DOUBLE 
%token SHORT UNSIGNED LONG
%token IF ELSE WHILE 
%token RETURN 
%token BREAK 
%token CONTINUE

%token <symAttrib> IDENTIFIER
%token <symAttrib> NUM_INTEGER
%token <symAttrib> NUM_FLOAT 
%token <symAttrib> STRING_LITERAL
%token <symAttrib> L_FLOWER_BRKT    
%token <symAttrib> R_FLOWER_BRKT
%token <symAttrib> L_PAREN
%token <symAttrib> R_PAREN
%token <symAttrib> L_SQR_BRKT
%token <symAttrib> R_SQR_BRKT
%token <symAttrib> EXCLAMATION
%token <symAttrib> TILDE

%token <symAttrib> SEMICOLON
%token <symAttrib> COLON
%token <symAttrib> COMMA 
%token <symAttrib> DOT
%token <symAttrib> INC_OP 
%token <symAttrib> DEC_OP

%token <symAttrib> REL_EQUAL
%token <symAttrib> REL_GREATEQUAL
%token <symAttrib> REL_GREATERTHAN
%token <symAttrib> REL_LESSEQUAL
%token <symAttrib> REL_LESSTHAN
%token <symAttrib> REL_NOTEQUAL

%token <symAttrib> AR_PLUS
%token <symAttrib> AR_MINUS
%token <symAttrib> AR_MUL
%token <symAttrib> AR_DIV
%token <symAttrib> AR_MOD
%token <symAttrib> BITWISE_AND
%token <symAttrib> BITWISE_OR
%token <symAttrib> BITWISE_XOR

%token <symAttrib> LOG_AND
%token <symAttrib> LOG_OR
%token <symAttrib> LOG_COMPARE


%left  REL_LESSEQUAL REL_GREATEQUAL REL_EQUAL REL_NOTEQUAL REL_LESSTHAN REL_GREATERTHAN
%left AR_PLUS AR_MINUS AR_MUL AR_DIV AR_MOD BITWISE_XOR BITWISE_AND BITWISE_OR
%left LOG_AND LOG_OR LOG_COMPARE

%type <symAttrib> parameter_declaration
%type <symAttrib> parameter_list

%type <symAttrib> direct_declarator
%type <symAttrib> direct_abstract_declarator

%type <symAttrib> declaration_specifiers

%type <symAttrib> expression
%type <symAttrib> assignment_expression
%type <symAttrib> log_and_expression
%type <symAttrib> log_or_expression
%type <symAttrib> or_expression
%type <symAttrib> and_expression
%type <symAttrib> xor_expression
%type <symAttrib> relational_expression
%type <symAttrib> additive_expression
%type <symAttrib> multiplicative_expression
%type <symAttrib> primary_expression
%type <symAttrib> unary_expression
%type <symAttrib> equality_expression
%type <symAttrib> unary_operator



%type <symAttrib> init_declaration_list
%type <symAttrib> init_declarator

%start start_unit

%% 

start_unit: 

    external_declaration            
|   start_unit external_declaration
;

external_declaration: 

    function_definition    
|   declaration             
;

function_definition: 

    declaration_specifiers direct_declarator declaration_list compound_statement 
|   declaration_specifiers direct_declarator compound_statement
|   direct_declarator declaration_list compound_statement
|   direct_declarator compound_statement
;

declaration:

|   declaration_specifiers init_declaration_list SEMICOLON {}
;

declaration_specifiers: 

    VOID            {strcpy(type, $1.val); strcpy($$.val, $1.val);}
|   INT             {strcpy(type, $1.val); strcpy($$.val, $1.val);}
|   CHAR           {strcpy(type, $1.val); strcpy($$.val, $1.val);}
|   FLOAT           {strcpy(type, $1.val); strcpy($$.val, $1.val);}
|   DOUBLE          {strcpy(type, $1.val); strcpy($$.val, $1.val);}
|   Modifiers INT   {strcpy(type, $2.val); strcpy($$.val, $2.val);}
|   Modifiers FLOAT {strcpy(type, $2.val); strcpy($$.val, $2.val);}
|   Modifiers CHAR      {strcpy(type, $2.val); strcpy($$.val, $2.val);}
|   Modifiers DOUBLE    {strcpy(type, $2.val); strcpy($$.val, $2.val);}
;

Modifiers: 

    SHORT
|   UNSIGNED
|   LONG
;

direct_declarator: 

    IDENTIFIER      
|   L_PAREN direct_declarator R_PAREN
|   direct_declarator L_SQR_BRKT log_or_expression R_SQR_BRKT
|   direct_declarator L_SQR_BRKT R_SQR_BRKT
|   direct_declarator L_PAREN parameter_list R_PAREN
|   direct_declarator L_PAREN identifier_list R_PAREN
|   direct_declarator L_PAREN R_PAREN
;

declaration_list: 

    declaration
|   declaration_list COMMA declaration
;

compound_statement: 

    L_FLOWER_BRKT R_FLOWER_BRKT
|   L_FLOWER_BRKT list_of_lists R_FLOWER_BRKT        
;

init_declaration_list: 

    init_declarator
|   init_declaration_list COMMA init_declarator
;

log_or_expression: 

    log_and_expression
|   log_or_expression LOG_OR log_and_expression
;

parameter_list: 

    parameter_declaration       { printf("Parameter dcl : %s\n");}
|   parameter_list COMMA parameter_declaration      { printf("Parameter list : %s\n");}      
;

identifier_list:

    IDENTIFIER
|   identifier_list COMMA IDENTIFIER
;

parameter_declaration: 

    declaration_specifiers direct_declarator 
|   declaration_specifiers direct_abstract_declarator
|   declaration_specifiers
;

direct_abstract_declarator:

     L_PAREN direct_abstract_declarator R_PAREN
|    L_SQR_BRKT R_SQR_BRKT
|    L_SQR_BRKT log_or_expression R_SQR_BRKT
|    direct_abstract_declarator L_SQR_BRKT R_SQR_BRKT
|    direct_abstract_declarator L_SQR_BRKT log_or_expression R_SQR_BRKT
|    L_PAREN R_PAREN
|    L_PAREN parameter_list R_PAREN
|    direct_abstract_declarator L_PAREN R_PAREN
|    direct_abstract_declarator L_PAREN parameter_list R_PAREN
;

list_of_lists: 

    list
|   list_of_lists list
;

init_declarator: 

    direct_declarator
|   direct_declarator REL_EQUAL initializer
;

log_and_expression: 

    or_expression
|   log_and_expression LOG_AND or_expression
;

list: 

    declaration_list 
|   statement     
;

initializer:
    assignment_expression
|   L_FLOWER_BRKT initializer_list R_FLOWER_BRKT
|   L_FLOWER_BRKT initializer_list COMMA R_FLOWER_BRKT
;

or_expression:

    xor_expression
|   or_expression BITWISE_OR xor_expression
;

statement: 

    labeled_statement
|   compound_statement
|   expression_statement
|   if_statement
|   while_statement
|   jump_statement
;

labeled_statement: 

    IDENTIFIER ':' statement
;

expression_statement: 

    SEMICOLON
|   expression SEMICOLON
;

if_statement: 

    IF L_PAREN expression R_PAREN statement
|   IF L_PAREN expression R_PAREN statement ELSE statement
;

while_statement: 

    WHILE L_PAREN expression R_PAREN statement
;

jump_statement: 

    RETURN expression SEMICOLON
|   BREAK SEMICOLON
|   CONTINUE SEMICOLON
;

expression: 

    assignment_expression
;

assignment_expression: 

    log_or_expression
|   unary_expression REL_EQUAL log_or_expression
;

initializer_list: 
    initializer
|   initializer_list COMMA initializer
;

unary_expression: 

    primary_expression
|   INC_OP unary_expression             
|   DEC_OP unary_expression             
|   unary_operator unary_expression     
;

primary_expression: 

    IDENTIFIER                      {printf("Assigned to : %s",$$);} // Assignment check
|   STRING_LITERAL
|   L_PAREN expression R_PAREN
|   NUM_INTEGER
|   NUM_FLOAT
;


unary_operator: 

    BITWISE_AND
|   AR_MUL
|   AR_PLUS
|   AR_MINUS
|   TILDE
|   EXCLAMATION
;

multiplicative_expression:

    unary_expression
|   multiplicative_expression AR_MUL unary_expression
|   multiplicative_expression AR_DIV unary_expression
|   multiplicative_expression AR_MOD unary_expression
;

additive_expression:

    multiplicative_expression
|   additive_expression AR_PLUS multiplicative_expression
|   additive_expression AR_MINUS multiplicative_expression
;

relational_expression: 

    additive_expression
|   relational_expression REL_LESSTHAN additive_expression
|   relational_expression REL_GREATERTHAN additive_expression
|   relational_expression REL_LESSEQUAL additive_expression
|   relational_expression REL_GREATEQUAL additive_expression
;

equality_expression: 

    relational_expression
|   equality_expression LOG_COMPARE relational_expression
|   equality_expression REL_NOTEQUAL relational_expression
;

and_expression:

    equality_expression
|   and_expression BITWISE_AND equality_expression
;

xor_expression: 

    and_expression
|   xor_expression BITWISE_XOR and_expression
;

%%


void yyerror(const char *s){
   printf("Error: %s at token %s in Line %d\n",s, yytext, yylineno );
}

extern int yylex();

int main()
{
    if(!yyparse()){
		if(invalid_mul_comment==1){
			printf(RED "ERROR : Invalid multi line commenting at line %d\n",start_multi);
			printf(RESET);
		}
		else if(mul_comment_flag==1){
			printf(RED "ERROR : No multi line comment ender, starts at line %d\n",yylineno);
			printf(RESET);
		}
        printf("\nParsing complete\n");
        printTables();
    }
        
    else
        printf("\nParsing error!\n");
}

































