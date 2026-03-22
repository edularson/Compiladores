%{
#include <stdio.h>
%}
%option noyywrap

LETRA       [a-zA-Z]
DIGITO      [0-9]
ALNUM       [a-zA-Z0-9]

SCHEME      https?

ROTULO      {ALNUM}({ALNUM}|"-")*{ALNUM}|{ALNUM}
HOST        {ROTULO}("."{ROTULO})+

PORTA       ":"{DIGITO}{1,5}

SEGMENTO    [a-zA-Z0-9._~@!$&'()*+,;=%-]+
PATH        ("/"{SEGMENTO}*)+

QUERY       "?"{ALNUM}[a-zA-Z0-9=&%._+~-]*

FRAGMENT    "#"[a-zA-Z0-9._~-]+

URL         {SCHEME}"://"{HOST}{PORTA}?{PATH}?{QUERY}?{FRAGMENT}?

URL_INVALIDA {SCHEME}"://"[^ \t\n]+

%%

{URL}           {
    printf("URL certa:   %s\n", yytext);
}

{URL_INVALIDA}  {
    printf("URL n ta certa: %s\n", yytext);
}

[ \t\n]+        { /* */ }

.               { /* */ }

%%

int main() {
    printf("digite uma URL:\n\n");
    yylex();
    return 0;
}

