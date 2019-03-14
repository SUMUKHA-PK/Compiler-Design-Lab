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

%}

%locations

%union {
	char id[100];
    int num;
    float floatNum;
    char charConst;
    struct{
            char type[100];
            char val[100];
    } symAttrib;
}

%token <id> VOID CHAR INT FLOAT DOUBLE 
%token SHORT UNSIGNED LONG
%token IF ELSE WHILE 
%token RETURN 
%token BREAK 
%token CONTINUE

%token <id> IDENTIFIER
%token <num> NUM_INTEGER
%token <floatNum> NUM_FLOAT 
%token <id> STRING_LITERAL
// %token <id> L_FLOWER_BRKT    
// %token <id> R_FLOWER_BRKT
// %token <id> L_PAREN
// %token <id> R_PAREN
// %token <id> L_SQR_BRKT
// %token <id> R_SQR_BRKT
// %token <id> EXCLAMATION
// %token <id> TILDE

// %token <id> SEMICOLON
// %token <id> COLON
// %token <id> COMMA 
// %token <id> DOT
%token INC_OP 
%token DEC_OP

%left REL_LESSEQUAL REL_GREATEQUAL REL_EQUAL REL_NOTEQUAL REL_LESSTHAN REL_GREATERTHAN
%left AR_PLUS AR_MINUS AR_MUL AR_DIV AR_MOD BITWISE_XOR BITWISE_AND BITWISE_OR
%left LOG_AND LOG_OR LOG_COMPARE


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

    declaration_specifiers ';'
|   declaration_specifiers init_declaration_list ';'
;

declaration_specifiers: 

    VOID
|   INT                              
|   CHAR            
|   FLOAT           
|   DOUBLE          
;

direct_declarator: 

    IDENTIFIER                  
|   '(' direct_declarator ')'
|   direct_declarator '[' log_or_expression ']'
|   direct_declarator '[' ']'
|   direct_declarator '(' parameter_list ')'
|   direct_declarator '(' identifier_list ')'
|   direct_declarator '(' ')'
;

declaration_list: 

    declaration
|   declaration_list ',' declaration
;

compound_statement: 

    '{' '}'
|   '{' list_of_lists '}'        
;

init_declaration_list: 

    init_declarator
|   init_declaration_list ',' init_declarator
;

log_or_expression: 

    log_and_expression
|   log_or_expression LOG_OR log_and_expression
;

parameter_list: 

    parameter_declaration       { printf("Parameter dcl : %s\n");}
|   parameter_list ',' parameter_declaration      { printf("Parameter list : %s\n");}      
;

identifier_list:

    IDENTIFIER
|   identifier_list ',' IDENTIFIER
;

parameter_declaration: 

    declaration_specifiers direct_declarator 
|   declaration_specifiers direct_abstract_declarator
|   declaration_specifiers
;

direct_abstract_declarator:

     '(' direct_abstract_declarator ')'
|    '[' ']'
|    '[' log_or_expression ']'
|    direct_abstract_declarator '[' ']'
|    direct_abstract_declarator '[' log_or_expression ']'
|    '(' ')'
|    '(' parameter_list ')'
|    direct_abstract_declarator '(' ')'
|    direct_abstract_declarator '(' parameter_list ')'
;

list_of_lists: 

    list
|   list_of_lists list
;

init_declarator: 

    direct_declarator
|   direct_declarator '=' initializer
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
|   '{' initializer_list '}'
|   '{' initializer_list ',' '}'
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

    ';'
|   expression ';'
;

if_statement: 

    IF '(' expression ')' statement
|   IF '(' expression ')' statement ELSE statement
;

while_statement: 

    WHILE '(' expression ')' statement
;

jump_statement: 

    RETURN expression ';'
|   BREAK ';'
|   CONTINUE ';'
;

expression: 

    assignment_expression
|   expression ',' assignment_expression
;

assignment_expression: 

    log_or_expression
|   unary_expression '=' log_or_expression
;

initializer_list: 
    initializer
|   initializer_list '=' initializer
;

unary_expression: 

    primary_expression
|   INC_OP unary_expression             
|   DEC_OP unary_expression             
|   unary_operator unary_expression     
;

primary_expression: 

    IDENTIFIER                      
|   NUM_FLOAT
|   NUM_INTEGER
|   STRING_LITERAL
|   '(' expression ')'
;

unary_operator: 

    '&'
|   '*'
|   '+'
|   '-'
|   '~'
|   '!'
;

multiplicative_expression:

    unary_expression
|   multiplicative_expression '*' unary_expression
|   multiplicative_expression '/' unary_expression
|   multiplicative_expression '%' unary_expression
;

additive_expression:

    multiplicative_expression
|   additive_expression '+' multiplicative_expression
|   additive_expression '-' multiplicative_expression
;

relational_expression: 

    additive_expression
|   relational_expression '<' additive_expression
|   relational_expression '>' additive_expression
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
|   and_expression '&' equality_expression
;

xor_expression: 

    and_expression
|   xor_expression '^' and_expression
;

or_expression:

    xor_expression
|   or_expression '|' xor_expression
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

































