%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Parser-yacc.tab.h"
int yylex();
%}

%union {int value; char* identifier;}
%token <value> NUMERIC
%token <identifier> VAR

%% 
expression: term additionalExpression
    ;

additionalExpression: '+' term additionalExpression { printf("+ "); }
    | '-' term additionalExpression { printf("- "); }
    | /* nothing */ { printf("\n"); }
    ;

term: factor optionalTerm
    ;

optionalTerm: '*' factor optionalTerm { printf("* "); }
    | /* nothing */ { }
    ;

factor: NUMERIC { printf("Value= %d ", $1); }
    | VAR { printf("Identifier = %s ", $1); free($1); }
    | '(' expression ')' { }
    ;
%%

int handleParsingError(const char* errorMessage) {
    fprintf(stderr, "Error: %s\n", errorMessage);
    return 1;
}

int main() {
    yyparse();  // Commence the parsing process
    return 0;
}
