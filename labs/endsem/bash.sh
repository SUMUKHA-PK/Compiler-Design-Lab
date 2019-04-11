flex main.l
bison -dy main.y
gcc lex.yy.c y.tab.c
