#!/bin/bash

flex ../Lexical\ Analyser/main1.l
bison -dy main1.y
gcc lex.yy.c y.tab.c tableStructure.c 
