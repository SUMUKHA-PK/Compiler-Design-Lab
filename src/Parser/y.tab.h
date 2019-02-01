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
    IDENTIFIER = 274,
    NUM_INTEGER = 275,
    NUM_FLOAT = 276,
    REL_LESSEQUAL = 277,
    REL_GREATEQUAL = 278,
    REL_EQUAL = 279,
    REL_NOTEQUAL = 280,
    REL_LESSTHAN = 281,
    REL_GREATERTHAN = 282,
    AR_PLUS = 283,
    AR_MINUS = 284,
    AR_MUL = 285,
    AR_DIV = 286,
    AR_MOD = 287,
    BITWISE_XOR = 288,
    BITWISE_AND = 289,
    BITWISE_OR = 290,
    LOG_AND = 291,
    LOG_OR = 292
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
#define IDENTIFIER 274
#define NUM_INTEGER 275
#define NUM_FLOAT 276
#define REL_LESSEQUAL 277
#define REL_GREATEQUAL 278
#define REL_EQUAL 279
#define REL_NOTEQUAL 280
#define REL_LESSTHAN 281
#define REL_GREATERTHAN 282
#define AR_PLUS 283
#define AR_MINUS 284
#define AR_MUL 285
#define AR_DIV 286
#define AR_MOD 287
#define BITWISE_XOR 288
#define BITWISE_AND 289
#define BITWISE_OR 290
#define LOG_AND 291
#define LOG_OR 292

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
