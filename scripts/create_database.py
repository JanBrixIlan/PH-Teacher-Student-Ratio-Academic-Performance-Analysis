from sqlalchemy import create_engine
import urllib
import pandas as pd
import os

# Connection
params = urllib.parse.quote_plus(
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=localhost\\SQLEXPRESS;"
    "DATABASE=DepEDdb;"
    "Trusted_Connection=yes;"
    "TrustServerCertificate=yes;"
)

engine = create_engine(
    f"mssql+pyodbc:///?odbc_connect={params}",
    fast_executemany=True
)

# Load all Excel files
folder = 'data/processed/'

for file in os.listdir(folder):
    if file.endswith('.xlsx'):
        df = pd.read_excel(f'{folder}/{file}')
        table_name = (file.replace('.xlsx', '')
                         .replace(' ', '_')
                         .replace('-', '_'))
        df.to_sql(table_name, engine, if_exists='replace', index=False)
        print(f"Loaded: {table_name}")

print("All tables created successfully")