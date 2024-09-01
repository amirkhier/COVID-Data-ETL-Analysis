# COVID-19 Data Analysis and ETL Project

## Overview

This repository contains SQL scripts and data files used to perform data exploration and ETL (Extract, Transform, Load) processes on COVID-19-related datasets, specifically focusing on deaths and vaccinations. The project is built on MySQL/MariaDB and is aimed at providing insights into the impact of COVID-19 through data analysis.

## Files in the Repository

### 1. Data Files
- **coronaDeaths.csv**: This file contains data related to COVID-19 deaths, including metrics such as total deaths, new deaths, and more.
- **coronaVacination.csv**: This file includes data on COVID-19 vaccinations, with details on vaccination rates, doses administered, and other relevant information.
- **Contact me if you need those 2 csv files , if the files not appear in repository**:Contact Me by sending mail "khier319@gmail.com" , the files isn't here , because the csv files are heavy to load  .
### 2. SQL Scripts
- **DataExploration.sql**: This script is designed for exploratory data analysis (EDA). It contains SQL queries that help in understanding the structure of the data, identifying key trends, and generating summary statistics.
- **ETL.sql**: This script is responsible for setting up the database and performing the ETL process. It creates the necessary tables, transforms the data from the CSV files, and loads it into the MySQL/MariaDB database.

## Prerequisites

- **MySQL/MariaDB**: Ensure that you have MySQL or MariaDB installed on your system.
- **MySQL Workbench or Command Line**: You can use MySQL Workbench or the command line interface to execute the SQL scripts.

## Getting Started

### 1. Setting Up the Database

1. **Run the ETL Script**:
    - The `ETL.sql` script will handle the creation of the database, table setup, and data import from the CSV files.
    - Execute the script using the following command:

    ```sql
    SOURCE /path/to/ETL.sql;
    ```

    - The script will:
        - Create a new database named `corona`.
        - Create the necessary tables for storing COVID-19 deaths and vaccination data.
        - Load the data from `coronaDeaths.csv` and `coronaVacination.csv` into the respective tables.

### 2. Data Exploration

- After the ETL process, you can run the `DataExploration.sql` script to perform exploratory data analysis.

    ```sql
    SOURCE /path/to/DataExploration.sql;
    ```

- This script contains various SQL queries that provide insights into the data, such as:
    - Aggregated statistics
    - Time series analysis
    - Comparative analysis between different regions or countries

## Project Structure

```plaintext
├── coronaDeaths.csv
├── coronaVacination.csv
├── DataExploration.sql
└── ETL.sql
```

## Usage

- **ETL Process**: Run `ETL.sql` to set up the database with the necessary tables and populate them with data.
- **Data Analysis**: Run `DataExploration.sql` to explore the data and generate insights.

## Contributing

If you'd like to contribute to this project, feel free to fork the repository and submit a pull request. Contributions in the form of additional analysis, improved ETL processes, or enhancements to the documentation are welcome.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Data sourced from [Link](https://ourworldindata.org/covid-deaths).
- Inspired by the ongoing global effort to understand and combat the COVID-19 pandemic.
