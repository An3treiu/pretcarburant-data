"""Load the cumulative dataset directly from GitHub raw URL.

Run with: python3 load_pandas.py
Requires: pandas (`pip install pandas`).
"""
import pandas as pd

URL = ('https://raw.githubusercontent.com/An3treiu/pretcarburant-data/'
       'main/monthly/cumulative-latest.csv')

df = pd.read_csv(URL, parse_dates=['date'])

print(f'Rows: {len(df)}')
print(f'Date range: {df.date.min().date()} to {df.date.max().date()}')
print(f'Fuel types: {sorted(df.fuel_type.unique().tolist())}')
print()
print('Last 5 rows:')
print(df.tail())

# Example: monthly mean diesel price for 2026
diesel = df[df.fuel_type == 'motorina_standard'].copy()
diesel['month'] = diesel.date.dt.to_period('M')
monthly_diesel = diesel.groupby('month')['price_avg'].mean().round(3)
print()
print('Monthly average diesel (motorina_standard), RON/L:')
print(monthly_diesel.tail(12))
