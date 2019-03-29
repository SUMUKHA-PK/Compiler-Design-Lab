/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.4"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 1 "main.y" /* yacc.c:339  */


    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>

    #include "tableStructure.h"

    #include "comments.h"

    #include "errors.h"

    extern int yylex();

    #define RED   "\x1B[31m"

    void yyerror(const char *s);

    extern char *yytext;
    extern int yylineno;	

    int sl_flag = -1, mul_comment_flag = 0, start_multi = 0, invalid_mul_comment = 0,dontPrint=0,ifIf=0,ifIfDec=0;

    char Type[100];
    char functype[100];
    char returnType[100];
    char argTypes[100][100];
    char argValues[100][100];
    int argLLs[100];
    int numArgs1 = 0;
    int numArgs2 = 0;
    int decORdef = 0; //0OR1
    Tables* currTable;
    int backPatchStack[100];
    int backPatchStackTop=-1;
    char threeAddrLabelStack[100][100];
    int threeAddrLabelStackTop=-1;

    FILE * threeAddressFile = NULL;
    char threeAddrCode[1000][1000];
    int threeAddrCodeLineNo = 0;
    char code[1000];
    int tempVarCount=0;
    int labelCount=0;

    void addthreeAddrCode(char * str){
        strcpy(threeAddrCode[threeAddrCodeLineNo],str);
        threeAddrCodeLineNo++;
    }

    char * newTempVar(){
        char * buf = (char*)malloc(10);
        sprintf(buf,"T_%d",tempVarCount);
        tempVarCount++;
        return buf;
    }

    char * newLabel(){
        char * buf = (char*)malloc(15);
        sprintf(buf,"Label_%d",labelCount);
        labelCount++;
        return buf;
    }

    char* curLabel(){
        char * buf = (char*)malloc(15);
        sprintf(buf,"Label_%d",labelCount);
        return buf;
    }
    
    void pushBackthreeAddrLabelStack(char * str){
        strcpy(threeAddrLabelStack[++threeAddrLabelStackTop],str);
    }

    void popthreeAddrLabelStack(){
        --threeAddrLabelStackTop;
    }

    void pushBackPatchStack(int n){
        backPatchStack[++backPatchStackTop] = n ;
    }

    int popBackPatchStack(){
        int var = backPatchStack[backPatchStackTop];
        backPatchStackTop--;
        return var;
    }

#line 155 "y.tab.c" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "y.tab.h".  */
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
    CHAR_LITERAL = 276,
    INC_OP = 277,
    DEC_OP = 278,
    REL_LESSEQUAL = 279,
    REL_GREATEQUAL = 280,
    REL_EQUAL = 281,
    REL_NOTEQUAL = 282,
    REL_LESSTHAN = 283,
    REL_GREATERTHAN = 284,
    AR_PLUS = 285,
    AR_MINUS = 286,
    AR_MUL = 287,
    AR_DIV = 288,
    AR_MOD = 289,
    BITWISE_XOR = 290,
    BITWISE_AND = 291,
    BITWISE_OR = 292,
    LOG_AND = 293,
    LOG_OR = 294,
    LOG_COMPARE = 295
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
#define CHAR_LITERAL 276
#define INC_OP 277
#define DEC_OP 278
#define REL_LESSEQUAL 279
#define REL_GREATEQUAL 280
#define REL_EQUAL 281
#define REL_NOTEQUAL 282
#define REL_LESSTHAN 283
#define REL_GREATERTHAN 284
#define AR_PLUS 285
#define AR_MINUS 286
#define AR_MUL 287
#define AR_DIV 288
#define AR_MOD 289
#define BITWISE_XOR 290
#define BITWISE_AND 291
#define BITWISE_OR 292
#define LOG_AND 293
#define LOG_OR 294
#define LOG_COMPARE 295

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 93 "main.y" /* yacc.c:355  */

    
    char charConst;
    struct{
        char type[100];
        char val[100];
        int num;
        float floatNum;
        char charlit;
    } symAttrib;

#line 287 "y.tab.c" /* yacc.c:355  */
};

typedef union YYSTYPE YYSTYPE;
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

/* Copy the second part of user declarations.  */

#line 318 "y.tab.c" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL \
             && defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
  YYLTYPE yyls_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE) + sizeof (YYLTYPE)) \
      + 2 * YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  13
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   231

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  61
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  45
/* YYNRULES -- Number of rules.  */
#define YYNRULES  103
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  163

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   295

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,    53,    58,     2,
      44,    45,    51,    54,    46,    55,     2,    52,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    50,    41,
      56,    49,    57,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    42,     2,    43,    59,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    47,    60,    48,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   175,   175,   176,   181,   182,   186,   193,   199,   204,
     205,   210,   211,   212,   213,   214,   219,   227,   228,   229,
     229,   252,   257,   258,   263,   264,   269,   270,   276,   288,
     305,   306,   311,   312,   317,   318,   336,   337,   342,   343,
     344,   345,   346,   347,   352,   357,   358,   363,   367,   375,
     363,   397,   396,   410,   415,   421,   415,   445,   446,   447,
     451,   452,   460,   461,   466,   475,   480,   485,   489,   490,
     495,   496,   515,   527,   530,   532,   534,   536,   538,   549,
     557,   604,   653,   690,   704,   753,   806,   818,   852,   887,
     921,   958,   971,  1007,  1044,  1057,  1085,  1098,  1127,  1140,
    1169,  1183,  1219,  1232
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "VOID", "CHAR", "INT", "FLOAT", "DOUBLE",
  "SHORT", "UNSIGNED", "LONG", "IF", "ELSE", "WHILE", "RETURN", "BREAK",
  "CONTINUE", "IDENTIFIER", "NUM_INTEGER", "NUM_FLOAT", "STRING_LITERAL",
  "CHAR_LITERAL", "INC_OP", "DEC_OP", "REL_LESSEQUAL", "REL_GREATEQUAL",
  "REL_EQUAL", "REL_NOTEQUAL", "REL_LESSTHAN", "REL_GREATERTHAN",
  "AR_PLUS", "AR_MINUS", "AR_MUL", "AR_DIV", "AR_MOD", "BITWISE_XOR",
  "BITWISE_AND", "BITWISE_OR", "LOG_AND", "LOG_OR", "LOG_COMPARE", "';'",
  "'['", "']'", "'('", "')'", "','", "'{'", "'}'", "'='", "':'", "'*'",
  "'/'", "'%'", "'+'", "'-'", "'<'", "'>'", "'&'", "'^'", "'|'", "$accept",
  "start_unit", "external_declaration", "function_definition",
  "declaration", "declaration_specifiers", "direct_declarator", "$@1",
  "declaration_list", "compound_statement", "init_declaration_list",
  "parameter_list", "parameter_declaration", "list_of_lists",
  "init_declarator", "list", "statement", "labeled_statement",
  "expression_statement", "if_statement", "$@2", "$@3", "$@4",
  "else_statement", "$@5", "while_statement", "$@6", "$@7",
  "jump_statement", "return", "expression", "array_funccall",
  "argument_list", "assignment_expression", "unary_expression",
  "primary_expression", "multiplicative_expression", "additive_expression",
  "relational_expression", "equality_expression", "and_expression",
  "xor_expression", "or_expression", "log_and_expression",
  "log_or_expression", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,    59,    91,    93,    40,    41,    44,   123,   125,    61,
      58,    42,    47,    37,    43,    45,    60,    62,    38,    94,
     124
};
# endif

#define YYPACT_NINF -90

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-90)))

#define YYTABLE_NINF -1

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
     196,   -90,   -90,   -90,   -90,   -90,   -90,   109,   -90,   -90,
     -90,     4,    11,   -90,   -90,   -90,    31,     6,   -90,    50,
     -13,   -90,     4,   -22,   130,    10,   -22,   -90,   -90,    34,
     -90,   -90,   -90,   -90,   -90,   -90,    10,    83,   -90,   -90,
     106,    30,   -14,   -18,    -2,    33,    38,    26,     1,   -90,
     116,    32,   116,   -90,   -90,   -90,    10,    60,   120,   148,
     -90,   -90,   134,   -90,   149,   -90,   -90,   -90,   -90,   -90,
     -90,   -90,   167,    36,   -90,   162,   171,   -90,   -90,   -90,
      65,    10,    85,    10,    10,    10,    10,    10,    10,    10,
      10,    10,    10,    10,    10,    10,    10,    10,    10,   -90,
      34,   127,   -90,   -90,   170,   172,   173,   -90,   -90,   168,
     -90,   -90,   -90,   -90,    10,    10,   -90,    53,   -90,   146,
     -90,   -90,   -90,   -90,   106,   106,    30,    30,    30,    30,
     -14,   -14,   -18,    -2,    33,    38,    26,    98,   -90,   116,
      10,    10,   -90,   -90,   171,   -90,   -90,    10,   -90,   159,
     161,   -90,   -90,   -90,   168,   168,   -90,   -90,   205,   -90,
     -90,   168,   -90
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,    11,    13,    12,    14,    15,    16,     0,     2,     4,
       5,     0,     0,     1,     3,     9,    34,     0,    26,     0,
      19,    22,     0,     0,     0,     0,     0,     7,    10,     0,
      73,    75,    74,    76,    77,    18,     0,    72,    79,    64,
      83,    86,    91,    94,    96,    98,   100,   102,     0,    21,
       0,    34,     0,     8,    47,    54,    60,     0,     0,    73,
      45,    24,    36,    39,     0,    32,    37,    38,    40,    41,
      42,    43,     0,     0,    62,    79,    70,    35,     6,    27,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,    17,
      31,     0,    28,    23,     0,     0,    61,    58,    59,     0,
      25,    33,    57,    46,     0,     0,    78,     0,    66,     0,
      68,    80,    81,    82,    84,    85,    89,    90,    87,    88,
      93,    92,    95,    97,    99,   101,   103,    30,    20,     0,
       0,     0,    44,    63,    71,    65,    67,     0,    29,     0,
       0,    69,    48,    55,     0,     0,    49,    56,    53,    51,
      50,     0,    52
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -90,   -90,   211,   -90,     5,     0,    -3,   -90,    67,    23,
     -90,   -90,    81,   -90,   192,   158,   -89,   -90,   -90,   -90,
     -90,   -90,   -90,   -90,   -90,   -90,   -90,   -90,   -90,   -90,
     -33,   -90,   -90,   -19,   -23,   -90,    89,    -1,   102,   129,
     131,   128,   132,   133,   -15
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     7,     8,     9,    21,    22,    12,    50,    62,    63,
      17,   101,   102,    64,    18,    65,    66,    67,    68,    69,
     104,   154,   158,   160,   161,    70,   105,   155,    71,    72,
      73,    37,   119,    74,    38,    39,    40,    41,    42,    43,
      44,    45,    46,    47,    76
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
      11,    75,    75,    80,    48,    10,    77,    11,    16,    92,
      88,    89,    10,    75,     1,     2,     3,     4,     5,    51,
     142,     6,    93,   106,    52,    24,    51,    30,    31,    32,
      33,    34,    49,    75,     1,     2,     3,     4,     5,    27,
      98,    75,    90,    91,    99,    15,    53,    28,   117,    78,
     100,     6,    29,    19,    36,    20,    94,   103,    75,    75,
     121,   122,   123,   120,    97,   156,   157,    30,    31,    32,
      33,    34,   162,    19,    19,    20,    20,   113,    24,    23,
      25,    25,   114,    26,    86,    87,    75,   126,   127,   128,
     129,    75,    95,    35,    36,   143,   145,   137,    96,   114,
     144,   107,    30,    31,    32,    33,    34,   149,   150,    13,
     116,   114,     1,     2,     3,     4,     5,    75,    75,     1,
       2,     3,     4,     5,    75,    81,     6,    82,   151,    36,
     118,    75,    75,     1,     2,     3,     4,     5,    75,   100,
      19,    54,    20,    55,    56,    57,    58,    59,    31,    32,
      33,    34,     1,     2,     3,     4,     5,    83,    84,    85,
      54,   108,    55,    56,    57,    58,    59,    31,    32,    33,
      34,    60,   138,   139,    36,   124,   125,    24,    61,    54,
      52,    55,    56,    57,    58,    59,    31,    32,    33,    34,
      60,   146,   147,    36,   130,   131,    24,   110,   109,     1,
       2,     3,     4,     5,   152,   114,   153,   114,   112,    60,
      98,   115,    36,     6,   140,    24,   141,   159,    14,   114,
     148,    79,   111,   132,   134,     0,   133,     0,     0,   135,
       0,   136
};

