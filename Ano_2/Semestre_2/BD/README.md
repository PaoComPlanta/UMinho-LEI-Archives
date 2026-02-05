# 🏎️ JBVMotors | Database System

**JBVMotors** is a complete database solution developed for the operational management of a vehicle rental company with three distinct branches. This project covers the entire data development lifecycle, from conceptual analysis and modeling to physical implementation and technical migration.

## 📊 Architecture and Modeling
The system was designed to ensure data integrity and scalability, focusing on:

* **Conceptual Modeling:** Detailed Entity-Relationship (ER) diagrams.
* **Logical Modeling:** Normalized relational schema to eliminate redundancies.
* **Relational Algebra:** Mathematical formalization of query operations.
* **Physical Implementation:** Optimized SQL scripts for **MySQL**.

## 🛠️ Technology Stack
* **Main Database:** MySQL
* **Scripting and Automation:** Python 3.7+
* **Interoperability:** PostgreSQL, CSV, and JSON (data sources).

## ⚙️ Data Tools (Python)
To facilitate system testing and integration, automated scripts were developed located in the `scripts_python/` directory:

* **`populate.py`**: Fake data generation engine with multi-format export (SQL, CSV, and JSON).
* **`migrate.py`**: ETL pipeline to migrate information from various sources directly to the MySQL engine.

### Usage Commands
```bash
# Generate complete data set
python populate.py --all

# Execute full migration to MySQL
python migrate.py all
```

## 👥 Authors

* [DelgadoDevT](https://github.com/DelgadoDevT)
* [PaoComPlanta](https://github.com/paocomplanta)
* [xfn14](https://github.com/xfn14)
* [inesferribeiro](https://github.com/inesferribeiro)