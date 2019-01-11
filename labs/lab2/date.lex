%{

    int flag=0;
    char str [11];

%}



DATE [0-9]+" "?("-"|"/")" "?[0-9]+" "?("-"|"/")" "?[0-9]+

%% 

{DATE} {flag=1; int j=0; for(int i=0;yytext[i]!='\0';i++) {if(yytext[i]!=' '){str[j]=yytext[i];j++;}}}

%%
    #include<time.h>
  

int yywrap() {}

int main() {
    yylex();
    if(flag==1) {
        printf("Valid date format found!\n");
        time_t t = time(NULL);
        struct tm tm = *localtime(&t);
        printf("now: %d-%d-%d \n", tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday);
        int day,next,mon,year;
        if(str[1]=='-'||str[1]=='/'){
            day=str[0]-'0';
            next=2;
        }
        else{
            day = (str[0]-'0')*10 + str[1]-'0';
            next=3;
        }
        if(str[next+1]=='-'||str[next+1]=='/'){
            mon = str[next]-'0';
            next=next+2;
        }
        else{
            mon = (str[next]-'0')*10 + str[next+1]-'0';
            next=next+3;
        }
        if(str[next+2]=='\0'){
            year = (str[next]-'0')*10 + str[next+1]-'0';
        }
        else{
            year = (str[next]-'0')*1000 + (str[next+1]-'0')*100 + (str[next+2]-'0')*10 + str[next+3]-'0';
        }
        if((day==tm.tm_mday)&&(mon==tm.tm_mon+1)&&(year==tm.tm_year+1900)){
            printf("Text has todays date!\n");
            printf("%d %d %d\n",day,mon,year);
        }
        else {
            printf("Text doesnt have todays date!\n");
        }
    }
    else{
        printf("No Valid date format found!\n");
    }
    return 0;
}