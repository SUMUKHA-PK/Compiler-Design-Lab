%{

// char and uchar
#define CHAR        0
#define UCHAR       1

// Int and it's derivatives
#define INT         2
#define SINT        3
#define LINT        4
#define LLINT       5
#define UINT        6
#define USINT       7
#define ULINT       8
#define ULLINT      9

// Real datatypes
#define FLOAT       10
#define DOUBLE      11


// Single-line comment 
#define SLCOMMENT   12

// To be pre-processed data
#define PREPROC     13


// Control statements
#define RETURN      14
#define IF          15
#define ELSE        16
#define WHILE       17


// Punctuators
#define LFLOWERBRKT 18
#define RFLOWERBRKT 19
#define LPAREN      20
#define RPAREN      21
#define SEMICOLON   22

// Operators

// Arithmetic operators
#define PLUS        23
#define MINUS       24
#define MUL         25
#define DIV         26
#define MOD         27

// Relational Operators
#define LESSTHAN    28
#define LESSEQUAL   29
#define EQUAL       30
#define GREATERTHAN 31
#define GREATEQUAL  32
#define NOTEQUAL    33

// Logical Operators
#define LOGAND      34
#define LOGOR       35
#define COMPARE     36

// Bitwise operators
#define BITWISEAND  37
#define BITWISEOR   38
#define BITWISEXOR  39


#define IDENTIFIER  40

// If anything else is there, add above this comment and update TOTALNUMBER

#define TOTALNUMBER 41
    
    unsigned int TokenCount[TOTALNUMBER];

%}


%%

"char"				{++TokenCount[CHAR];}
"unsigned char"			{++TokenCount[UCHAR];}

"int"				{++TokenCount[INT];}
"short int"			{++TokenCount[SINT];}
"long int"			{++TokenCount[LINT];}
"long long int"			{++TokenCount[LLINT];}
"unsigned short int"		{++TokenCount[USINT];}
"unsigned long int"		{++TokenCount[ULINT];}
"unsigned long long int"	{++TokenCount[ULLINT];}

"float"				{++TokenCount[FLOAT];}
"double"			{++TokenCount[DOUBLE];}

"//"				{++TokenCount[SLCOMMENT];}
"#"				{++TokenCount[PREPROC];}

"return"			{++TokenCount[RETURN];}
"if"				{++TokenCount[IF];}
"else"				{++TokenCount[ELSE];}
"while"				{++TokenCount[WHILE];}

"{"				{++TokenCount[LFLOWERBRKT];}
"}"				{++TokenCount[RFLOWERBRKT];}
"("				{++TokenCount[LPAREN];}
")"				{++TokenCount[RPAREN];}
";"				{++TokenCount[SEMICOLON];}

"+"				{++TokenCount[PLUS];}
"-"				{++TokenCount[MINUS];}
"*"				{++TokenCount[MUL];}
"/"				{++TokenCount[DIV];}
"%"				{++TokenCount[MOD];}

"<"				{++TokenCount[LESSTHAN];}
"<="				{++TokenCount[LESSEQUAL];}
"="				{++TokenCount[EQUAL];}
">="				{++TokenCount[GREATEQUAL];}
">"				{++TokenCount[GREATERTHAN];}
"!="				{++TokenCount[NOTEQUAL];}

"&&"				{++TokenCount[LOGAND];}
"||"				{++TokenCount[LOGOR];}
"=="				{++TokenCount[COMPARE];}

"&"				{++TokenCount[BITWISEAND];}
"|"				{++TokenCount[BITWISEOR];}
"^"				{++TokenCount[BITWISEXOR];}

"identifier"			{++TokenCount[IDENTIFIER];}

%%

int yywrap(){}


int main() {
	yylex();
	
	for(unsigned i = 0; i < TOTALNUMBER; i++) {
		printf("%u\n", TokenCount[i]);
	}

	return 0;
}
