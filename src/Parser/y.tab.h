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
    VOID = 258,
    CHAR = 259,
    INT = 260,
    FLOAT = 261,
    DOUBLE = 262,
    SHORT = 263,
    UNSIGNED = 264,
    LONG = 265,
    IF = 266,
    ELSE = 267,
    WHILE = 268,
    RETURN = 269,
    BREAK = 270,
    CONTINUE = 271,
    IDENTIFIER = 272,
    NUM_INTEGER = 273,
    NUM_FLOAT = 274,
    STRING_LITERAL = 275,
    REL_LESSEQUAL = 276,
    REL_GREATEQUAL = 277,
    REL_EQUAL = 278,
    REL_NOTEQUAL = 279,
    REL_LESSTHAN = 280,
    REL_GREATERTHAN = 281,
    LOG_AND = 282,
    LOG_OR = 283,
    LOG_COMPARE = 284,
    INC_OP = 285,
    DEC_OP = 286
  };
#endif
/* Tokens.  */
#define VOID 258
#define CHAR 259
#define INT 260
#define FLOAT 261
#define DOUBLE 262
#define SHORT 263
#define UNSIGNED 264
#define LONG 265
#define IF 266
#define ELSE 267
#define WHILE 268
#define RETURN 269
#define BREAK 270
#define CONTINUE 271
#define IDENTIFIER 272
#define NUM_INTEGER 273
#define NUM_FLOAT 274
#define STRING_LITERAL 275
#define REL_LESSEQUAL 276
#define REL_GREATEQUAL 277
#define REL_EQUAL 278
#define REL_NOTEQUAL 279
#define REL_LESSTHAN 280
#define REL_GREATERTHAN 281
#define LOG_AND 282
#define LOG_OR 283
#define LOG_COMPARE 284
#define INC_OP 285
#define DEC_OP 286

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