static const yytype_int16 yycheck[] =
{
       0,    24,    25,    36,    19,     0,    25,     7,    11,    27,
      24,    25,     7,    36,     3,     4,     5,     6,     7,    22,
     109,    17,    40,    56,    46,    47,    29,    17,    18,    19,
      20,    21,    45,    56,     3,     4,     5,     6,     7,    16,
      39,    64,    56,    57,    43,    41,    23,    41,    81,    26,
      50,    17,    46,    42,    44,    44,    58,    52,    81,    82,
      83,    84,    85,    82,    38,   154,   155,    17,    18,    19,
      20,    21,   161,    42,    42,    44,    44,    41,    47,    12,
      49,    49,    46,    16,    54,    55,   109,    88,    89,    90,
      91,   114,    59,    43,    44,   114,    43,   100,    60,    46,
     115,    41,    17,    18,    19,    20,    21,   140,   141,     0,
      45,    46,     3,     4,     5,     6,     7,   140,   141,     3,
       4,     5,     6,     7,   147,    42,    17,    44,   147,    44,
      45,   154,   155,     3,     4,     5,     6,     7,   161,   139,
      42,    11,    44,    13,    14,    15,    16,    17,    18,    19,
      20,    21,     3,     4,     5,     6,     7,    51,    52,    53,
      11,    41,    13,    14,    15,    16,    17,    18,    19,    20,
      21,    41,    45,    46,    44,    86,    87,    47,    48,    11,
      46,    13,    14,    15,    16,    17,    18,    19,    20,    21,
      41,    45,    46,    44,    92,    93,    47,    48,    50,     3,
       4,     5,     6,     7,    45,    46,    45,    46,    41,    41,
      39,    49,    44,    17,    44,    47,    44,    12,     7,    46,
     139,    29,    64,    94,    96,    -1,    95,    -1,    -1,    97,
      -1,    98
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,     4,     5,     6,     7,    17,    62,    63,    64,
      65,    66,    67,     0,    63,    41,    67,    71,    75,    42,
      44,    65,    66,    69,    47,    49,    69,    70,    41,    46,
      17,    18,    19,    20,    21,    43,    44,    92,    95,    96,
      97,    98,    99,   100,   101,   102,   103,   104,   105,    45,
      68,    67,    46,    70,    11,    13,    14,    15,    16,    17,
      41,    48,    69,    70,    74,    76,    77,    78,    79,    80,
      86,    89,    90,    91,    94,    95,   105,    94,    70,    75,
      91,    42,    44,    51,    52,    53,    54,    55,    24,    25,
      56,    57,    27,    40,    58,    59,    60,    38,    39,    43,
      66,    72,    73,    65,    81,    87,    91,    41,    41,    50,
      48,    76,    41,    41,    46,    49,    45,    91,    45,    93,
      94,    95,    95,    95,    97,    97,    98,    98,    98,    98,
      99,    99,   100,   101,   102,   103,   104,    67,    45,    46,
      44,    44,    77,    94,   105,    43,    45,    46,    73,    91,
      91,    94,    45,    45,    82,    88,    77,    77,    83,    12,
      84,    85,    77
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    61,    62,    62,    63,    63,    64,    64,    64,    65,
      65,    66,    66,    66,    66,    66,    67,    67,    67,    68,
      67,    67,    69,    69,    70,    70,    71,    71,    72,    72,
      73,    73,    74,    74,    75,    75,    76,    76,    77,    77,
      77,    77,    77,    77,    78,    79,    79,    81,    82,    83,
      80,    85,    84,    84,    87,    88,    86,    89,    89,    89,
      90,    90,    91,    91,    92,    92,    92,    92,    93,    93,
      94,    94,    95,    96,    96,    96,    96,    96,    96,    97,
      97,    97,    97,    98,    98,    98,    99,    99,    99,    99,
      99,   100,   100,   100,   101,   101,   102,   102,   103,   103,
     104,   104,   105,   105
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     2,     1,     1,     4,     3,     3,     2,
       3,     1,     1,     1,     1,     1,     1,     4,     3,     0,
       5,     3,     1,     3,     2,     3,     1,     3,     1,     3,
       2,     1,     1,     2,     1,     3,     1,     1,     1,     1,
       1,     1,     1,     1,     3,     1,     2,     0,     0,     0,
       9,     0,     3,     0,     0,     0,     7,     2,     2,     2,
       1,     2,     1,     3,     1,     4,     3,     4,     1,     3,
       1,     3,     1,     1,     1,     1,     1,     1,     3,     1,
       3,     3,     3,     1,     3,     3,     1,     3,     3,     3,
       3,     1,     3,     3,     1,     3,     1,     3,     1,     3,
       1,     3,     1,     3
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)                                \
    do                                                                  \
      if (N)                                                            \
        {                                                               \
          (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;        \
          (Current).first_column = YYRHSLOC (Rhs, 1).first_column;      \
          (Current).last_line    = YYRHSLOC (Rhs, N).last_line;         \
          (Current).last_column  = YYRHSLOC (Rhs, N).last_column;       \
        }                                                               \
      else                                                              \
        {                                                               \
          (Current).first_line   = (Current).last_line   =              \
            YYRHSLOC (Rhs, 0).last_line;                                \
          (Current).first_column = (Current).last_column =              \
            YYRHSLOC (Rhs, 0).last_column;                              \
        }                                                               \
    while (0)
#endif

#define YYRHSLOC(Rhs, K) ((Rhs)[K])


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL

/* Print *YYLOCP on YYO.  Private, do not rely on its existence. */

YY_ATTRIBUTE_UNUSED
static unsigned
yy_location_print_ (FILE *yyo, YYLTYPE const * const yylocp)
{
  unsigned res = 0;
  int end_col = 0 != yylocp->last_column ? yylocp->last_column - 1 : 0;
  if (0 <= yylocp->first_line)
    {
      res += YYFPRINTF (yyo, "%d", yylocp->first_line);
      if (0 <= yylocp->first_column)
        res += YYFPRINTF (yyo, ".%d", yylocp->first_column);
    }
  if (0 <= yylocp->last_line)
    {
      if (yylocp->first_line < yylocp->last_line)
        {
          res += YYFPRINTF (yyo, "-%d", yylocp->last_line);
          if (0 <= end_col)
            res += YYFPRINTF (yyo, ".%d", end_col);
        }
      else if (0 <= end_col && yylocp->first_column < end_col)
        res += YYFPRINTF (yyo, "-%d", end_col);
    }
  return res;
 }

#  define YY_LOCATION_PRINT(File, Loc)          \
  yy_location_print_ (File, &(Loc))

# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value, Location); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  YYUSE (yylocationp);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  YY_LOCATION_PRINT (yyoutput, *yylocationp);
  YYFPRINTF (yyoutput, ": ");
  yy_symbol_value_print (yyoutput, yytype, yyvaluep, yylocationp);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, YYLTYPE *yylsp, int yyrule)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                       , &(yylsp[(yyi + 1) - (yynrhs)])                       );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, yylsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep, YYLTYPE *yylocationp)
{
  YYUSE (yyvaluep);
  YYUSE (yylocationp);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Location data for the lookahead symbol.  */
YYLTYPE yylloc
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
  = { 1, 1, 1, 1 }
# endif
;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.
       'yyls': related to locations.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    /* The location stack.  */
    YYLTYPE yylsa[YYINITDEPTH];
    YYLTYPE *yyls;
    YYLTYPE *yylsp;

    /* The locations where the error started and ended.  */
    YYLTYPE yyerror_range[3];

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;
  YYLTYPE yyloc;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N), yylsp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yylsp = yyls = yylsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  yylsp[0] = yylloc;
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;
        YYLTYPE *yyls1 = yyls;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yyls1, yysize * sizeof (*yylsp),
                    &yystacksize);

        yyls = yyls1;
        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
        YYSTACK_RELOCATE (yyls_alloc, yyls);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;
      yylsp = yyls + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END
  *++yylsp = yylloc;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];

  /* Default location.  */
  YYLLOC_DEFAULT (yyloc, (yylsp - yylen), yylen);
  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 6:
