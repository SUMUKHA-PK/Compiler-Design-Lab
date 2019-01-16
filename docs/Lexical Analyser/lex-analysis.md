# Lexical Analyser

We use the **Flex** tool to build a lexical analyser that recognises tokens and provides error handling.
<br>

The Lexical Analyser can detect 2 types of errors: 
* No token follows given set of rules.
* Symbol that doesnt exist in the character set exists in the file.
<br>
<br>

**Pre-requisites :**
* Flex tool.
* Gcc compiler. 

**Steps to reproduce :**
* Do ```cd /src/Lexical Analyser``` to open directory.
* Run the flex script by ```flex main.l```.
* This produces a C code file ```lex.yy.c``` in the directory. 
* Run the C code produced by lex using ```cc lex.yy.c```.
* This produces an executable a.out in the directory.

**Running tests :**
* Do ```chmod +x /path/to/folder/run_tests.sh```
* Run ```./run_tests.sh``` to run all tests