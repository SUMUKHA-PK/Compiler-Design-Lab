/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    CHAR = 258,
    INT = 259,
    FLOAT = 260,
    DOUBLE = 261,
    SHORT = 262,
    UNSIGNED = 263,
    LONG = 264,
    RETURN = 265,
    IF = 266,
    ELSE = 267,
    WHILE = 268,
    L_FLOWER_BRKT = 269,
    R_FLOWER_BRKT = 270,
    L_PAREN = 271,
    R_PAREN = 272,
    STRING = 273,
    VOID = 274,
    BREAK = 275,
    L_SQR_BRKT = 276,
    R_SQR_BRKT = 277,
    IDENTIFIER = 278,
    NUM_INTEGER = 279,
    NUM_FLOAT = 280,
    SEMICOLON = 281,
    COMMA = 282,
    REL_LESSEQUAL = 283,
    REL_GREATEQUAL = 284,
    REL_EQUAL = 285,
    REL_NOTEQUAL = 286,
    REL_LESSTHAN = 287,
    REL_GREATERTHAN = 288,
    AR_PLUS = 289,
    AR_MINUS = 290,
    AR_MUL = 291,
    AR_DIV = 292,
    AR_MOD = 293,
    BITWISE_XOR = 294,
    BITWISE_AND = 295,
    BITWISE_OR = 296,
    LOG_AND = 297,
    LOG_OR = 298,
    LOG_COMPARE = 299
  };
#endif
/* Tokens.  */
#define CHAR 258
#define INT 259
#define FLOAT 260
#define DOUBLE 261
#define SHORT 262
#define UNSIGNED 263
#define LONG 264
#define RETURN 265
#define IF 266
#define ELSE 267
#define WHILE 268
#define L_FLOWER_BRKT 269
#define R_FLOWER_BRKT 270
#define L_PAREN 271
#define R_PAREN 272
#define STRING 273
#define VOID 274
#define BREAK 275
#define L_SQR_BRKT 276
#define R_SQR_BRKT 277
#define IDENTIFIER 278
#define NUM_INTEGER 279
#define NUM_FLOAT 280
#define SEMICOLON 281
#define COMMA 282
#define REL_LESSEQUAL 283
#define REL_GREATEQUAL 284
#define REL_EQUAL 285
#define REL_NOTEQUAL 286
#define REL_LESSTHAN 287
#define REL_GREATERTHAN 288
#define AR_PLUS 289
#define AR_MINUS 290
#define AR_MUL 291
#define AR_DIV 292
#define AR_MOD 293
#define BITWISE_XOR 294
#define BITWISE_AND 295
#define BITWISE_OR 296
#define LOG_AND 297
#define LOG_OR 298
#define LOG_COMPARE 299

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif


extern YYSTYPE yylval;
extern YYLTYPE yylloc;
int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
