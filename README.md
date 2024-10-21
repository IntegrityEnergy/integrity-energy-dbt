# DBT Project: Integrity Energy

Data collected from various sources and stored in Amazon Redshift. Data models created to report on leads and sales.

## Table of Contents

- [About the Project](#about-the-project)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [DBT Commands](#dbt-commands)
- [Folder Structure](#folder-structure)
- [Contributing](#contributing)

## About the Project

A detailed description of your DBT project. What problems does it solve? How does it process data? What are the key features and models in your project?

### Built With

- [DBT](https://www.getdbt.com/) - Data Build Tool for data transformations
- [Pipenv](https://pipenv.pypa.io/en/latest/) - Python dependency and virtual environment management

## Getting Started

These instructions will help you set up the DBT project and install dependencies using `Pipenv`.

### Prerequisites

Before setting up the project, ensure that you have the following installed on your local machine:

- Python 3.11
- Pipenv
- DBT-Redshift

### Installation
Clone the repo

```bash
cd path/to/local/storage/location
git clone <clone_url> 
```

You can install Pipenv and DBT by running:

```bash
pip install pipenv
pip install dbt-redshift
```

Start up a virtual environment:

```bash
pipenv shell
```

Install dependencies from Pipfile.lock:

```bash
pipenv install
```

## Usage
Once everything is set up, you can start running DBT commands within the Pipenv shell. Below are some common DBT commands:

## DBT Commands

Install dependencies
```bash
dbt deps
```

Run a specific model and target
```bash
dbt run --select <model_name> --target dev
```
- Target should always default to dev, but it is good practice to specify in dbt command 
- You can also run with specific tags instead of running a single model if you need to run a batch of sql statements
```bash
dbt run --select tag:<tag_name> --target dev 
```

## Folder Structure

The following is an overview of the project's folder structure:

```bash
├── integrity_energy_dbt/
│   ├── models/                # Models that clean and prepare the data
│   │   ├── prod-dbt-base/ 
│   │   ├── prod-dbt-intermediate/
│   │   ├── prod-dbt-mart/
│   ├── sources.yml            # Sources specified for models
├── tests/                     # Custom tests for data integrity
├── dbt_project.yml            # Main DBT project configuration file
├── .gitignore                 # file for specifying what git should ignore when pushing to remote
├── Pipfile                    # Pipenv configuration for managing Python dependencies
├── Pipfile.lock               # Locked Pipenv dependencies (generated automatically)
└── README.md                  # Project-level documentation
```

## Contributing
- Always work in separate branch from main
```bash
git checkout -b <new_branch_name> 
```
- NEVER PUSH CHANGES DIRECTLY TO MAIN BRANCH
- Once updates are made to model, run this command on the FIRST time pushing new branch
```bash
git add <new_files_with_changes>
git commit -m "Commit Message"
git push --set-upstream origin <new_branch_name> 
```
- All pushes after initial push will go to this branch as long as you are in the local version
- Check which branch you working in with this command
```bash
git branch 
```
- Push changes after initial set-upstream
```bash
git add <new_files_with_changes>
git commit -m "Commit Message"
git push 
```
- After pushing changes to separate branch, open PR in GitHub and assign a reviewer. Once approved, your changes will merge to main branch and be updated in the pipeline on the next run.

