%{

// Datatypes

#define CHAR 	    1
#define INT     	2
#define FLOAT       3
#define DOUBLE      4

// Keywords supporting Datatypes
#define SHORT		5
#define UNSIGNED	6
#define LONG		7


// Single-line comment 

#define SL_COMMENT   8


// To be pre-processed data

#define PRE_PROC     9


// Control statements

#define RETURN      10
#define IF          11
#define ELSE        12
#define WHILE       13


// Punctuators

#define L_FLOWER_BRKT 14
#define R_FLOWER_BRKT 15
#define L_PAREN      16
#define R_PAREN      17
#define SEMICOLON   18


// Operators


// Arithmetic operators

#define AR_PLUS        19
#define AR_MINUS       20
#define AR_MUL         21
#define AR_DIV         22
#define AR_MOD         23

// Relational Operators

#define REL_LESSTHAN    24
#define REL_LESSEQUAL   25
#define REL_EQUAL       26
#define REL_GREATERTHAN 27
#define REL_GREATEQUAL  28
#define REL_NOTEQUAL    29

// Logical Operators

#define LOG_AND      30
#define LOG_OR       31
#define LOG_COMPARE     32

// Bitwise operators

#define BITWISE_AND  33
#define BITWISE_OR   34
#define BITWISE_XOR  35


#define NUM_INTEGER		36

#define NUM_FLOAT       37

#define IDENTIFIER	38

#define STRING		39

#define NEWLINE		40

#define TAB			41

#define MUL_COMMENT_A 42
#define MUL_COMMENT_B 43

#define SINGLE_QUOTE 44
// If anything else is there, add above this comment and update TOTALNUMBER

#define TOTALNUMBER 44

    
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
SPECIAL_CHARS ("~"|"!"|"@"|"#"|"$"|"%"|"^"|"&"|"*"|"("|")"|":"|";"|"<"|">"|"?"|"|"|"["|"]"|"+"|"-"|"="|"/")*


INTEGER [0-9]+

IDENTIFIER [a-zA-Z_]+[a-zA-Z0-9_]* 

%%

\n {}                                      

EOF                                        {return 0;}
{CHAR}				                       {++TokenCount[CHAR]; return CHAR;}

{INT}	                		           {++TokenCount[INT]; return INT;} 


{FLOAT}                      			   {++TokenCount[FLOAT]; return FLOAT; }
{DOUBLE}                         		   {++TokenCount[DOUBLE]; return DOUBLE; }

"//"				                       {++TokenCount[SL_COMMENT]; return SL_COMMENT;}
"#"				                           {++TokenCount[PRE_PROC]; return PRE_PROC;}
"/*"                                       {++TokenCount[MUL_COMMENT_A]; return MUL_COMMENT_A;}
"*/"	                                   {++TokenCount[MUL_COMMENT_B]; return MUL_COMMENT_B;}

"return"			                       {++TokenCount[RETURN]; return RETURN;}
"if"				                       {++TokenCount[IF]; return IF;}
"else"				                       {++TokenCount[ELSE]; return ELSE;}
"while"				                       {++TokenCount[WHILE]; return WHILE;}

"{"				                           {++TokenCount[L_FLOWER_BRKT]; return L_FLOWER_BRKT;}
"}"				                           {++TokenCount[R_FLOWER_BRKT]; return R_FLOWER_BRKT;}
"("				                           {++TokenCount[L_PAREN]; return L_PAREN;}
")"				                           {++TokenCount[R_PAREN]; return R_PAREN;}
";"				                           {++TokenCount[SEMICOLON]; return SEMICOLON;}

"+"				                           {++TokenCount[AR_PLUS]; return AR_PLUS;}
"-"				                           {++TokenCount[AR_MINUS]; return AR_MINUS;}
"*"				                           {++TokenCount[AR_MUL]; return AR_MUL;}
"/"				                           {++TokenCount[AR_DIV]; return AR_DIV;}
"%"				                           {++TokenCount[AR_MOD]; return AR_MOD;}

"<"				                           {++TokenCount[REL_LESSTHAN]; return REL_LESSTHAN;}
"<="				                       {++TokenCount[REL_LESSEQUAL]; return REL_LESSEQUAL;}
"="				                           {++TokenCount[REL_EQUAL]; return REL_EQUAL;}
">="				                       {++TokenCount[REL_GREATEQUAL]; return REL_GREATEQUAL;}
">"				                           {++TokenCount[REL_GREATERTHAN]; return REL_GREATERTHAN;}
"!="				                       {++TokenCount[REL_NOTEQUAL]; return REL_NOTEQUAL;}

"&&"				                       {++TokenCount[LOG_AND]; return LOG_AND;}
"||"				                       {++TokenCount[LOG_OR]; return LOG_OR;}
"=="				                       {++TokenCount[LOG_COMPARE]; return LOG_COMPARE;}

"&"				                           {++TokenCount[BITWISE_AND]; return BITWISE_AND;}
"|"				                           {++TokenCount[BITWISE_OR]; return BITWISE_OR;}
"^"				                           {++TokenCount[BITWISE_XOR]; return BITWISE_XOR;}

{INTEGER}								   {++TokenCount[NUM_INTEGER]; return NUM_INTEGER;}

{INTEGER}"."{INTEGER}                      {++TokenCount[NUM_FLOAT]; return NUM_FLOAT;}


{QUOTE}({SPACE}|{CHARACTERS}|{SPECIAL_CHARS})*{QUOTE}    {++TokenCount[STRING]; return STRING;}

{QUOTE}                                    {return SINGLE_QUOTE;}

{IDENTIFIER}                               {++TokenCount[IDENTIFIER]; return IDENTIFIER;}

%%

int yywrap(){}

int mul_comment_flag = 0, start_multi=0;

int main() {

	int getNextToken = yylex();

	// Continuosly reads next token
	while(getNextToken) {
		if(getNextToken == CHAR) {
			printf("KEYWORD : %s\n\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == INT){
			printf("KEYWORD : %s\n\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == FLOAT){
			printf("KEYWORD : %s\n\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken==DOUBLE){
			printf("KEYWORD : %s\n\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == SHORT){
			printf("KEYWORD : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == UNSIGNED){
			printf("KEYWORD : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == LONG){
			printf("KEYWORD : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == SL_COMMENT){
			printf("SINGLE LINE COMMENT at line %d\n",yylineno);
		}
		else if(getNextToken == PRE_PROC){
			printf("PRE PROCESSOR DIRECTIVES: %s at line %d\n",yytext,yylineno);
		}
		else if(getNextToken == RETURN){
			printf("RETURN CALLED at %d\n",yylineno);
		}
		else if(getNextToken == IF){

		}
		else if(getNextToken == ELSE){

		}
		else if(getNextToken == WHILE){

		}
		else if(getNextToken == L_FLOWER_BRKT){

		}
		else if(getNextToken == R_FLOWER_BRKT){

		}
		else if(getNextToken == L_PAREN){

		}
		else if(getNextToken == R_PAREN){

		}
		else if(getNextToken == SEMICOLON){
			printf("SEMICOLON at line %d\n",yylineno);
		}
		else if(getNextToken==AR_PLUS){
			printf("ARITHEMATIC OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == AR_MINUS){
			printf("ARITHEMATIC OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == AR_MUL){
			printf("ARITHEMATIC OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == AR_DIV){
			printf("ARITHEMATIC OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == AR_MOD){
			printf("ARITHEMATIC OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == REL_LESSTHAN){
			printf("RELATIONAL OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == REL_LESSEQUAL){
			printf("RELATIONAL OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == REL_EQUAL){
			printf("RELATIONAL OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == REL_GREATERTHAN){
			printf("RELATIONAL OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == REL_GREATEQUAL){
			printf("RELATIONAL OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == REL_NOTEQUAL){
			printf("RELATIONAL OPERATOR : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == LOG_AND){
			printf("LOGICAL OPERATOR: %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == LOG_AND){
			printf("LOGICAL OPERATOR: %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == LOG_AND){
			printf("LOGICAL OPERATOR: %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == BITWISE_AND){
			printf("BITWISE OPERATOR: %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}	
		else if(getNextToken == BITWISE_AND){
			printf("BITWISE OPERATOR: %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == BITWISE_AND){
			printf("BITWISE OPERATOR: %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == NUM_INTEGER){
			printf("INTEGER : %s \n",yytext);
			printf("At line %d\n\n",yylineno);
		}	
		else if(getNextToken == NUM_FLOAT){
			printf("FLOAT : %s \n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == IDENTIFIER){
			printf("IDENTIFIER: %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == STRING){
			printf("STRING : %s\n",yytext);
			printf("At line %d\n\n",yylineno);
		}
		else if(getNextToken == NEWLINE){

		}
		else if(getNextToken == TAB){

		}
		else if(getNextToken == MUL_COMMENT_A){
			if(mul_comment_flag==0){
				mul_comment_flag=1;
				start_multi = yylineno;
			}
			else{
				printf("Invalid behaviour. Two continuos open multi line comments at %d and %d\n",start_multi,yylineno);
			}
		}
		else if(getNextToken == MUL_COMMENT_B){
			if(mul_comment_flag==1){
				printf("Multi line comments from line %d to %d\n",start_multi,yylineno);
				mul_comment_flag=0;
			}
			else{
				printf("Multi line commenting not started, end symbol found at line %d\n",yylineno);
			}
		}
		else if (getNextToken == SINGLE_QUOTE){
			printf("ERR_INCOMPLETE_STRING : %s",yytext);
			getNextToken = yylex();
			printf("%s\n\n",yytext);
		}
		getNextToken = yylex();
	}
	if(mul_comment_flag==1){
		printf("No multi line comment ender, starts at line %d\n",yylineno);
	}
	return 0;
}
