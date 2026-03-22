%{
#include <stdio.h>
%}

%option noyywrap

DIGITO  [0-9]
HIFEN   [-]

%%

(978|979){HIFEN}?{DIGITO}{HIFEN}?{DIGITO}{3}{HIFEN}?{DIGITO}{5}{HIFEN}?{DIGITO} {
    printf("achou o ISBN atual: %s\n", yytext); 
}

{DIGITO}{HIFEN}?{DIGITO}{3}{HIFEN}?{DIGITO}{5}{HIFEN}?[0-9X] {
    printf("achou o ISBN antigo: %s\n", yytext); 
}

[ \t\n]+    { /**/ }
.           { /**/ }

%%

int main() {
    printf("digite o ISBN (Ex: 978-3-16-148410-0):\n");
    yylex();
    return 0;
}

