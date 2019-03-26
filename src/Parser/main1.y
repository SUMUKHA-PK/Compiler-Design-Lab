%{

    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include<time.h>

    #include "tableStructure1.h"

    #include "comments.h"

    #include "errors.h"

    extern int yylex();

    #define RED   "\x1B[31m"

    void yyerror(const char *s);

    extern char *yytext;
    extern int yylineno;	

    int sl_flag = -1, mul_comment_flag = 0, start_multi = 0, invalid_mul_comment = 0,dontPrint=0;

    char current_id[100];
    symbolToken *currSymbolPtr;
    char dataType[100];
    int stateDataType;
    char functype[100];
    char returnType[100];
    char argTypes[100][100];
    char argValues[100][100];
    int argLLs[100];
    int numArgs1 = 0;
    int numArgs2 = 0;
    int decORdef = 0; //0OR1
    
    // If a function definition is found, functionScope = 1
    // If functionScope == 1 && you encounter a '{', createNewScope() at '{'
    int doneWithLeftBrkt;
    int functionScope;
   

enum {
    YES,
    NO,
};

enum {
    DONE,
    GONE,
};

%}

%locations


%union {
    
    char charConst;
    struct{
            char type[100];
            char val[100];
            int num;
            float floatNum;
            char charlit;

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
%token <symAttrib> CHAR_LITERAL


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
%type <symAttrib> array_funccall
// %type <symAttrib> function_call
%type <symAttrib> argument_list
%type <symAttrib> expression 
%type <symAttrib> init_declarator
%type <symAttrib> direct_declarator
%type <symAttrib> parameter_list
%type <symAttrib> parameter_declaration
%type <symAttrib> declaration_specifiers
%type <symAttrib> declaration


%start start_unit

%% 

start_unit: 

    external_declaration            
|   start_unit external_declaration
;

external_declaration: 

    function_definition         {}
|   declaration                 {}
;

function_definition: 
    declaration_specifiers direct_declarator {
                                                symbolToken *ptr = getPtrFromParentScope($2.val);
                                                strncpy(ptr->type, "function_def", sizeof(ptr->type));    
                                             }    

        compound_statement                  {  
                                                
                                            }
                                                                                       
                                                                                    
                                                                                  
;

declaration:

    declaration_specifiers init_declaration_list ';' 
;

declaration_specifiers: 

    VOID            {insertsymbolTokenWithType(yytext, "datatype", "void", yylineno, 0); strcpy(dataType, $1.type); strcpy($$.type, $1.type);}        
|   INT             {insertsymbolTokenWithType(yytext, "datatype", "int", yylineno, 0); strcpy(dataType, $1.type); strcpy($$.type, $1.type);}                                           
|   CHAR            {insertsymbolTokenWithType(yytext, "datatype", "char", yylineno, 0);strcpy(dataType, $1.type); strcpy($$.type, $1.type);}
|   FLOAT           {insertsymbolTokenWithType(yytext, "datatype", "float", yylineno, 0); strcpy(dataType, $1.type); strcpy($$.type, $1.type);}                   
|   DOUBLE          {insertsymbolTokenWithType(yytext, "datatype", "double", yylineno, 0); strcpy(dataType, $1.type); strcpy($$.type, $1.type);}
;

direct_declarator: 

    IDENTIFIER                                      {   
                                                        strcpy($1.type, dataType);
                                                        if(!findInSymbolTable($1.val, $1.type)) {
                                                            insertsymbolToken($1.val,$1.type, yylineno, SYMBOLTABLE);
                                                        }
                                                        else
                                                            redeclarationError($1.type, $1.val, yylineno);
                                                        
                                                        strncpy($$.val, $1.val, sizeof($$.val));
                                                        strncpy($$.type, $1.type, sizeof($$.type)); 

                                                    }              
//  |   '(' direct_declarator ')'                   
|   direct_declarator '[' log_or_expression ']'     {
                                                        updateSymbolTokenType($1.val, "array"); 
                                                    }
|   direct_declarator '[' ']'                       {
                                                        updateSymbolTokenType($1.val, "array");
                                                    }
 |   direct_declarator '('                          { 
                                                        if(CurrScopeTable == GlobalScopeTable ) {
                                                            createNewScope($1.val);
                                                            functionScope = YES;
                                                        }
                                                    }       
                                                    
 
  parameter_list ')'     
                                                    
                                                    
                                                    
|   direct_declarator '(' ')'                   
;

declaration_list: 

    declaration
|   declaration_list ',' declaration
;

// compound_statement: 

//    '{' '}'                             
// |   '{' list_of_lists '}'            
// ;

compound_statement: 

    '{' 
        {   if(functionScope == YES) {
                doneWithLeftBrkt = YES;
                functionScope = NO;
            }
            else if(doneWithLeftBrkt == YES) {
                unsigned r = rand();
                char tempname[100];
                snprintf(tempname, sizeof(tempname), "%x", r);
                createNewScope(tempname);
                functionScope = NO;
            }
        }
    
    X
;

X: 
    {   gotoParentScope();
        if(CurrScopeTable->parent == GlobalScopeTable)
            functionScope = YES;    
    
    }  '}'
|   list_of_lists {
                    gotoParentScope();  
                    if(CurrScopeTable->parent == GlobalScopeTable)
                        functionScope = YES;
                  }'}'
;




init_declaration_list: 

    init_declarator                                 
|   init_declaration_list ',' init_declarator
;

init_declarator: 

    direct_declarator                               {   symbolToken *ptr = getCurrentSymbolPtr($1.val);
                                                        if(strcmp(ptr->type, "array") && strcmp(ptr->type, "function_call") && strcmp(ptr->type, "function_def"))
                                                            updateSymbolTokenType($1.val, "simple_var");
                                                            strncpy($$.val, $1.val, sizeof($$.val));
                                                    }
|   direct_declarator '=' assignment_expression     {   
                                                        symbolToken *ptr = getCurrentSymbolPtr($1.val);
                                                        if(strcmp(ptr->type, "array") && strcmp(ptr->type, "function_call") && strcmp(ptr->type, "function_def"))
                                                            updateSymbolTokenType($1.val, "simple_var");
                                                        if(strcmp($1.type, $3.type)) {
                                                            typeMismatchError($1.type, $3.type, yylineno);
                                                            exit(1);
                                                        }
                                                    }
;

parameter_list: 

     parameter_declaration                      {   
                                                    strncpy(argTypes[numArgs1], $1.type, sizeof(argTypes[numArgs1]));
                                                    strncpy(argValues[numArgs1], $1.val, sizeof(argValues[numArgs1]));
                                                    numArgs1++;
                                                }   
|   parameter_list ',' parameter_declaration    { 
                                                    strncpy(argTypes[numArgs1], $3.type, sizeof(argTypes[numArgs1]));
                                                    strncpy(argValues[numArgs1], $3.val, sizeof(argValues[numArgs1]));
                                                    numArgs1++;
                                                   
                                                }       
;

// identifier_list:

//     IDENTIFIER                                      {strcpy($1.type, dataType); strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
// |   identifier_list ',' IDENTIFIER                  {strcpy($3.type, dataType); strcpy($$.type, $3.type); strcpy($$.val, $3.val);}
// ;

parameter_declaration: 

    declaration_specifiers direct_declarator        {   
                                                        strcpy($1.type, dataType); strcpy($$.type, $1.type); strcpy($$.val, $2.val);

                                                    }
;


list_of_lists: 

    list                
|   list_of_lists list
;


list: 

    declaration_list       
|   statement           
;



statement: 

    labeled_statement
|   compound_statement
|   expression_statement
|   if_statement
|   while_statement
|   jump_statement
// |   function_call
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

    RETURN ';'
|   RETURN expression ';'                 
|   BREAK ';'
|   CONTINUE ';'
;

expression: 

    assignment_expression                           {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}        
|   expression ',' assignment_expression    
;

array_funccall: 

    primary_expression                          {
                                                    strcpy($$.type, $1.type);
                                                    strcpy($$.val, $1.val);
                                                    if(!strcmp($1.type, "int"))
                                                        $$.num = $1.num;
                                                    else if(!strcmp($1.type, "float"))
                                                        $$.floatNum = $1.floatNum;
                                                    else if(!strcmp($1.type, "char"))
                                                        $$.charlit = $1.charlit;
                                                }         

|   IDENTIFIER '[' expression ']'           {
                                                    

                                                }

|   IDENTIFIER '(' ')'              {printf("\nEncountered a function call");}
|   IDENTIFIER '(' argument_list ')'
;
  


argument_list: 
    assignment_expression                                   {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
|   argument_list ',' assignment_expression            {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
;

assignment_expression: 

    log_or_expression                               {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
|   unary_expression '=' log_or_expression          {   
                                                        if(!strcmp($1.type, "string_literal") || !strcmp($3.type, "string_literal"))
                                                            assOperandsTypeError($1.type, $3.type, yylineno);

                                                        strcpy($$.type, $1.type); strcpy($$.val, $1.val);
                                                       
                                                    }
                                                    
;

// initializer_list: 
//     initializer
// |   initializer_list '=' initializer  
// ;

unary_expression: 

    array_funccall                          {   strcpy($$.val, $1.val); 
                                                     strcpy($$.type, $1.type); 
                                                    if(!strcmp($1.type, "int"))
                                                        $$.num = $1.num;
                                                    else if(!strcmp($1.type, "float"))
                                                        $$.floatNum = $1.floatNum;

                                            }   
;

primary_expression: 

    IDENTIFIER              { insertsymbolToken(yytext,dataType, yylineno, 0); strcpy($1.type, dataType); strcpy($$.type, $1.type); strcpy($$.val, $1.val);printf("%s %s\n",$1.val,$1.type); }    


|   NUM_FLOAT               {strcpy($$.type, $1.type);  $$.floatNum = $1.floatNum;}

|   NUM_INTEGER             {strcpy($$.type, $1.type); $$.num = $1.num;}

|   STRING_LITERAL          {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}

|   CHAR_LITERAL            {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}

|   '(' expression ')'      {
                                strcpy($$.type, $2.type); 
                                if(!strcmp($2.type, "int"))
                                    $$.num = $2.num;
                                else if(!strcmp($2.type, "float"))
                                    $$.floatNum = $2.floatNum;
                                else if(!strcmp($2.type, "char"))
                                    $$.charlit = $2.charlit;
                                else if(!strcmp($2.type, "string_literal"))
                                    exprInvalidError($2.type, yylineno);
                            }
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

    unary_expression                                        {
                                                                strcpy($$.type, $1.type);
                                                                if(!strcmp($1.type, "int"))
                                                                    $$.num = $1.num;
                                                                else if(!strcmp($1.type, "float"))
                                                                    $$.floatNum, $1.floatNum;
                                                                else if(!strcmp($1.type, "char"))
                                                                    $$.charlit = $1.charlit;
                                                                else if(!strcmp($1.type, "string_literal"))
                                                                    exprInvalidError($1.type, yylineno);
                                                            }

|   multiplicative_expression '*' unary_expression          {   
                                                                if(!strcmp($1.type, "string_literal") || !strcmp($3.type, "string_literal"))
                                                                    mulOperandsTypeError($1.type, $3.type, yylineno);
                                                                // Valid cases
                                                                if(!strcmp($1.type, "int")) {
                                                                    if(!strcmp($3.type, "int")) {
                                                                        strcpy($$.type, "int");
                                                                        $$.num = $1.num * $3.num;
                                                                    }
                                                                    else if(!strcmp($3.type, "float")) {
                                                                        strcpy($3.type, "float");
                                                                        $$.floatNum = $1.num * $3.floatNum;
                                                                    }
                                                                    else  if(!strcmp($3.type, "char")) {
                                                                        strcpy($3.type, "int");
                                                                        $$.num = $1.num * $3.charlit;
                                                                    }
                                                                }
                                                                else if(!strcmp($1.type, "float")) {
                                                                    strcpy($$.type, "float");
                                                                    if(!strcmp($3.type, "int")) 
                                                                        $$.floatNum = $1.floatNum * $3.num;
                                                                    else if(!strcmp($3.type, "float"))
                                                                        $$.floatNum = $1.floatNum * $3.floatNum;
                                                                    else if(!strcmp($3.type, "char"))
                                                                        $$.floatNum = $1.floatNum * $3.charlit;
                                                                }
                                                                else if(!strcmp($1.type, "char")) {
                                                                    if(!strcmp($3.type, "int")) {
                                                                        strcpy($$.type, "int");
                                                                        $$.num = $1.charlit * $3.num;
                                                                    }
                                                                    else if(!strcmp($3.type, "float")) {
                                                                        strcpy($$.type, "float");
                                                                        $$.floatNum = $1.charlit * $3.floatNum;
                                                                    }
                                                                    else if(!strcmp($3.type, "char")) {
                                                                        strcpy($$.type, "char");
                                                                        $$.charlit = $1.charlit * $3.charlit;
                                                                    }
                                                                }
                                                            }


|   multiplicative_expression '/' unary_expression          {   if(!strcmp($1.type, "string_literal") || !strcmp($3.type, "string_literal"))
                                                                    divOperandsTypeError($1.type, $3.type, yylineno) ;
                                                                if(!strcmp($1.type, "int")) {
                                                                    if(!strcmp($3.type, "int")) {
                                                                        strcpy($$.type, "int");
                                                                        $$.num = $1.num / $3.num;
                                                                    }
                                                                    else if(!strcmp($3.type, "float")) {
                                                                        strcpy($3.type, "float");
                                                                        $$.floatNum = $1.num / $3.floatNum;
                                                                    }
                                                                    else  if(!strcmp($3.type, "char")) {
                                                                        strcpy($3.type, "int");
                                                                        $$.num = $1.num / $3.charlit;
                                                                    }
                                                                }
                                                                else if(!strcmp($1.type, "float")) {
                                                                    strcpy($$.type, "float");
                                                                    if(!strcmp($3.type, "int")) 
                                                                        $$.floatNum = $1.floatNum / $3.num;
                                                                    else if(!strcmp($3.type, "float"))
                                                                        $$.floatNum = $1.floatNum / $3.floatNum;
                                                                    else if(!strcmp($3.type, "char"))
                                                                        $$.floatNum = $1.floatNum / $3.charlit;
                                                                }
                                                                else if(!strcmp($1.type, "char")) {
                                                                    if(!strcmp($3.type, "int")) {
                                                                        strcpy($$.type, "int");
                                                                        $$.num = $1.charlit / $3.num;
                                                                    }
                                                                    else if(!strcmp($3.type, "float")) {
                                                                        strcpy($$.type, "float");
                                                                        $$.floatNum = $1.charlit / $3.floatNum;
                                                                    }
                                                                    else if(!strcmp($3.type, "char")) {
                                                                        strcpy($$.type, "char");
                                                                        $$.charlit = $1.charlit / $3.charlit;
                                                                    }
                                                                }
                                                            }


|   multiplicative_expression '%' unary_expression          {
                                                                if(!strcmp($1.type, "float") || !strcmp($3.type, "float"))
                                                                    modOperandsTypeError($1.type, $3.type, yylineno);
                                                                else if(!strcmp($1.type, "string_literal") || !strcmp($3.type, "string_literal"))
                                                                    modOperandsTypeError($1.type, $3.type, yylineno);

                                                                else if(!strcmp($1.type, "int")) {
                                                                    if(!strcmp($3.type, "int")) {
                                                                        strcpy($$.type, "int");
                                                                        $$.num = $1.num % $3.num;
                                                                    }
                                                                    else if(!strcmp($1.type, "char")) {
                                                                        strcpy($$.type, "int");
                                                                        $$.num = $1.num % $3.charlit;
                                                                    }
                                                                }
                                                                else if(!strcmp($1.type, "char")) {
                                                                    if(!strcmp($3.type, "int")) {
                                                                        strcpy($$.type, "char");
                                                                        $$.charlit = $1.charlit % $3.num;
                                                                    }
                                                                    else if(!strcmp($3.type, "char")) {
                                                                        strcpy($$.type, "char");
                                                                        $$.charlit = $1.charlit % $3.charlit;
                                                                    }
                                                                }
                                                            
                                                            }
;

additive_expression:

    multiplicative_expression                               {   strcpy($$.type, $1.type);
                                                                if(!strcmp($1.type, "int"))
                                                                    $$.num = $1.num;
                                                                else if(!strcmp($1.type, "float"))
                                                                    $$.floatNum = $1.floatNum;
                                                                else if(!strcmp($1.type, "char"))
                                                                    $$.charlit = $1.charlit;
                                                                else if(!strcmp($1.type, "string_literal"))
                                                                    exprInvalidError($1.type, yylineno);
                                                            }


|   additive_expression '+' multiplicative_expression       {   if(!strcmp($1.type, "string_literal") || !strcmp($3.type, "string_literal")) 
                                                                    addOperandsTypeError($1.type, $3.type, yylineno);
                                                                
                                                                if(!strcmp($1.type, "int")) {
                                                                    if(!strcmp($3.type, "int")) {
                                                                        strcpy($$.type, "int");
                                                                        $$.num = $1.num + $3.num;
                                                                    }
                                                                    else if(!strcmp($3.type, "char")) {
                                                                        strcpy($$.type, "int");
                                                                        $$.num = $1.num + $3.charlit;
                                                                    }
                                                                    else if(!strcmp($3.type, "float")) {
                                                                        strcpy($$.type, "float");
                                                                        $$.floatNum = $1.num + $3.floatNum;
                                                                    }
                                                                }
                                                                else if(!strcmp($1.type, "float")) {
                                                                    strcpy($$.type, "float");
                                                                    if(!strcmp($3.type, "int")) 
                                                                        $$.floatNum = $1.floatNum + $3.num;
                                                            
                                                                    else if(!strcmp($3.type, "float")) 
                                                                        $$.floatNum = $1.floatNum + $3.floatNum;
                                                                    
                                                                    else if(!strcmp($3.type, "char"))
                                                                        $$.floatNum = $1.floatNum + $3.charlit;
                                                                    
                                                                }
                                                                else if(!strcmp($1.type, "char")) {
                                                                    if(!strcmp($3.type, "int")) {
                                                                        strcpy($$.type, "int");
                                                                        $$.num = $1.charlit + $3.num;
                                                                    }
                                                                    else if(!strcmp($3.type, "char")) {
                                                                        strcpy($$.type, "char");
                                                                        $$.charlit = $1.charlit + $3.charlit;
                                                                    }
                                                                    else if(!strcmp($3.type, "float")) {
                                                                        strcpy($$.type, "float");
                                                                        $$.floatNum = $1.charlit + $3.floatNum;
                                                                    }
                                                                }
                                                            }


|   additive_expression '-' multiplicative_expression       {
                                                              if(!strcmp($1.type, "string_literal") || !strcmp($3.type, "string_literal")) 
                                                                    subOperandsTypeError($1.type, $3.type, yylineno);
                                                                
                                                                if(!strcmp($1.type, "int")) {
                                                                    if(!strcmp($3.type, "int")) {
                                                                        strcpy($$.type, "int");
                                                                        $$.num = $1.num - $3.num;
                                                                    }
                                                                    else if(!strcmp($3.type, "char")) {
                                                                        strcpy($$.type, "int");
                                                                        $$.num = $1.num - $3.charlit;
                                                                    }
                                                                    else if(!strcmp($3.type, "float")) {
                                                                        strcpy($$.type, "float");
                                                                        $$.floatNum = $1.num - $3.floatNum;
                                                                    }
                                                                }
                                                                else if(!strcmp($1.type, "float")) {
                                                                    strcpy($$.type, "float");
                                                                    if(!strcmp($3.type, "int")) 
                                                                        $$.floatNum = $1.floatNum - $3.num;
                                                            
                                                                    else if(!strcmp($3.type, "float")) 
                                                                        $$.floatNum = $1.floatNum - $3.floatNum;
                                                                    
                                                                    else if(!strcmp($3.type, "char"))
                                                                        $$.floatNum = $1.floatNum - $3.charlit;
                                                                    
                                                                }
                                                                else if(!strcmp($1.type, "char")) {
                                                                    if(!strcmp($3.type, "int")) {
                                                                        strcpy($$.type, "int");
                                                                        $$.num = $1.charlit - $3.num;
                                                                    }
                                                                    else if(!strcmp($3.type, "char")) {
                                                                        strcpy($$.type, "char");
                                                                        $$.charlit = $1.charlit - $3.charlit;
                                                                    }
                                                                    else if(!strcmp($3.type, "float")) {
                                                                        strcpy($$.type, "float");
                                                                        $$.floatNum = $1.charlit - $3.floatNum;
                                                                    }
                                                                }
                                                            }
;

relational_expression: 

    additive_expression                                         {
                                                                    strcpy($$.type, $1.type);
                                                                    if(!strcmp($1.type, "int"))
                                                                        $$.num = $1.num;
                                                                    else if(!strcmp($1.type, "float"))
                                                                        $$.floatNum = $1.floatNum;
                                                                    else if(!strcmp($1.type, "char"))
                                                                        $$.charlit = $1.charlit;
                                                                    else if(!strcmp($1.type, "string_literal"))
                                                                        exprInvalidError($1.type, yylineno);
                                                                }

|   relational_expression '<' additive_expression               { 
                                                                    if(!strcmp($1.type, "string_literal") || !strcmp($3.type, "string_literal"))
                                                                        relOperandsTypeError($1.type, $3.type, yylineno);

                                                                    strcpy($$.type, "int");
                                                                    if(!strcmp($1.type, "int")) {
                                                                        if(!strcmp($3.type, "int")) 
                                                                            $$.num = $1.num < $3.num;
                                                                        else if(!strcmp($3.type, "char"))
                                                                            $$.num = $1.num < $3.charlit;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.num < $3.floatNum;
                                                                    }
                                                                    else if(!strcmp($1.type, "float")) {
                                                                        if(!strcmp($3.type, "int"))
                                                                            $$.num = $1.floatNum < $3.num;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.floatNum < $3.floatNum;
                                                                        else if(!strcmp($3.type, "char")) 
                                                                            $$.num = $1.floatNum < $3.charlit;
                                                                    }
                                                                    else if(!strcmp($1.type, "char")) {
                                                                        if(!strcmp($3.type, "int")) 
                                                                            $$.num = $1.charlit < $3.num;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.charlit < $3.floatNum;
                                                                        else if(!strcmp($3.type, "char")) 
                                                                            $$.num = $1.charlit < $3.charlit;
                                                                    }
                                                                }

|   relational_expression '>' additive_expression               {
                                                                    if(!strcmp($1.type, "string_literal") || !strcmp($3.type, "string_literal"))
                                                                        relOperandsTypeError($1.type, $3.type, yylineno);

                                                                    strcpy($$.type, "int");
                                                                    if(!strcmp($1.type, "int")) {
                                                                        if(!strcmp($3.type, "int")) 
                                                                            $$.num = $1.num > $3.num;
                                                                        else if(!strcmp($3.type, "char"))
                                                                            $$.num = $1.num > $3.charlit;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.num > $3.floatNum;
                                                                    }
                                                                    else if(!strcmp($1.type, "float")) {
                                                                        if(!strcmp($3.type, "int"))
                                                                            $$.num = $1.floatNum > $3.num;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.floatNum > $3.floatNum;
                                                                        else if(!strcmp($3.type, "char")) 
                                                                            $$.num = $1.floatNum > $3.charlit;
                                                                    }
                                                                    else if(!strcmp($1.type, "char")) {
                                                                        if(!strcmp($3.type, "int")) 
                                                                            $$.num = $1.charlit > $3.num;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.charlit > $3.floatNum;
                                                                        else if(!strcmp($3.type, "char")) 
                                                                            $$.num = $1.charlit > $3.charlit;
                                                                    }
                                                                } 
                                                                

|   relational_expression REL_LESSEQUAL additive_expression     {
                                                                   if(!strcmp($1.type, "string_literal") || !strcmp($3.type, "string_literal"))
                                                                        relOperandsTypeError($1.type, $3.type, yylineno);

                                                                    strcpy($$.type, "int");
                                                                    if(!strcmp($1.type, "int")) {
                                                                        if(!strcmp($3.type, "int")) 
                                                                            $$.num = $1.num <= $3.num;
                                                                        else if(!strcmp($3.type, "char"))
                                                                            $$.num = $1.num <= $3.charlit;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.num <= $3.floatNum;
                                                                    }
                                                                    else if(!strcmp($1.type, "float")) {
                                                                        if(!strcmp($3.type, "int"))
                                                                            $$.num = $1.floatNum <= $3.num;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.floatNum <= $3.floatNum;
                                                                        else if(!strcmp($3.type, "char")) 
                                                                            $$.num = $1.floatNum <= $3.charlit;
                                                                    }
                                                                    else if(!strcmp($1.type, "char")) {
                                                                        if(!strcmp($3.type, "int")) 
                                                                            $$.num = $1.charlit <= $3.num;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.charlit <= $3.floatNum;
                                                                        else if(!strcmp($3.type, "char")) 
                                                                            $$.num = $1.charlit <= $3.charlit;
                                                                    }
                                                                }

|   relational_expression REL_GREATEQUAL additive_expression    {
                                                                    if(!strcmp($1.type, "string_literal") || !strcmp($3.type, "string_literal"))
                                                                        relOperandsTypeError($1.type, $3.type, yylineno);

                                                                    strcpy($$.type, "int");
                                                                    if(!strcmp($1.type, "int")) {
                                                                        if(!strcmp($3.type, "int")) 
                                                                            $$.num = $1.num >= $3.num;
                                                                        else if(!strcmp($3.type, "char"))
                                                                            $$.num = $1.num >= $3.charlit;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.num >= $3.floatNum;
                                                                    }
                                                                    else if(!strcmp($1.type, "float")) {
                                                                        if(!strcmp($3.type, "int"))
                                                                            $$.num = $1.floatNum >= $3.num;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.floatNum >= $3.floatNum;
                                                                        else if(!strcmp($3.type, "char")) 
                                                                            $$.num = $1.floatNum >= $3.charlit;
                                                                    }
                                                                    else if(!strcmp($1.type, "char")) {
                                                                        if(!strcmp($3.type, "int")) 
                                                                            $$.num = $1.charlit >= $3.num;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.charlit >= $3.floatNum;
                                                                        else if(!strcmp($3.type, "char")) 
                                                                            $$.num = $1.charlit >= $3.charlit;
                                                                    }
                                                                }
;

equality_expression: 

    relational_expression                                   {
                                                                strcpy($$.type, $1.type);
                                                                if(!strcmp($1.type, "int"))
                                                                    $$.num = $1.num;
                                                                else if(!strcmp($1.type, "float"))
                                                                    $$.floatNum = $1.floatNum;
                                                                else if(!strcmp($1.type, "char"))
                                                                    $$.charlit = $1.charlit;
                                                                else if(!strcmp($1.type, "string_literal"))
                                                                    exprInvalidError($1.type, yylineno);
                                                            }

|   equality_expression LOG_COMPARE relational_expression   {
                                                                if(!strcmp($1.type, "string_literal") || !strcmp($3.type, "string_literal"))
                                                                        relOperandsTypeError($1.type, $3.type, yylineno);

                                                                    strcpy($$.type, "int");
                                                                    if(!strcmp($1.type, "int")) {
                                                                        if(!strcmp($3.type, "int")) 
                                                                            $$.num = $1.num == $3.num;
                                                                        else if(!strcmp($3.type, "char"))
                                                                            $$.num = $1.num == $3.charlit;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.num == $3.floatNum;
                                                                    }
                                                                    else if(!strcmp($1.type, "float")) {
                                                                        if(!strcmp($3.type, "int"))
                                                                            $$.num = $1.floatNum == $3.num;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.floatNum == $3.floatNum;
                                                                        else if(!strcmp($3.type, "char")) 
                                                                            $$.num = $1.floatNum == $3.charlit;
                                                                    }
                                                                    else if(!strcmp($1.type, "char")) {
                                                                        if(!strcmp($3.type, "int")) 
                                                                            $$.num = $1.charlit == $3.num;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.charlit == $3.floatNum;
                                                                        else if(!strcmp($3.type, "char")) 
                                                                            $$.num = $1.charlit == $3.charlit;
                                                                    }
                                                            }   

|   equality_expression REL_NOTEQUAL relational_expression  {
                                                                if(!strcmp($1.type, "string_literal") || !strcmp($3.type, "string_literal"))
                                                                        relOperandsTypeError($1.type, $3.type, yylineno);

                                                                    strcpy($$.type, "int");
                                                                    if(!strcmp($1.type, "int")) {
                                                                        if(!strcmp($3.type, "int")) 
                                                                            $$.num = $1.num != $3.num;
                                                                        else if(!strcmp($3.type, "char"))
                                                                            $$.num = $1.num != $3.charlit;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.num != $3.floatNum;
                                                                    }
                                                                    else if(!strcmp($1.type, "float")) {
                                                                        if(!strcmp($3.type, "int"))
                                                                            $$.num = $1.floatNum != $3.num;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.floatNum != $3.floatNum;
                                                                        else if(!strcmp($3.type, "char")) 
                                                                            $$.num = $1.floatNum != $3.charlit;
                                                                    }
                                                                    else if(!strcmp($1.type, "char")) {
                                                                        if(!strcmp($3.type, "int")) 
                                                                            $$.num = $1.charlit != $3.num;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.charlit != $3.floatNum;
                                                                        else if(!strcmp($3.type, "char")) 
                                                                            $$.num = $1.charlit != $3.charlit;
                                                                    }
                                                            }
;

and_expression:

    equality_expression                         {strcpy($$.type, $1.type);
                                                    if(!strcmp($1.type, "int"))
                                                        $$.num = $1.num;
                                                    else if(!strcmp($1.type, "float"))
                                                        $$.floatNum = $1.floatNum;
                                                    else if(!strcmp($1.type, "char"))
                                                        $$.charlit = $1.charlit;
                                                    else if(!strcmp($1.type, "string_literal"))
                                                        exprInvalidError($1.type, yylineno);
                                                }

|   and_expression '&' equality_expression      {  if((!strcmp($1.type, "int") && !strcmp($3.type, "int"))){
                                                        strcpy($$.type, $1.type);
                                                        $$.num = $1.num & $3.num;                                                
                                                    } 
                                                    else if(!strcmp($1.type, "char") && !strcmp($3.type, "char")) {
                                                        strcpy($$.type, $1.type);
                                                        $$.charlit = $1.charlit & $3.charlit;
                                                    }
                                                    else if(!strcmp($1.type, "int") && !strcmp($3.type, "char")) {
                                                        strcpy($$.type, "int");
                                                        $$.num = $1.num & $3.charlit;
                                                    }
                                                    else if(!strcmp($1.type, "char") && !strcmp($3.type, "int")) {
                                                        strcpy($$.type, "char");
                                                        $$.num = $1.charlit & $3.num;
                                                    }
                                                    else 
                                                      bwAndOperandsTypeError($1.type, $3.type, yylineno);
                                                }
;

xor_expression: 

    and_expression                              {strcpy($$.type, $1.type);
                                                    if(!strcmp($1.type, "int"))
                                                        $$.num = $1.num;
                                                    else if(!strcmp($1.type, "float"))
                                                        $$.floatNum = $1.floatNum;
                                                    else if(!strcmp($1.type, "char"))
                                                        $$.charlit = $1.charlit;   
                                                    else if(!strcmp($1.type, "string_literal"))
                                                        exprInvalidError($1.type, yylineno);                                          
                                                }

|   xor_expression '^' and_expression           {   if((!strcmp($1.type, "int") && !strcmp($3.type, "int"))){
                                                        strcpy($$.type, $1.type);
                                                        $$.num = $1.num ^ $3.num;                                                
                                                    } 
                                                    else if(!strcmp($1.type, "char") && !strcmp($3.type, "char")) {
                                                        strcpy($$.type, $1.type);
                                                        $$.charlit = $1.charlit ^ $3.charlit;
                                                    }
                                                    else if(!strcmp($1.type, "int") && !strcmp($3.type, "char")) {
                                                        strcpy($$.type, "int");
                                                        $$.num = $1.num ^ $3.charlit;
                                                    }
                                                    else if(!strcmp($1.type, "char") && !strcmp($3.type, "int")) {
                                                        strcpy($$.type, "char");
                                                        $$.num = $1.charlit ^ $3.num;
                                                    }
                                                    else 
                                                      bwAndOperandsTypeError($1.type, $3.type, yylineno);
                                                
                                                }
;

or_expression:

    xor_expression                              {strcpy($$.type, $1.type);
                                                    if(!strcmp($1.type, "int"))
                                                        $$.num = $1.num;
                                                    else if(!strcmp($1.type, "float"))
                                                        $$.floatNum = $1.floatNum;
                                                    else if(!strcmp($1.type, "char"))
                                                        $$.charlit = $1.charlit;   
                                                    else if(!strcmp($1.type, "string_literal"))
                                                        exprInvalidError($1.type, yylineno);
                                                }

|   or_expression '|' xor_expression            { 
                                                    if((!strcmp($1.type, "int") && !strcmp($3.type, "int"))){
                                                        strcpy($$.type, $1.type);
                                                        $$.num = $1.num ^ $3.num;                                                
                                                    } 
                                                    else if(!strcmp($1.type, "char") && !strcmp($3.type, "char")) {
                                                        strcpy($$.type, $1.type);
                                                        $$.charlit = $1.charlit ^ $3.charlit;
                                                    }
                                                    else if(!strcmp($1.type, "int") && !strcmp($3.type, "char")) {
                                                        strcpy($$.type, "int");
                                                        $$.num = $1.num ^ $3.charlit;
                                                    }
                                                    else if(!strcmp($1.type, "char") && !strcmp($3.type, "int")) {
                                                        strcpy($$.type, "char");
                                                        $$.num = $1.charlit ^ $3.num;
                                                    }
                                                    else 
                                                      bwAndOperandsTypeError($1.type, $3.type, yylineno);
                                                }
;


log_and_expression: 

    or_expression                               {strcpy($$.type, $1.type);
                                                    if(!strcmp($1.type, "int"))
                                                        $$.num = $1.num;
                                                    else if(!strcmp($1.type, "float"))
                                                        $$.floatNum = $1.floatNum;
                                                    else if(!strcmp($1.type, "char"))
                                                        $$.charlit = $1.charlit;  
                                                    else if(!strcmp($1.type, "string_literal"))
                                                        exprInvalidError($1.type, yylineno); 
                                                    
                                                }

|   log_and_expression LOG_AND or_expression    { if(!strcmp($1.type, "string_literal") || !strcmp($3.type, "string_literal"))
                                                                        logOperandsTypeError($1.type, $3.type, yylineno);

                                                                    strcpy($$.type, "int");
                                                                    if(!strcmp($1.type, "int")) {
                                                                        if(!strcmp($3.type, "int")) 
                                                                            $$.num = $1.num && $3.num;
                                                                        else if(!strcmp($3.type, "char"))
                                                                            $$.num = $1.num && $3.charlit;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.num && $3.floatNum;
                                                                    }
                                                                    else if(!strcmp($1.type, "float")) {
                                                                        if(!strcmp($3.type, "int"))
                                                                            $$.num = $1.floatNum && $3.num;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.floatNum && $3.floatNum;
                                                                        else if(!strcmp($3.type, "char")) 
                                                                            $$.num = $1.floatNum && $3.charlit;
                                                                    }
                                                                    else if(!strcmp($1.type, "char")) {
                                                                        if(!strcmp($3.type, "int")) 
                                                                            $$.num = $1.charlit && $3.num;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.charlit && $3.floatNum;
                                                                        else if(!strcmp($3.type, "char")) 
                                                                            $$.num = $1.charlit && $3.charlit;
                                                                    }
                                                }
;

log_or_expression: 

    log_and_expression                          {   
                                                    strcpy($$.type, $1.type);
                                                    if(!strcmp($1.type, "int"))
                                                        $$.num = $1.num;
                                                    else if(!strcmp($1.type, "float"))
                                                        $$.floatNum = $1.floatNum;
                                                    else if(!strcmp($1.type, "char"))
                                                        $$.charlit = $1.charlit; 
                                                    else if(!strcmp($1.type, "string_literal"))
                                                        exprInvalidError($1.type, yylineno);
                                                }

|   log_or_expression LOG_OR log_and_expression {
                                                    if(!strcmp($1.type, "string_literal") || !strcmp($3.type, "string_literal"))
                                                                        logOperandsTypeError($1.type, $3.type, yylineno);

                                                                    strcpy($$.type, "int");
                                                                    if(!strcmp($1.type, "int")) {
                                                                        if(!strcmp($3.type, "int")) 
                                                                            $$.num = $1.num || $3.num;
                                                                        else if(!strcmp($3.type, "char"))
                                                                            $$.num = $1.num || $3.charlit;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.num || $3.floatNum;
                                                                    }
                                                                    else if(!strcmp($1.type, "float")) {
                                                                        if(!strcmp($3.type, "int"))
                                                                            $$.num = $1.floatNum || $3.num;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.floatNum || $3.floatNum;
                                                                        else if(!strcmp($3.type, "char")) 
                                                                            $$.num = $1.floatNum || $3.charlit;
                                                                    }
                                                                    else if(!strcmp($1.type, "char")) {
                                                                        if(!strcmp($3.type, "int")) 
                                                                            $$.num = $1.charlit || $3.num;
                                                                        else if(!strcmp($3.type, "float"))
                                                                            $$.num = $1.charlit || $3.floatNum;
                                                                        else if(!strcmp($3.type, "char")) 
                                                                            $$.num = $1.charlit || $3.charlit;
                                                                    }
                                                        

                                                }
;



%%


void yyerror(const char *s){
   printf("Error: %s at token %s in Line %d\n",s, yytext, yylineno );
}

extern int yylex();

int main()
{
    time_t t;

    srand((unsigned int )time(&t));
    initScopeTable();
    if(!yyparse()){
		if(invalid_mul_comment==1){
			printf(RED "ERROR : Invalid multi line commenting at line %d\n",start_multi);
			printf(RESET);
		}
		else if(mul_comment_flag==1){
			printf(RED "ERROR : No multi line comment ender, starts at line %d\n",yylineno);
			printf(RESET);
		}
    }
        
    else
        printf("\nParsing error!\n");

    printScopeTables(GlobalScopeTable);
}
