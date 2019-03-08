%{

    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    
    #include "y.tab.h"

    #include "tableStructure.h"

    #include "comments.h"

    void yyerror(const char *s);

     extern char *yytext;
    extern int yylineno;	

    #define RED   "\x1B[31m"
    #define RESET "\x1B[0m"
    #define GREEN "\x1B[32m"
    #define BLUE  "\x1B[34m"


%}

%locations

%token VOID CHAR INT FLOAT DOUBLE SHORT UNSIGNED LONG
%token IF ELSE WHILE 
%token RETURN 
%token BREAK 
%token CONTINUE

%token IDENTIFIER
%token NUM_INTEGER NUM_FLOAT 
%token STRING_LITERAL

%token REL_LESSEQUAL REL_GREATEQUAL REL_EQUAL REL_NOTEQUAL REL_LESSTHAN REL_GREATERTHAN

%token LOG_AND LOG_OR LOG_COMPARE

%token INC_OP 
%token DEC_OP

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

    declaration_specifiers declarator declaration_list compound_statement
|   declaration_specifiers declarator compound_statement
|   declarator declaration_list compound_statement
|   declarator compound_statement
;

statement: 

    labeled_statement
|   compound_statement
|   expression_statement
|   if_statement
|   while_statement
;

statement_list: 

    statement
|   statement_list statement
;

labeled_statement: 

    IDENTIFIER ':' statement
;

compound_statement: 

    '{' '}'
|   '{' statement_list '}'
|   '{' declaration_list '}'
|   '{' declaration_list statement_list '}'
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

primary_expression: 

    IDENTIFIER
|   NUM_FLOAT
|   NUM_INTEGER
|   STRING_LITERAL
|   '(' expression ')'
;

unary_expression: 

    primary_expression
|   INC_OP unary_expression
|   DEC_OP unary_expression
|   unary_operator unary_expression
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

log_and_expression: 

    or_expression
|   log_and_expression LOG_AND or_expression
;

log_or_expression: 

    log_and_expression
|   log_or_expression LOG_OR log_and_expression
;

assignment_expression: 

    log_or_expression
|   unary_expression assignment_operator log_or_expression
;

assignment_operator: 

    '='
;

expression: 

    assignment_expression
|   expression ',' assignment_expression
;

constant_expression: 

    log_or_expression
;

type_specifier: 

    VOID
|   INT
|   CHAR
|   FLOAT
|   DOUBLE
|   SHORT
|   LONG
|   UNSIGNED
;

declarator: 

    direct_declarator
;

direct_declarator: 

    IDENTIFIER
|   '(' declarator ')'
|   direct_declarator '[' constant_expression ']'
|   direct_declarator '[' ']'
|   direct_declarator '(' parameter_list ')'
|   direct_declarator '(' identifier_list ')'
|   direct_declarator '(' ')'
;

identifier_list:

    IDENTIFIER
|   identifier_list ',' IDENTIFIER
;

parameter_list: 

    parameter_declaration
|   parameter_list ',' parameter_declaration
;

parameter_declaration: 

    declaration_specifiers declarator
|   declaration_specifiers abstract_declarator
|   declaration_specifiers
;

abstract_declarator: 

    direct_abstract_declarator
;

direct_abstract_declarator:

     '(' abstract_declarator ')'
|    '[' ']'
|    '[' constant_expression ']'
|    direct_abstract_declarator '[' ']'
|    direct_abstract_declarator '[' constant_expression ']'
|    '(' ')'
|    '(' parameter_list ')'
|    direct_abstract_declarator '(' ')'
|    direct_abstract_declarator '(' parameter_list ')'
;

declaration:

    declaration_specifiers ';'
|   declaration_specifiers init_declaration_list ';'
;

declaration_list: 

    declaration
|   declaration_list ',' declaration
;

declaration_specifiers: 

    type_specifier
;

init_declaration_list: 

    init_declarator
|   init_declaration_list ',' init_declarator
;

init_declarator: 

    declarator
|   declarator '=' initializer
;

initializer:
     assignment_expression
|   '{' initializer_list '}'
|   '{' initializer_list ',' '}'
;

initializer_list: 
    initializer
|   initializer_list ',' initializer
;

%%


void yyerror(const char *s){
   printf("Error: %s at token %s in Line %d\n",s, yytext, yylineno );
}

extern int yylex();

int main()
{
	initTables();
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
        printf(GREEN "\n\nSYMBOL TABLE" RESET);
        printf("\n-----------------------------------------------------------------\n");
        printf(BLUE "%-20s%10s%24s\n","VALUE","TYPE","LINE NUMBER" RESET);
        printf("-----------------------------------------------------------------\n");
        printTable(0);

        printf(GREEN "\n\nCONSTANT TABLE" RESET);
        printf("\n-----------------------------------------------------------------\n");
        printf(BLUE "%-20s%10s%24s\n","VALUE","TYPE","LINE NUMBER" RESET);
        printf("-----------------------------------------------------------------\n");
        printTable(1);
    }
        
    else
        printf("\nParsing error!\n");
}

































