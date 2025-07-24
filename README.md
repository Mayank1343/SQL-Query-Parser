# SQL Query Parser 🔍

This project is a **desktop-based SQL Query Parser and Executor** built using **Flex, Bison, SQLite, C, and Python**. It parses user-written SQL queries, validates their syntax, and executes them on an SQLite database — all from a friendly **Tkinter GUI**.

---

## 🎯 Features

- ✅ Supports basic SQL operations:
  - `SELECT`, `INSERT`, `UPDATE`, `DELETE`
- ✅ Executes queries on a local SQLite database (`mydb.db`)
- ✅ Displays query results or errors in real-time
- ✅ Suggests common syntax fixes for incorrect queries
- ✅ GUI made with Python's `tkinter`

---

## 🛠 Technologies Used

- **Flex** – for lexical analysis
- **Bison** – for parsing SQL grammar
- **C** – for core parsing and database logic
- **SQLite** – lightweight database for query execution
- **Python (Tkinter)** – for the graphical user interface

---

## 🚀 How It Works

1. User types SQL query in the GUI
2. Query is parsed using Flex & Bison (compiled as DLL)
3. If valid, it’s executed on `mydb.db` using SQLite
4. Output or suggestions are displayed in the GUI

---

## 📁 Project Structure

SQL Query Parser/
│
├── parser.y # Bison grammar file
├── lex.l # Flex lexer file
├── main.c # C file for parsing & SQLite execution
├── sqlite3.h # SQLite header (from amalgamation)
├── sqlite3.c # SQLite source file
├── gui.py # Python GUI using tkinter
├── sql_parser.dll # Compiled shared library (ignored in repo)
└── README.md # You're reading it now!


## ⚙️ How to Run

### 1. Compile C parser:

```bash
bison -d parser.y
flex lex.l
gcc -I. -c lex.yy.c parser.tab.c main.c sqlite3.c
gcc -shared -o sql_parser.dll lex.yy.o parser.tab.o main.o sqlite3.o
python gui.py
