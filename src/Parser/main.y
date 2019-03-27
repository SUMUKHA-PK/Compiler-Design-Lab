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

    int sl_flag = -1, mul_comment_flag = 0, start_multi = 0, invalid_mul_comment = 0,dontPrint=0;

    char Type[100];
    char functype[100];
    char returnType[100];
    char argTypes[100][100];
    char argValues[100][100];
    int argLLs[100];
    int numArgs1 = 0;
    int numArgs2 = 0;
    int decORdef = 0; //0OR1
    Tables* currTable;

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
%type <symAttrib> argument_list
%type <symAttrib> expression 
%type <symAttrib> init_declarator
%type <symAttrib> direct_declarator
%type <symAttrib> parameter_list
%type <symAttrib> parameter_declaration

%type <symAttrib> return
%type <symAttrib> RETURN

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
     declaration_specifiers direct_declarator declaration_list compound_statement  {
                                                                                    if(returnType[0]=='\0') strcpy(returnType,"void");
                                                                                        if(strcmp($1.type,returnType)){
                                                                                        returnTypeMisMatchError($1.type,$1.val,returnType, yylineno);
                                                                                    }
                                                                                  }
 |   declaration_specifiers direct_declarator compound_statement                  { if(returnType[0]=='\0') strcpy(returnType,"void");
                                                                                        if(strcmp($1.type,returnType)){
                                                                                        returnTypeMisMatchError($1.type,$1.val,returnType, yylineno);
                                                                                    }
                                                                                  }
|   direct_declarator declaration_list compound_statement
;

declaration:

    declaration_specifiers ';'
|   declaration_specifiers init_declaration_list ';'
;

declaration_specifiers: 

    VOID            {strcpy(Type, $1.type); strcpy($$.type, $1.type);}        
|   INT             {strcpy(Type, $1.type); strcpy($$.type, $1.type);}                                           
|   CHAR            {strcpy(Type, $1.type); strcpy($$.type, $1.type);}
|   FLOAT           {strcpy(Type, $1.type); strcpy($$.type, $1.type);}                   
|   DOUBLE          {strcpy(Type, $1.type); strcpy($$.type, $1.type);}
;

direct_declarator: 

    IDENTIFIER                                      {   strcpy($1.type, Type); strcpy($$.type, $1.type); strcpy($$.val, $1.val);
                                                        if(!findInHashTable($1.val,$1.type)){
                                                            insertsymbolToken(yytext,$1.type, yylineno, 0);
                                                        }
                                                        else{
                                                            if(!decORdef) redeclarationError($1.type,$1.val,yylineno);
                                                        }
                                                    }               
// |   '(' direct_declarator ')'
|   direct_declarator '[' log_or_expression ']'
|   direct_declarator '[' ']'
|   direct_declarator '('                       {
                                                    if(decORdef==1)incrementTableScope();
                                                }
    parameter_list ')'     
                                                {  
                                                    // strcpy($$.type, $1.type); strcpy($$.val, $1.val);
                                                    if(decORdef==0){
                                                        decORdef=1;
                                                    }
                                                    else{
                                                        if(numArgs2>numArgs1){
                                                            tooManyArgumentsError(yylineno);
                                                        }
                                                        else if(numArgs2<numArgs1){
                                                            tooLessArgumentsError(yylineno);   
                                                        }
                                                        decORdef=2;
                                                    }
                                                    if(decORdef==2){
                                                        // for(int i=0;i<numArgs1;i++){
                                                        //     argLLs[i] = deleteFromHashTable(argValues[i],argTypes[i]);
                                                        //     printf("Args: %s %s %d\n",argValues[i],argTypes[i],argLLs[i]);
                                                        // }
                                                        // incrementTableScope();
                                                        // for(int i=0;i<numArgs1;i++){
                                                        //     insertsymbolToken(argValues[i],argTypes[i],argLLs[i],0);
                                                        // }
                                                        decORdef = 0;
                                                    }
                                                }           
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


parameter_list: 

     parameter_declaration                       {   //{strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
                                                    if(decORdef==0) {
                                                        strcpy(argTypes[numArgs1],$1.type); 
                                                        strcpy(argValues[numArgs1],$1.val); 
                                                        numArgs1++;
                                                    }
                                                    else{
                                                        // printf("SOMETHING:1 %s1 %s",argTypes[numArgs2],$1.type);
                                                        if(strcmp(argTypes[numArgs2],$1.type)){
                                                            argumentTypeMismatchError(argTypes[numArgs2],$1.type,yylineno);          
                                                        }
                                                        numArgs2++;
                                                    }
                                                }   
