# netflix_data_analysis
netflix data normalisation and analysis projecf using mysql, recursive ctes, relational database design.



# Netflix Data Normalization Project

## Project Overview

This project focuses on transforming a raw Netflix titles dataset into a normalized relational database using MySQL.

The raw dataset contained multi-valued columns such as directors, cast, genres, and countries. These columns were split and organized into separate relational tables to improve data structure and make the dataset easier to query and analyze.

## Database Structure

The normalized database contains the following tables:

- `shows`
- `directors`
- `actors`
- `genres`
- `country`
- `show_director`
- `show_actor`
- `show_genre`
- `show_country`

The `show_*` tables are bridge tables used to handle many-to-many relationships between Netflix shows and directors, actors, genres, and countries.

## SQL Techniques Used

- Database normalization
- Primary keys and foreign keys
- Many-to-many relationships
- Recursive CTEs
- `SUBSTRING_INDEX()`
- `TRIM()`
- `REPLACE()`
- `LENGTH()`
- `JOIN`
- `DISTINCT`
- Data transformation and cleaning

## Data Transformation

Columns containing comma-separated values were split into individual records using recursive CTEs and string functions.

For example, a show containing multiple directors or actors was converted into separate records and connected using bridge tables.

## Tools Used

- MySQL
- MySQL Workbench

## Project Goal

The goal of this project was to practice SQL data transformation, database normalization, and relational database design using a real-world Netflix dataset.
