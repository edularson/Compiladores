%{
#include <stdio.h>
%}
%option noyywrap

DIGITO      [0-9]
OCTETO      (25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])
IP          {OCTETO}\.{OCTETO}\.{OCTETO}\.{OCTETO}
IP_INVALIDO [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+

%%

{IP}            { printf("endereço IP certo: %s\n", yytext); }
{IP_INVALIDO}   { printf("IP n existe: %s\n", yytext); }
[ \t\n]+        { /* */ }
.               { /* */ }

%%

int main() {
    printf("digite um IP (ex: 192.168.0.1):\n");
    yylex();
    return 0;
}




