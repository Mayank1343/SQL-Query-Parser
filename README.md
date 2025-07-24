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
4. Output or suggestions ar
