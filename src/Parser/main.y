%{
    #include<stdio.h>

    void yyerror(const char *s);
	// extern int 


    extern char *yytext;
    extern int yylineno,sl_flag = -1, mul_comment_flag = 0, start_multi=0,invalid_mul_comment=0, left_flower_brkt=0, last_lfb=0,left_bracket=0,last_brack=0;	

    #define RED   "\x1B[31m"
    #define RESET "\x1B[0m"
    #define GREEN "\x1B[32m"
    #define BLUE  "\x1B[34m"

%}

%locations


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
%token VOID
%token BREAK
%token L_SQR_BRKT
%token R_SQR_BRKT
%token MUL_COMMENT_A
%token MUL_COMMENT_B
%token SL_COMMENT

%token IDENTIFIER
%token NUM_INTEGER 
%token NUM_FLOAT
%token SEMICOLON
%token COMMA   

%left REL_LESSEQUAL REL_GREATEQUAL REL_EQUAL REL_NOTEQUAL REL_LESSTHAN REL_GREATERTHAN
%left AR_PLUS AR_MINUS AR_MUL AR_DIV AR_MOD BITWISE_XOR BITWISE_AND BITWISE_OR
%left LOG_AND LOG_OR LOG_COMPARE
%start ED

%%
ED: 
    SEMICOLON_FOUND 
|   expr ED 
|   while ED 
|   if_elses ED 
|   var_func_dec_def ED 
|   fcall_vardef_arrayvalue ED
| 
;

SEMICOLON_FOUND: 
    SEMICOLON               {printf("Line %d. Semicolon found\n", yylineno);}
;

IDENTIFIER_FOUND: 
    IDENTIFIER              {printf("Line %d. Identifier found\n", yylineno);}
;


expr:
    expr AR_PLUS expr       {$$ = $1 + $3; printf("Line %d. Addition operator found!\n", yylineno);}
|   expr AR_MINUS expr       {$$ = $1 - $3; printf("Line %d. Minux operator found\n", yylineno);}
|   expr AR_MUL expr       {$$ = $1 * $3; printf("Line %d. Multiplication operator found\n", yylineno);}
|   expr AR_DIV expr       {$$ = $1 / $3; printf("Line %d. Division operator found\n", yylineno);}
|   expr AR_MOD expr       {$$ = $1 % $3; printf("Line %d. Modulo operator found\n", yylineno);}
|   expr AR_PLUS AR_PLUS      {$$ = $1++; printf("Line %d. Increment operator found\n", yylineno);}
|   expr BITWISE_XOR expr       {$$ = $1 ^ $3; printf("Line %d. Bitwise Xor expression found\n", yylineno);}
|   expr BITWISE_OR expr       {$$ = $1 | $3; printf("Line %d. Bitwise or expression found\n", yylineno);}
|   expr BITWISE_AND expr       {$$ = $1 & $3; printf("Line %d. Bitwise and expression found\n", yylineno);}
|   expr BITWISE_AND BITWISE_AND expr   {$$ = $1 && $4; printf("Line %d. Logical and expression found\n", yylineno);}
|   expr BITWISE_OR BITWISE_OR expr   {$$ = $1 || $4; printf("Line %d. Logical or expression found\n", yylineno);}
|   expr REL_EQUAL REL_EQUAL expr   {$$ = $1 == $4; printf("Line %d. Compare expression found\n", yylineno);}
|   expr REL_LESSTHAN expr       {$$ = $1 < $3; printf("Line %d. Less than\n expression found", yylineno);}
|   expr REL_LESSEQUAL expr   {$$ = $1 <= $3; printf("Line %d. Less than or equal expression found\n", yylineno);}
|   expr REL_EQUAL expr       {$$ = $1 = $3; printf("Line %d. Equal\n expression found", yylineno);}      
|   expr REL_GREATEQUAL expr   {$$ = $1 >= $3; printf("Line %d. Greater than or equal expression found\n", yylineno);}
|   expr REL_GREATERTHAN expr       {$$ = $1 > $3; printf("Line %d. Greater than expression found\n", yylineno);}
|   expr REL_NOTEQUAL expr   {$$ = $1 != $3; printf("Line %d. Not equal expression found\n", yylineno);}
|   NUMBER
|   IDENTIFIER_FOUND            
;

datatype: 

    FLOAT                 {printf("Line %d. Found float datatype\n", yylineno);}
