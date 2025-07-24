%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern char *yytext;
extern int yylex_destroy(void);


void yyerror(const char *s);
int yylex(void);

%}

%union {
    char* str;
}

%token <str> IDENTIFIER NUMBER STRING
%token SELECT FROM WHERE INSERT INTO VALUES UPDATE SET DELETE
%token EQUAL COMMA SEMICOLON LPAREN RPAREN STAR
%type <str> value
%token CREATE TABLE


%start input

%%

input:
    statements
    ;


statements:
    statement SEMICOLON statements
    | statement SEMICOLON
    ;

statement:
    select_stmt
    | insert_stmt
    | update_stmt
    | delete_stmt
    | create_stmt
    ;

create_stmt:
    CREATE TABLE IDENTIFIER LPAREN column_defs RPAREN
    {
        printf("Parsed CREATE TABLE statement\n");
    }
;

column_defs:
    column_def COMMA column_defs
    | column_def
;

column_def:
    IDENTIFIER IDENTIFIER  // e.g., id INTEGER
;


select_stmt:
    SELECT column_list FROM IDENTIFIER where_clause
    {
        printf("Parsed SELECT statement\n");
    }
    ;

column_list:
    IDENTIFIER COMMA column_list
    | IDENTIFIER
    | STAR
    ;

where_clause:
    WHERE condition
    | /* empty */
    ;

condition:
    IDENTIFIER EQUAL value
    ;

value:
    NUMBER
    | STRING
    | IDENTIFIER
    ;

insert_stmt:
    INSERT INTO IDENTIFIER LPAREN column_list RPAREN VALUES LPAREN value_list RPAREN
    {
        printf("Parsed INSERT statement\n");
    }
    ;

value_list:
    value COMMA value_list
    | value
    ;

update_stmt:
    UPDATE IDENTIFIER SET assignment_list where_clause
    {
        printf("Parsed UPDATE statement\n");
    }
    ;

assignment_list:
    assignment COMMA assignment_list
    | assignment
    ;

assignment:
    IDENTIFIER EQUAL value
    ;

delete_stmt:
    DELETE FROM IDENTIFIER where_clause
    {
        printf("Parsed DELETE statement\n");
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax Error: %s at '%s'\n", s, yytext);

    // Very basic suggestion logic
    if (strstr(yytext, "SELECT")) {
        fprintf(stderr, "💡 Tip: SELECT must be followed by columns and a FROM clause.\n");
    } else if (strstr(yytext, "WHERE")) {
        fprintf(stderr, "💡 Tip: Make sure your WHERE clause uses correct operators and identifiers.\n");
    } else {
        fprintf(stderr, "💡 Tip: Use format like: SELECT column FROM table WHERE condition;\n");
    }
}