#line 186 "main.y" /* yacc.c:1646  */
    {
                                                                                    if(returnType[0]=='\0') strcpy(returnType,"void");
                                                                                        if(strcmp((yyvsp[-3].symAttrib).type,returnType)){
                                                                                        returnTypeMisMatchError((yyvsp[-3].symAttrib).type,(yyvsp[-3].symAttrib).val,returnType, yylineno);
                                                                                    }
                                                                                    sprintf(code,"func end\n"); addthreeAddrCode(code);
                                                                                  }
#line 1646 "y.tab.c" /* yacc.c:1646  */
    break;

  case 7:
#line 193 "main.y" /* yacc.c:1646  */
    { if(returnType[0]=='\0') strcpy(returnType,"void");
                                                                                        if(strcmp((yyvsp[-2].symAttrib).type,returnType)){
                                                                                        returnTypeMisMatchError((yyvsp[-2].symAttrib).type,(yyvsp[-2].symAttrib).val,returnType, yylineno);
                                                                                    }
                                                                                    sprintf(code,"func end\n"); addthreeAddrCode(code);
                                                                                  }
#line 1657 "y.tab.c" /* yacc.c:1646  */
    break;

  case 10:
#line 205 "main.y" /* yacc.c:1646  */
    {ifIfDec=0;}
#line 1663 "y.tab.c" /* yacc.c:1646  */
    break;

  case 11:
#line 210 "main.y" /* yacc.c:1646  */
    {strcpy(Type, (yyvsp[0].symAttrib).type); strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type);}
#line 1669 "y.tab.c" /* yacc.c:1646  */
    break;

  case 12:
#line 211 "main.y" /* yacc.c:1646  */
    {ifIfDec=1;strcpy(Type, (yyvsp[0].symAttrib).type); strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type);}
#line 1675 "y.tab.c" /* yacc.c:1646  */
    break;

  case 13:
#line 212 "main.y" /* yacc.c:1646  */
    {ifIfDec=1;strcpy(Type, (yyvsp[0].symAttrib).type); strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type);}
#line 1681 "y.tab.c" /* yacc.c:1646  */
    break;

  case 14:
#line 213 "main.y" /* yacc.c:1646  */
    {ifIfDec=1;strcpy(Type, (yyvsp[0].symAttrib).type); strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type);}
#line 1687 "y.tab.c" /* yacc.c:1646  */
    break;

  case 15:
#line 214 "main.y" /* yacc.c:1646  */
    {ifIfDec=1;strcpy(Type, (yyvsp[0].symAttrib).type); strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type);}
#line 1693 "y.tab.c" /* yacc.c:1646  */
    break;

  case 16:
#line 219 "main.y" /* yacc.c:1646  */
    {   strcpy((yyvsp[0].symAttrib).type, Type); strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type); strcpy((yyval.symAttrib).val, (yyvsp[0].symAttrib).val);
                                                        if(!findInHashTable((yyvsp[0].symAttrib).val,(yyvsp[0].symAttrib).type)){
                                                            insertsymbolToken(yytext,(yyvsp[0].symAttrib).type, yylineno, 0);
                                                        }
                                                        else{
                                                            if(!decORdef) redeclarationError((yyvsp[0].symAttrib).type,(yyvsp[0].symAttrib).val,yylineno);
                                                        }
                                                    }
#line 1706 "y.tab.c" /* yacc.c:1646  */
    break;

  case 19:
#line 229 "main.y" /* yacc.c:1646  */
    {
                                                    if(decORdef==1){
                                                        incrementTableScope();
                                                        sprintf(code,"\nfunction begin %s:\n",(yyvsp[-1].symAttrib).val);addthreeAddrCode(code);
                                                    }
                                                }
#line 1717 "y.tab.c" /* yacc.c:1646  */
    break;

  case 20:
#line 236 "main.y" /* yacc.c:1646  */
    {   if(decORdef==0){
                                                        decORdef=1;
                                                    }
                                                    else{
                                                        if(numArgs2>numArgs1){
                                                            tooManyArgumentsError(yylineno);
                                                        }
                                                        else if(numArgs2<numArgs1){
                                                            tooLessArgumentsError(yylineno);   
                                                        }
                                                        decORdef=2;
                                                    }
                                                    if(decORdef==2){
                                                        decORdef = 0;
                                                    }
                                                }
#line 1738 "y.tab.c" /* yacc.c:1646  */
    break;

  case 28:
#line 276 "main.y" /* yacc.c:1646  */
    {  if(decORdef==0) {
                                                        strcpy(argTypes[numArgs1],(yyvsp[0].symAttrib).type); 
                                                        strcpy(argValues[numArgs1],(yyvsp[0].symAttrib).val); 
                                                        numArgs1++;
                                                    }
                                                    else{
                                                        if(strcmp(argTypes[numArgs2],(yyvsp[0].symAttrib).type)){
                                                            argumentTypeMismatchError(argTypes[numArgs2],(yyvsp[0].symAttrib).type,yylineno);          
                                                        }
                                                        numArgs2++;
                                                    }
                                                }
#line 1755 "y.tab.c" /* yacc.c:1646  */
    break;

  case 29:
#line 288 "main.y" /* yacc.c:1646  */
    {   
                                                    if(decORdef==0) {
                                                        strcpy(argTypes[numArgs1],(yyvsp[0].symAttrib).type);
                                                        strcpy(argValues[numArgs1],(yyvsp[0].symAttrib).val);
                                                        numArgs1++; 
                                                    }
                                                    else{
                                                        if(strcmp(argTypes[numArgs2],(yyvsp[0].symAttrib).type)){
                                                            argumentTypeMismatchError(argTypes[numArgs2],(yyvsp[0].symAttrib).type,yylineno);        
                                                        }
                                                        numArgs2++;
                                                    }
                                                }
#line 1773 "y.tab.c" /* yacc.c:1646  */
    break;

  case 30:
#line 305 "main.y" /* yacc.c:1646  */
    {strcpy((yyvsp[-1].symAttrib).type, Type); strcpy((yyval.symAttrib).type, (yyvsp[-1].symAttrib).type); strcpy((yyval.symAttrib).val, (yyvsp[-1].symAttrib).val);}
#line 1779 "y.tab.c" /* yacc.c:1646  */
    break;

  case 35:
#line 318 "main.y" /* yacc.c:1646  */
    {   char typeStr[100];    
                                                        if(findInHashTable((yyvsp[-2].symAttrib).val,typeStr)){
                                                            strcpy((yyvsp[-2].symAttrib).type,typeStr);
                                                            if(strcmp((yyvsp[-2].symAttrib).type,(yyvsp[0].symAttrib).type)){
                                                                typeMismatchError((yyvsp[-2].symAttrib).type,(yyvsp[0].symAttrib).type,yylineno);
                                                            }
                                                            else{
                                                                sprintf(code,"%s = %s\n",(yyvsp[-2].symAttrib).val,(yyvsp[0].symAttrib).val);addthreeAddrCode(code);
                                                            }
                                                        }
                                                        else{
                                                            variableNotDeclaredError((yyvsp[0].symAttrib).type,(yyvsp[0].symAttrib).val,yylineno);
                                                        }
                                                    }
#line 1798 "y.tab.c" /* yacc.c:1646  */
    break;

  case 47:
#line 363 "main.y" /* yacc.c:1646  */
    {   ifIf=1;
                                                        incrementTableScope();
                                                    }
#line 1806 "y.tab.c" /* yacc.c:1646  */
    break;

  case 48:
#line 367 "main.y" /* yacc.c:1646  */
    {
                                                        pushBackPatchStack(threeAddrCodeLineNo);
                                                        sprintf(code,"IF (%s) GOTO %s\nGOTO ",(yyvsp[-1].symAttrib).val,curLabel());
                                                        addthreeAddrCode(code);
                                                        sprintf(code,"\n%s : \n",newLabel());
                                                        addthreeAddrCode(code);
                                                    }
#line 1818 "y.tab.c" /* yacc.c:1646  */
    break;

  case 49:
#line 375 "main.y" /* yacc.c:1646  */
    {
                                                        int prevTop = popBackPatchStack();
                                                        pushBackPatchStack(threeAddrCodeLineNo);
                                                        pushBackPatchStack(prevTop);
                                                        sprintf(code,"GOTO ");
                                                        addthreeAddrCode(code);
                                                        
                                                        char * nextlabel = newLabel();
                                                        sprintf(code,"\n%s: \n",nextlabel);
                                                        addthreeAddrCode(code);

                                                        char tempCode[100];
                                                        sprintf(tempCode,"%s\n",nextlabel);
                                                        int d = popBackPatchStack();
                                                        strcat(threeAddrCode[d],tempCode);printf("@");
                                                        printf("%s\n",threeAddrCode[d]);
                                                    }
#line 1840 "y.tab.c" /* yacc.c:1646  */
    break;

  case 51:
#line 397 "main.y" /* yacc.c:1646  */
    {
                                                        ifIf=1;
                                                        incrementTableScope();
                                                    }
#line 1849 "y.tab.c" /* yacc.c:1646  */
    break;

  case 52:
#line 401 "main.y" /* yacc.c:1646  */
    {
                                                        char * nextlabel = newLabel();
                                                        sprintf(code,"\n%s: \n",nextlabel);
                                                        addthreeAddrCode(code);

                                                        char tempCode[100];
                                                        sprintf(tempCode,"%s\n",nextlabel);
                                                        strcat(threeAddrCode[popBackPatchStack()],tempCode);
                                                    }
#line 1863 "y.tab.c" /* yacc.c:1646  */
    break;

  case 54:
#line 415 "main.y" /* yacc.c:1646  */
    {
                                                    pushBackthreeAddrLabelStack(curLabel());
                                                    sprintf(code,"\n%s :\n",newLabel());addthreeAddrCode(code);
                                                    ifIf=1;
                                                    incrementTableScope();
                                                }
#line 1874 "y.tab.c" /* yacc.c:1646  */
    break;

  case 55:
#line 421 "main.y" /* yacc.c:1646  */
    {
                                                    pushBackPatchStack(threeAddrCodeLineNo);
                                                    sprintf(code,"IF (%s) GOTO %s\nGOTO ",(yyvsp[-1].symAttrib).val,curLabel());
                                                    addthreeAddrCode(code);
                                                    sprintf(code,"\n%s\n",newLabel()); 
                                                    addthreeAddrCode(code); 
                                                }
