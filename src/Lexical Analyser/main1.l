%{

#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include "../Parser/y.tab.h"
#include "../Parser/comments.h"
#include "../Parser/tableStructure.h"

// Colours for terminal
#define RED   "\x1B[31m"
#define RESET "\x1B[0m"
#define GREEN "\x1B[32m"
#define BLUE  "\x1B[34m"

%}

%option yylineno

DIGIT [0-9]
LETTER [a-zA-Z_]
IDENTIFIER [a-zA-Z_]+[a-zA-Z0-9_]* 

NEWLINE "\\n"

%%

\n  { }

"//"                                       {    sl_flag = yylineno;
                                           }
"/*"                                       {    if(mul_comment_flag==0) {
                                                    mul_comment_flag=1;
                                                    start_multi = yylineno;
                                                }
                                                else{
                                                    invalid_mul_comment = 1;
                                                }
                                            }
"*/"	                                    {   if(mul_comment_flag==1){
                                                    invalid_mul_comment=0;
                                                    mul_comment_flag=0;
                                                    printf("Multi line comments found from line %d to %d\n",start_multi,yylineno);
                                                }
                                                else{
                                                    printf(RED "ERROR : No multi line comment starter found. End found at %d\n",yylineno);
                                                    printf(RESET);
                                                }
                                            }

"break"                                     {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolTokenWithType(yytext,"keyword",  "\0", yylineno, 0);
                                                    return BREAK;
                                                }
                                            }
"char"                                      {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    // insertsymbolToken(yytext, "char", yylineno, 0); 
                                                    strcpy(yylval.symAttrib.val,yytext);
                                                    strcpy(yylval.symAttrib.type,yytext);
                                                    return CHAR;
                                                }
                                            }
"continue"                                  {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolTokenWithType(yytext, "keyword", "\0", yylineno, 0); 
                                                    return CONTINUE;
                                                }
                                            }
"double"                                    {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    // insertsymbolToken(yytext, "double", yylineno, 0); 
                                                    strcpy(yylval.symAttrib.val,yytext);
                                                    strcpy(yylval.symAttrib.type,yytext);
                                                    return DOUBLE;
                                                }
                                            }
"else"                                      {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolTokenWithType(yytext, "keyword", "\0", yylineno, 0); 
                                                    return ELSE;
                                                }
                                            }
"float"                                     {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    // insertsymbolToken(yytext, "float", yylineno, 0); 
                                                    strcpy(yylval.symAttrib.val,yytext);
                                                    strcpy(yylval.symAttrib.type,yytext);

                                                    return FLOAT;
                                                }
                                            }
"if"                                        {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolTokenWithType(yytext, "keyword", "\0",  yylineno, 0); 
                                                    return IF;
                                                }
                                            }
"int"                                       {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    // insertsymbolToken(yytext, "int", yylineno, 0); 
                                                    strcpy(yylval.symAttrib.val,yytext);
                                                    strcpy(yylval.symAttrib.type,yytext);
                                                   
                                                    return INT;
                                                }
                                            }
"long"                                      {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolTokenWithType(yytext, "keyword",  "\0", yylineno, 0); 
                                                    return LONG;
                                                }
                                            }
"return"                                    {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolTokenWithType(yytext, "keyword",  "\0", yylineno, 0); 
                                                    return RETURN;
                                                }
                                            }
"short"                                     {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolToken(yytext, "keyword", yylineno, 0); 
                                                    return SHORT;
                                                }
                                            }
"while"                                     {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolTokenWithType(yytext, "keyword",  "\0", yylineno, 0); 
                                                    return WHILE;
                                                }
                                            }
"void"                                      {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    // insertsymbolToken(yytext, "void", yylineno, 0); 
                                                    strcpy(yylval.symAttrib.val,yytext);
                                                    strcpy(yylval.symAttrib.type,yytext);
                                                    return VOID;
                                                }
                                            }

{IDENTIFIER}                                {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    strcpy(yylval.symAttrib.type, "identifier");
                                                    strcpy(yylval.symAttrib.val,yytext);
                                                    return IDENTIFIER;
                                                }
                                            }

{DIGIT}+                                    {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolTokenWithType(yytext, "constant", "int", yylineno, 1); 
                                                    strcpy(yylval.symAttrib.val, yytext);
                                                    strcpy(yylval.symAttrib.type, "int");
                                                    yylval.symAttrib.num = atoi(yytext);
                                                    return NUM_INTEGER;
                                                }
                                            }

{DIGIT}*"."{DIGIT}+                         {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolTokenWithType(yytext, "constant", "float", yylineno, 1); 
                                                    strcpy(yylval.symAttrib.val, yytext);
                                                    yylval.symAttrib.floatNum = strtof(yytext, NULL);
                                                    strcpy(yylval.symAttrib.type, "float");
                                                    return NUM_FLOAT;
                                                }
                                            }

\"[^"\n]*["\n]	                            {   if(yylineno!=sl_flag&&mul_comment_flag!=1) { 
                                                    insertsymbolTokenWithType(yytext, "constant", "string_literal", yylineno, 1);
                                                    strcpy(yylval.symAttrib.val, yytext);
                                                    strcpy(yylval.symAttrib.type, "string_literal");
                                                    return(STRING_LITERAL);
                                                } 
                                            }

\'.\'                                       {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolTokenWithType(yytext, "constant", "char", yylineno, 1);
                                                    strcpy(yylval.symAttrib.val, yytext);
                                                    strcpy(yylval.symAttrib.type, "char");
                                                    yylval.symAttrib.charlit = *yytext;
                                                    return (CHAR_LITERAL);
                                                }   

                                            }                                                                  



"++"                                        {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    return INC_OP;
                                                }
                                            }
"--"                                        {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    return DEC_OP;
                                                }
                                            }
"&&"                                        {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    return LOG_AND;
                                                }
                                            }
"||"                                        {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    return LOG_OR;
                                                }
                                            }
"<="                                        {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    return REL_LESSEQUAL;
                                                }
                                            }
">="                                        {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    return REL_GREATEQUAL;
                                                }
                                            }
"=="                                        {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    return LOG_COMPARE;
                                                }
                                            }
"!="                                        {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    return REL_NOTEQUAL;
                                                }
                                            }
";"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return ';'; 
                                                }
                                            }
"{"		                                    { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                  
                                                    return '{';
                                                }
                                            }
"}"		                                    { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 gotoParentScope();
                                                 return '}'; 
                                                }
                                            }
","			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return ','; 
                                                }
                                            }
":"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return ':'; 
                                                }
                                            }
"="			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return '='; 
                                                }
                                            }
"("			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                        
                                                 return('('); 
                                                }
                                            }
")"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                             
                                                 return(')'); 
                                                }
                                            }
"["		                                    { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return('['); 
                                                }
                                            }
"]"		                                    { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return(']'); 
                                                }
                                            }
"."			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return('.'); 
                                                }
                                            }
"&"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return('&'); 
                                                }
                                            }
"!"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return('!'); 
                                                }
                                            }
"~"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return('~'); 
                                                }
                                            }
"-"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return('-'); 
                                                }
                                            }
"+"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return('+'); 
                                                }
                                            }
"*"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return('*'); 
                                                }
                                            }
"/"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return('/'); 
                                                }
                                            }
"%"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return('%'); 
                                                }
                                            }
"<"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return('<'); 
                                                }
                                            }
">"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return('>'); 
                                                }
                                            }
"^"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return('^'); 
                                                }
                                            }
"|"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return('|'); 
                                                }
                                            }   

                                            
%%

int yywrap(){}

