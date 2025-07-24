%{
#include "parser.tab.h"
#include <string.h>
%}

%option noyywrap

%%

"CREATE"        { return CREATE; }
"TABLE"         { return TABLE; }
"SELECT"        { return SELECT; }
"FROM"          { return FROM; }
"WHERE"         { return WHERE; }
"INSERT"        { return INSERT; }
"INTO"          { return INTO; }
"VALUES"        { return VALUES; }
"UPDATE"        { return UPDATE; }
"SET"           { return SET; }
"DELETE"        { return DELETE; }


[a-zA-Z_][a-zA-Z0-9_]*    { yylval.str = strdup(yytext); return IDENTIFIER; }
[0-9]+                   { yylval.str = strdup(yytext); return NUMBER; }
"'"[^']*"'"              { yylval.str = strdup(yytext); return STRING; }

"="             { return EQUAL; }
","             { return COMMA; }
";"             { return SEMICOLON; }
"("             { return LPAREN; }
")"             { return RPAREN; }
"*"             { return STAR; }


%%