#line 1886 "y.tab.c" /* yacc.c:1646  */
    break;

  case 56:
#line 428 "main.y" /* yacc.c:1646  */
    {
                                                    sprintf(code,"GOTO %s\n",threeAddrLabelStack[threeAddrLabelStackTop]);
                                                    addthreeAddrCode(code);
                                                    popthreeAddrLabelStack();

                                                    char *nextlabel = newLabel();
                                                    sprintf(code,"\n%s: \n",nextlabel);
                                                    addthreeAddrCode(code);

                                                    char tempCode[100];
                                                    sprintf(tempCode,"%s\n",nextlabel);
                                                    strcat(threeAddrCode[popBackPatchStack()],tempCode);
                                                }
#line 1904 "y.tab.c" /* yacc.c:1646  */
    break;

  case 60:
#line 451 "main.y" /* yacc.c:1646  */
    {sprintf(code,"return \n");addthreeAddrCode(code);}
#line 1910 "y.tab.c" /* yacc.c:1646  */
    break;

  case 61:
#line 452 "main.y" /* yacc.c:1646  */
    {
                                                        strcpy(returnType,(yyvsp[0].symAttrib).type);
                                                        sprintf(code,"return %s\n",(yyvsp[0].symAttrib).val);addthreeAddrCode(code);
                                                    }
#line 1919 "y.tab.c" /* yacc.c:1646  */
    break;

  case 62:
#line 460 "main.y" /* yacc.c:1646  */
    {strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type); strcpy((yyval.symAttrib).val, (yyvsp[0].symAttrib).val);}
#line 1925 "y.tab.c" /* yacc.c:1646  */
    break;

  case 64:
#line 466 "main.y" /* yacc.c:1646  */
    {
                                                    strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type);
                                                    strcpy((yyval.symAttrib).val, (yyvsp[0].symAttrib).val);
                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int"))
                                                        (yyval.symAttrib).num = (yyvsp[0].symAttrib).num;
                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                        (yyval.symAttrib).floatNum = (yyvsp[0].symAttrib).floatNum;
                                                }
#line 1938 "y.tab.c" /* yacc.c:1646  */
    break;

  case 65:
#line 475 "main.y" /* yacc.c:1646  */
    {
                                                    

                                                }
#line 1947 "y.tab.c" /* yacc.c:1646  */
    break;

  case 66:
#line 480 "main.y" /* yacc.c:1646  */
    {
                                                    

                                                }
#line 1956 "y.tab.c" /* yacc.c:1646  */
    break;

  case 68:
#line 489 "main.y" /* yacc.c:1646  */
    {strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type); strcpy((yyval.symAttrib).val, (yyvsp[0].symAttrib).val);}
#line 1962 "y.tab.c" /* yacc.c:1646  */
    break;

  case 69:
#line 490 "main.y" /* yacc.c:1646  */
    {strcpy((yyval.symAttrib).type, (yyvsp[-2].symAttrib).type); strcpy((yyval.symAttrib).val, (yyvsp[-2].symAttrib).val);}
#line 1968 "y.tab.c" /* yacc.c:1646  */
    break;

  case 70:
#line 495 "main.y" /* yacc.c:1646  */
    {strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type); strcpy((yyval.symAttrib).val, (yyvsp[0].symAttrib).val);}
#line 1974 "y.tab.c" /* yacc.c:1646  */
    break;

  case 71:
#line 496 "main.y" /* yacc.c:1646  */
    {  strcpy((yyval.symAttrib).type, (yyvsp[-2].symAttrib).type); strcpy((yyval.symAttrib).val, (yyvsp[-2].symAttrib).val);
                                                        char typeStr[100];    
                                                        if(findInHashTable((yyvsp[-2].symAttrib).val,typeStr)){
                                                            strcpy((yyvsp[-2].symAttrib).type,typeStr);
                                                            if(strcmp((yyvsp[-2].symAttrib).type,(yyvsp[0].symAttrib).type)){
                                                                typeMismatchError((yyvsp[-2].symAttrib).type,(yyvsp[0].symAttrib).type,yylineno);
                                                            }
                                                            else{
                                                                sprintf(code,"%s = %s\n",(yyvsp[-2].symAttrib).val,(yyvsp[0].symAttrib).val);addthreeAddrCode(code);
                                                            }
                                                        }
                                                        else{
                                                            variableNotDeclaredError((yyvsp[0].symAttrib).type,(yyvsp[0].symAttrib).val,yylineno);
                                                        }
                                                    }
#line 1994 "y.tab.c" /* yacc.c:1646  */
    break;

  case 72:
#line 515 "main.y" /* yacc.c:1646  */
    {   
                                                strcpy((yyval.symAttrib).val, (yyvsp[0].symAttrib).val); 
                                                strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type); 
                                                if(!strcmp((yyvsp[0].symAttrib).type, "int"))
                                                    (yyval.symAttrib).num = (yyvsp[0].symAttrib).num;
                                                else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                    (yyval.symAttrib).floatNum = (yyvsp[0].symAttrib).floatNum;
                                            }
#line 2007 "y.tab.c" /* yacc.c:1646  */
    break;

  case 73:
#line 527 "main.y" /* yacc.c:1646  */
    {strcpy((yyvsp[0].symAttrib).type, Type); strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type); strcpy((yyval.symAttrib).val, (yyvsp[0].symAttrib).val);}
#line 2013 "y.tab.c" /* yacc.c:1646  */
    break;

  case 74:
#line 530 "main.y" /* yacc.c:1646  */
    {strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type);  (yyval.symAttrib).floatNum = (yyvsp[0].symAttrib).floatNum;}
#line 2019 "y.tab.c" /* yacc.c:1646  */
    break;

  case 75:
#line 532 "main.y" /* yacc.c:1646  */
    {strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type); (yyval.symAttrib).num = (yyvsp[0].symAttrib).num;}
#line 2025 "y.tab.c" /* yacc.c:1646  */
    break;

  case 76:
#line 534 "main.y" /* yacc.c:1646  */
    {strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type); strcpy((yyval.symAttrib).val, (yyvsp[0].symAttrib).val);}
#line 2031 "y.tab.c" /* yacc.c:1646  */
    break;

  case 77:
#line 536 "main.y" /* yacc.c:1646  */
    {strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type); strcpy((yyval.symAttrib).val, (yyvsp[0].symAttrib).val);}
#line 2037 "y.tab.c" /* yacc.c:1646  */
    break;

  case 78:
#line 538 "main.y" /* yacc.c:1646  */
    {
                                strcpy((yyval.symAttrib).type, (yyvsp[-1].symAttrib).type); 
                                if(!strcmp((yyvsp[-1].symAttrib).type, "int"))
                                    (yyval.symAttrib).num = (yyvsp[-1].symAttrib).num;
                                else if(!strcmp((yyvsp[-1].symAttrib).type, "float"))
                                    (yyval.symAttrib).floatNum = (yyvsp[-1].symAttrib).floatNum;
                            }
#line 2049 "y.tab.c" /* yacc.c:1646  */
    break;

  case 79:
#line 549 "main.y" /* yacc.c:1646  */
    {
                                                                strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type);
                                                                strcpy((yyval.symAttrib).val,(yyvsp[0].symAttrib).val);
                                                                if(!strcmp((yyvsp[0].symAttrib).type, "int"))
                                                                    (yyval.symAttrib).num = (yyvsp[0].symAttrib).num;
                                                                else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                    (yyval.symAttrib).floatNum, (yyvsp[0].symAttrib).floatNum;
                                                            }
#line 2062 "y.tab.c" /* yacc.c:1646  */
    break;

  case 80:
#line 557 "main.y" /* yacc.c:1646  */
    {   if(!strcmp((yyvsp[-2].symAttrib).type, "string_literal") || !strcmp((yyvsp[0].symAttrib).type, "string_literal"))
                                                                    divOperandsTypeError((yyvsp[-2].symAttrib).type, (yyvsp[0].symAttrib).type, yylineno) ;

                                                                strcpy((yyval.symAttrib).type, "int");
                                                                strcpy((yyval.symAttrib).val,newTempVar());
                                                                sprintf(code,"%s = (%s * %s)\n",(yyval.symAttrib).val,(yyvsp[-2].symAttrib).val,(yyvsp[0].symAttrib).val);
                                                                addthreeAddrCode(code);
                                                                if(!strcmp((yyvsp[-2].symAttrib).type, "int")) {
                                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int")) {
                                                                        strcpy((yyval.symAttrib).type, "int");
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num / (yyvsp[0].symAttrib).num;
                                                                    }
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float")) {
                                                                        strcpy((yyvsp[0].symAttrib).type, "float");
                                                                        (yyval.symAttrib).floatNum = (yyvsp[-2].symAttrib).num / (yyvsp[0].symAttrib).floatNum;
                                                                    }
                                                                    else  if(!strcmp((yyvsp[0].symAttrib).type, "char")) {
                                                                        strcpy((yyvsp[0].symAttrib).type, "int");
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num / (yyvsp[0].symAttrib).charlit;
                                                                    }
                                                                }
                                                                else if(!strcmp((yyvsp[-2].symAttrib).type, "float")) {
                                                                    strcpy((yyval.symAttrib).type, "float");
                                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int")) 
                                                                        (yyval.symAttrib).floatNum = (yyvsp[-2].symAttrib).floatNum / (yyvsp[0].symAttrib).num;
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                        (yyval.symAttrib).floatNum = (yyvsp[-2].symAttrib).floatNum / (yyvsp[0].symAttrib).floatNum;
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char"))
                                                                        (yyval.symAttrib).floatNum = (yyvsp[-2].symAttrib).floatNum / (yyvsp[0].symAttrib).charlit;
                                                                }
                                                                else if(!strcmp((yyvsp[-2].symAttrib).type, "char")) {
                                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int")) {
                                                                        strcpy((yyval.symAttrib).type, "int");
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit / (yyvsp[0].symAttrib).num;
                                                                    }
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float")) {
                                                                        strcpy((yyval.symAttrib).type, "float");
                                                                        (yyval.symAttrib).floatNum = (yyvsp[-2].symAttrib).charlit / (yyvsp[0].symAttrib).floatNum;
                                                                    }
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char")) {
                                                                        strcpy((yyval.symAttrib).type, "char");
                                                                        (yyval.symAttrib).charlit = (yyvsp[-2].symAttrib).charlit / (yyvsp[0].symAttrib).charlit;
                                                                    }
                                                                }
                                                            }
