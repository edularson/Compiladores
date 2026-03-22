#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

typedef enum {
    TOKEN_INT, TOKEN_REAL, TOKEN_OP, 
    TOKEN_LPAREN, TOKEN_RPAREN, TOKEN_EOF, TOKEN_ERROR
} TokenType;

typedef struct {
    TokenType type;
    char lexema[64];
} Token;

const char *input;
int pos = 0;

Token proximo_token() {
    Token t;

    while (input[pos] == ' ' || input[pos] == '\t' || input[pos] == '\n') {
        pos++;
    }

    t.lexema[0] = input[pos];
    t.lexema[1] = '\0';

    if (input[pos] == '\0') {
        t.type = TOKEN_EOF;
        return t;
    }

    if (strchr("+-*/", input[pos])) {
        t.type = TOKEN_OP;
        pos++;
        return t;
    }
    if (input[pos] == '(') {
        t.type = TOKEN_LPAREN;
        pos++;
        return t;
    }
    if (input[pos] == ')') {
        t.type = TOKEN_RPAREN;
        pos++;
        return t;
    }

    if (isdigit(input[pos])) {
        int i = 0;
        int pontos = 0;
        
        while (isdigit(input[pos]) || input[pos] == '.') {
            if (input[pos] == '.') pontos++;
            t.lexema[i++] = input[pos++];
        }
        t.lexema[i] = '\0';

        if (pontos == 0) t.type = TOKEN_INT;
        else if (pontos == 1) t.type = TOKEN_REAL;
        else t.type = TOKEN_ERROR;

        return t;
    }

    t.type = TOKEN_ERROR;
    pos++;
    return t;
}

int main() {
    char expressao[256];
    printf("digite a expressao: ");
    fgets(expressao, 256, stdin);
    input = expressao;

    printf("\ntokens encontrados:\n");
    Token t;
    do {
        t = proximo_token();
        const char *nomes[] = {"INTEIRO", "REAL", "OPERADOR", "ABRE_PAR", "FECHA_PAR", "EOF", "ERRO"};
        if (t.type != TOKEN_EOF) {
            printf("[%s] -> \"%s\"\n", nomes[t.type], t.lexema);
        }
    } while (t.type != TOKEN_EOF && t.type != TOKEN_ERROR);

    return 0;
}