%{
    #include "y.tab.h"
    #include "symtab.h"
%}

%option yylineno

IDENTIFIER [a-zA-Z][a-zA-Z0-9]*
DIGIT [0-9]+

%%

\n {}
"//"                        {comm=yylineno;}
"int"                       {   
                                if(yylineno!=comm){
                                    strcpy(yylval.symattrib.val,yytext);
                                    strcpy(yylval.symattrib.type,yytext);
                                    return INT;
                                }
                            }
"float"                     {
                                if(yylineno!=comm) {
                                    strcpy(yylval.symattrib.val,yytext);
                                    strcpy(yylval.symattrib.type,yytext);
                                    return FLOAT;
                                }
                            }
"return"                    {
                                if(yylineno!=comm) {
                                    return RETURN;
                                }
                            }
";"                         {
                                if(yylineno!=comm) {
                                    return ';';
                                }
                            }
"#"                         {
                                if(yylineno!=comm) {
                                    return '#';
                                }
                            }
"<"                         {
                                if(yylineno!=comm) {
                                    return '<';
                                }
                            }
">"                         {
                                if(yylineno!=comm) {
                                    return '>';
                                }
                            }
"."                         {
                                if(yylineno!=comm) {
                                    return '.';
                                }
                            }
","                         {
                                if(yylineno!=comm) {
                                    return ',';
                                }
                            }
"="                         {
                                if(yylineno!=comm) {
                                    return '=';
                                }
                            }
"!"                         {
                                if(yylineno!=comm) {
                                    return '!';
                                }
                            }
"if"                        {
                                if(yylineno!=comm) {
                                    return IF;
                                }
                            }
"else"                      {
                                if(yylineno!=comm) {
                                    return ELSE;
                                }
                            }
"&"                         {
                                if(yylineno!=comm) {
                                    return '&';
                                }                        

                            }
"*"                         {
                                if(yylineno!=comm){
                                    return '*';
                                }
                            }    
"break"                     {
                                if(yylineno!=comm){
                                    return BREAK;
                                }
                            }                   
{DIGIT}+                    {
                                if(yylineno!=comm) {
                                    strcpy(yylval.symattrib.val,yytext);
                                    strcpy(yylval.symattrib.type,"int");
                                    return NUM_INTEGER;
                                }
                            }
{DIGIT}+"."{DIGIT}+         {
                                if(yylineno!=comm) {
                                    strcpy(yylval.symattrib.val,yytext);
                                    strcpy(yylval.symattrib.type,"float");
                                    return NUM_FLOAT;
                                }
                            }
{IDENTIFIER}                {
                                if(yylineno!=comm) {
                                    return IDENTIFIER;
                                }
                            }   
"{"                         {
                                if(yylineno!=comm) {
                                    return '{';
                                }
                            }
"}"                         {
                                if(yylineno!=comm) {
                                    return '}';
                                }
                            }
"("                         {   
                                if(yylineno!=comm) {
                                    return '(';
                                }
                            }
")"                         {
                                if(yylineno!=comm) {
                                    return ')';
                                }
                            }

%%

int yywrap() {}