#line 2112 "y.tab.c" /* yacc.c:1646  */
    break;

  case 81:
#line 604 "main.y" /* yacc.c:1646  */
    {   
                                                                if(!strcmp((yyvsp[-2].symAttrib).type, "string_literal") || !strcmp((yyvsp[0].symAttrib).type, "string_literal"))
                                                                    divOperandsTypeError((yyvsp[-2].symAttrib).type, (yyvsp[0].symAttrib).type, yylineno) ;

                                                                strcpy((yyval.symAttrib).type, "int");
                                                                strcpy((yyval.symAttrib).val,newTempVar());
                                                                sprintf(code,"%s = (%s / %s)\n",(yyval.symAttrib).val,(yyvsp[-2].symAttrib).val,(yyvsp[0].symAttrib).val);
                                                                addthreeAddrCode(code);

                                                                if(!strcmp((yyvsp[-2].symAttrib).type, "int")) {
                                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int")) {
                                                                        strcpy((yyval.symAttrib).type, "int");
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num / (yyvsp[0].symAttrib).num;
                                                                    }
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float")) {
                                                                        strcpy((yyvsp[0].symAttrib).type, "float");
                                                                        (yyval.symAttrib).floatNum = (yyvsp[-2].symAttrib).num / (yyvsp[0].symAttrib).floatNum;
                                                                    }
                                                                    else  if(!strcmp((yyvsp[0].symAttrib).type, "char")) {
                                                                        strcpy((yyvsp[0].symAttrib).type, "int");
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num / (yyvsp[0].symAttrib).charlit;
                                                                    }
                                                                }
                                                                else if(!strcmp((yyvsp[-2].symAttrib).type, "float")) {
                                                                    strcpy((yyval.symAttrib).type, "float");
                                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int")) 
                                                                        (yyval.symAttrib).floatNum = (yyvsp[-2].symAttrib).floatNum / (yyvsp[0].symAttrib).num;
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                        (yyval.symAttrib).floatNum = (yyvsp[-2].symAttrib).floatNum / (yyvsp[0].symAttrib).floatNum;
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char"))
                                                                        (yyval.symAttrib).floatNum = (yyvsp[-2].symAttrib).floatNum / (yyvsp[0].symAttrib).charlit;
                                                                }
                                                                else if(!strcmp((yyvsp[-2].symAttrib).type, "char")) {
                                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int")) {
                                                                        strcpy((yyval.symAttrib).type, "int");
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit / (yyvsp[0].symAttrib).num;
                                                                    }
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float")) {
                                                                        strcpy((yyval.symAttrib).type, "float");
                                                                        (yyval.symAttrib).floatNum = (yyvsp[-2].symAttrib).charlit / (yyvsp[0].symAttrib).floatNum;
                                                                    }
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char")) {
                                                                        strcpy((yyval.symAttrib).type, "char");
                                                                        (yyval.symAttrib).charlit = (yyvsp[-2].symAttrib).charlit / (yyvsp[0].symAttrib).charlit;
                                                                    }
                                                                }
                                                            }
#line 2164 "y.tab.c" /* yacc.c:1646  */
    break;

  case 82:
#line 653 "main.y" /* yacc.c:1646  */
    {
                                                                strcpy((yyval.symAttrib).type, "int");
                                                                strcpy((yyval.symAttrib).val,newTempVar());
                                                                sprintf(code,"%s = (%s % %s)\n",(yyval.symAttrib).val,(yyvsp[-2].symAttrib).val,(yyvsp[0].symAttrib).val);
                                                                addthreeAddrCode(code);
                                                                
                                                                if(!strcmp((yyvsp[-2].symAttrib).type, "float") || !strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                    modOperandsTypeError((yyvsp[-2].symAttrib).type, (yyvsp[0].symAttrib).type, yylineno);
                                                                else if(!strcmp((yyvsp[-2].symAttrib).type, "string_literal") || !strcmp((yyvsp[0].symAttrib).type, "string_literal"))
                                                                    modOperandsTypeError((yyvsp[-2].symAttrib).type, (yyvsp[0].symAttrib).type, yylineno);
                                                                    
                                                                else if(!strcmp((yyvsp[-2].symAttrib).type, "int")) {
                                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int")) {
                                                                        strcpy((yyval.symAttrib).type, "int");
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num % (yyvsp[0].symAttrib).num;
                                                                    }
                                                                    else if(!strcmp((yyvsp[-2].symAttrib).type, "char")) {
                                                                        strcpy((yyval.symAttrib).type, "int");
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num % (yyvsp[0].symAttrib).charlit;
                                                                    }
                                                                }
                                                                else if(!strcmp((yyvsp[-2].symAttrib).type, "char")) {
                                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int")) {
                                                                        strcpy((yyval.symAttrib).type, "char");
                                                                        (yyval.symAttrib).charlit = (yyvsp[-2].symAttrib).charlit % (yyvsp[0].symAttrib).num;
                                                                    }
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char")) {
                                                                        strcpy((yyval.symAttrib).type, "char");
                                                                        (yyval.symAttrib).charlit = (yyvsp[-2].symAttrib).charlit % (yyvsp[0].symAttrib).charlit;
                                                                    }
                                                                }
                                                            
                                                            }
#line 2202 "y.tab.c" /* yacc.c:1646  */
    break;

  case 83:
#line 690 "main.y" /* yacc.c:1646  */
    {   
                                                                strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type);
                                                                strcpy((yyval.symAttrib).val,(yyvsp[0].symAttrib).val);
                                                                if(!strcmp((yyvsp[0].symAttrib).type, "int"))
                                                                    (yyval.symAttrib).num = (yyvsp[0].symAttrib).num;
                                                                else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                    (yyval.symAttrib).floatNum = (yyvsp[0].symAttrib).floatNum;
                                                                else if(!strcmp((yyvsp[0].symAttrib).type, "char"))
                                                                    (yyval.symAttrib).charlit = (yyvsp[0].symAttrib).charlit;
                                                                else if(!strcmp((yyvsp[0].symAttrib).type, "string_literal"))
                                                                    exprInvalidError((yyvsp[0].symAttrib).type, yylineno);
                                                            }
#line 2219 "y.tab.c" /* yacc.c:1646  */
    break;

  case 84:
#line 704 "main.y" /* yacc.c:1646  */
    {   if(!strcmp((yyvsp[-2].symAttrib).type, "string_literal") || !strcmp((yyvsp[0].symAttrib).type, "string_literal")) 
                                                                    addOperandsTypeError((yyvsp[-2].symAttrib).type, (yyvsp[0].symAttrib).type, yylineno);
                                                                
                                                                strcpy((yyval.symAttrib).type, "int");
                                                                strcpy((yyval.symAttrib).val,newTempVar());
                                                                sprintf(code,"%s = %s + %s\n",(yyval.symAttrib).val,(yyvsp[-2].symAttrib).val,(yyvsp[0].symAttrib).val);
                                                                addthreeAddrCode(code);
                                                                if(!strcmp((yyvsp[-2].symAttrib).type, "int")) {
                                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int")) {
                                                                        strcpy((yyval.symAttrib).type, "int");
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num + (yyvsp[0].symAttrib).num;
                                                                    }
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char")) {
                                                                        strcpy((yyval.symAttrib).type, "int");
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num + (yyvsp[0].symAttrib).charlit;
                                                                    }
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float")) {
                                                                        strcpy((yyval.symAttrib).type, "float");
                                                                        (yyval.symAttrib).floatNum = (yyvsp[-2].symAttrib).num + (yyvsp[0].symAttrib).floatNum;
                                                                    }
                                                                }
                                                                else if(!strcmp((yyvsp[-2].symAttrib).type, "float")) {
                                                                    strcpy((yyval.symAttrib).type, "float");
                                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int")) 
                                                                        (yyval.symAttrib).floatNum = (yyvsp[-2].symAttrib).floatNum + (yyvsp[0].symAttrib).num;
                                                            
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float")) 
                                                                        (yyval.symAttrib).floatNum = (yyvsp[-2].symAttrib).floatNum + (yyvsp[0].symAttrib).floatNum;
                                                                    
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char"))
                                                                        (yyval.symAttrib).floatNum = (yyvsp[-2].symAttrib).floatNum + (yyvsp[0].symAttrib).charlit;
                                                                    
                                                                }
                                                                else if(!strcmp((yyvsp[-2].symAttrib).type, "char")) {
                                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int")) {
                                                                        strcpy((yyval.symAttrib).type, "int");
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit + (yyvsp[0].symAttrib).num;
                                                                    }
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char")) {
                                                                        strcpy((yyval.symAttrib).type, "char");
                                                                        (yyval.symAttrib).charlit = (yyvsp[-2].symAttrib).charlit + (yyvsp[0].symAttrib).charlit;
                                                                    }
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float")) {
                                                                        strcpy((yyval.symAttrib).type, "float");
                                                                        (yyval.symAttrib).floatNum = (yyvsp[-2].symAttrib).charlit + (yyvsp[0].symAttrib).floatNum;
                                                                    }
                                                                }
                                                            }
#line 2272 "y.tab.c" /* yacc.c:1646  */
    break;

  case 85:
