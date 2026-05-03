import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from matplotlib.ticker import PercentFormatter
import textwrap

# 1. Load the dataset
df = pd.read_csv('Macro Data Long Format.xlsx - MacroData_long_format_2 MAY 202.csv')

# 2. Extract the year and filter for 2005 and 2014
df['Year'] = pd.to_datetime(df['Date']).dt.year
df_filtered = df[df['Year'].isin([2005, 2014])].copy()

# 3. Pivot the data to get 2005 and 2014 values side-by-side
pivot_df = df_filtered.pivot_table(
    index=['Region', 'Industry'], 
    columns='Year', 
    values='Value'
).reset_index()

# 4. Calculate CAGRs
years = 2014 - 2005
pivot_df['CAGR'] = (pivot_df[2014] / pivot_df[2005]) ** (1 / years) - 1
pivot_df.dropna(subset=['CAGR'], inplace=True)

# 5. Generate standard bar charts for each individual industry
industries = pivot_df['Industry'].unique()
for industry in industries:
    ind_data = pivot_df[pivot_df['Industry'] == industry].sort_values(by='CAGR', ascending=False)
    
    plt.figure(figsize=(10, 6))
    sns.barplot(x='CAGR', y='Region', data=ind_data, palette='viridis')
    
    # Wrap the title text 
    title_text = f'2005-2014 CAGR for {industry}'
    wrapped_title = textwrap.fill(title_text, width=55) # Wraps text at 55 characters
    
    plt.title(wrapped_title, fontsize=13, weight='bold', pad=12)
    plt.xlabel('Compound Annual Growth Rate (CAGR)', fontsize=12)
    plt.ylabel('Region', fontsize=12)
    plt.grid(axis='x', linestyle='--', alpha=0.7)
    
    # Format x-axis as percentage
    plt.gca().xaxis.set_major_formatter(PercentFormatter(1.0))
    plt.tight_layout()
    
    # Save charts
    safe_name = industry.replace('/', '_').replace(' ', '_').replace(',', '')
    plt.savefig(f'{safe_name[:50]}_CAGR.png')
    plt.close()

# 6. Generate the combined GMP vs GDPC1 chart
gmp_data = pivot_df[pivot_df['Industry'] == 'GMP'].copy()
gdpc1_data = pivot_df[pivot_df['Industry'] == 'GDPC1'].copy()

# label gdpc1
gdpc1_data['Region'] = gdpc1_data['Region'] + ' - US GDP (GDPC1)'

# Combine and sort the datasets
combined_data = pd.concat([gmp_data, gdpc1_data]).sort_values(by='CAGR', ascending=False)

# Render charts
plt.figure(figsize=(12, 8))

# Apply color palette (orange for US GDP, blue for individual metro gmps)
custom_palette = ['#ff7f0e' if 'GDPC1' in region else '#1f77b4' for region in combined_data['Region']]

sns.barplot(x='CAGR', y='Region', data=combined_data, palette=custom_palette)

# Wrap the combined chart title
combined_title = '2005-2014 CAGR: Regional GMP vs. US GDP (GDPC1)'
wrapped_combined_title = textwrap.fill(combined_title, width=60)

plt.title(wrapped_combined_title, fontsize=14, weight='bold', pad=15)
plt.xlabel('Compound Annual Growth Rate (CAGR)', fontsize=12)
plt.ylabel('Region / Metric', fontsize=12)
plt.grid(axis='x', linestyle='--', alpha=0.7)
plt.gca().xaxis.set_major_formatter(PercentFormatter(1.0))
plt.tight_layout()

# Save final charts
plt.savefig('GMP_vs_GDPC1_CAGR_Combined.png')
plt.close()

#Sanity check
print("Script execution complete. Files and charts saved.")