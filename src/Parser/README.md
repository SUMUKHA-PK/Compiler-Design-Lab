# Parser

This directory has all parser related files. 

## How do I get the parser?

To get the parser executable, 

    $ chmod u+x run.sh
    $ ./run.sh

It will generate an executable **parseme** which will parse a given C file. 

## How do I use it?

Suppose you have a C file named **code1.c**. You can do the following to parse it. 

    $ ./parseme < code1.c 

If there are no syntax errors / lexical errors, it will print the Symbol Table and Constant Table.

If there is a Syntax error, it will point out where the error is. 