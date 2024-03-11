%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "Parser-yacc.tab.h"  // Include the yacc-generated header file
    extern YYSTYPE yylval;
    int yylex();
%}

%%
[0-9]+         { yylval.num = atoi(yytext); return NUMBER; }
[a-zA-Z]+      { yylval.str = strdup(yytext); return VARIABLE; }
[ \t\n]        ;  // Skip whitespace
[-+*()]        { return yytext[0]; }
.              { printf("Error: Invalid character %s\n", yytext); }
%%

int yywrap(void)
{
    return 1;
}
