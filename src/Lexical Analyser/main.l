%{

#include "../Parser/y.tab.h"

// Datatypes
#define RED   "\x1B[31m"
#define RESET "\x1B[0m"
#define GREEN "\x1B[32m"
#define BLUE  "\x1B[34m"

#define CHAR_D 	    1
#define INT_D     	2
#define FLOAT_D       3
#define DOUBLE_D      4

// Keywords supporting Datatypes
#define SHORT_D		5
#define UNSIGNED_D	6
#define LONG_D		7


// Single-line comment 

#define SL_COMMENT_D   8


// To be pre-processed data

#define PRE_PROC_D     9


// Control statements

#define RETURN_D      10
#define IF_D          11
#define ELSE_D        12
#define WHILE_D       13


// Punctuators

#define L_FLOWER_BRKT_D 14
#define R_FLOWER_BRKT_D 15
#define L_PAREN_D      16
#define R_PAREN_D      17
#define SEMICOLON_D   18


// Operators


// Arithmetic operators

#define AR_PLUS_D        19
#define AR_MINUS_D       20
#define AR_MUL_D         21
#define AR_DIV_D         22
#define AR_MOD_D         23

// Relational Operators

#define REL_LESSTHAN_D    24
#define REL_LESSEQUAL_D   25
#define REL_EQUAL_D       26
#define REL_GREATERTHAN_D 27
#define REL_GREATEQUAL_D  28
#define REL_NOTEQUAL_D    29

// Logical Operators

#define LOG_AND_D      30
#define LOG_OR_D       31
#define LOG_COMPARE_D     32

// Bitwise operators

#define BITWISE_AND_D  33
#define BITWISE_OR_D   34
#define BITWISE_XOR_D  35


#define NUM_INTEGER_D		36

#define NUM_FLOAT_D       37

#define IDENTIFIER_D	38

#define STRING_D		39

#define NEWLINE_D		40

#define TAB_D			41

#define MUL_COMMENT_A_D 42
#define MUL_COMMENT_B_D 43

#define SINGLE_QUOTE_D 44

#define COMMA_D 45

#define DOT_D 46

#define VOID_D 47

#define L_SQR_BRKT_D 48
#define R_SQR_BRKT_D 49

#define BREAK_D 50

#define TOTALNUMBER_D 50


unsigned int TokenCount[TOTALNUMBER_D];

%}

%option yylineno

CHAR "char "" "*
INT "int "" "*
SHORT "short "" "*
LONG "long "" "*
UNSIGNED "unsigned "" "*
FLOAT "float "" "*
DOUBLE "double "" "*
VOID "void "" "*

QUOTE "\""
SPACE " "*
CHARACTERS [a-zA-Z0-9_]*
SPECIAL_CHARS ("~"|"`"|"!"|"@"|"#"|"$"|"%"|"^"|"&"|"*"|"("|")"|":"|";"|"<"|">"|"?"|"|"|"["|"]"|"+"|"-"|"="|"/"|"."|","|"_")*

SEMICOLON ";"

COMMA ","

DOT  "."

NEWLINE "\\n"

INTEGER [0-9]+

IDENTIFIER [a-zA-Z_]+[a-zA-Z0-9_]* 

%%

\n {}                                      

EOF                                        {return 0;}
{CHAR}				                       {++TokenCount[CHAR_D]; return CHAR;}

{INT}                                      {++TokenCount[INT_D]; return INT;} 


{FLOAT}                      			   {++TokenCount[FLOAT_D]; return FLOAT; }
{DOUBLE}                         		   {++TokenCount[DOUBLE_D]; return DOUBLE; }

{VOID}                                     {++TokenCount[VOID_D]; return VOID; }

"//"				                       {++TokenCount[SL_COMMENT_D]; return SL_COMMENT_D;}
"#"				                           {++TokenCount[PRE_PROC_D]; return PRE_PROC_D;}
"/*"                                       {++TokenCount[MUL_COMMENT_A_D]; return MUL_COMMENT_A_D;}
"*/"	                                   {++TokenCount[MUL_COMMENT_B_D]; return MUL_COMMENT_B_D;}