|   parameter_list ',' parameter_declaration    {   
                                                    if(decORdef==0) {
                                                        strcpy(argTypes[numArgs1],$3.type);
                                                        strcpy(argValues[numArgs1],$3.val);
                                                        numArgs1++; 
                                                    }
                                                    else{
                                                        // printf("SOMETHING:j %sj %s",argTypes[numArgs2],$3.type);
                                                        if(strcmp(argTypes[numArgs2],$3.type)){
                                                            argumentTypeMismatchError(argTypes[numArgs2],$3.type,yylineno);        
                                                        }
                                                        numArgs2++;
                                                    }
                                                }       
;

identifier_list:

    IDENTIFIER                                  //    {strcpy($1.type, Type); strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
|   identifier_list ',' IDENTIFIER              //    {strcpy($3.type, Type); strcpy($$.type, $3.type); strcpy($$.val, $3.val);}
;

parameter_declaration: 

    declaration_specifiers direct_declarator        {strcpy($1.type, Type); strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
// |   declaration_specifiers direct_abstract_declarator
|   declaration_specifiers
;

// direct_abstract_declarator:

// //      '(' direct_abstract_declarator ')'
// // |    '[' ']'
// // |    '[' log_or_expression ']'
// |    direct_abstract_declarator '[' ']'
// |    direct_abstract_declarator '[' log_or_expression ']'
// // |    '(' ')'
// // |    '(' parameter_list ')'
// |    direct_abstract_declarator '(' ')'                     
// |    direct_abstract_declarator '(' parameter_list ')'      {
//                                                                 strcpy(argTypes[numArgs1],$3.type); numArgs1++; printf("Argtype: %s\n",$3.type);
//                                                             }   
// ;

list_of_lists: 

    list
|   list_of_lists list
;

init_declarator: 

    direct_declarator          
|   direct_declarator '=' assignment_expression     {   char typeStr[100];    
                                                        if(findInHashTable($1.val,typeStr)){
                                                            strcpy($1.type,typeStr);
                                                            if(strcmp($1.type,$3.type)){
                                                                typeMismatchError($1.type,$3.type,yylineno);
                                                            }
                                                        }
                                                        else{
                                                            variableNotDeclaredError($3.type,$3.val,yylineno);
                                                        }
                                                    }
;



list: 

    declaration_list 
|   statement     
;

// initializer:
//     assignment_expression
// // |   '{' initializer_list '}'
// // |   '{' initializer_list ',' '}'
// ;


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

    return  ';'
|   BREAK ';'
|   CONTINUE ';'
;

return: 
    RETURN 
|   RETURN expression                               {strcpy(returnType,$2.type);}
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
                                                }         

|   array_funccall '[' expression ']'           {
                                                    

                                                }

|   array_funccall '(' ')'                      {
                                                    

                                                }

|   array_funccall '(' argument_list ')'
;

