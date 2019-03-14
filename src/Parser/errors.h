#ifndef _ERRORS_H
#define _ERRORS_H 1

// This header file has all declarations of functions called when errors occur while checking the semantics.

extern void logOrOperandsTypeError(char *type1, char *type2, int lineno) {

    printf("Error in Line %d.", lineno);
    printf("There cannot be bitwise-or operation between operands of types %s and %s\n", type1, type2);
}

extern void logXorOperandsTypeError(char *type1, char *type2, int lineno) {

    printf("Error in Line %d.", lineno);
    printf("There cannot be bitwise-xor operation between operands of types %s and %s\n", type1, type2);
}

extern void logAndOperandsTypeError(char *type1, char *type2, int lineno) {

    printf("Error in Line %d.", lineno);
    printf("There cannot be bitwise-and operation between operands of types %s and %s\n", type1, type2);
}


#endif  // _ERRORS_H