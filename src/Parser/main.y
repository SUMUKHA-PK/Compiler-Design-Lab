%{
    #include<stdio.h>

    void yyerror(const char *s);

   

    extern char *yytext;
    extern int yylineno;

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
    RETURN expr
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
;


Z: 
    COMMA IDENTIFIER_FOUND A  {printf("In Z. Taken the path of Comma Identifier A\n");}
|   SEMICOLON_FOUND     {printf("In Z. Stopped at ;\n");}
;

A: 
    REL_EQUAL expr Z    {printf("In A. Taken the path of = expr Z\n");}
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

int mul_comment_flag = 0, start_multi=0,invalid_mul_comment=0, left_flower_brkt=0, last_lfb=0,left_bracket=0,last_brack=0;

    initTables();

    int getNextToken = yylex();

    while(getNextToken) {
		if(getNextToken == CHAR) {
			printf("KEYWORD : %s\n\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "CHARACTER", yylineno, 0);
		}
		else if(getNextToken == INT){
			printf("KEYWORD : %s\n\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "INTEGER", yylineno, 0);
		}
		else if(getNextToken == FLOAT){
			printf("KEYWORD : %s\n\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "FLOAT", yylineno, 0);
		}
		else if(getNextToken==DOUBLE){
			printf("KEYWORD : %s\n\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "DOUBLE", yylineno, 0);
		}
		else if(getNextToken == SHORT){
			printf("KEYWORD : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "SHORT", yylineno, 0);
		}
		else if(getNextToken == UNSIGNED){
			printf("KEYWORD : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "UNSIGNED", yylineno, 0);
		}
		else if(getNextToken == LONG){
			printf("KEYWORD : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "LONG", yylineno, 0);
		}
		else if(getNextToken == SL_COMMENT){
			printf("SINGLE LINE COMMENT at line %d\n",yylineno);
		}
		// else if(getNextToken == PRE_PROC){
		// 	printf("PRE PROCESSOR DIRECTIVES: %s at line %d\n",yytext,yylineno);
		// }
		else if(getNextToken == RETURN){
			printf("RETURN CALLED at %d\n",yylineno);
			insertsymbolToken(yytext, "RETURN", yylineno, 0);
		}
		else if(getNextToken == IF){
			printf("Found %s at line %d\n\n",yytext,yylineno);
			insertsymbolToken(yytext, "IF", yylineno, 0);
		}
		else if(getNextToken == ELSE){
			printf("Found %s at line %d\n\n",yytext,yylineno);
			insertsymbolToken(yytext, "ELSE", yylineno, 0);
		}
		else if(getNextToken == WHILE){
			printf("Found %s at line %d\n\n",yytext,yylineno);
			insertsymbolToken(yytext, "WHILE", yylineno, 0);
		}
		else if(getNextToken == L_FLOWER_BRKT){
			left_flower_brkt ++;
			printf("Found %s \n",yytext);
			insertsymbolToken(yytext, "L F BRACKET", yylineno, 0);	
		}
		else if(getNextToken == R_FLOWER_BRKT){
			left_flower_brkt--;
			last_lfb = yylineno;
			printf("Found %s \n",yytext);	
			insertsymbolToken(yytext, "R F BRACKET", yylineno, 0);
		}
		else if(getNextToken == L_PAREN){
			left_bracket++;
			printf("Found : %s \n ",yytext);
			insertsymbolToken(yytext, "L BRACKET", yylineno, 0);
		}
		else if(getNextToken == R_PAREN){
			left_bracket--;
			last_brack = yylineno;
			printf("Found : %s \n ",yytext);
			insertsymbolToken(yytext, "R BRACKET", yylineno, 0);
		}
		else if(getNextToken == SEMICOLON){
			printf("SEMICOLON at line %d\n",yylineno);
			insertsymbolToken(yytext, "SEMICOLON", yylineno, 0);
		}
		else if(getNextToken==AR_PLUS){
			printf("ARITHEMATIC OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "AR_PLUS", yylineno, 0);
		}
		else if(getNextToken == AR_MINUS){
			printf("ARITHEMATIC OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "AR_MINUS", yylineno, 0);
		}
		else if(getNextToken == AR_MUL){
			printf("ARITHEMATIC OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "AR_MUL", yylineno, 0);
		}
		else if(getNextToken == AR_DIV){
			printf("ARITHEMATIC OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "AR_DIV", yylineno, 0);
		}
		else if(getNextToken == AR_MOD){
			printf("ARITHEMATIC OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "AR_MOD", yylineno, 0);
		}
		else if(getNextToken == REL_LESSTHAN){
			printf("RELATIONAL OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "REL_LESSTHAN", yylineno, 0);
		}
		else if(getNextToken == REL_LESSEQUAL){
			printf("RELATIONAL OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "REL_LESSEQUAL", yylineno, 0);
		}
		else if(getNextToken == REL_EQUAL){
			printf("RELATIONAL OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "REL_EQUAL", yylineno, 0);
		}
		else if(getNextToken == REL_GREATERTHAN){
			printf("RELATIONAL OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "REL_GREATERTHAN", yylineno, 0);
		}
		else if(getNextToken == REL_GREATEQUAL){
			printf("RELATIONAL OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "REL_GREATEQUAL", yylineno, 0);
		}
		else if(getNextToken == REL_NOTEQUAL){
			printf("RELATIONAL OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "REL_NOTEQUAL", yylineno, 0);
		}
		else if(getNextToken == LOG_AND){
			printf("LOGICAL OPERATOR: %s\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "LOG_AND", yylineno, 0);
		}
		else if(getNextToken == LOG_OR){
			printf("LOGICAL OPERATOR: %s\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "LOG_OR", yylineno, 0);
		}
		else if(getNextToken == LOG_COMPARE){
			printf("LOGICAL OPERATOR: %s\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "LOG_COMPARE", yylineno, 0);
		}
		else if(getNextToken == BITWISE_AND){
			printf("BITWISE OPERATOR: %s\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "BITWISE_AND", yylineno, 0);
		}	
		else if(getNextToken == BITWISE_OR){
			printf("BITWISE OPERATOR: %s\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "BITWISE_OR", yylineno, 0);
		}
		else if(getNextToken == BITWISE_XOR){
			printf("BITWISE OPERATOR: %s\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "BITWISE_XOR", yylineno, 0);
		}
		else if(getNextToken == NUM_INTEGER){
			printf("INTEGER : %s \n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "INTEGER", yylineno, 1);
		}	
		else if(getNextToken == NUM_FLOAT){
			printf("FLOAT : %s \n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "FLOAT", yylineno, 1);
		}
		else if(getNextToken == IDENTIFIER){
			printf("IDENTIFIER: %s\n",yytext);
			printf("At line %d\n\n",yylineno);
			insertsymbolToken(yytext, "IDENTIFIER", yylineno, 0);
		}
		else if(getNextToken == STRING){
			printf("STRING : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		// else if(getNextToken == NEWLINE){

		// }
		// else if(getNextToken == TAB){

		// }
		else if(getNextToken == MUL_COMMENT_A){
			if(mul_comment_flag==0){
				mul_comment_flag=1;
				start_multi = yylineno;
			}
			else{
				invalid_mul_comment = 1;
			}
		}
		else if(getNextToken == MUL_COMMENT_B){
			if(mul_comment_flag==1){
				invalid_mul_comment=0;
				mul_comment_flag=0;
				printf("Multi line comments found from line %d to %d\n",start_multi,yylineno);
			}
			else{
				printf(RED "ERROR : No multi line comment starter found. End found at %d\n",yylineno);
				printf(RESET);
			}
		}
		// else if (getNextToken == SINGLE_QUOTE){
		// 	printf(RED "ERROR : Incomplete String : %s",yytext);
		// 	printf(RESET);
		// 	getNextToken = yylex();
		// 	printf("%s\n\n",yytext);
		// }
		else if(getNextToken == COMMA){
			printf("Found %s at line %d\n\n",yytext,yylineno);
		}
		// else if(getNextToken == DOT){
		// 	printf("Found %s at line %d\n\n",yytext,yylineno);
		// }
		else{
			printf(RED "Found UNRECOGNISED TOKEN : %s at line %d\n\n",yytext,yylineno);
			printf(RESET);
		}
		getNextToken = yylex();
	}
	if(invalid_mul_comment==1){
		printf(RED "ERROR : Invalid multi line commenting at line %d\n",start_multi);
		printf(RESET);
	}
	else if(mul_comment_flag==1){
		printf(RED "ERROR : No multi line comment ender, starts at line %d\n",yylineno);
		printf(RESET);
	}
	if(left_flower_brkt!=0){
		printf(RED "ERROR: expected declaration or statement at end of input, line number %d\n",last_lfb);
		printf(RESET);
	}
	if(left_bracket!=0){
		printf(RED "ERROR: expected declaration or statement at end of input, line number %d\n",last_brack);
		printf(RESET);
	}

    printf("Enter expression: \n\n");
    if(!yyparse()){
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
