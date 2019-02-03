id: 

IDENTIFIER_D


expr: 

    NUM_INTEGER_D
|   NUM_FLOAT_D
|   id
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
|   expr '|' '|' expr   {$$ = $1 || $4|}
|   expr '=' '=' expr   {$$ = $1 == $4}
|   expr '<' expr       {$$ = $1 < $3}
|   expr '<' '=' expr   {$$ = $1 <= $4}
|   expr '=' expr       {$$ = $1 = $3}      // an error: if $1 is a INTEGER or FLOATINGPOINT
|   expr '>' '=' expr   {$$ = $1 >= $4}
|   expr '>' expr       {$$ = $1 > $3}
|   expr '!' '=' expr   {$$ = $1 != $4}


datatype: 

    FLOAT_D
|   DOUBLE_D
|   CHAR_D
|   UNSIGNED_D CHAR_D
|   INT_D
|   UNSIGNED_D INT_D 
|   SHORT_D INT_D
|   SHORT_D UNSIGNED_D INT_D
|   LONG_D INT_D
|   LONG_D UNSIGNED_D INT_D  
|   "void"                      // This is something we have to add.   


var_dec: 

    datatype id     ;


var_def: 

    var_dec '=' NUM_FLOAT_D        ;
|   var_dec '=' NUM_INTEGER_D   ;
|   id '=' NUM_FLOAT_D              ;
|   id '=' NUM_INTEGER_D        ;


array_dec: 

    datatype id '[' id ']'      ;
|   datatype id '[' NUM_INTEGER_D ']' ;

// Not able to think how to write rules for array_def

// Before getting to conditional statements, looping etc., I will define how a block of code should look like. 

S: 
    pretty much anything ending with a ;    - just not able to write the rules for it. 


block: 
    
    '{' '}'
|   '{' block '}'
|   '{' S '}'


// conditional statements

if: 

    IF_D '(' expr ')' '{' block '}'

else: 

    ELSE_D '{' block '}'

else_if: 

    ELSE_D IF_D '(' expr ')' '{' block '}'
|   else_if

// We actually need these: 

if_else: 

    if else

if_else_if: 

    if else_if else


// Looping - only while. 

while: 

    WHILE_D '(' expr ')' '{' block '}'


// Functions

arg: 

    datatype id 
|   arg ','

func_dec: 

    datatype id '(' arg ;)'     ; 

func_def: 

    func_dec block





