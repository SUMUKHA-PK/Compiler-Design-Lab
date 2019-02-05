%{
    #include<stdio.h>

    void yyerror(const char *s);

    extern char *yytext;
    extern int lineNo;
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
%token SEMICOLON

%left REL_LESSEQUAL REL_GREATEQUAL REL_EQUAL REL_NOTEQUAL REL_LESSTHAN REL_GREATERTHAN
%left AR_PLUS AR_MINUS AR_MUL AR_DIV AR_MOD BITWISE_XOR BITWISE_AND BITWISE_OR
%left LOG_AND LOG_OR LOG_COMPARE
%start ED

%%
ED: 
    SEMICOLON | expr SEMICOLON ED | var_dec SEMICOLON ED | var_def SEMICOLON ED | //| while | func_dec | func_def | if_elses 
;


expr:
    expr AR_PLUS expr       {$$ = $1 + $3; printf("Addition");}
|   expr AR_MINUS expr       {$$ = $1 - $3; printf("Subtraction");}
|   expr AR_MUL expr       {$$ = $1 * $3; printf("Multiplication");}
|   expr AR_DIV expr       {$$ = $1 / $3; printf("Division");}
|   expr AR_MOD expr       {$$ = $1 % $3; printf("Modulo");}
|   expr AR_PLUS AR_PLUS      {$$ = $1++; printf("Increment");}
|   expr BITWISE_XOR expr       {$$ = $1 ^ $3; printf("BITWISE_XOR");}
|   expr BITWISE_OR expr       {$$ = $1 | $3; printf("BITWISE_OR");}
|   expr BITWISE_AND expr       {$$ = $1 & $3; printf("BITWISE_AND");}
|   expr BITWISE_AND BITWISE_AND expr   {$$ = $1 && $4; printf("Logical LOG_AND");}
|   expr BITWISE_OR BITWISE_AND expr   {$$ = $1 || $4; printf("LOG_OR");}
|   expr LOG_COMPARE LOG_COMPARE expr   {$$ = $1 == $4; printf("LOG_COMPARE");}
|   expr REL_LESSTHAN expr       {$$ = $1 < $3; printf("REL_LESSTHAN");}
|   expr REL_LESSEQUAL expr   {$$ = $1 <= $3; printf("REL_LESSEQUAL");}
|   expr REL_EQUAL expr       {$$ = $1 = $3; printf("REL_EQUAL");}      
|   expr REL_GREATEQUAL expr   {$$ = $1 >= $3; printf("REL_GREATEQUAL");}
|   expr REL_GREATERTHAN expr       {$$ = $1 > $3; printf("REL_GREATERTHAN");}
|   expr REL_NOTEQUAL expr   {$$ = $1 != $3; printf("REL_NOTEQUAL");}
|   NUM_INTEGER 
|   NUM_FLOAT
|   IDENTIFIER 
;

datatype: 

    FLOAT                 {printf("Found float\n");}
|   DOUBLE                {printf("Found double\n");}
|   CHAR                    {printf("Found Char\n");}
|   UNSIGNED CHAR                   {printf("Found uc\n");}
|   INT                 {printf("Found int\n");}
|   UNSIGNED INT                    {printf("Found USI\n");}
|   SHORT INT                   {printf("Found SI\n");}
|   SHORT UNSIGNED INT                  {printf("Found SUI\n");}
|   LONG INT                    {printf("Found LI\n");}
|   LONG UNSIGNED INT                   {printf("Found LLI\n");}
|   "void" 
;

var_dec: 

    datatype IDENTIFIER         {printf("Found declaration \n");}

;

NUMBER: 
    NUM_INTEGER                 {printf("Found i number\n");}
|   NUM_FLOAT                   {printf("Found f number\n");}

;

var_def: 

    var_dec REL_EQUAL NUMBER           {printf("Found vardef vardec\n");}
|   IDENTIFIER REL_EQUAL NUMBER                  {printf("Found vardef \n");}

; 

// block: 
    
//     L_FLOWER_BRKT R_FLOWER_BRKT
// |   L_FLOWER_BRKT block R_FLOWER_BRKT
// |   L_FLOWER_BRKT "blah!" R_FLOWER_BRKT

// ;

// else_if:
//     ELSE L_FLOWER_BRKT block R_FLOWER_BRKT IF L_PAREN expr R_PAREN L_FLOWER_BRKT block R_FLOWER_BRKT | else_if           {printf("R");}
// ;

// if_elses:
//     IF L_PAREN expr R_PAREN L_FLOWER_BRKT block R_FLOWER_BRKT else_if ELSE L_FLOWER_BRKT block R_FLOWER_BRKT 
// |   IF L_PAREN expr R_PAREN L_FLOWER_BRKT block R_FLOWER_BRKT else_if 
// |   IF L_PAREN expr R_PAREN L_FLOWER_BRKT block R_FLOWER_BRKT
// ;
// ;

while: 
    WHILE L_PAREN expr R_PAREN L_FLOWER_BRKT block R_FLOWER_BRKT
;

// Functions

// arg: 
//     datatype IDENTIFIER 
// |   arg ','

// ;

// func_dec: 
//     datatype IDENTIFIER L_PAREN arg R_PAREN ; 
// ;

// func_def: 
//     func_dec block
// ;

%%

void yyerror(const char *s){
   printf("%s %s\n",s, yytext );
}

int main()
{
    printf("Enter expression: ");
    if(!yyparse())
        printf("\nParsing complete\n");
    else
        printf("\nParsing failed\n");

}
