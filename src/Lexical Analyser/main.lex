%{
    #define I_INT 1
    int n_int=0,n_sInt= 0,n_lInt=0,n_llInt=0,n_float=0,n_double=0,n_pproc=0,n_comm=0;
%}
%option yylineno

%%

"#" {++n_pproc;}
"//" {++n_comm;}
"double " {++n_double;}
"float " {++n_float;}
"int " {++n_int;}
"short int " {++n_sInt;}
"long int " {++n_lInt;}
"long long int " {++n_llInt;}

%%

int yywrap(){}
int main() {
    yylex();
    printf("%d %d %d %d %d %d %d %d\n",n_int,n_sInt,n_lInt,n_llInt,n_float,n_double,n_pproc,n_comm);
    return 0;
}