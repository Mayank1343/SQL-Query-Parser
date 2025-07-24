#include <sqlite3.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Flex/Bison externs
extern int yyparse(void);
extern void yylex_destroy(void);
extern struct yy_buffer_state *yy_scan_string(const char *str);
extern void yy_delete_buffer(struct yy_buffer_state *buffer);

// Global variables
sqlite3 *db;
char result[4096];
char last_query[1024];

// Store query string
__attribute__((visibility("default")))
void set_query(const char* q) {
    strncpy(last_query, q, sizeof(last_query));
    last_query[sizeof(last_query)-1] = '\0';  // Ensure null-termination
}

// Parse the SQL query using Bison
__attribute__((visibility("default")))
int parse_sql(const char* input) {
    struct yy_buffer_state *buffer = yy_scan_string(input);
    int res = yyparse();
    yy_delete_buffer(buffer);
    yylex_destroy();
    return res;
}

// Execute query on SQLite and return results
__attribute__((visibility("default")))
const char* execute_query() {
    sqlite3_stmt *stmt;
    int rc;

    result[0] = '\0';  // Clear previous output

    rc = sqlite3_open("mydb.db", &db);
    if (rc != SQLITE_OK) {
        snprintf(result, sizeof(result), "❌ Can't open database: %s\n", sqlite3_errmsg(db));
        return result;
    }

    rc = sqlite3_prepare_v2(db, last_query, -1, &stmt, NULL);
    if (rc != SQLITE_OK) {
        snprintf(result, sizeof(result), "❌ Invalid SQL Execution: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        return result;
    }

    int col_count = sqlite3_column_count(stmt);
    while ((rc = sqlite3_step(stmt)) == SQLITE_ROW) {
        for (int i = 0; i < col_count; i++) {
            const char *text = (const char *)sqlite3_column_text(stmt, i);
            strcat(result, text ? text : "NULL");
            strcat(result, "\t");
        }
        strcat(result, "\n");
    }

    sqlite3_finalize(stmt);
    sqlite3_close(db);
    return result;
}
