#!/bin/bash

flex ../Lexical\ Analyser/main.l
bison -dy main.y -Wnone
gcc lex.yy.c y.tab.c tableStructure.c errors.c