"return"			                       {++TokenCount[RETURN_D]; return RETURN;}
"if"				                       {++TokenCount[IF_D]; return IF;}
"else"				                       {++TokenCount[ELSE_D]; return ELSE;}
"while"				                       {++TokenCount[WHILE_D]; return WHILE;}
"break"                                    {++TokenCount[BREAK_D]; return BREAK;}

"{"				                           {++TokenCount[L_FLOWER_BRKT_D]; return L_FLOWER_BRKT;}
"}"				                           {++TokenCount[R_FLOWER_BRKT_D]; return R_FLOWER_BRKT;}
"("				                           {++TokenCount[L_PAREN_D]; return L_PAREN;}
")"				                           {++TokenCount[R_PAREN_D]; return R_PAREN;}
"["                                        {++TokenCount[L_SQR_BRKT_D]; return L_SQR_BRKT;}
"]"                                        {++TokenCount[R_SQR_BRKT_D]; return L_SQR_BRKT;}
";"				                           {++TokenCount[SEMICOLON_D]; return SEMICOLON;}

"+"				                           {++TokenCount[AR_PLUS_D]; return AR_PLUS;}
"-"				                           {++TokenCount[AR_MINUS_D]; return AR_MINUS;}
"*"				                           {++TokenCount[AR_MUL_D]; return AR_MUL;}
"/"				                           {++TokenCount[AR_DIV_D]; return AR_DIV;}
"%"				                           {++TokenCount[AR_MOD_D]; return AR_MOD;}

"<"				                           {++TokenCount[REL_LESSTHAN_D]; return REL_LESSTHAN;}
"<="				                       {++TokenCount[REL_LESSEQUAL_D]; return REL_LESSEQUAL;}
"="				                           {++TokenCount[REL_EQUAL_D]; return REL_EQUAL;}
">="				                       {++TokenCount[REL_GREATEQUAL_D]; return REL_GREATEQUAL;}
">"				                           {++TokenCount[REL_GREATERTHAN_D]; return REL_GREATERTHAN;}
"!="				                       {++TokenCount[REL_NOTEQUAL_D]; return REL_NOTEQUAL;}

"&&"				                       {++TokenCount[LOG_AND_D]; return LOG_AND;}
"||"				                       {++TokenCount[LOG_OR_D]; return LOG_OR;}
"=="				                       {++TokenCount[LOG_COMPARE_D]; return LOG_COMPARE_D;}

"&"				                           {++TokenCount[BITWISE_AND_D]; return BITWISE_AND;}
"|"				                           {++TokenCount[BITWISE_OR_D]; return BITWISE_OR;}
"^"				                           {++TokenCount[BITWISE_XOR_D]; return BITWISE_XOR;}

{INTEGER}								   {++TokenCount[NUM_INTEGER_D]; return NUM_INTEGER;}

{INTEGER}"."{INTEGER}                      {++TokenCount[NUM_FLOAT_D]; return NUM_FLOAT;}


{QUOTE}({SPACE}|{CHARACTERS}|{SPECIAL_CHARS}|{NEWLINE})*{QUOTE} {++TokenCount[STRING]; return STRING;}

{QUOTE}                                    {return SINGLE_QUOTE_D;}

{IDENTIFIER}                               {++TokenCount[IDENTIFIER]; return IDENTIFIER;}

{COMMA}                                   {return COMMA_D;}

{DOT}                                      {return DOT_D;}


%%

int yywrap(){}

int mul_comment_flag = 0, start_multi=0,invalid_mul_comment=0, left_flower_brkt=0, last_lfb=0,left_bracket=0,last_brack=0;

int symbolTableSize = 0,constantTableSize=0;

int TableSize = 1000;

typedef struct symbol {
	char value[100];
	char type[100];
	int line;
	struct symbol* next; 
} symbolToken;

symbolToken * symbolTable[1000];
symbolToken * constantTable[1000];

