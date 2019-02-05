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
    SEMICOLON | expr SEMICOLON ED | var_dec SEMICOLON ED | var_def SEMICOLON ED | while | func_dec SEMICOLON ED |  if_elses ED |@ func_def |
;


expr:
    expr AR_PLUS expr       {$$ = $1 + $3; printf("Addition\n");}
|   expr AR_MINUS expr       {$$ = $1 - $3; printf("Subtraction\n");}
|   expr AR_MUL expr       {$$ = $1 * $3; printf("Multiplication\n");}
|   expr AR_DIV expr       {$$ = $1 / $3; printf("Division\n");}
|   expr AR_MOD expr       {$$ = $1 % $3; printf("Modulo\n");}
|   expr AR_PLUS AR_PLUS      {$$ = $1++; printf("Increment\n");}
|   expr BITWISE_XOR expr       {$$ = $1 ^ $3; printf("BITWISE_XOR\n");}
|   expr BITWISE_OR expr       {$$ = $1 | $3; printf("BITWISE_OR\n");}
|   expr BITWISE_AND expr       {$$ = $1 & $3; printf("BITWISE_AND\n");}
|   expr BITWISE_AND BITWISE_AND expr   {$$ = $1 && $4; printf("Logical LOG_AND\n");}
|   expr BITWISE_OR BITWISE_AND expr   {$$ = $1 || $4; printf("LOG_OR\n");}
|   expr LOG_COMPARE LOG_COMPARE expr   {$$ = $1 == $4; printf("LOG_COMPARE\n");}
|   expr REL_LESSTHAN expr       {$$ = $1 < $3; printf("REL_LESSTHAN\n");}
|   expr REL_LESSEQUAL expr   {$$ = $1 <= $3; printf("REL_LESSEQUAL\n");}
|   expr REL_EQUAL expr       {$$ = $1 = $3; printf("REL_EQUAL\n");}      
|   expr REL_GREATEQUAL expr   {$$ = $1 >= $3; printf("REL_GREATEQUAL\n");}
|   expr REL_GREATERTHAN expr       {$$ = $1 > $3; printf("REL_GREATERTHAN\n");}
|   expr REL_NOTEQUAL expr   {$$ = $1 != $3; printf("REL_NOTEQUAL\n");}
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
|   "void"                          {printf("Found void");}
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

block: 
    ED
;

else_if:
    IF L_PAREN expr R_PAREN L_FLOWER_BRKT block R_FLOWER_BRKT else_if           {printf("ELSEIF\n");}
|   elses 
|   L_FLOWER_BRKT block R_FLOWER_BRKT
;

elses:
    ELSE else_if                    {printf("ELSES\n");}
| 
;


if_elses:
    IF L_PAREN expr R_PAREN L_FLOWER_BRKT block R_FLOWER_BRKT  elses            {printf("if else\n");}
;

while: 
    WHILE L_PAREN expr R_PAREN L_FLOWER_BRKT block R_FLOWER_BRKT    {printf("While found!\n");}
;

// Functions

arg: 
    datatype IDENTIFIER                            {printf("ARG found!\n");}
|   arg ','

;

func_dec: 
    datatype IDENTIFIER L_PAREN arg R_PAREN              {printf("func dec found!");}
;

func_def: 
    func_dec L_FLOWER_BRKT block R_FLOWER_BRKT             {printf("func def found\n");}
;

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