#line 753 "main.y" /* yacc.c:1646  */
    {
                                                              if(!strcmp((yyvsp[-2].symAttrib).type, "string_literal") || !strcmp((yyvsp[0].symAttrib).type, "string_literal")) 
                                                                    subOperandsTypeError((yyvsp[-2].symAttrib).type, (yyvsp[0].symAttrib).type, yylineno);
                                                                
                                                                strcpy((yyval.symAttrib).type, "int");
                                                                strcpy((yyval.symAttrib).val,newTempVar());
                                                                sprintf(code,"%s = %s - %s\n",(yyval.symAttrib).val,(yyvsp[-2].symAttrib).val,(yyvsp[0].symAttrib).val);
                                                                addthreeAddrCode(code);
                                                                if(!strcmp((yyvsp[-2].symAttrib).type, "int")) {
                                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int")) {
                                                                        strcpy((yyval.symAttrib).type, "int");
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num - (yyvsp[0].symAttrib).num;
                                                                    }
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char")) {
                                                                        strcpy((yyval.symAttrib).type, "int");
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num - (yyvsp[0].symAttrib).charlit;
                                                                    }
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float")) {
                                                                        strcpy((yyval.symAttrib).type, "float");
                                                                        (yyval.symAttrib).floatNum = (yyvsp[-2].symAttrib).num - (yyvsp[0].symAttrib).floatNum;
                                                                    }
                                                                }
                                                                else if(!strcmp((yyvsp[-2].symAttrib).type, "float")) {
                                                                    strcpy((yyval.symAttrib).type, "float");
                                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int")) 
                                                                        (yyval.symAttrib).floatNum = (yyvsp[-2].symAttrib).floatNum - (yyvsp[0].symAttrib).num;
                                                            
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float")) 
                                                                        (yyval.symAttrib).floatNum = (yyvsp[-2].symAttrib).floatNum - (yyvsp[0].symAttrib).floatNum;
                                                                    
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char"))
                                                                        (yyval.symAttrib).floatNum = (yyvsp[-2].symAttrib).floatNum - (yyvsp[0].symAttrib).charlit;
                                                                    
                                                                }
                                                                else if(!strcmp((yyvsp[-2].symAttrib).type, "char")) {
                                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int")) {
                                                                        strcpy((yyval.symAttrib).type, "int");
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit - (yyvsp[0].symAttrib).num;
                                                                    }
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char")) {
                                                                        strcpy((yyval.symAttrib).type, "char");
                                                                        (yyval.symAttrib).charlit = (yyvsp[-2].symAttrib).charlit - (yyvsp[0].symAttrib).charlit;
                                                                    }
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float")) {
                                                                        strcpy((yyval.symAttrib).type, "float");
                                                                        (yyval.symAttrib).floatNum = (yyvsp[-2].symAttrib).charlit - (yyvsp[0].symAttrib).floatNum;
                                                                    }
                                                                }
                                                            }
#line 2326 "y.tab.c" /* yacc.c:1646  */
    break;

  case 86:
#line 806 "main.y" /* yacc.c:1646  */
    {
                                                                    strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type);
                                                                    strcpy((yyval.symAttrib).val,(yyvsp[0].symAttrib).val);
                                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int"))
                                                                        (yyval.symAttrib).num = (yyvsp[0].symAttrib).num;
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                        (yyval.symAttrib).floatNum = (yyvsp[0].symAttrib).floatNum;
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char"))
                                                                        (yyval.symAttrib).charlit = (yyvsp[0].symAttrib).charlit;
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "string_literal"))
                                                                        exprInvalidError((yyvsp[0].symAttrib).type, yylineno);
                                                                }
#line 2343 "y.tab.c" /* yacc.c:1646  */
    break;

  case 87:
#line 818 "main.y" /* yacc.c:1646  */
    { 
                                                                    if(!strcmp((yyvsp[-2].symAttrib).type, "string_literal") || !strcmp((yyvsp[0].symAttrib).type, "string_literal"))
                                                                        relOperandsTypeError((yyvsp[-2].symAttrib).type, (yyvsp[0].symAttrib).type, yylineno);

                                                                    strcpy((yyval.symAttrib).type, "int");
                                                                    strcpy((yyval.symAttrib).val,newTempVar());
                                                                    sprintf(code,"%s = (%s < %s)\n",(yyval.symAttrib).val,(yyvsp[-2].symAttrib).val,(yyvsp[0].symAttrib).val);
                                                                    addthreeAddrCode(code);
                                                                    if(!strcmp((yyvsp[-2].symAttrib).type, "int")) {
                                                                        if(!strcmp((yyvsp[0].symAttrib).type, "int")) 
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num < (yyvsp[0].symAttrib).num;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "char"))
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num < (yyvsp[0].symAttrib).charlit;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num < (yyvsp[0].symAttrib).floatNum;
                                                                    }
                                                                    else if(!strcmp((yyvsp[-2].symAttrib).type, "float")) {
                                                                        if(!strcmp((yyvsp[0].symAttrib).type, "int"))
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum < (yyvsp[0].symAttrib).num;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum < (yyvsp[0].symAttrib).floatNum;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "char")) 
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum < (yyvsp[0].symAttrib).charlit;
                                                                    }
                                                                    else if(!strcmp((yyvsp[-2].symAttrib).type, "char")) {
                                                                        if(!strcmp((yyvsp[0].symAttrib).type, "int")) 
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit < (yyvsp[0].symAttrib).num;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit < (yyvsp[0].symAttrib).floatNum;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "char")) 
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit < (yyvsp[0].symAttrib).charlit;
                                                                    }
                                                                }
#line 2381 "y.tab.c" /* yacc.c:1646  */
    break;

  case 88:
#line 852 "main.y" /* yacc.c:1646  */
    {
                                                                    if(!strcmp((yyvsp[-2].symAttrib).type, "string_literal") || !strcmp((yyvsp[0].symAttrib).type, "string_literal"))
                                                                        relOperandsTypeError((yyvsp[-2].symAttrib).type, (yyvsp[0].symAttrib).type, yylineno);

                                                                    strcpy((yyval.symAttrib).type, "int");
                                                                    strcpy((yyval.symAttrib).val,newTempVar());
                                                                    sprintf(code,"%s = (%s > %s)\n",(yyval.symAttrib).val,(yyvsp[-2].symAttrib).val,(yyvsp[0].symAttrib).val);
                                                                    addthreeAddrCode(code);
                                                                    if(!strcmp((yyvsp[-2].symAttrib).type, "int")) {
                                                                        if(!strcmp((yyvsp[0].symAttrib).type, "int")) 
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num > (yyvsp[0].symAttrib).num;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "char"))
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num > (yyvsp[0].symAttrib).charlit;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num > (yyvsp[0].symAttrib).floatNum;
                                                                    }
                                                                    else if(!strcmp((yyvsp[-2].symAttrib).type, "float")) {
                                                                        if(!strcmp((yyvsp[0].symAttrib).type, "int"))
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum > (yyvsp[0].symAttrib).num;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum > (yyvsp[0].symAttrib).floatNum;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "char")) 
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum > (yyvsp[0].symAttrib).charlit;
                                                                    }
                                                                    else if(!strcmp((yyvsp[-2].symAttrib).type, "char")) {
                                                                        if(!strcmp((yyvsp[0].symAttrib).type, "int")) 
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit > (yyvsp[0].symAttrib).num;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit > (yyvsp[0].symAttrib).floatNum;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "char")) 
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit > (yyvsp[0].symAttrib).charlit;
                                                                    }
                                                                }
#line 2419 "y.tab.c" /* yacc.c:1646  */
    break;

  case 89:
#line 887 "main.y" /* yacc.c:1646  */
    {
                                                                   if(!strcmp((yyvsp[-2].symAttrib).type, "string_literal") || !strcmp((yyvsp[0].symAttrib).type, "string_literal"))
                                                                        relOperandsTypeError((yyvsp[-2].symAttrib).type, (yyvsp[0].symAttrib).type, yylineno);

                                                                    strcpy((yyval.symAttrib).type, "int");
                                                                    strcpy((yyval.symAttrib).val,newTempVar());
                                                                    sprintf(code,"%s = (%s <= %s)\n",(yyval.symAttrib).val,(yyvsp[-2].symAttrib).val,(yyvsp[0].symAttrib).val);
                                                                    addthreeAddrCode(code);
                                                                    if(!strcmp((yyvsp[-2].symAttrib).type, "int")) {
                                                                        if(!strcmp((yyvsp[0].symAttrib).type, "int")) 
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num <= (yyvsp[0].symAttrib).num;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "char"))
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num <= (yyvsp[0].symAttrib).charlit;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num <= (yyvsp[0].symAttrib).floatNum;
                                                                    }
                                                                    else if(!strcmp((yyvsp[-2].symAttrib).type, "float")) {
                                                                        if(!strcmp((yyvsp[0].symAttrib).type, "int"))
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum <= (yyvsp[0].symAttrib).num;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum <= (yyvsp[0].symAttrib).floatNum;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "char")) 
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum <= (yyvsp[0].symAttrib).charlit;
                                                                    }
                                                                    else if(!strcmp((yyvsp[-2].symAttrib).type, "char")) {
                                                                        if(!strcmp((yyvsp[0].symAttrib).type, "int")) 
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit <= (yyvsp[0].symAttrib).num;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit <= (yyvsp[0].symAttrib).floatNum;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "char")) 
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit <= (yyvsp[0].symAttrib).charlit;
                                                                    }
                                                                }
#line 2457 "y.tab.c" /* yacc.c:1646  */
    break;

  case 90:
#line 921 "main.y" /* yacc.c:1646  */
    {
                                                                    if(!strcmp((yyvsp[-2].symAttrib).type, "string_literal") || !strcmp((yyvsp[0].symAttrib).type, "string_literal"))
                                                                        relOperandsTypeError((yyvsp[-2].symAttrib).type, (yyvsp[0].symAttrib).type, yylineno);

                                                                    strcpy((yyval.symAttrib).type, "int");
                                                                    strcpy((yyval.symAttrib).val,newTempVar());
                                                                    sprintf(code,"%s = (%s >= %s)\n",(yyval.symAttrib).val,(yyvsp[-2].symAttrib).val,(yyvsp[0].symAttrib).val);
                                                                    addthreeAddrCode(code);
                                                                    if(!strcmp((yyvsp[-2].symAttrib).type, "int")) {
                                                                        if(!strcmp((yyvsp[0].symAttrib).type, "int")) 
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num >= (yyvsp[0].symAttrib).num;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "char"))
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num >= (yyvsp[0].symAttrib).charlit;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num >= (yyvsp[0].symAttrib).floatNum;
                                                                    }
                                                                    else if(!strcmp((yyvsp[-2].symAttrib).type, "float")) {
                                                                        if(!strcmp((yyvsp[0].symAttrib).type, "int"))
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum >= (yyvsp[0].symAttrib).num;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum >= (yyvsp[0].symAttrib).floatNum;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "char")) 
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum >= (yyvsp[0].symAttrib).charlit;
                                                                    }
                                                                    else if(!strcmp((yyvsp[-2].symAttrib).type, "char")) {
                                                                        if(!strcmp((yyvsp[0].symAttrib).type, "int")) 
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit >= (yyvsp[0].symAttrib).num;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit >= (yyvsp[0].symAttrib).floatNum;
                                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "char")) 
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit >= (yyvsp[0].symAttrib).charlit;
                                                                    }
                                                                }