void initTables(){
	for(int i=0;i<TableSize;i++){
		symbolTable[i]=NULL;
		constantTable[i] = NULL;
	}
}

void printTable(int table){
	int i;
	if(table==0) {
		int tableSize = symbolTableSize;
	}
	else {
		int tableSize = constantTableSize;
	} 
	
	for(i=0;i<TableSize;i++){
		symbolToken * temp;
		if(table==0) temp = symbolTable[i];
		else temp = constantTable[i];
		while(temp!=NULL){
			printf("%-10s%10s%20d\n",temp->value,temp->type,temp->line);
			temp=temp->next;
		}
	}
}

int hash(unsigned char * s){
	unsigned long hashVar = 5381;
	int c;

    while (c = *s++)
        hashVar = (((hashVar << 5) + hashVar) + c)%1000;

    return hashVar;
}

symbolToken* createsymbolToken(char *value, char *type, int lineNumber){
    symbolToken *item = (symbolToken*)malloc(sizeof(symbolToken));
    strcpy(item->value, value);
    strcpy(item->type, type);
    item->line = lineNumber;
    item->next = NULL;

    return item;
}

void insertsymbolToken(char *value, char *type, int lineNumber, int tableno){
    int hashIndex = hash(value);

    symbolToken *item = createsymbolToken(value, type, lineNumber);

    if(tableno == 0)
    {
        symbolToken * temp = symbolTable[hashIndex];
        while(temp!=NULL && temp->next!=NULL)
            temp = temp->next;

        if(temp == NULL)
            symbolTable[hashIndex] = item;
        else
            temp->next = item;
    }

    else
    {
        symbolToken * temp = constantTable[hashIndex];
        while(temp!=NULL && temp->next!=NULL)
            temp = temp->next;

        if(temp == NULL)
            constantTable[hashIndex] = item;
        else
            temp->next = item;
    }
    
}

// int main() {

// 	int getNextToken = yylex();
// 	initTables();
	
