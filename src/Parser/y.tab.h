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
    MUL_COMMENT_A = 278,
    MUL_COMMENT_B = 279,
    SL_COMMENT = 280,
    IDENTIFIER = 281,
    NUM_INTEGER = 282,
    NUM_FLOAT = 283,
    SEMICOLON = 284,
    COMMA = 285,
    REL_LESSEQUAL = 286,
    REL_GREATEQUAL = 287,
    REL_EQUAL = 288,
    REL_NOTEQUAL = 289,
    REL_LESSTHAN = 290,
    REL_GREATERTHAN = 291,
    AR_PLUS = 292,
    AR_MINUS = 293,
    AR_MUL = 294,
    AR_DIV = 295,
    AR_MOD = 296,
    BITWISE_XOR = 297,
    BITWISE_AND = 298,
    BITWISE_OR = 299,
    LOG_AND = 300,
    LOG_OR = 301,
    LOG_COMPARE = 302
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
#define MUL_COMMENT_A 278
#define MUL_COMMENT_B 279
#define SL_COMMENT 280
#define IDENTIFIER 281
#define NUM_INTEGER 282
#define NUM_FLOAT 283
#define SEMICOLON 284
#define COMMA 285
#define REL_LESSEQUAL 286
#define REL_GREATEQUAL 287
#define REL_EQUAL 288
#define REL_NOTEQUAL 289
#define REL_LESSTHAN 290
#define REL_GREATERTHAN 291
#define AR_PLUS 292
#define AR_MINUS 293
#define AR_MUL 294
#define AR_DIV 295
#define AR_MOD 296
#define BITWISE_XOR 297
#define BITWISE_AND 298
#define BITWISE_OR 299
#define LOG_AND 300
#define LOG_OR 301
#define LOG_COMPARE 302

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
