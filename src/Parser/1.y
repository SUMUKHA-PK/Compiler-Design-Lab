%{

    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>

    #include "tableStructure.h"

    #include "comments.h"

    #include "errors.h"

    extern int yylex();

    #define RED   "\x1B[31m"

    void yyerror(const char *s);

    extern char *yytext;
    extern int yylineno;	

    int sl_flag = -1, mul_comment_flag = 0, start_multi = 0, invalid_mul_comment = 0;

    char Type[100];
    char functype[100];

%}

%locations


%union {
    
    char charConst;
    struct{
            char type[100];
            char val[100];
            int num;
    float floatNum;

    } symAttrib;
}

%token <symAttrib> VOID 
%token <symAttrib> CHAR
%token <symAttrib> INT
%token <symAttrib> FLOAT
%token <symAttrib> DOUBLE 



%token SHORT UNSIGNED LONG
%token IF ELSE WHILE 
%token RETURN 
%token BREAK 
%token CONTINUE

// %token <id> IDENTIFIER
// %token <num> NUM_INTEGER
// %token <floatNum> NUM_FLOAT 
// %token STRING_LITERAL

%token <symAttrib> IDENTIFIER
%token <symAttrib> NUM_INTEGER
%token <symAttrib> NUM_FLOAT 
%token <symAttrib> STRING_LITERAL


%token INC_OP 
%token DEC_OP

%left REL_LESSEQUAL REL_GREATEQUAL REL_EQUAL REL_NOTEQUAL REL_LESSTHAN REL_GREATERTHAN
%left AR_PLUS AR_MINUS AR_MUL AR_DIV AR_MOD BITWISE_XOR BITWISE_AND BITWISE_OR
%left LOG_AND LOG_OR LOG_COMPARE

// %type <symAttrib> initializer
%type <symAttrib> assignment_expression
// %type <symAttrib> initializer_list
%type <symAttrib> log_or_expression
%type <symAttrib> log_and_expression
%type <symAttrib> or_expression
%type <symAttrib> xor_expression
%type <symAttrib> and_expression
%type <symAttrib> equality_expression
%type <symAttrib> relational_expression
%type <symAttrib> additive_expression
%type <symAttrib> multiplicative_expression
%type <symAttrib> unary_expression
%type <symAttrib> primary_expression
%type <symAttrib> expression 
// %type <symAttrib> unary_operator



%type <symAttrib> declaration_specifiers

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
;

declaration:

    declaration_specifiers ';'
|   declaration_specifiers init_declaration_list ';'
;

declaration_specifiers: 

    VOID            {strcpy(Type, $1.type); strcpy($$.type, $1.type); printf("Type = %s\n", $1.type);}        
|   INT             {strcpy(Type, $1.type); strcpy($$.type, $1.type); printf("Type = %s\n", $1.type);}                                           
|   CHAR            {strcpy(Type, $1.type); strcpy($$.type, $1.type); printf("Type = %s\n", $1.type);}
|   FLOAT           {strcpy(Type, $1.type); strcpy($$.type, $1.type); printf("Type = %s\n", $1.type);}                   
|   DOUBLE          {strcpy(Type, $1.type); strcpy($$.type, $1.type); printf("Type = %s\n", $1.type);}
;

direct_declarator: 

    IDENTIFIER                                      { insertsymbolToken(yytext,Type, yylineno, 0); printf("Type: %s\n",Type); }            
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

    parameter_declaration       
|   parameter_list ',' parameter_declaration         
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



list: 

    declaration_list 
|   statement     
;

initializer:
    assignment_expression
// |   '{' initializer_list '}'
// |   '{' initializer_list ',' '}'
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

    RETURN expression ';'                           {strcpy(returnType,$2.type);}
|   BREAK ';'
|   CONTINUE ';'
;

expression: 

    assignment_expression                           {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}        
|   expression ',' assignment_expression
;

