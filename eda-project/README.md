# Exploratory Data Analysis (EDA) Project Portfolio

## Project Overview
This portfolio showcases comprehensive exploratory data analysis projects using real-world datasets, demonstrating statistical analysis, data visualization, and insight generation skills essential for data analytics roles.

## Featured Projects

### 1. Titanic Survival Analysis (Complete Implementation)
- **Dataset**: Kaggle Titanic Dataset - 891 passenger records with survival outcomes
- **Techniques**: Statistical testing, feature engineering, survival analysis, correlation analysis
- **Tools**: Python (pandas, matplotlib, seaborn, scipy), Jupyter Notebook
- **Key Insights**: Gender, passenger class, and age were strongest survival predictors

#### Code Example - Data Exploration:
```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from scipy import stats

# Load and explore the dataset
titanic_df = pd.read_csv('https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv')
print(f"Dataset shape: {titanic_df.shape}")
print(f"Missing values:\n{titanic_df.isnull().sum()}")

# Survival rate by gender
survival_by_gender = titanic_df.groupby('Sex')['Survived'].mean()
print(f"Survival rates by gender:\n{survival_by_gender}")

# Create visualization
fig, axes = plt.subplots(2, 2, figsize=(15, 12))

# Survival by gender
sns.countplot(data=titanic_df, x='Sex', hue='Survived', ax=axes[0,0])
axes[0,0].set_title('Survival Count by Gender')

# Age distribution
sns.histplot(data=titanic_df, x='Age', hue='Survived', kde=True, ax=axes[0,1])
axes[0,1].set_title('Age Distribution by Survival')

# Passenger class survival
sns.countplot(data=titanic_df, x='Pclass', hue='Survived', ax=axes[1,0])
axes[1,0].set_title('Survival by Passenger Class')

# Correlation heatmap
numeric_cols = ['Survived', 'Pclass', 'Age', 'SibSp', 'Parch', 'Fare']
corr_matrix = titanic_df[numeric_cols].corr()
sns.heatmap(corr_matrix, annot=True, cmap='coolwarm', ax=axes[1,1])
axes[1,1].set_title('Feature Correlation Matrix')

plt.tight_layout()
plt.show()
```

#### Statistical Analysis Results:
- **Chi-square test**: Gender vs Survival (p < 0.001, highly significant)
- **ANOVA**: Age differences between survivors and non-survivors (p < 0.05)
- **Survival Rates**: Female (74.2%), Male (18.9%)
- **Class Impact**: 1st Class (63%), 2nd Class (47%), 3rd Class (24%)

### 2. NYC Airbnb Market Analysis (Complete Implementation)
- **Dataset**: NYC Airbnb Open Data - 48,000+ listings with pricing and location data
- **Techniques**: Geospatial analysis, price modeling, neighborhood clustering
- **Tools**: Python (pandas, plotly, folium, sklearn), Geographic visualization
- **Key Insights**: Manhattan premium pricing, seasonal trends, room type preferences

#### Code Example - Price Analysis:
```python
import plotly.express as px
import folium
from sklearn.cluster import KMeans

# Load NYC Airbnb dataset
airbnb_df = pd.read_csv('http://data.insideairbnb.com/united-states/ny/new-york-city/2023-12-04/visualisations/listings.csv')

# Price analysis by borough
borough_stats = airbnb_df.groupby('neighbourhood_group').agg({
    'price': ['mean', 'median', 'std'],
    'number_of_reviews': 'mean',
    'availability_365': 'mean'
}).round(2)

print("Price Statistics by Borough:")
print(borough_stats)

# Geographic visualization
ym_coordinates = [40.7589, -73.9851]
m = folium.Map(location=nym_coordinates, zoom_start=11)

# Add price heatmap
for idx, row in airbnb_df.sample(1000).iterrows():
    folium.CircleMarker(
        location=[row['latitude'], row['longitude']],
        radius=3,
        popup=f"${row['price']}/night",
        color='red' if row['price'] > 200 else 'blue',
        fill=True
    ).add_to(m)

m.save('nyc_airbnb_heatmap.html')

# Room type analysis
room_type_analysis = airbnb_df.groupby('room_type').agg({
    'price': ['mean', 'count'],
    'number_of_reviews': 'mean'
})

# Visualization
fig = px.box(airbnb_df, x='neighbourhood_group', y='price', 
             title='Airbnb Price Distribution by Borough')
fig.update_layout(xaxis_title='Borough', yaxis_title='Price ($)')
fig.show()
```

#### Market Analysis Results:
- **Average Prices**: Manhattan ($196), Brooklyn ($124), Queens ($103)
- **Room Type Distribution**: Entire home (52%), Private room (45%), Shared room (3%)
- **Seasonal Trends**: 15-20% price variation between peak and off-season
- **Occupancy Patterns**: Higher review frequency correlates with lower prices

### 3. E-commerce Sales Pattern Analysis
- **Dataset**: Online Retail UCI Dataset - 540,000+ transactions
- **Techniques**: Time series decomposition, customer segmentation, basket analysis
- **Tools**: Python, Advanced statistical modeling
- **Key Insights**: Seasonal sales patterns, customer lifetime value distribution

## Advanced Analytics Techniques Demonstrated

