%{
   int single_comm = 0, multi_comm = 0, flag_mc = 0; 
%}

%%

"//" {single_comm=1;}
"/*" {multi_comm=1;} 
"*/" {if(multi_comm==1)flag_mc=1;}
%% 

int yywrap(){}
int main(){
    yylex();
    if(single_comm==0)
        printf("\nNo single line comments found!\n");
    else
        printf("\nSingle line comments found!\n");
    if(flag_mc==0)
        printf("\nNo Multi line comments found!\n");
    else
        printf("\nMulti line comments found!\n");
    return 0;
}