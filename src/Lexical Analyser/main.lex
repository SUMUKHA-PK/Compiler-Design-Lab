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

#define TOTALNUMBER 41
    
    unsigned int TokenCount[TOTALNUMBER];

%}

CHAR "char "" "*
INT "int "" "*
SHORT "short "" "*
LONG "long "" "*
UNSIGNED "unsigned "" "*
FLOAT "float "" "*
DOUBLE "double "" "*

%%

{CHAR}				                       {++TokenCount[CHAR];}
{UNSIGNED}" "*{CHAR}		               {++TokenCount[U_CHAR];}

{INT}	                		           {++TokenCount[INT];}
{SHORT}" "*{INT}			               {++TokenCount[S_INT];}
{LONG}" "*{INT}			                   {++TokenCount[L_INT];}
{LONG}" "*{LONG}" "*{INT}	               {++TokenCount[LL_INT];}
{UNSIGNED}" "*{INT}	     	               {++TokenCount[US_INT];}
{UNSIGNED}" "*{LONG}" "*{INT}	           {++TokenCount[UL_INT];}
{UNSIGNED}" "*{LONG}" "*{LONG}" "*{INT}	   {++TokenCount[ULL_INT];}

{FLOAT}                      			   {++TokenCount[FLOAT];}
{DOUBLE}                         		   {++TokenCount[DOUBLE];}

"//"				                       {++TokenCount[SL_COMMENT];}
"#"				                           {++TokenCount[PRE_PROC];}

"return"			                       {++TokenCount[RETURN];}
"if"				                       {++TokenCount[IF];}
"else"				                       {++TokenCount[ELSE];}
"while"				                       {++TokenCount[WHILE];}

"{"				                           {++TokenCount[L_FLOWER_BRKT];}
"}"				                           {++TokenCount[R_FLOWER_BRKT];}
"("				                           {++TokenCount[L_PAREN];}
")"				                           {++TokenCount[R_PAREN];}
";"				                           {++TokenCount[SEMICOLON];}

"+"				                           {++TokenCount[AR_PLUS];}
"-"				                           {++TokenCount[AR_MINUS];}
"*"				                           {++TokenCount[AR_MUL];}
"/"				                           {++TokenCount[AR_DIV];}
"%"				                           {++TokenCount[AR_MOD];}

"<"				                           {++TokenCount[REL_LESSTHAN];}
"<="				                       {++TokenCount[REL_LESSEQUAL];}
"="				                           {++TokenCount[REL_EQUAL];}
">="				                       {++TokenCount[REL_GREATEQUAL];}
">"				                           {++TokenCount[REL_GREATERTHAN];}
"!="				                       {++TokenCount[REL_NOTEQUAL];}

"&&"				                       {++TokenCount[LOG_AND];}
"||"				                       {++TokenCount[LOG_OR];}
"=="				                       {++TokenCount[LOG_COMPARE];}

"&"				                           {++TokenCount[BITWISE_AND];}
"|"				                           {++TokenCount[BITWISE_OR];}
"^"				                           {++TokenCount[BITWISE_XOR];}

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