### Statistical Methods:
1. **Hypothesis Testing**: Chi-square, t-tests, ANOVA for group comparisons
2. **Correlation Analysis**: Pearson, Spearman correlation matrices
3. **Distribution Analysis**: Normality tests, outlier detection using IQR and Z-scores
4. **Time Series Analysis**: Trend decomposition, seasonality detection

### Visualization Portfolio:
1. **Statistical Plots**: Histograms, box plots, violin plots, Q-Q plots
2. **Relationship Analysis**: Scatter plots, correlation heatmaps, pair plots
3. **Geographic Analysis**: Choropleth maps, location-based clustering
4. **Interactive Dashboards**: Plotly-based dynamic visualizations

## Technical Skills Demonstrated
- **Data Cleaning**: Missing value imputation, outlier treatment, data type conversion
- **Feature Engineering**: Creating derived variables, binning, encoding categorical data
- **Statistical Testing**: Comprehensive hypothesis testing with proper interpretation
- **Advanced Visualization**: Multi-dimensional plotting, interactive charts
- **Business Insight Generation**: Translating statistical findings to actionable recommendations
- **Report Writing**: Executive summaries with technical appendices

## Tools and Technologies
- **Programming**: Python, R, SQL
- **Visualization**: Matplotlib, Seaborn, Plotly, ggplot2, Tableau
- **Statistical Analysis**: SciPy, Statsmodels, R statistical packages
- **Data Processing**: Pandas, NumPy, dplyr, tidyr
- **Geographic Analysis**: Folium, GeoPandas, Mapbox
- **Notebooks**: Jupyter Notebook, R Markdown

## Project Structure (Executable Format)
```
eda-project/
├── notebooks/
│   ├── 01_titanic_analysis.ipynb       # Complete Titanic EDA
│   ├── 02_nyc_airbnb_analysis.ipynb    # NYC Airbnb market analysis
│   ├── 03_ecommerce_patterns.ipynb     # E-commerce sales analysis
│   └── 04_statistical_testing.ipynb   # Advanced statistical methods
├── data/
│   ├── raw/
│   │   ├── titanic.csv
│   │   ├── airbnb_nyc.csv
│   │   └── online_retail.csv
│   └── processed/
│       ├── clean_titanic.csv
│       └── aggregated_sales.csv
├── src/
│   ├── data_cleaning.py                # Reusable cleaning functions
│   ├── statistical_tests.py           # Custom statistical testing
│   └── visualization_utils.py          # Plotting utilities
├── reports/
│   ├── titanic_executive_summary.pdf
│   ├── airbnb_market_report.html
│   └── ecommerce_insights.md
├── visualizations/
│   ├── titanic_survival_charts.png
│   ├── nyc_airbnb_heatmap.html
│   └── sales_trend_dashboard.html
└── README.md
```

## Execution Instructions

### Setup Environment:
```bash
pip install pandas numpy matplotlib seaborn scipy plotly folium scikit-learn
```

### Run Analysis:
```bash
# Clone repository
git clone https://github.com/sandeepkarmacharya/sandeepkarmacharya.git
cd sandeepkarmacharya/eda-project

# Start Jupyter notebook
jupyter notebook notebooks/
```

## Key Methodologies
1. **Data Quality Assessment**: Missing value analysis, duplicate detection, data type validation
2. **Descriptive Statistics**: Central tendency, dispersion, distribution shape analysis
3. **Inferential Statistics**: Confidence intervals, hypothesis testing, effect size calculation
4. **Exploratory Visualization**: Univariate, bivariate, and multivariate plotting strategies
5. **Pattern Recognition**: Trend identification, anomaly detection, clustering analysis
6. **Business Intelligence**: KPI development, performance metrics, actionable insights

## Datasets Used
1. **Titanic Dataset**: Kaggle's famous survival prediction dataset
2. **NYC Airbnb**: Inside Airbnb open data for market analysis
3. **UCI Online Retail**: E-commerce transaction data for customer behavior analysis
4. **Custom Simulated Data**: For specific statistical method demonstrations

## Business Impact & Insights

### Titanic Analysis:
- Identified key survival factors for risk assessment models
- Demonstrated statistical significance testing in real-world scenarios
- Applied survival analysis techniques used in insurance and healthcare

### NYC Airbnb Analysis:
- Revealed pricing strategies and market positioning insights
- Geographic analysis applicable to real estate and urban planning
- Customer preference analysis for hospitality industry applications

### E-commerce Analysis:
- Customer segmentation for targeted marketing strategies
- Seasonal trend identification for inventory management
- Purchase pattern analysis for recommendation systems

## Professional Applications
These analyses demonstrate skills directly applicable to:
- **Business Analytics**: Customer behavior analysis, market research
- **Data Science**: Feature engineering, statistical modeling, hypothesis testing
- **Business Intelligence**: KPI development, dashboard creation, insight generation
- **Consulting**: Data-driven recommendations, stakeholder communication

## Contact
For detailed project files, code reviews, and collaboration opportunities:
- **Email**: sand.deep.pro@gmail.com
- **LinkedIn**: [Sandeep Karmacharya](https://linkedin.com/in/sandeepkarmacharya)
- **GitHub**: Complete code implementations available in this repository

---
*This portfolio demonstrates proficiency in exploratory data analysis, statistical thinking, and data-driven insight generation using real-world datasets – core competencies for data analyst, business intelligence, and data scientist roles.*
