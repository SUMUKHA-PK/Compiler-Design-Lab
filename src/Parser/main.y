%{
    #include<stdio.h>

    void yyerror(const char *s);

    extern char *yytext;
    extern int yylineno;
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

%token IDENTIFIER
%token NUM_INTEGER 
%token NUM_FLOAT
%token SEMICOLON

%left REL_LESSEQUAL REL_GREATEQUAL REL_EQUAL REL_NOTEQUAL REL_LESSTHAN REL_GREATERTHAN
%left AR_PLUS AR_MINUS AR_MUL AR_DIV AR_MOD BITWISE_XOR BITWISE_AND BITWISE_OR
%left LOG_AND LOG_OR LOG_COMPARE
%start ED

%%
ED: 
    SEMICOLON | expr ED | datatype_identifier ED | while ED |  if_elses ED | function_call ED | 
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
|   expr LOG_COMPARE LOG_COMPARE expr   {$$ = $1 == $4; printf("Line %d. Compare expression found\n", yylineno);}
|   expr REL_LESSTHAN expr       {$$ = $1 < $3; printf("Line %d. Less than\n expression found", yylineno);}
|   expr REL_LESSEQUAL expr   {$$ = $1 <= $3; printf("Line %d. Less than or equal expression found\n", yylineno);}
|   expr REL_EQUAL expr       {$$ = $1 = $3; printf("Line %d. Equal\n expression found", yylineno);}      
|   expr REL_GREATEQUAL expr   {$$ = $1 >= $3; printf("Line %d. Greater than or equal expression found\n", yylineno);}
|   expr REL_GREATERTHAN expr       {$$ = $1 > $3; printf("Line %d. Greater than expression found\n", yylineno);}
|   expr REL_NOTEQUAL expr   {$$ = $1 != $3; printf("Line %d. Not equal expression found\n", yylineno);}
|   NUM_INTEGER                 {printf("Line %d. Integer found\n", yylineno);}
|   NUM_FLOAT                   {printf("Line %d. Floating Number found\n", yylineno);}
|   IDENTIFIER                  {printf("Line %d. An Identifier found\n", yylineno);}
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
    ED
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

datatype_identifier: 

    datatype IDENTIFIER X 
;

X: 
    SEMICOLON                           {printf("Line %d. Found a variable declaration\n", yylineno);}
|   REL_EQUAL NUMBER  SEMICOLON         {printf("Line %d. Found a variable declaration and definition\n", yylineno);}
|   "," Y                            {printf("Line %d. Possibly found arguments for a function\n", yylineno);}               
|   L_PAREN X R_PAREN func  
|           
;

Y: 
    datatype_identifier 
|   IDENTIFIER 
|   X
;

func: 

    SEMICOLON                                           {printf("Line %d. Found a function declaration\n", yylineno);}
|   L_FLOWER_BRKT block R_FLOWER_BRKT                   {printf("Line %d. Found a function definition\n", yylineno);}
;

function_call: 

    IDENTIFIER L_PAREN Z R_PAREN SEMICOLON              {printf("Line %d. Found a function call\n", yylineno);}
;

Z: 
    IDENTIFIER
|   "," Z

%%

void yyerror(const char *s){
   printf("Error: %s at token %s in Line %d\n",s, yytext, yylineno );
}

int main()
{
    printf("Enter expression: \n\n");
    if(!yyparse())
        printf("\nParsing complete\n");
    else
        printf("\nParsing error madarchod!\n");
}
