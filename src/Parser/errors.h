#ifndef _ERRORS_H
#define _ERRORS_H 1

// This header file has all declarations of functions called when errors occur while checking the semantics.

extern void logOrOperandsTypeError(char *type1, char *type2, int lineno);

extern void logXorOperandsTypeError(char *type1, char *type2, int lineno) ;

extern void logAndOperandsTypeError(char *type1, char *type2, int lineno) ;

extern void modOperandsTypeError(char *type1, char *type2, int lineno) ;

extern void typeMismatchError(char *type1, char *type2, int lineno);

extern void variableNotDeclaredError(char *type1,char *type2, int lineno);

extern void redeclarationError(char *type1,char *type2, int lineno);

extern void returnTypeMisMatchError(char *type1,char *type2, char * returnType, int lineno);

#endif  // _ERRORS_H