#line 2495 "y.tab.c" /* yacc.c:1646  */
    break;

  case 91:
#line 958 "main.y" /* yacc.c:1646  */
    {
                                                                strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type);
                                                                strcpy((yyval.symAttrib).val,(yyvsp[0].symAttrib).val);
                                                                if(!strcmp((yyvsp[0].symAttrib).type, "int"))
                                                                    (yyval.symAttrib).num = (yyvsp[0].symAttrib).num;
                                                                else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                    (yyval.symAttrib).floatNum = (yyvsp[0].symAttrib).floatNum;
                                                                else if(!strcmp((yyvsp[0].symAttrib).type, "char"))
                                                                    (yyval.symAttrib).charlit = (yyvsp[0].symAttrib).charlit;
                                                                else if(!strcmp((yyvsp[0].symAttrib).type, "string_literal"))
                                                                    exprInvalidError((yyvsp[0].symAttrib).type, yylineno);
                                                            }
#line 2512 "y.tab.c" /* yacc.c:1646  */
    break;

  case 92:
#line 971 "main.y" /* yacc.c:1646  */
    {
                                                                if(!strcmp((yyvsp[-2].symAttrib).type, "string_literal") || !strcmp((yyvsp[0].symAttrib).type, "string_literal"))
                                                                    relOperandsTypeError((yyvsp[-2].symAttrib).type, (yyvsp[0].symAttrib).type, yylineno);
                                                                
                                                                strcpy((yyval.symAttrib).type, "int");
                                                                strcpy((yyval.symAttrib).val,newTempVar());
                                                                sprintf(code,"%s = (%s == %s)\n",(yyval.symAttrib).val,(yyvsp[-2].symAttrib).val,(yyvsp[0].symAttrib).val);
                                                                addthreeAddrCode(code);
                                                                if(!strcmp((yyvsp[-2].symAttrib).type, "int")) {
                                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int")) 
                                                                        {
                                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num == (yyvsp[0].symAttrib).num;
                                                                        }
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char"))
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num == (yyvsp[0].symAttrib).charlit;
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num == (yyvsp[0].symAttrib).floatNum;
                                                                }
                                                                else if(!strcmp((yyvsp[-2].symAttrib).type, "float")) {
                                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int"))
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum == (yyvsp[0].symAttrib).num;
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum == (yyvsp[0].symAttrib).floatNum;
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char")) 
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum == (yyvsp[0].symAttrib).charlit;
                                                                }
                                                                else if(!strcmp((yyvsp[-2].symAttrib).type, "char")) {
                                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int")) 
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit == (yyvsp[0].symAttrib).num;
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit == (yyvsp[0].symAttrib).floatNum;
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char")) 
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit == (yyvsp[0].symAttrib).charlit;
                                                                }
                                                            }
#line 2552 "y.tab.c" /* yacc.c:1646  */
    break;

  case 93:
#line 1007 "main.y" /* yacc.c:1646  */
    {
                                                                if(!strcmp((yyvsp[-2].symAttrib).type, "string_literal") || !strcmp((yyvsp[0].symAttrib).type, "string_literal"))
                                                                relOperandsTypeError((yyvsp[-2].symAttrib).type, (yyvsp[0].symAttrib).type, yylineno);
                                                                
                                                                strcpy((yyval.symAttrib).type, "int");
                                                                strcpy((yyval.symAttrib).val,newTempVar());
                                                                sprintf(code,"%s = (%s != %s)\n",(yyval.symAttrib).val,(yyvsp[-2].symAttrib).val,(yyvsp[0].symAttrib).val);
                                                                addthreeAddrCode(code);
                                                                if(!strcmp((yyvsp[-2].symAttrib).type, "int")) {
                                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int")) 
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num != (yyvsp[0].symAttrib).num;
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char"))
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num != (yyvsp[0].symAttrib).charlit;
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num != (yyvsp[0].symAttrib).floatNum;
                                                                }
                                                                else if(!strcmp((yyvsp[-2].symAttrib).type, "float")) {
                                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int"))
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum != (yyvsp[0].symAttrib).num;
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum != (yyvsp[0].symAttrib).floatNum;
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char")) 
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum != (yyvsp[0].symAttrib).charlit;
                                                                }
                                                                else if(!strcmp((yyvsp[-2].symAttrib).type, "char")) {
                                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int")) 
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit != (yyvsp[0].symAttrib).num;
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit != (yyvsp[0].symAttrib).floatNum;
                                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char")) 
                                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit != (yyvsp[0].symAttrib).charlit;
                                                                }
                                                            }
#line 2590 "y.tab.c" /* yacc.c:1646  */
    break;

  case 94:
#line 1044 "main.y" /* yacc.c:1646  */
    {   
                                                    strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type);
                                                    strcpy((yyval.symAttrib).val,(yyvsp[0].symAttrib).val);
                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int"))
                                                        (yyval.symAttrib).num = (yyvsp[0].symAttrib).num;
                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                        (yyval.symAttrib).floatNum = (yyvsp[0].symAttrib).floatNum;
                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char"))
                                                        (yyval.symAttrib).charlit = (yyvsp[0].symAttrib).charlit;
                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "string_literal"))
                                                        exprInvalidError((yyvsp[0].symAttrib).type, yylineno);
                                                }
#line 2607 "y.tab.c" /* yacc.c:1646  */
    break;

  case 95:
#line 1057 "main.y" /* yacc.c:1646  */
    {   
                                                    strcpy((yyval.symAttrib).val, (yyvsp[-2].symAttrib).val);
                                                    strcpy((yyval.symAttrib).val,newTempVar());
                                                    sprintf(code,"%s = %s & %s\n",(yyval.symAttrib).val,(yyvsp[-2].symAttrib).val,(yyvsp[0].symAttrib).val);
                                                    addthreeAddrCode(code);
                                                    if((!strcmp((yyvsp[-2].symAttrib).type, "int") && !strcmp((yyvsp[0].symAttrib).type, "int"))){
                                                        strcpy((yyval.symAttrib).type, (yyvsp[-2].symAttrib).type);
                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num & (yyvsp[0].symAttrib).num;                                                
                                                    } 
                                                    else if(!strcmp((yyvsp[-2].symAttrib).type, "char") && !strcmp((yyvsp[0].symAttrib).type, "char")) {
                                                        strcpy((yyval.symAttrib).type, (yyvsp[-2].symAttrib).type);
                                                        (yyval.symAttrib).charlit = (yyvsp[-2].symAttrib).charlit & (yyvsp[0].symAttrib).charlit;
                                                    }
                                                    else if(!strcmp((yyvsp[-2].symAttrib).type, "int") && !strcmp((yyvsp[0].symAttrib).type, "char")) {
                                                        strcpy((yyval.symAttrib).type, "int");
                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num & (yyvsp[0].symAttrib).charlit;
                                                    }
                                                    else if(!strcmp((yyvsp[-2].symAttrib).type, "char") && !strcmp((yyvsp[0].symAttrib).type, "int")) {
                                                        strcpy((yyval.symAttrib).type, "char");
                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit & (yyvsp[0].symAttrib).num;
                                                    }
                                                    else 
                                                      bwAndOperandsTypeError((yyvsp[-2].symAttrib).type, (yyvsp[0].symAttrib).type, yylineno);
                                                }
#line 2636 "y.tab.c" /* yacc.c:1646  */
    break;

  case 96:
#line 1085 "main.y" /* yacc.c:1646  */
    {   
                                                    strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type);
                                                    strcpy((yyval.symAttrib).val, (yyvsp[0].symAttrib).val);
                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int"))
                                                        (yyval.symAttrib).num = (yyvsp[0].symAttrib).num;
                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                        (yyval.symAttrib).floatNum = (yyvsp[0].symAttrib).floatNum;
                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char"))
                                                        (yyval.symAttrib).charlit = (yyvsp[0].symAttrib).charlit;   
                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "string_literal"))
                                                        exprInvalidError((yyvsp[0].symAttrib).type, yylineno);                                          
                                                }
#line 2653 "y.tab.c" /* yacc.c:1646  */
    break;

  case 97:
#line 1098 "main.y" /* yacc.c:1646  */
    {   
                                                    strcpy((yyval.symAttrib).type, "int");
                                                    strcpy((yyval.symAttrib).val,newTempVar());
                                                    sprintf(code,"%s = %s ^ %s\n",(yyval.symAttrib).val,(yyvsp[-2].symAttrib).val,(yyvsp[0].symAttrib).val);
                                                    addthreeAddrCode(code);
                                                    if((!strcmp((yyvsp[-2].symAttrib).type, "int") && !strcmp((yyvsp[0].symAttrib).type, "int"))){
                                                        strcpy((yyval.symAttrib).type, (yyvsp[-2].symAttrib).type);
                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num ^ (yyvsp[0].symAttrib).num;                                                
                                                    } 
                                                    else if(!strcmp((yyvsp[-2].symAttrib).type, "char") && !strcmp((yyvsp[0].symAttrib).type, "char")) {
                                                        strcpy((yyval.symAttrib).type, (yyvsp[-2].symAttrib).type);
                                                        (yyval.symAttrib).charlit = (yyvsp[-2].symAttrib).charlit ^ (yyvsp[0].symAttrib).charlit;
                                                    }
                                                    else if(!strcmp((yyvsp[-2].symAttrib).type, "int") && !strcmp((yyvsp[0].symAttrib).type, "char")) {
                                                        strcpy((yyval.symAttrib).type, "int");
                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num ^ (yyvsp[0].symAttrib).charlit;
                                                    }
                                                    else if(!strcmp((yyvsp[-2].symAttrib).type, "char") && !strcmp((yyvsp[0].symAttrib).type, "int")) {
                                                        strcpy((yyval.symAttrib).type, "char");
                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit ^ (yyvsp[0].symAttrib).num;
                                                    }
                                                    else 
                                                      bwAndOperandsTypeError((yyvsp[-2].symAttrib).type, (yyvsp[0].symAttrib).type, yylineno);
                                                
                                                }
#line 2683 "y.tab.c" /* yacc.c:1646  */
    break;

  case 98:
