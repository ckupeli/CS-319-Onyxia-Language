%{
#include <stdio.h>
%}

%union{
  char *str; /* string value*/
}

%token <str> TRUE 
%token <str> FALSE
%token <str> CONSTANT 
%token <str> VARIABLE 
%token <str> LIST
%token <str> PREDICATE
%token INTEGER
%token MAIN
%token AND OR IMPLIES NOT
%token LP RP LBRACE RBRACE LSQUARE RSQUARE
%token IF ELSE
%token WHILE
%token RETURN OUTPUT INPUT
%token ASSIGNMENT
%token COMMA
%token NL

%left AND OR IMPLIES
%right NOT ASSIGNMENT
%%
program: main
| program main
;

main: MAIN LP RP LBRACE statement RBRACE NL
{ printf ("Input program accepted!\n"); } 
;

statement: truthValue
| assignmentStmt
| returnStmt
| predicateStmt
| ifStmt
| whileStmt
| inputStmt
| outputStmt
;

list: LIST LSQUARE RSQUARE
| LIST LSQUARE INTEGER RSQUARE
;

truthValue: trueOrFalse
| VARIABLE
| CONSTANT
| connective
| list
;

trueOrFalse: TRUE
| FALSE
;

connective: truthValue AND truthValue
| truthValue OR truthValue
| truthValue IMPLIES truthValue
| NOT truthValue
;

returnStmt: RETURN LP truthValue RP
;

predicateStmt: PREDICATE LP RP
| PREDICATE LP RP LBRACE returnStmt RBRACE
| PREDICATE LP truthValue RP
| PREDICATE LP truthValue RP LBRACE returnStmt RBRACE
;

listDeclaration: COMMA truthValue
| COMMA truthValue listDeclaration
;

assignmentStmt: VARIABLE ASSIGNMENT truthValue
| CONSTANT ASSIGNMENT truthValue
| list ASSIGNMENT truthValue
| list ASSIGNMENT LBRACE truthValue RBRACE
| list ASSIGNMENT LBRACE truthValue listDeclaration RBRACE
;

elseStmt: ELSE LBRACE truthValue RBRACE
| ELSE LBRACE assignmentStmt RBRACE
| ELSE LBRACE returnStmt RBRACE
| ELSE LBRACE predicateStmt RBRACE
| ELSE LBRACE ifStmt RBRACE
| ELSE LBRACE whileStmt RBRACE
| ELSE LBRACE inputStmt RBRACE
| ELSE LBRACE outputStmt RBRACE
;

ifStmt: IF LP truthValue RP LBRACE truthValue RBRACE
| IF LP truthValue RP LBRACE assignmentStmt RBRACE
| IF LP truthValue RP LBRACE returnStmt RBRACE
| IF LP truthValue RP LBRACE predicateStmt RBRACE
| IF LP truthValue RP LBRACE ifStmt RBRACE
| IF LP truthValue RP LBRACE whileStmt RBRACE
| IF LP truthValue RP LBRACE inputStmt RBRACE
| IF LP truthValue RP LBRACE outputStmt RBRACE
| IF LP truthValue RP LBRACE truthValue RBRACE elseStmt
| IF LP truthValue RP LBRACE assignmentStmt RBRACE elseStmt
| IF LP truthValue RP LBRACE returnStmt RBRACE elseStmt
| IF LP truthValue RP LBRACE predicateStmt RBRACE elseStmt
| IF LP truthValue RP LBRACE ifStmt RBRACE elseStmt
| IF LP truthValue RP LBRACE whileStmt RBRACE elseStmt
| IF LP truthValue RP LBRACE inputStmt RBRACE elseStmt
| IF LP truthValue RP LBRACE outputStmt RBRACE elseStmt
| IF LP truthValue RP LBRACE truthValue RBRACE ELSE ifStmt
| IF LP truthValue RP LBRACE assignmentStmt RBRACE ELSE ifStmt
| IF LP truthValue RP LBRACE returnStmt RBRACE ELSE ifStmt
| IF LP truthValue RP LBRACE predicateStmt RBRACE ELSE ifStmt
| IF LP truthValue RP LBRACE ifStmt RBRACE ELSE ifStmt
| IF LP truthValue RP LBRACE whileStmt RBRACE ELSE ifStmt
| IF LP truthValue RP LBRACE inputStmt RBRACE ELSE ifStmt
| IF LP truthValue RP LBRACE outputStmt RBRACE ELSE ifStmt
;

whileStmt: WHILE LP truthValue RP LBRACE truthValue RBRACE
| WHILE LP truthValue RP LBRACE assignmentStmt RBRACE
| WHILE LP truthValue RP LBRACE predicateStmt RBRACE
| WHILE LP truthValue RP LBRACE ifStmt RBRACE
| WHILE LP truthValue RP LBRACE whileStmt RBRACE
| WHILE LP truthValue RP LBRACE inputStmt RBRACE
| WHILE LP truthValue RP LBRACE outputStmt RBRACE
;

inputStmt: INPUT LP VARIABLE RP
| INPUT LP CONSTANT RP
;

outputStmt: OUTPUT LP truthValue RP
;

%%
#include "lex.yy.c"
int lineno;

main() {
  return yyparse();
}
int yyerror(char *s) { printf("Syntax error on line %d!\n", lineno, s);}