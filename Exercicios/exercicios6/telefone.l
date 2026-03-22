%{
#include <stdio.h>
%}

DIGITO  [0-9]
DDD     \([0-9]{2}\)
ESPACO  [ ]?

%%

{DDD}{ESPACO}9{DIGITO}{4}-{DIGITO}{4}    { printf("achou o celular: %s\n", yytext); }
{DDD}{ESPACO}{DIGITO}{4}-{DIGITO}{4}     { printf("achou telegone fixo: %s\n", yytext); }
9{DIGITO}{4}-{DIGITO}{4}                 { printf("celular (sem DDD): %s\n", yytext); }
{DIGITO}{4}-{DIGITO}{4}                  { printf("fiixo (sem DDD)o: %s\n", yytext); }

.|\n    { /* */ }

%%

int yywrap() { return 1; }

int main() {
    printf("digite um num de telefone (ex: (42) 98871-5757):\n");
    yylex();
    return 0;
}