// 	// Continuosly reads next token
// 	while(getNextToken) {
// 		if(getNextToken == CHAR) {
// 			printf("KEYWORD : %s\n\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "CHARACTER", yylineno, 0);
// 		}
// 		else if(getNextToken == INT){
// 			printf("KEYWORD : %s\n\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "INTEGER", yylineno, 0);
// 		}
// 		else if(getNextToken == FLOAT){
// 			printf("KEYWORD : %s\n\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "FLOAT", yylineno, 0);
// 		}
// 		else if(getNextToken==DOUBLE){
// 			printf("KEYWORD : %s\n\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "DOUBLE", yylineno, 0);
// 		}
// 		else if(getNextToken == SHORT){
// 			printf("KEYWORD : %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "SHORT", yylineno, 0);
// 		}
// 		else if(getNextToken == UNSIGNED){
// 			printf("KEYWORD : %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "UNSIGNED", yylineno, 0);
// 		}
// 		else if(getNextToken == LONG){
// 			printf("KEYWORD : %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "LONG", yylineno, 0);
// 		}
// 		else if(getNextToken == SL_COMMENT){
// 			printf("SINGLE LINE COMMENT at line %d\n",yylineno);
// 		}
// 		else if(getNextToken == PRE_PROC){
// 			printf("PRE PROCESSOR DIRECTIVES: %s at line %d\n",yytext,yylineno);
// 		}
// 		else if(getNextToken == RETURN){
// 			printf("RETURN CALLED at %d\n",yylineno);
// 			insertsymbolToken(yytext, "RETURN", yylineno, 0);
// 		}
// 		else if(getNextToken == IF){
// 			printf("Found %s at line %d\n\n",yytext,yylineno);
// 			insertsymbolToken(yytext, "IF", yylineno, 0);
// 		}
// 		else if(getNextToken == ELSE){
// 			printf("Found %s at line %d\n\n",yytext,yylineno);
// 			insertsymbolToken(yytext, "ELSE", yylineno, 0);
// 		}
// 		else if(getNextToken == WHILE){
// 			printf("Found %s at line %d\n\n",yytext,yylineno);
// 			insertsymbolToken(yytext, "WHILE", yylineno, 0);
// 		}
// 		else if(getNextToken == L_FLOWER_BRKT){
// 			left_flower_brkt ++;
// 			printf("Found %s \n",yytext);
// 			insertsymbolToken(yytext, "L F BRACKET", yylineno, 0);	
// 		}
// 		else if(getNextToken == R_FLOWER_BRKT){
// 			left_flower_brkt--;
// 			last_lfb = yylineno;
// 			printf("Found %s \n",yytext);	
// 			insertsymbolToken(yytext, "R F BRACKET", yylineno, 0);
// 		}
// 		else if(getNextToken == L_PAREN){
// 			left_bracket++;
// 			printf("Found : %s \n ",yytext);
// 			insertsymbolToken(yytext, "L BRACKET", yylineno, 0);
// 		}
// 		else if(getNextToken == R_PAREN){
// 			left_bracket--;
// 			last_brack = yylineno;
// 			printf("Found : %s \n ",yytext);
// 			insertsymbolToken(yytext, "R BRACKET", yylineno, 0);
// 		}
// 		else if(getNextToken == SEMICOLON){
// 			printf("SEMICOLON at line %d\n",yylineno);
// 			insertsymbolToken(yytext, "SEMICOLON", yylineno, 0);
// 		}
// 		else if(getNextToken==AR_PLUS){
// 			printf("ARITHEMATIC OPERATOR : %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "AR_PLUS", yylineno, 0);
// 		}
// 		else if(getNextToken == AR_MINUS){
// 			printf("ARITHEMATIC OPERATOR : %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "AR_MINUS", yylineno, 0);
// 		}
// 		else if(getNextToken == AR_MUL){
// 			printf("ARITHEMATIC OPERATOR : %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "AR_MUL", yylineno, 0);
// 		}
// 		else if(getNextToken == AR_DIV){
// 			printf("ARITHEMATIC OPERATOR : %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "AR_DIV", yylineno, 0);
// 		}
// 		else if(getNextToken == AR_MOD){
// 			printf("ARITHEMATIC OPERATOR : %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "AR_MOD", yylineno, 0);
// 		}
// 		else if(getNextToken == REL_LESSTHAN){
// 			printf("RELATIONAL OPERATOR : %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "REL_LESSTHAN", yylineno, 0);
// 		}
// 		else if(getNextToken == REL_LESSEQUAL){
// 			printf("RELATIONAL OPERATOR : %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "REL_LESSEQUAL", yylineno, 0);
// 		}
// 		else if(getNextToken == REL_EQUAL){
// 			printf("RELATIONAL OPERATOR : %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "REL_EQUAL", yylineno, 0);
// 		}
// 		else if(getNextToken == REL_GREATERTHAN){
// 			printf("RELATIONAL OPERATOR : %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "REL_GREATERTHAN", yylineno, 0);
// 		}
// 		else if(getNextToken == REL_GREATEQUAL){
// 			printf("RELATIONAL OPERATOR : %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "REL_GREATEQUAL", yylineno, 0);
// 		}
// 		else if(getNextToken == REL_NOTEQUAL){
// 			printf("RELATIONAL OPERATOR : %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "REL_NOTEQUAL", yylineno, 0);
// 		}
// 		else if(getNextToken == LOG_AND){
// 			printf("LOGICAL OPERATOR: %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "LOG_AND", yylineno, 0);
// 		}
// 		else if(getNextToken == LOG_OR){
// 			printf("LOGICAL OPERATOR: %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "LOG_OR", yylineno, 0);
// 		}
// 		else if(getNextToken == LOG_COMPARE){
// 			printf("LOGICAL OPERATOR: %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "LOG_COMPARE", yylineno, 0);
// 		}
// 		else if(getNextToken == BITWISE_AND){
// 			printf("BITWISE OPERATOR: %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "BITWISE_AND", yylineno, 0);
// 		}	
// 		else if(getNextToken == BITWISE_OR){
// 			printf("BITWISE OPERATOR: %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "BITWISE_OR", yylineno, 0);
// 		}
// 		else if(getNextToken == BITWISE_XOR){
// 			printf("BITWISE OPERATOR: %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "BITWISE_XOR", yylineno, 0);
// 		}
// 		else if(getNextToken == NUM_INTEGER){
// 			printf("INTEGER : %s \n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "INTEGER", yylineno, 1);
// 		}	
// 		else if(getNextToken == NUM_FLOAT){
// 			printf("FLOAT : %s \n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "FLOAT", yylineno, 1);
// 		}
// 		else if(getNextToken == IDENTIFIER){
// 			printf("IDENTIFIER: %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 			insertsymbolToken(yytext, "IDENTIFIER", yylineno, 0);
// 		}
// 		else if(getNextToken == STRING){
// 			printf("STRING : %s\n",yytext);
// 			printf("At line %d\n\n",yylineno);
// 		}
// 		else if(getNextToken == NEWLINE){