assignment_expression: 

    log_or_expression                               {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
|   unary_expression '=' log_or_expression          {   if(findInHashTable($1.val,$1.type)){
                                                            if(strcmp($1.type,$3.type)){
                                                                typeMismatchError($1.type,$3.type,yylineno);
                                                            }
                                                        }
                                                        else{
                                                            variableNotDeclaredError($3.type,yylineno);
                                                        }
                                                    }
;

unary_expression: 

    primary_expression                          {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
// |   INC_OP unary_expression             
// |   DEC_OP unary_expression             
// |   unary_operator unary_expression     
;

primary_expression: 

    IDENTIFIER              { insertsymbolToken(yytext,Type, yylineno, 0);strcpy($1.type, Type); strcpy($$.type, $1.type); strcpy($$.val, $1.val); }                            
|   NUM_FLOAT               {strcpy($$.type, $1.type); strcpy($$.val, $1.val); $$.floatNum = $1.floatNum;}
|   NUM_INTEGER             {strcpy($$.type, $1.type); strcpy($$.val, $1.val); $$.num = $1.num;}
|   STRING_LITERAL          {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
|   '(' expression ')'      {strcpy($$.type, $2.type); strcpy($$.val, $2.val); $$.num = $2.num; $$.floatNum = $2.floatNum;}
;


// unary_operator: 

//     '&'
// |   '*'
// |   '+'
// |   '-'
// |   '~'
// |   '!'
// ;

multiplicative_expression:

    unary_expression    {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
|   multiplicative_expression '*' unary_expression          {strcpy($$.type, $1.type); strcpy($$.val, $1.val); }
|   multiplicative_expression '/' unary_expression          {strcpy($$.type, $1.type); strcpy($$.val, $1.val); }
|   multiplicative_expression '%' unary_expression          {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
;

additive_expression:

    multiplicative_expression                                {strcpy($$.type, $1.type); strcpy($$.val, $1.val); }
|   additive_expression '+' multiplicative_expression       {strcpy($$.type, $1.type); strcpy($$.val, $1.val); }
|   additive_expression '-' multiplicative_expression       {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
;

relational_expression: 

    additive_expression                                         {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
|   relational_expression '<' additive_expression               {strcpy($$.type, $1.type); strcpy($$.val, $1.val); }
|   relational_expression '>' additive_expression               {strcpy($$.type, $1.type); strcpy($$.val, $1.val); }
|   relational_expression REL_LESSEQUAL additive_expression     {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
|   relational_expression REL_GREATEQUAL additive_expression    {strcpy($$.type, $1.type); strcpy($$.val, $1.val); }
;

equality_expression: 

    relational_expression                                   {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
|   equality_expression LOG_COMPARE relational_expression   {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
|   equality_expression REL_NOTEQUAL relational_expression  {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
;

and_expression:

    equality_expression                         {strcpy($$.type, $1.type);
                                                    if(!strcmp($1.type, "int"))
                                                        $$.num = $1.num;
                                                    else
                                                        $$.floatNum = $1.floatNum;
                                                }
|   and_expression '&' equality_expression      {{ if((!strcmp($1.type, "int") && !strcmp($3.type, "int")) || (!strcmp($1.type, "char") && !strcmp($3.type, "char"))){
                                                        strcpy($$.type, $1.type);
                                                        $$.num = $1.num & $3.num;                                                
                                                    } 
                                                  else 
                                                      logAndOperandsTypeError($1.type, $3.type, yylineno);
                                                }}
;

xor_expression: 

    and_expression                              {strcpy($$.type, $1.type); 
                                                    if(!strcmp($1.type, "int"))
                                                        $$.num = $1.num;
                                                    else
                                                        $$.floatNum = $1.floatNum;                                               
                                                }

|   xor_expression '^' and_expression           {{ if((!strcmp($1.type, "int") && !strcmp($3.type, "int")) || (!strcmp($1.type, "char") && !strcmp($3.type, "char"))){
                                                        strcpy($$.type, $1.type);
                                                        $$.num = $1.num ^ $3.num;                                                
                                                    } 
                                                  else 
                                                      logXorOperandsTypeError($1.type, $3.type, yylineno);
                                                }
                                                }
;

or_expression:

    xor_expression                              {strcpy($$.type, $1.type); 
                                                    if(!strcmp($1.type, "int"))
                                                        $$.num = $1.num;
                                                    else
                                                        $$.floatNum = $1.floatNum;
                                                }

|   or_expression '|' xor_expression            { if((!strcmp($1.type, "int") && !strcmp($3.type, "int")) || (!strcmp($1.type, "char") && !strcmp($3.type, "char"))){
                                                        strcpy($$.type, $1.type);
                                                        $$.num = $1.num | $3.num;                                                
                                                    } 
                                                  else 
                                                      logOrOperandsTypeError($1.type, $3.type, yylineno);
                                                }
;


log_and_expression: 

    or_expression                               {strcpy($$.type, $1.type);  
                                                    if(!strcmp($1.type, "int"))
                                                        $$.num = $1.num;
                                                    
                                                    else if(!strcmp($1.type, "float"))
                                                        $$.floatNum = $1.floatNum;
                                                    
                                                }

|   log_and_expression LOG_AND or_expression    { strcpy($$.type, "int");
                                                    int i1, i2; float f1, f2;
                                                    // if(!strcmp())
                                                    
                                                }
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

