#line 1127 "main.y" /* yacc.c:1646  */
    {
                                                    strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type);
                                                    strcpy((yyval.symAttrib).val,(yyvsp[0].symAttrib).val);
                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int"))
                                                        (yyval.symAttrib).num = (yyvsp[0].symAttrib).num;
                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                        (yyval.symAttrib).floatNum = (yyvsp[0].symAttrib).floatNum;
                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char"))
                                                        (yyval.symAttrib).charlit = (yyvsp[0].symAttrib).charlit;   
                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "string_literal"))
                                                        exprInvalidError((yyvsp[0].symAttrib).type, yylineno);
                                                }
#line 2700 "y.tab.c" /* yacc.c:1646  */
    break;

  case 99:
#line 1140 "main.y" /* yacc.c:1646  */
    { 
                                                    strcpy((yyval.symAttrib).type, "int");
                                                    strcpy((yyval.symAttrib).val,newTempVar());
                                                    sprintf(code,"%s = %s | %s\n",(yyval.symAttrib).val,(yyvsp[-2].symAttrib).val,(yyvsp[0].symAttrib).val);
                                                    addthreeAddrCode(code);
                                                    if((!strcmp((yyvsp[-2].symAttrib).type, "int") && !strcmp((yyvsp[0].symAttrib).type, "int"))){
                                                        strcpy((yyval.symAttrib).type, (yyvsp[-2].symAttrib).type);
                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num ^ (yyvsp[0].symAttrib).num;                                                
                                                    } 
                                                    else if(!strcmp((yyvsp[-2].symAttrib).type, "char") && !strcmp((yyvsp[0].symAttrib).type, "char")) {
                                                        strcpy((yyval.symAttrib).type, (yyvsp[-2].symAttrib).type);
                                                        (yyval.symAttrib).charlit = (yyvsp[-2].symAttrib).charlit ^ (yyvsp[0].symAttrib).charlit;
                                                    }
                                                    else if(!strcmp((yyvsp[-2].symAttrib).type, "int") && !strcmp((yyvsp[0].symAttrib).type, "char")) {
                                                        strcpy((yyval.symAttrib).type, "int");
                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num ^ (yyvsp[0].symAttrib).charlit;
                                                    }
                                                    else if(!strcmp((yyvsp[-2].symAttrib).type, "char") && !strcmp((yyvsp[0].symAttrib).type, "int")) {
                                                        strcpy((yyval.symAttrib).type, "char");
                                                        (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit ^ (yyvsp[0].symAttrib).num;
                                                    }
                                                    else 
                                                      bwAndOperandsTypeError((yyvsp[-2].symAttrib).type, (yyvsp[0].symAttrib).type, yylineno);
                                                }
#line 2729 "y.tab.c" /* yacc.c:1646  */
    break;

  case 100:
#line 1169 "main.y" /* yacc.c:1646  */
    {
                                                    strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type);
                                                    strcpy((yyval.symAttrib).val,(yyvsp[0].symAttrib).val);
                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int"))
                                                        (yyval.symAttrib).num = (yyvsp[0].symAttrib).num;
                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                        (yyval.symAttrib).floatNum = (yyvsp[0].symAttrib).floatNum;
                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char"))
                                                        (yyval.symAttrib).charlit = (yyvsp[0].symAttrib).charlit;  
                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "string_literal"))
                                                        exprInvalidError((yyvsp[0].symAttrib).type, yylineno); 
                                                    
                                                }
#line 2747 "y.tab.c" /* yacc.c:1646  */
    break;

  case 101:
#line 1183 "main.y" /* yacc.c:1646  */
    { if(!strcmp((yyvsp[-2].symAttrib).type, "string_literal") || !strcmp((yyvsp[0].symAttrib).type, "string_literal"))
                                                    logOperandsTypeError((yyvsp[-2].symAttrib).type, (yyvsp[0].symAttrib).type, yylineno);

                                                    strcpy((yyval.symAttrib).type, "int");
                                                    strcpy((yyval.symAttrib).val,newTempVar());
                                                    sprintf(code,"%s = %s && %s\n",(yyval.symAttrib).val,(yyvsp[-2].symAttrib).val,(yyvsp[0].symAttrib).val);
                                                    addthreeAddrCode(code);
                                                    if(!strcmp((yyvsp[-2].symAttrib).type, "int")) {
                                                        if(!strcmp((yyvsp[0].symAttrib).type, "int")) 
                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num && (yyvsp[0].symAttrib).num;
                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "char"))
                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num && (yyvsp[0].symAttrib).charlit;
                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num && (yyvsp[0].symAttrib).floatNum;
                                                    }
                                                    else if(!strcmp((yyvsp[-2].symAttrib).type, "float")) {
                                                        if(!strcmp((yyvsp[0].symAttrib).type, "int"))
                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum && (yyvsp[0].symAttrib).num;
                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum && (yyvsp[0].symAttrib).floatNum;
                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "char")) 
                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum && (yyvsp[0].symAttrib).charlit;
                                                    }
                                                    else if(!strcmp((yyvsp[-2].symAttrib).type, "char")) {
                                                        if(!strcmp((yyvsp[0].symAttrib).type, "int")) 
                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit && (yyvsp[0].symAttrib).num;
                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit && (yyvsp[0].symAttrib).floatNum;
                                                        else if(!strcmp((yyvsp[0].symAttrib).type, "char")) 
                                                            (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit && (yyvsp[0].symAttrib).charlit;
                                                    }
                                                }
#line 2784 "y.tab.c" /* yacc.c:1646  */
    break;

  case 102:
#line 1219 "main.y" /* yacc.c:1646  */
    {   
                                                    strcpy((yyval.symAttrib).type, (yyvsp[0].symAttrib).type);
                                                    strcpy((yyval.symAttrib).val,(yyvsp[0].symAttrib).val);
                                                    if(!strcmp((yyvsp[0].symAttrib).type, "int"))
                                                        (yyval.symAttrib).num = (yyvsp[0].symAttrib).num;
                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                        (yyval.symAttrib).floatNum = (yyvsp[0].symAttrib).floatNum;
                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "char"))
                                                        (yyval.symAttrib).charlit = (yyvsp[0].symAttrib).charlit; 
                                                    else if(!strcmp((yyvsp[0].symAttrib).type, "string_literal"))
                                                        exprInvalidError((yyvsp[0].symAttrib).type, yylineno);
                                                }
#line 2801 "y.tab.c" /* yacc.c:1646  */
    break;

  case 103:
#line 1232 "main.y" /* yacc.c:1646  */
    {
                                                        if(!strcmp((yyvsp[-2].symAttrib).type, "string_literal") || !strcmp((yyvsp[0].symAttrib).type, "string_literal"))
                                                        logOperandsTypeError((yyvsp[-2].symAttrib).type, (yyvsp[0].symAttrib).type, yylineno);
                                                        strcpy((yyval.symAttrib).type, "int");
                                                        strcpy((yyval.symAttrib).val,newTempVar());
                                                        sprintf(code,"%s = %s || %s\n",(yyval.symAttrib).val,(yyvsp[-2].symAttrib).val,(yyvsp[0].symAttrib).val);
                                                        addthreeAddrCode(code);
                                                        if(!strcmp((yyvsp[-2].symAttrib).type, "int")) {
                                                            if(!strcmp((yyvsp[0].symAttrib).type, "int")) 
                                                                (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num || (yyvsp[0].symAttrib).num;
                                                            else if(!strcmp((yyvsp[0].symAttrib).type, "char"))
                                                                (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num || (yyvsp[0].symAttrib).charlit;
                                                            else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                (yyval.symAttrib).num = (yyvsp[-2].symAttrib).num || (yyvsp[0].symAttrib).floatNum;
                                                        }
                                                        else if(!strcmp((yyvsp[-2].symAttrib).type, "float")) {
                                                            if(!strcmp((yyvsp[0].symAttrib).type, "int"))
                                                                (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum || (yyvsp[0].symAttrib).num;
                                                            else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum || (yyvsp[0].symAttrib).floatNum;
                                                            else if(!strcmp((yyvsp[0].symAttrib).type, "char")) 
                                                                (yyval.symAttrib).num = (yyvsp[-2].symAttrib).floatNum || (yyvsp[0].symAttrib).charlit;
                                                        }
                                                        else if(!strcmp((yyvsp[-2].symAttrib).type, "char")) {
                                                            if(!strcmp((yyvsp[0].symAttrib).type, "int")) 
                                                                (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit || (yyvsp[0].symAttrib).num;
                                                            else if(!strcmp((yyvsp[0].symAttrib).type, "float"))
                                                                (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit || (yyvsp[0].symAttrib).floatNum;
                                                            else if(!strcmp((yyvsp[0].symAttrib).type, "char")) 
                                                                (yyval.symAttrib).num = (yyvsp[-2].symAttrib).charlit || (yyvsp[0].symAttrib).charlit;
                                                        }
                                                    }
#line 2838 "y.tab.c" /* yacc.c:1646  */
    break;


#line 2842 "y.tab.c" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;
  *++yylsp = yyloc;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }

  yyerror_range[1] = yylloc;

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval, &yylloc);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  yyerror_range[1] = yylsp[1-yylen];
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;

      yyerror_range[1] = *yylsp;
      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp, yylsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  yyerror_range[2] = yylloc;
  /* Using YYLLOC is tempting, but would change the location of
     the lookahead.  YYLOC is available though.  */
  YYLLOC_DEFAULT (yyloc, yyerror_range, 2);
  *++yylsp = yyloc;

  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval, &yylloc);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp, yylsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 1266 "main.y" /* yacc.c:1906  */

void yyerror(const char *s){
   printf("Error: %s at token %s in Line %d\n",s, yytext, yylineno );
}

extern int yylex();

void writeTACToFile(){
    threeAddressFile = fopen("threeAddressCode.txt","w");
    for(int i=0;i<threeAddrCodeLineNo;i++){
                fprintf(threeAddressFile, "%s", threeAddrCode[i]);
        }
    fclose(threeAddressFile);
}

int main()
{
    if(!yyparse()){
		if(invalid_mul_comment==1){
			printf(RED "ERROR : Invalid multi line commenting at line %d\n",start_multi);
			printf(RESET);
		}
		else if(mul_comment_flag==1){
			printf(RED "ERROR : No multi line comment ender, starts at line %d\n",yylineno);
			printf(RESET);
		}
        if(!dontPrint) {
            printf("\nParsing complete\n");
            printTables();
            writeTACToFile();
        }
        else{
            printf("\nParsing error!\n");
        }
    }
        
    else
        printf("\nParsing error!\n");
}

































