#ifndef _ERRORS_H
#define _ERRORS_H 1

// This header file has all declarations of functions called when errors occur while checking the semantics.

extern void bwOrOperandsTypeError(char *type1, char *type2, int lineno);

extern void bwXorOperandsTypeError(char *type1, char *type2, int lineno) ;

extern void bwAndOperandsTypeError(char *type1, char *type2, int lineno) ;

extern void modOperandsTypeError(char *type1, char *type2, int lineno) ;

extern void mulOperandsTypeError(char *type1, char *type2, int lineno);

extern void divOperandsTypeError(char *type1, char *type2, int lineno);

extern void addOperandsTypeError(char *type1, char *type2, int lineno);

extern void subOperandsTypeError(char *type1, char *type2, int lineno);

extern void relOperandsTypeError(char *type1, char *type2, int lineno);

extern void logOperandsTypeError(char *type1, char *type2, int lineno);

extern void assOperandsTypeError(char *type1, char *type2, int lineno);

extern void exprInvalidError(char *type, int lineno);

extern void typeMismatchError(char *type1, char *type2, int lineno);

extern void variableNotDeclaredError(char *type1,char *type2, int lineno);

extern void redeclarationError(char *type1,char *type2, int lineno);

extern void returnTypeMisMatchError(char *type1,char *type2, char * returnType, int lineno);

extern void tooLessArgumentsError(int lineno);

extern void tooManyArgumentsError(int lineno);

extern void argumentTypeMismatchError(char *type1,char *type2, int lineno);

#endif  // _ERRORS_H