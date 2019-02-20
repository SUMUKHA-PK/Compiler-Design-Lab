%{
#include"y.tab.c"
%}

%option yylineno

FOR "for"                              
INT "int "                             
IDENTIFIER [a-zA-Z]+[a-zA-Z0-9]*       
INTEGER [0-9]                          
AR_PLUS "+"
AR_EQUAL "="
AR_LTHAN  "<"
SEMICOLON ";"
AR_INC    "++"

%%

EOF                                    {return 0;}
{FOR}                                  {return FOR;}
{INT}                                  {return INT;}
{IDENTIFIER}                           {return IDENTIFIER;}
{INTEGER}                              {return INTEGER;}
{AR_PLUS}                              {return AR_PLUS;}
{AR_EQUAL}                             {return AR_EQUAL;}
{AR_LTHAN}                             {return AR_LTHAN;}
{SEMICOLON}                            {return SEMICOLON;}
{AR_INC}                               {return AR_INC;}

.                                      {printf("Unrecognised rule!"); return 1;}
%%

int yywrap(){}