|   DOUBLE                {printf("Line %d. Found double datatype\n", yylineno);}
|   CHAR                    {printf("Line %d. Found char datatype\n", yylineno);}
|   UNSIGNED CHAR                   {printf("Line %d. Found unsigned char datatype\n", yylineno);}
|   INT                 {printf("Line %d. Found int datatype\n", yylineno);}
|   UNSIGNED INT                    {printf("Line %d. Found unsigned int datatype\n", yylineno);}
|   SHORT INT                   {printf("Line %d. Found short int datatype\n", yylineno);}
|   SHORT UNSIGNED INT                  {printf("Line %d. Found short unsigned int datatype\n", yylineno);}
|   LONG INT                    {printf("Line %d. Found long int datatype\n", yylineno);}
|   LONG UNSIGNED INT                   {printf("Line %d. Found long unsigned int\n", yylineno);}
|   VOID                          {printf("Line %d. Found void\n", yylineno);}
;



NUMBER: 
    NUM_INTEGER                 {printf("Line %d. Found integer\n", yylineno);}
|   NUM_FLOAT                   {printf("Line %d. Found floating point number\n", yylineno);}

;

block: 
    ED Q                              {printf("Line %d. Found code block\n", yylineno);}
;

Q: 
    RETURN expr SEMICOLON_FOUND
|
;

else_if:
    IF L_PAREN expr R_PAREN L_FLOWER_BRKT R_FLOWER_BRKT elses
|   L_FLOWER_BRKT R_FLOWER_BRKT 
;

elses:
    ELSE else_if                    {printf("ELSES\n");}
| 
;


if_elses:
    IF L_PAREN expr R_PAREN L_FLOWER_BRKT R_FLOWER_BRKT  elses            {printf("if else\n");}
;


while: 
    WHILE L_PAREN expr R_PAREN L_FLOWER_BRKT block R_FLOWER_BRKT    {printf("Line %d. Found a while loop\n", yylineno);}
;

var_func_dec_def: 

    datatype X          {printf("In var_func. Line %d. Found datatype!\n", yylineno);}
;

X: 
    IDENTIFIER_FOUND Y        {printf("In X. Line %d. Found an identifier\n", yylineno);}
;

Y: 
    L_PAREN func        {printf("In Y. Taken the path of a function\n");}
|   REL_EQUAL expr Z    {printf("In Y. Taken the path of = expr Z\n");}
|   Z                   {printf("In Y. Taken the path of Z\n");}
|   L_SQR_BRKT array    
;

array: 
    expr R_SQR_BRKT Z
|   R_SQR_BRKT REL_EQUAL L_FLOWER_BRKT expr array3
;


array3: 
    COMMA expr array4
|   R_FLOWER_BRKT   Z
;

array4: 
    array3
;


Z: 
    COMMA IDENTIFIER_FOUND A  {printf("In Z. Taken the path of Comma Identifier A\n");}
|   SEMICOLON_FOUND     {printf("In Z. Stopped at ;\n");}
;

A: 
    REL_EQUAL expr Z    {printf("In A. Taken the path of = expr Z\n");}
|   L_SQR_BRKT array
|   Z                   {printf("In A. Taken the path of Z\n");}
;

func: 
    R_PAREN C
|   datatype IDENTIFIER_FOUND B
;

C: 
    SEMICOLON_FOUND 
|   L_FLOWER_BRKT block R_FLOWER_BRKT
;

B: 
    R_PAREN C
|   COMMA datatype IDENTIFIER_FOUND B
;  

fcall_vardef_arrayvalue: 

    IDENTIFIER_FOUND fcall_var_array          {printf("Line %d. Found a variable definition / function call / array value definition\n", yylineno);}
;

fcall_var_array: 

    function_call                               {printf("Line %d. Found a function call\n", yylineno);}                      
|   array_value_definition                      {printf("Line %d. Found an array integer definition\n", yylineno);}
|   variable_definition                         {printf("Line %d. Found a variable definition\n", yylineno);}
;

function_call: 

    L_PAREN arguments R_PAREN SEMICOLON_FOUND   {printf("Line %d. Done with function call production\n", yylineno);}            
;

array_value_definition: 

    L_SQR_BRKT expr R_SQR_BRKT REL_EQUAL expr SEMICOLON_FOUND       
;

variable_definition: 

    REL_EQUAL expr SEMICOLON_FOUND                  
;

arguments: 

    expr fcall1         
|                       // no arguments at all  {printf("No arguments at all\n");}
;

fcall1: 

    COMMA expr fcall2   // multiple arguments   {printf("Multiple arguments\n");}
|                                               {printf("One argument to that function\n");}
;

fcall2: 

    fcall1                                      {printf("Done with fcall2\n");}
;

%%

void yyerror(const char *s){
   printf("Error: %s at token %s in Line %d\n",s, yytext, yylineno );
}

int main()
{
	initTables();
    printf("Enter expression: \n\n");
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
