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
                                                    insertsymbolToken(yytext, "BREAK", yylineno, 0);
                                                    return BREAK;
                                                }
                                            }
"char"                                      {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolToken(yytext, "CHARACTER", yylineno, 0); 
                                                    strcpy(yylval.symAttrib.val, yytext);
                                                    return CHAR;
                                                }
                                            }
"continue"                                  {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolToken(yytext, "CONTINUE", yylineno, 0); 
                                                    return CONTINUE;
                                                }
                                            }
"double"                                    {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolToken(yytext, "DOUBLE", yylineno, 0); 
                                                    strcpy(yylval.symAttrib.val, yytext);
                                                    return DOUBLE;
                                                }
                                            }
"else"                                      {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolToken(yytext, "ELSE", yylineno, 0); 
                                                    return ELSE;
                                                }
                                            }
"float"                                     {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolToken(yytext, "FLOAT", yylineno, 0); 
                                                    strcpy(yylval.symAttrib.val, yytext);
                                                    return FLOAT;
                                                }
                                            }
"if"                                        {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolToken(yytext, "IF", yylineno, 0); 
                                                    return IF;
                                                }
                                            }
"int"                                       {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolToken(yytext, "INT", yylineno, 0); 
                                                    
                                                    strcpy(yylval.symAttrib.val, yytext);
                                                    return INT;
                                                }
                                            }
"long"                                      {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolToken(yytext, "LONG", yylineno, 0); 
                                                    return LONG;
                                                }
                                            }
"return"                                    {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolToken(yytext, "RETURN", yylineno, 0); 
                                                    return RETURN;
                                                }
                                            }
"short"                                     {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolToken(yytext, "SHORT", yylineno, 0); 
                                                    return SHORT;
                                                }
                                            }
"while"                                     {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolToken(yytext, "WHILE", yylineno, 0); 
                                                    return WHILE;
                                                }
                                            }
"void"                                      {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolToken(yytext, "VOID", yylineno, 0); 
                                                    strcpy(yylval.symAttrib.val, yytext);
                                                    return VOID;
                                                }
                                            }

{IDENTIFIER}                                {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolToken(yytext, "IDENTIFIER", yylineno, 0);
                                                    return IDENTIFIER;
                                                }
                                            }

{DIGIT}+                                    {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolToken(yytext, "NUM_INTEGER", yylineno, 1); 
                                                    return NUM_INTEGER;
                                                }
                                            }

{DIGIT}*"."{DIGIT}+                         {   if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                    insertsymbolToken(yytext, "NUM_FLOAT", yylineno, 1); 
                                                    return NUM_FLOAT;
                                                }
                                            }

LETTER?\"(\\.|[^\\"])*\"	                {   if(yylineno!=sl_flag&&mul_comment_flag!=1) { 
                                                    insertsymbolToken(yytext, "STRING_LITERAL", yylineno, 1);
                                                    return(STRING_LITERAL);
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
                                                 return SEMICOLON; 
                                                }
                                            }
"{"		                                    { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 incrementTableScope(); return L_FLOWER_BRKT;
                                                }
                                            }
"}"		                                    { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 returnToParentScope(); return R_FLOWER_BRKT; 
                                                }
                                            }
","			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return COMMA; 
                                                }
                                            }
":"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return COLON; 
                                                }
                                            }
"="			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return REL_EQUAL; 
                                                }
                                            }
"("			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return L_PAREN; 
                                                }
                                            }
")"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return R_PAREN; 
                                                }
                                            }
"["		                                    { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return L_SQR_BRKT; 
                                                }
                                            }
"]"		                                    { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return R_SQR_BRKT; 
                                                }
                                            }
"."			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return DOT; 
                                                }
                                            }
"&"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return BITWISE_AND; 
                                                }
                                            }
"!"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return EXCLAMATION; 
                                                }
                                            }
"~"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return TILDE; 
                                                }
                                            }
"-"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return AR_MINUS; 
                                                }
                                            }
"+"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return AR_PLUS; 
                                                }
                                            }
"*"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return AR_MUL; 
                                                }
                                            }
"/"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return AR_DIV; 
                                                }
                                            }
"%"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return AR_MOD; 
                                                }
                                            }
"<"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return REL_LESSTHAN; 
                                                }
                                            }
">"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return REL_GREATERTHAN; 
                                                }
                                            }
"^"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return BITWISE_XOR; 
                                                }
                                            }
"|"			                                { if(yylineno!=sl_flag&&mul_comment_flag!=1) {
                                                 return BITWISE_OR; 
                                                }
                                            }   
                                            
%%

int yywrap(){}

