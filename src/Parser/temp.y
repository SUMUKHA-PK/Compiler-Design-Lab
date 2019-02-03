expr: 

    NUM_INTEGER
|   NUM_FLOAT
|       IDENTIFIER
|   expr '+' expr       {$$ = $1 + $3}
|   expr '-' expr       {$$ = $1 - $3}
|   expr '*' expr       {$$ = $1 * $3}
|   expr '/' expr       {$$ = $1 / $3}
|   expr '%' expr       {$$ = $1 % $3}
|   expr '+' '+'      {$$ = $1++}
|   expr '^' expr       {$$ = $1 ^ $3}
|   expr '|' expr       {$$ = $1 | $3}
|   expr '&' expr       {$$ = $1 & $3}
|   expr '&' '&' expr   {$$ = $1 && $4}
|   expr '|' '|' expr   {$$ = $1 || $4}
|   expr '=' '=' expr   {$$ = $1 == $4}
|   expr '<' expr       {$$ = $1 < $3}
|   expr '<' '=' expr   {$$ = $1 <= $4}
|   expr '=' expr       {$$ = $1 = $3}      
|   expr '>' '=' expr   {$$ = $1 >= $4}
|   expr '>' expr       {$$ = $1 > $3}
|   expr '!' '=' expr   {$$ = $1 != $4}



datatype: 

    FLOAT
|   DOUBLE
|   CHAR
|   UNSIGNED CHAR
|   INT
|   UNSIGNED INT 
|   SHORT INT
|   SHORT UNSIGNED INT
|   LONG INT
|   LONG UNSIGNED INT  
|   "void"            

var_dec: 

    datatype IDENTIFIER    ;


var_def: 

    var_dec '=' NUM_FLOAT        
|   var_dec '=' NUM_INTEGER   
|   IDENTIFIER '=' NUM_FLOAT              
|   IDENTIFIER '=' NUM_INTEGER       
|   ; 


statement: 
	 "blah!"

block: 
    
    L_FLOWER_BRKT R_FLOWER_BRKT
|   L_FLOWER_BRKT block R_FLOWER_BRKT
|   L_FLOWER_BRKT statement R_FLOWER_BRKT


// conditional statements

if: 

    IF L_PAREN expr R_PAREN L_FLOWER_BRKT block R_FLOWER_BRKT

else: 

    ELSE L_FLOWER_BRKT block R_FLOWER_BRKT

else_if: 

    ELSE IF L_FLOWER_BRKT expr R_FLOWER_BRKT L_FLOWER_BRKT block R_FLOWER_BRKT
|   else_if

// We actually need these: 

if_else: 

    if else

if_else_if: 

    if else_if else


// Looping - only while. 

while: 

    WHILE L_PAREN expr R_PAREN L_FLOWER_BRKT block R_FLOWER_BRKT


// Functions

arg: 

    datatype IDENTIFIER 
|   arg ','

func_dec: 

    datatype IDENTIFIER L_PAREN arg R_PAREN     ; 

func_def: 

    func_dec block
%%

void yyerror(){
    printf("Invalid Expression\n");
}

int main()
{
    printf("Enter expression: ");
    if(!yyparse())
        printf("\nParsing complete\n");
    else
        printf("\nParsing failed\n");

}

#########################################################

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


block: 
    
    L_FLOWER_BRKT R_FLOWER_BRKT
|   L_FLOWER_BRKT block R_FLOWER_BRKT
|   L_FLOWER_BRKT "blah!" R_FLOWER_BRKT

if: 

    IF L_PAREN expr R_PAREN L_FLOWER_BRKT block R_FLOWER_BRKT

