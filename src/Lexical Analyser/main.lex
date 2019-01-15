%{

// Datatypes

#define CHAR 	    0
#define INT     	1
#define FLOAT       2
#define DOUBLE      3

// Keywords supporting Datatypes
#define SHORT		4
#define UNSIGNED	5
#define LONG		6


// Single-line comment 

#define SL_COMMENT   7


// To be pre-processed data

#define PRE_PROC     8


// Control statements

#define RETURN      9
#define IF          10
#define ELSE        11
#define WHILE       12


// Punctuators

#define L_FLOWER_BRKT 13
#define R_FLOWER_BRKT 14
#define L_PAREN      15
#define R_PAREN      16
#define SEMICOLON   17


// Operators


// Arithmetic operators

#define AR_PLUS        18
#define AR_MINUS       19
#define AR_MUL         20
#define AR_DIV         21
#define AR_MOD         22

// Relational Operators

#define REL_LESSTHAN    23
#define REL_LESSEQUAL   24
#define REL_EQUAL       25
#define REL_GREATERTHAN 26
#define REL_GREATEQUAL  27
#define REL_NOTEQUAL    28

// Logical Operators

#define LOG_AND      29
#define LOG_OR       30
#define LOG_COMPARE     31

// Bitwise operators

#define BITWISE_AND  32
#define BITWISE_OR   33
#define BITWISE_XOR  34


#define NUM_INTEGER		35

#define NUM_FLOAT       36

#define IDENTIFIER	37

#define STRING		38

#define NEWLINE		39

#define TAB			40

// If anything else is there, add above this comment and update TOTALNUMBER

#define TOTALNUMBER 41

    
    unsigned int TokenCount[TOTALNUMBER];

%}

%option yylineno

CHAR "char "" "*
INT "int "" "*
SHORT "short "" "*
LONG "long "" "*
UNSIGNED "unsigned "" "*
FLOAT "float "" "*
DOUBLE "double "" "*

QUOTE "\""
SPACE " "*
CHARACTERS [a-zA-Z0-9_]*
SPECIAL_CHARS "~"|"!"|"@"|"#"|"$"|"%"|"^"|"&"|"*"|"("|")"|":"|";"|"<"|">"|"?"


INTEGER [0-9]+

IDENTIFIER [a-zA-Z_]+[a-zA-Z0-9_]* 

%%

\n {}                                      

{CHAR}				                       {++TokenCount[CHAR]; printf("\nFound %s \n",yytext);}

{INT}	                		           {++TokenCount[INT]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}


{FLOAT}                      			   {++TokenCount[FLOAT]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
{DOUBLE}                         		   {++TokenCount[DOUBLE]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}

"//"				                       {++TokenCount[SL_COMMENT]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
"#"				                           {++TokenCount[PRE_PROC]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}

"return"			                       {++TokenCount[RETURN]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
"if"				                       {++TokenCount[IF]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
"else"				                       {++TokenCount[ELSE]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
"while"				                       {++TokenCount[WHILE]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}

"{"				                           {++TokenCount[L_FLOWER_BRKT]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
"}"				                           {++TokenCount[R_FLOWER_BRKT]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
"("				                           {++TokenCount[L_PAREN]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
")"				                           {++TokenCount[R_PAREN]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
";"				                           {++TokenCount[SEMICOLON]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}

"+"				                           {++TokenCount[AR_PLUS]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
"-"				                           {++TokenCount[AR_MINUS]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
"*"				                           {++TokenCount[AR_MUL]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
"/"				                           {++TokenCount[AR_DIV]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
"%"				                           {++TokenCount[AR_MOD]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}

"<"				                           {++TokenCount[REL_LESSTHAN]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
"<="				                       {++TokenCount[REL_LESSEQUAL]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
"="				                           {++TokenCount[REL_EQUAL]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
">="				                       {++TokenCount[REL_GREATEQUAL]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
">"				                           {++TokenCount[REL_GREATERTHAN]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
"!="				                       {++TokenCount[REL_NOTEQUAL]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}

"&&"				                       {++TokenCount[LOG_AND]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
"||"				                       {++TokenCount[LOG_OR]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
"=="				                       {++TokenCount[LOG_COMPARE]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}

"&"				                           {++TokenCount[BITWISE_AND]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
"|"				                           {++TokenCount[BITWISE_OR]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
"^"				                           {++TokenCount[BITWISE_XOR]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}

{INTEGER}								   {++TokenCount[NUM_INTEGER];printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}

{INTEGER}"."{INTEGER}                      {++TokenCount[NUM_FLOAT];printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}


{QUOTE}{CHARACTERS}{SPACE}{CHARACTERS}{SPECIAL_CHARS}{QUOTE}                       {++TokenCount[STRING];printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}

{IDENTIFIER}                               {++TokenCount[IDENTIFIER];printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}

%%

int yywrap(){}


int main() {
	yylex();
	
	for(unsigned i = 0; i < TOTALNUMBER; i++) {
		printf("%u  ", TokenCount[i]);
	}
	printf("\n%d \n",TokenCount[STRING]);
	return 0;
}
