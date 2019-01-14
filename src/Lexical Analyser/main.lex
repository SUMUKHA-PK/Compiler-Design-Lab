%{

// char and U_CHAR

#define CHAR        0
#define U_CHAR       1


// Int and it's derivatives

#define INT          2
#define S_INT        3
#define L_INT        4
#define LL_INT       5
#define U_INT        6
#define US_INT       7
#define UL_INT       8
#define ULL_INT      9

// Real datatypes

#define FLOAT       10
#define DOUBLE      11


// Single-line comment 

#define SL_COMMENT   12


// To be pre-processed data

#define PRE_PROC     13


// Control statements

#define RETURN      14
#define IF          15
#define ELSE        16
#define WHILE       17


// Punctuators

#define L_FLOWER_BRKT 18
#define R_FLOWER_BRKT 19
#define L_PAREN      20
#define R_PAREN      21
#define SEMICOLON   22


// Operators


// Arithmetic operators

#define AR_PLUS        23
#define AR_MINUS       24
#define AR_MUL         25
#define AR_DIV         26
#define AR_MOD         27

// Relational Operators

#define REL_LESSTHAN    28
#define REL_LESSEQUAL   29
#define REL_EQUAL       30
#define REL_GREATERTHAN 31
#define REL_GREATEQUAL  32
#define REL_NOTEQUAL    33

// Logical Operators

#define LOG_AND      34
#define LOG_OR       35
#define LOG_COMPARE     36

// Bitwise operators

#define BITWISE_AND  37
#define BITWISE_OR   38
#define BITWISE_XOR  39


#define IDENTIFIER  40

// If anything else is there, add above this comment and update TOTALNUMBER
// ADD TAB AND NEW LINE
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

%%

\n {}                                      

{CHAR}				                       {++TokenCount[CHAR]; printf("\nFound %s \n",yytext);}
{UNSIGNED}" "*{CHAR}		               {++TokenCount[U_CHAR]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}

{INT}	                		           {++TokenCount[INT]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
{SHORT}" "*{INT}			               {++TokenCount[S_INT]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
{LONG}" "*{INT}			                   {++TokenCount[L_INT]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
{LONG}" "*{LONG}" "*{INT}	               {++TokenCount[LL_INT]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
{UNSIGNED}" "*{INT}	     	               {++TokenCount[US_INT]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
{UNSIGNED}" "*{LONG}" "*{INT}	           {++TokenCount[UL_INT]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}
{UNSIGNED}" "*{LONG}" "*{LONG}" "*{INT}	   {++TokenCount[ULL_INT]; printf("\nFound %s \n",yytext); printf("Line number : %d \n",yylineno);}

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

"identifier"			                   {++TokenCount[IDENTIFIER];}
 
%%

int yywrap(){}


int main() {
	yylex();
	
	for(unsigned i = 0; i < TOTALNUMBER; i++) {
		printf("%u  ", TokenCount[i]);
	}
	printf("\n");
	return 0;
}
