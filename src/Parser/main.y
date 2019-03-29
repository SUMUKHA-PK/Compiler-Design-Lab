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

    int sl_flag = -1, mul_comment_flag = 0, start_multi = 0, invalid_mul_comment = 0,dontPrint=0,ifIf=0,ifIfDec=0;

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
    int backPatchStack[100];
    int backPatchStackTop=-1;
    char threeAddrLabelStack[100][100];
    int threeAddrLabelStackTop=-1;

    FILE * threeAddressFile = NULL;
    char threeAddrCode[1000][1000];
    int threeAddrCodeLineNo = 0;
    char code[1000];
    int tempVarCount=0;
    int labelCount=0;

    void addthreeAddrCode(char * str){
        strcpy(threeAddrCode[threeAddrCodeLineNo],str);
        threeAddrCodeLineNo++;
    }

    char * newTempVar(){
        char * buf = (char*)malloc(10);
        sprintf(buf,"T_%d",tempVarCount);
        tempVarCount++;
        return buf;
    }

    char * newLabel(){
        char * buf = (char*)malloc(15);
        sprintf(buf,"Label_%d",labelCount);
        labelCount++;
        return buf;
    }

    char* curLabel(){
        char * buf = (char*)malloc(15);
        sprintf(buf,"Label_%d",labelCount);
        return buf;
    }
    
    void pushBackthreeAddrLabelStack(char * str){
        strcpy(threeAddrLabelStack[++threeAddrLabelStackTop],str);
    }

    void popthreeAddrLabelStack(){
        --threeAddrLabelStackTop;
    }

    void pushBackPatchStack(int n){
        backPatchStack[++backPatchStackTop] = n ;
    }

    int popBackPatchStack(){
        int var = backPatchStack[backPatchStackTop];
        backPatchStackTop--;
        return var;
    }
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
                                                                                    sprintf(code,"func end\n"); addthreeAddrCode(code);
                                                                                  }
 |   declaration_specifiers direct_declarator compound_statement                  { if(returnType[0]=='\0') strcpy(returnType,"void");
                                                                                        if(strcmp($1.type,returnType)){
                                                                                        returnTypeMisMatchError($1.type,$1.val,returnType, yylineno);
                                                                                    }
                                                                                    sprintf(code,"func end\n"); addthreeAddrCode(code);
                                                                                  }
|   direct_declarator declaration_list compound_statement
;

declaration:

    declaration_specifiers ';'
|   declaration_specifiers init_declaration_list ';'   {ifIfDec=0;}
;

declaration_specifiers: 

    VOID            {strcpy(Type, $1.type); strcpy($$.type, $1.type);}        
|   INT             {ifIfDec=1;strcpy(Type, $1.type); strcpy($$.type, $1.type);}                                           
|   CHAR            {ifIfDec=1;strcpy(Type, $1.type); strcpy($$.type, $1.type);}
|   FLOAT           {ifIfDec=1;strcpy(Type, $1.type); strcpy($$.type, $1.type);}                   
|   DOUBLE          {ifIfDec=1;strcpy(Type, $1.type); strcpy($$.type, $1.type);}
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
|   direct_declarator '[' log_or_expression ']'
|   direct_declarator '[' ']'
|   direct_declarator '('                       {
                                                    if(decORdef==1){
                                                        incrementTableScope();
                                                        sprintf(code,"\nfunction begin %s:\n",$1.val);addthreeAddrCode(code);
                                                    }
                                                }
    parameter_list ')'     
                                                {   if(decORdef==0){
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
                                                        decORdef = 0;
                                                    }
                                                }
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

    parameter_declaration                       {  if(decORdef==0) {
                                                        strcpy(argTypes[numArgs1],$1.type); 
                                                        strcpy(argValues[numArgs1],$1.val); 
                                                        numArgs1++;
                                                    }
                                                    else{
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
                                                        if(strcmp(argTypes[numArgs2],$3.type)){
                                                            argumentTypeMismatchError(argTypes[numArgs2],$3.type,yylineno);        
                                                        }
                                                        numArgs2++;
                                                    }
                                                }       
;