argument_list: 
    assignment_expression                                   {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
|   argument_list ',' assignment_expression            {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
;

assignment_expression: 

    log_or_expression                               {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
|   unary_expression '=' log_or_expression          {  strcpy($$.type, $1.type); strcpy($$.val, $1.val);
                                                        if(findInHashTable($1.val,$1.type)){
                                                            if(strcmp($1.type,$3.type)){
                                                                typeMismatchError($1.type,$3.type,yylineno);
                                                            }
                                                        }
                                                        else{
                                                            variableNotDeclaredError($3.type,$3.val,yylineno);
                                                        }
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
// |   INC_OP unary_expression             
// |   DEC_OP unary_expression             
// |   unary_operator unary_expression     
;

primary_expression: 

    IDENTIFIER              { insertsymbolToken(yytext,Type, yylineno, 0); strcpy($1.type, Type); strcpy($$.type, $1.type); strcpy($$.val, $1.val);}    


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
                                                            }
|   multiplicative_expression '*' unary_expression          {   if(!strcmp($1.type, "string_literal") || !strcmp($3.type, "string_literal"))
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


|   multiplicative_expression '/' unary_expression          { 
                                                                if(!strcmp($1.type, "int") && !strcmp($3.type, "int")) {
                                                                    strcpy($$.type, "int");
                                                                    $$.num = $1.num / $3.num;
                                                                }
                                                                else if(!strcmp($1.type, "int") && !strcmp($3.type, "float")) {
                                                                    strcpy($$.type, "float");
                                                                    $$.floatNum = $1.num / $3.floatNum;
                                                                }
                                                                else if(!strcmp($1.type, "float") && !strcmp($3.type, "int")) {
                                                                    strcpy($$.type, "float");
                                                                    $$.floatNum = $1.floatNum / $3.num;
                                                                }
                                                                else if(!strcmp($1.type, "float") && !strcmp($3.type, "float")) {
                                                                    strcpy($$.type, "float");
                                                                    $$.floatNum = $1.floatNum / $3.floatNum;
                                                                }
                                                            }


|   multiplicative_expression '%' unary_expression          {
                                                                if(!strcmp($1.type, "float") || !strcmp($3.type, "float"))
                                                                    modOperandsTypeError($1.type, $3.type, yylineno);
                                                                else {
                                                                    strcpy($$.type, "int");
                                                                    $$.num = $1.num % $3.num;
                                                                }
                                                            
                                                            }
;

additive_expression:

    multiplicative_expression                               {strcpy($$.type, $1.type);
                                                                if(!strcmp($1.type, "int"))
                                                                    $$.num = $1.num;
                                                                else if(!strcmp($1.type, "float"))
                                                                    $$.floatNum = $1.floatNum;
                                                            }


|   additive_expression '+' multiplicative_expression       { if(!strcmp($1.type, "int") && !strcmp($3.type, "int")) {
                                                                    strcpy($$.type, "int");
                                                                    $$.num = $1.num + $3.num;
                                                                }
                                                                else if(!strcmp($1.type, "int") && !strcmp($3.type, "float")) {
                                                                    strcpy($$.type, "float");
                                                                    $$.floatNum = $1.num + $3.floatNum;                                                                    
                                                                }
                                                                else if(!strcmp($1.type, "float") && !strcmp($3.type, "int")) {
                                                                    strcpy($$.type, "float");
                                                                    $$.floatNum = $1.floatNum + $3.num;
                                                                }
                                                                else {
                                                                    strcpy($$.type, "float");
                                                                    $$.floatNum = $1.floatNum + $3.floatNum;
                                                                } 
                                                            }


|   additive_expression '-' multiplicative_expression       {
                                                                if(!strcmp($1.type, "int") && !strcmp($3.type, "int")) {
                                                                    strcpy($$.type, "int");
                                                                    $$.num = $1.num - $3.num;
                                                                }
                                                                else if(!strcmp($1.type, "int") && !strcmp($3.type, "float")) {
                                                                    strcpy($$.type, "float");
                                                                    $$.floatNum = $1.num - $3.floatNum;                                                                    
                                                                }
                                                                else if(!strcmp($1.type, "float") && !strcmp($3.type, "int")) {
                                                                    strcpy($$.type, "float");
                                                                    $$.floatNum = $1.floatNum - $3.num;
                                                                }
                                                                else {
                                                                    strcpy($$.type, "float");
                                                                    $$.floatNum = $1.floatNum - $3.floatNum;
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
                                                                }

|   relational_expression '<' additive_expression               { 
                                                                    strcpy($$.type, "int");
                                                                    if(!strcmp($1.type, "int") && !strcmp($3.type, "int"))
                                                                        $$.num = $1.num < $3.num;
                                                                    else if(!strcmp($1.type, "int") && !strcmp($3.type, "float"))
                                                                        $$.num = $1.num < $3.floatNum;
                                                                    else if(!strcmp($1.type, "float") && !strcmp($3.type, "int"))
                                                                        $$.num = $1.floatNum < $3.num;
                                                                    else if(!strcmp($1.type, "float") && !strcmp($3.type, "float"))
                                                                        $$.num = $1.floatNum < $3.floatNum;
                                                                }

|   relational_expression '>' additive_expression               {
                                                                    strcpy($$.type, "int");
                                                                    if(!strcmp($1.type, "int") && !strcmp($3.type, "int"))
                                                                        $$.num = $1.num > $3.num;
                                                                    else if(!strcmp($1.type, "int") && !strcmp($3.type, "float"))
                                                                        $$.num = $1.num > $3.floatNum;
                                                                    else if(!strcmp($1.type, "float") && !strcmp($3.type, "int"))
                                                                        $$.num = $1.floatNum > $3.num;
                                                                    else if(!strcmp($1.type, "float") && !strcmp($3.type, "float"))
                                                                        $$.num = $1.floatNum > $3.floatNum;
                                                                } 
                                                                

|   relational_expression REL_LESSEQUAL additive_expression     {
                                                                    strcpy($$.type, "int");
                                                                    if(!strcmp($1.type, "int") && !strcmp($3.type, "int"))
                                                                        $$.num = $1.num <= $3.num;
                                                                    else if(!strcmp($1.type, "int") && !strcmp($3.type, "float"))
                                                                        $$.num = $1.num <= $3.floatNum;
                                                                    else if(!strcmp($1.type, "float") && !strcmp($3.type, "int"))
                                                                        $$.num = $1.floatNum <= $3.num;
                                                                    else if(!strcmp($1.type, "float") && !strcmp($3.type, "float"))
                                                                        $$.num = $1.floatNum <= $3.floatNum;
                                                                }

|   relational_expression REL_GREATEQUAL additive_expression    {
                                                                    strcpy($$.type, "int");
                                                                    if(!strcmp($1.type, "int") && !strcmp($3.type, "int"))
                                                                        $$.num = $1.num >= $3.num;
                                                                    else if(!strcmp($1.type, "int") && !strcmp($3.type, "float"))
                                                                        $$.num = $1.num >= $3.floatNum;
                                                                    else if(!strcmp($1.type, "float") && !strcmp($3.type, "int"))
                                                                        $$.num = $1.floatNum >= $3.num;
                                                                    else if(!strcmp($1.type, "float") && !strcmp($3.type, "float"))
                                                                        $$.num = $1.floatNum >= $3.floatNum;
                                                                }
;

equality_expression: 

    relational_expression                                   {
                                                                strcpy($$.type, $1.type);
                                                                if(!strcmp($1.type, "int"))
                                                                    $$.num = $1.num;
                                                                else if(!strcmp($1.type, "float"))
                                                                    $$.floatNum = $1.floatNum;
                                                            }

|   equality_expression LOG_COMPARE relational_expression   {
                                                                strcpy($$.type, "int");
                                                                if(!strcmp($1.type, "int") && !strcmp($3.type, "int"))
                                                                    $$.num = $1.num == $3.num;
                                                                else if(!strcmp($1.type, "int") && !strcmp($3.type, "float"))
                                                                    $$.num = $1.num == $3.floatNum;
                                                                else if(!strcmp($1.type, "float") && !strcmp($3.type, "int"))
                                                                    $$.num = $1.floatNum == $3.num;
                                                                else if(!strcmp($1.type, "float") && !strcmp($3.type, "float"))
                                                                    $$.num = $1.floatNum == $3.floatNum;
                                                            }   

|   equality_expression REL_NOTEQUAL relational_expression  {
                                                                strcpy($$.type, "int");
                                                                if(!strcmp($1.type, "int") && !strcmp($3.type, "int"))
                                                                    $$.num = $1.num != $3.num;
                                                                else if(!strcmp($1.type, "int") && !strcmp($3.type, "float"))
                                                                    $$.num = $1.num != $3.floatNum;
                                                                else if(!strcmp($1.type, "float") && !strcmp($3.type, "int"))
                                                                    $$.num = $1.floatNum != $3.num;
                                                                else if(!strcmp($1.type, "float") && !strcmp($3.type, "float"))
                                                                    $$.num = $1.floatNum != $3.floatNum;
                                                            }
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
                                                      logOperandsTypeError($1.type, $3.type, yylineno);
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
                                                      logOperandsTypeError($1.type, $3.type, yylineno);
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
                                                      logOperandsTypeError($1.type, $3.type, yylineno);
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
                                                    if(!strcmp($1.type, "int") && !strcmp($3.type, "int"))
                                                        $$.num = $1.num && $3.num;
                                                    else if(!strcmp($1.type, "int") && !strcmp($3.type, "float"))
                                                        $$.num = $1.num && $3.floatNum;
                                                    else if(!strcmp($1.type, "float") && !strcmp($3.type, "int"))
                                                        $$.num = $1.floatNum && $3.num;
                                                    else if(!strcmp($1.type, "float") && !strcmp($3.type, "float"))
                                                        $$.num = $1.floatNum && $3.floatNum;

                                                    
                                                }
;

log_or_expression: 

    log_and_expression                          {
                                                    strcpy($$.type, $1.type);
                                                    if(!strcmp($1.type, "int"))
                                                        $$.num = $1.num;
                                                    else if(!strcmp($1.type, "float"))
                                                        $$.floatNum = $1.floatNum;
                                                }

|   log_or_expression LOG_OR log_and_expression {
                                                    strcpy($$.type, "int");
                                                    if(!strcmp($1.type, "int") && !strcmp($3.type, "int"))
                                                        $$.num = $1.num || $3.num;
                                                    else if(!strcmp($1.type, "int") && !strcmp($3.type, "float"))
                                                        $$.num = $1.num || $3.floatNum;
                                                    else if(!strcmp($1.type, "float") && !strcmp($3.type, "int"))
                                                        $$.num = $1.floatNum || $3.num;
                                                    else if(!strcmp($1.type, "float") && !strcmp($3.type, "float"))
                                                        $$.num = $1.floatNum || $3.floatNum;

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
        if(!dontPrint) {
            printf("\nParsing complete\n");
            printTables();
        }
        else{
            printf("\nParsing error!\n");
        }
    }
        
    else
        printf("\nParsing error!\n");
}

































