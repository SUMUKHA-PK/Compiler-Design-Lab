%{
    int num_chars = 0,num_lines = 0,num_spaces = 0,num_words = 0;

%}

%%

\n {++num_lines; ++num_chars;}
" " {++num_spaces;}
"end" {++num_words; return 0;}
. {++num_chars;}
[a-zA-Z][a-zA-Z]* {++num_words; num_chars+=yyleng;}

%%

int yywrap() {}

int main() {
    yylex();
    printf("The number of characters are %d, the number of lines are %d, the number of spaces are %d and the number of words are %d. \n",num_chars,num_lines,num_spaces,num_words);
    return 0;
}