parameter_declaration: 

    declaration_specifiers direct_declarator        {strcpy($1.type, Type); strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
|   declaration_specifiers
;

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
                                                            else{
                                                                sprintf(code,"%s = %s\n",$1.val,$3.val);addthreeAddrCode(code);
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

    IF                                              {   ifIf=1;
                                                        incrementTableScope();
                                                    }

    '(' expression ')'                              {
                                                        pushBackPatchStack(threeAddrCodeLineNo);
                                                        sprintf(code,"IF (%s) GOTO %s\nGOTO ",$4.val,curLabel());
                                                        addthreeAddrCode(code);
                                                        sprintf(code,"\n%s : \n",newLabel());
                                                        addthreeAddrCode(code);
                                                    }

    statement                                       {
                                                        int prevTop = popBackPatchStack();
                                                        pushBackPatchStack(threeAddrCodeLineNo);
                                                        pushBackPatchStack(prevTop);
                                                        sprintf(code,"GOTO ");
                                                        addthreeAddrCode(code);
                                                        
                                                        char * nextlabel = newLabel();
                                                        sprintf(code,"\n%s: \n",nextlabel);
                                                        addthreeAddrCode(code);

                                                        char tempCode[100];
                                                        sprintf(tempCode,"%s\n",nextlabel);
                                                        int d = popBackPatchStack();
                                                        strcat(threeAddrCode[d],tempCode);printf("@");
                                                        printf("%s\n",threeAddrCode[d]);
                                                    }
    else_statement 
;

else_statement:
    ELSE 
                                                    {
                                                        ifIf=1;
                                                        incrementTableScope();
                                                    }
    statement                                       {
                                                        char * nextlabel = newLabel();
                                                        sprintf(code,"\n%s: \n",nextlabel);
                                                        addthreeAddrCode(code);

                                                        char tempCode[100];
                                                        sprintf(tempCode,"%s\n",nextlabel);
                                                        strcat(threeAddrCode[popBackPatchStack()],tempCode);
                                                    }
|
;

while_statement: 

    WHILE                                       {
                                                    pushBackthreeAddrLabelStack(curLabel());
                                                    sprintf(code,"\n%s :\n",newLabel());addthreeAddrCode(code);
                                                    ifIf=1;
                                                    incrementTableScope();
                                                }
    '(' expression ')'                          {
                                                    pushBackPatchStack(threeAddrCodeLineNo);
                                                    sprintf(code,"IF (%s) GOTO %s\nGOTO ",$4.val,curLabel());
                                                    addthreeAddrCode(code);
                                                    sprintf(code,"\n%s\n",newLabel()); 
                                                    addthreeAddrCode(code); 
                                                }
    statement                                   {
                                                    sprintf(code,"GOTO %s\n",threeAddrLabelStack[threeAddrLabelStackTop]);
                                                    addthreeAddrCode(code);
                                                    popthreeAddrLabelStack();

                                                    char *nextlabel = newLabel();
                                                    sprintf(code,"\n%s: \n",nextlabel);
                                                    addthreeAddrCode(code);

                                                    char tempCode[100];
                                                    sprintf(tempCode,"%s\n",nextlabel);
                                                    strcat(threeAddrCode[popBackPatchStack()],tempCode);
                                                }
;

jump_statement: 

    return  ';'
|   BREAK ';'
|   CONTINUE ';'
;

return: 
    RETURN                                          {sprintf(code,"return \n");addthreeAddrCode(code);} 
|   RETURN expression                               {
                                                        strcpy(returnType,$2.type);
                                                        sprintf(code,"return %s\n",$2.val);addthreeAddrCode(code);
                                                    }
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
    assignment_expression                              {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
|   argument_list ',' assignment_expression            {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
;

assignment_expression: 

    log_or_expression                               {strcpy($$.type, $1.type); strcpy($$.val, $1.val);}
|   unary_expression '=' log_or_expression          {  strcpy($$.type, $1.type); strcpy($$.val, $1.val);
                                                        char typeStr[100];    
                                                        if(findInHashTable($1.val,typeStr)){
                                                            strcpy($1.type,typeStr);
                                                            if(strcmp($1.type,$3.type)){
                                                                typeMismatchError($1.type,$3.type,yylineno);
                                                            }
                                                            else{
                                                                sprintf(code,"%s = %s\n",$1.val,$3.val);addthreeAddrCode(code);
                                                            }
                                                        }
                                                        else{
                                                            variableNotDeclaredError($3.type,$3.val,yylineno);
                                                        }
                                                    }
;

unary_expression: 

    array_funccall                          {   
                                                strcpy($$.val, $1.val); 
                                                strcpy($$.type, $1.type); 
                                                if(!strcmp($1.type, "int"))
                                                    $$.num = $1.num;
                                                else if(!strcmp($1.type, "float"))
                                                    $$.floatNum = $1.floatNum;
                                            }    
;

primary_expression: 

    IDENTIFIER              {strcpy($1.type, Type); strcpy($$.type, $1.type); strcpy($$.val, $1.val);}    


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

multiplicative_expression:

    unary_expression                                        {
                                                                strcpy($$.type, $1.type);
                                                                strcpy($$.val,$1.val);
                                                                if(!strcmp($1.type, "int"))
                                                                    $$.num = $1.num;
                                                                else if(!strcmp($1.type, "float"))
                                                                    $$.floatNum, $1.floatNum;
                                                            }
|   multiplicative_expression '*' unary_expression          {   if(!strcmp($1.type, "string_literal") || !strcmp($3.type, "string_literal"))
                                                                    divOperandsTypeError($1.type, $3.type, yylineno) ;

                                                                strcpy($$.type, "int");
                                                                strcpy($$.val,newTempVar());
                                                                sprintf(code,"%s = (%s * %s)\n",$$.val,$1.val,$3.val);
                                                                addthreeAddrCode(code);
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
                                                                if(!strcmp($1.type, "string_literal") || !strcmp($3.type, "string_literal"))
                                                                    divOperandsTypeError($1.type, $3.type, yylineno) ;

                                                                strcpy($$.type, "int");
                                                                strcpy($$.val,newTempVar());
                                                                sprintf(code,"%s = (%s / %s)\n",$$.val,$1.val,$3.val);
                                                                addthreeAddrCode(code);

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
                                                                strcpy($$.type, "int");
                                                                strcpy($$.val,newTempVar());
                                                                sprintf(code,"%s = (%s % %s)\n",$$.val,$1.val,$3.val);
                                                                addthreeAddrCode(code);
                                                                
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

    multiplicative_expression                               {   
                                                                strcpy($$.type, $1.type);
                                                                strcpy($$.val,$1.val);
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
                                                                
                                                                strcpy($$.type, "int");
                                                                strcpy($$.val,newTempVar());
                                                                sprintf(code,"%s = %s + %s\n",$$.val,$1.val,$3.val);
                                                                addthreeAddrCode(code);
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
                                                                
                                                                strcpy($$.type, "int");
                                                                strcpy($$.val,newTempVar());
                                                                sprintf(code,"%s = %s - %s\n",$$.val,$1.val,$3.val);
                                                                addthreeAddrCode(code);
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
                                                                    strcpy($$.val,$1.val);
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
                                                                    strcpy($$.val,newTempVar());
                                                                    sprintf(code,"%s = (%s < %s)\n",$$.val,$1.val,$3.val);
                                                                    addthreeAddrCode(code);
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
                                                                    strcpy($$.val,newTempVar());
                                                                    sprintf(code,"%s = (%s > %s)\n",$$.val,$1.val,$3.val);
                                                                    addthreeAddrCode(code);
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
                                                                    strcpy($$.val,newTempVar());
                                                                    sprintf(code,"%s = (%s <= %s)\n",$$.val,$1.val,$3.val);
                                                                    addthreeAddrCode(code);
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
                                                                    strcpy($$.val,newTempVar());
                                                                    sprintf(code,"%s = (%s >= %s)\n",$$.val,$1.val,$3.val);
                                                                    addthreeAddrCode(code);
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
                                                                strcpy($$.val,$1.val);
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
                                                                strcpy($$.val,newTempVar());
                                                                sprintf(code,"%s = (%s == %s)\n",$$.val,$1.val,$3.val);
                                                                addthreeAddrCode(code);
                                                                if(!strcmp($1.type, "int")) {
                                                                    if(!strcmp($3.type, "int")) 
                                                                        {
                                                                            $$.num = $1.num == $3.num;
                                                                        }
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
                                                                strcpy($$.val,newTempVar());
                                                                sprintf(code,"%s = (%s != %s)\n",$$.val,$1.val,$3.val);
                                                                addthreeAddrCode(code);
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

    equality_expression                         {   
                                                    strcpy($$.type, $1.type);
                                                    strcpy($$.val,$1.val);
                                                    if(!strcmp($1.type, "int"))
                                                        $$.num = $1.num;
                                                    else if(!strcmp($1.type, "float"))
                                                        $$.floatNum = $1.floatNum;
                                                    else if(!strcmp($1.type, "char"))
                                                        $$.charlit = $1.charlit;
                                                    else if(!strcmp($1.type, "string_literal"))
                                                        exprInvalidError($1.type, yylineno);
                                                }

|   and_expression '&' equality_expression      {   
                                                    strcpy($$.val, $1.val);
                                                    strcpy($$.val,newTempVar());
                                                    sprintf(code,"%s = %s & %s\n",$$.val,$1.val,$3.val);
                                                    addthreeAddrCode(code);
                                                    if((!strcmp($1.type, "int") && !strcmp($3.type, "int"))){
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

    and_expression                              {   
                                                    strcpy($$.type, $1.type);
                                                    strcpy($$.val, $1.val);
                                                    if(!strcmp($1.type, "int"))
                                                        $$.num = $1.num;
                                                    else if(!strcmp($1.type, "float"))
                                                        $$.floatNum = $1.floatNum;
                                                    else if(!strcmp($1.type, "char"))
                                                        $$.charlit = $1.charlit;   
                                                    else if(!strcmp($1.type, "string_literal"))
                                                        exprInvalidError($1.type, yylineno);                                          
                                                }

|   xor_expression '^' and_expression           {   
                                                    strcpy($$.type, "int");
                                                    strcpy($$.val,newTempVar());
                                                    sprintf(code,"%s = %s ^ %s\n",$$.val,$1.val,$3.val);
                                                    addthreeAddrCode(code);
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

or_expression:

    xor_expression                              {
                                                    strcpy($$.type, $1.type);
                                                    strcpy($$.val,$1.val);
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
                                                    strcpy($$.type, "int");
                                                    strcpy($$.val,newTempVar());
                                                    sprintf(code,"%s = %s | %s\n",$$.val,$1.val,$3.val);
                                                    addthreeAddrCode(code);
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

    or_expression                               {
                                                    strcpy($$.type, $1.type);
                                                    strcpy($$.val,$1.val);
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
                                                    strcpy($$.val,newTempVar());
                                                    sprintf(code,"%s = %s && %s\n",$$.val,$1.val,$3.val);
                                                    addthreeAddrCode(code);
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
                                                    strcpy($$.val,$1.val);
                                                    if(!strcmp($1.type, "int"))
                                                        $$.num = $1.num;
                                                    else if(!strcmp($1.type, "float"))
                                                        $$.floatNum = $1.floatNum;
                                                    else if(!strcmp($1.type, "char"))
                                                        $$.charlit = $1.charlit; 
                                                    else if(!strcmp($1.type, "string_literal"))
                                                        exprInvalidError($1.type, yylineno);
                                                }

|   log_or_expression LOG_OR log_and_expression     {
                                                        if(!strcmp($1.type, "string_literal") || !strcmp($3.type, "string_literal"))
                                                        logOperandsTypeError($1.type, $3.type, yylineno);
                                                        strcpy($$.type, "int");
                                                        strcpy($$.val,newTempVar());
                                                        sprintf(code,"%s = %s || %s\n",$$.val,$1.val,$3.val);
                                                        addthreeAddrCode(code);
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

void writeTACToFile(){
    threeAddressFile = fopen("threeAddressCode.txt","w");
    for(int i=0;i<threeAddrCodeLineNo;i++){
                fprintf(threeAddressFile, "%s", threeAddrCode[i]);
        }
    fclose(threeAddressFile);
}

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
            writeTACToFile();
        }
        else{
            printf("\nParsing error!\n");
        }
    }
        
    else
        printf("\nParsing error!\n");
}

