// 		}
// 		else if(getNextToken == TAB){

// 		}
// 		else if(getNextToken == MUL_COMMENT_A){
// 			if(mul_comment_flag==0){
// 				mul_comment_flag=1;
// 				start_multi = yylineno;
// 			}
// 			else{
// 				invalid_mul_comment = 1;
// 			}
// 		}
// 		else if(getNextToken == MUL_COMMENT_B){
// 			if(mul_comment_flag==1){
// 				invalid_mul_comment=0;
// 				mul_comment_flag=0;
// 				printf("Multi line comments found from line %d to %d\n",start_multi,yylineno);
// 			}
// 			else{
// 				printf(RED "ERROR : No multi line comment starter found. End found at %d\n",yylineno);
// 				printf(RESET);
// 			}
// 		}
// 		else if (getNextToken == SINGLE_QUOTE){
// 			printf(RED "ERROR : Incomplete String : %s",yytext);
// 			printf(RESET);
// 			getNextToken = yylex();
// 			printf("%s\n\n",yytext);
// 		}
// 		else if(getNextToken == COMMA){
// 			printf("Found %s at line %d\n\n",yytext,yylineno);
// 		}
// 		else if(getNextToken == DOT){
// 			printf("Found %s at line %d\n\n",yytext,yylineno);
// 		}
// 		else{
// 			printf(RED "Found UNRECOGNISED TOKEN : %s at line %d\n\n",yytext,yylineno);
// 			printf(RESET);
// 		}
// 		getNextToken = yylex();
// 	}
// 	if(invalid_mul_comment==1){
// 		printf(RED "ERROR : Invalid multi line commenting at line %d\n",start_multi);
// 		printf(RESET);
// 	}
// 	else if(mul_comment_flag==1){
// 		printf(RED "ERROR : No multi line comment ender, starts at line %d\n",yylineno);
// 		printf(RESET);
// 	}
// 	if(left_flower_brkt!=0){
// 		printf(RED "ERROR: expected declaration or statement at end of input, line number %d\n",last_lfb);
// 		printf(RESET);
// 	}
// 	if(left_bracket!=0){
// 		printf(RED "ERROR: expected declaration or statement at end of input, line number %d\n",last_brack);
// 		printf(RESET);
// 	}

// 	printf(GREEN "\n\nSYMBOL TABLE" RESET);
// 	printf("\n-----------------------------------------------------------------\n");
//     printf(BLUE "%-20s%10s%24s\n","VALUE","TYPE","LINE NUMBER" RESET);
//     printf("-----------------------------------------------------------------\n");
// 	printTable(0);

// 	printf(GREEN "\n\nCONSTANT TABLE" RESET);
// 	printf("\n-----------------------------------------------------------------\n");
//     printf(BLUE "%-20s%10s%24s\n","VALUE","TYPE","LINE NUMBER" RESET);
//     printf("-----------------------------------------------------------------\n");
// 	printTable(1);
// 	return 0;
// }
