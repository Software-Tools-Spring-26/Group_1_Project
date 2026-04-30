# Software-Tools-Group-1-Project
# Group-Project Final Report 
Group: Grant Hanauer, Nicholas Hoffman, Aurora Seekins, and Hannah Farrell

## Introduction 
A real estate developer is considering opportunities for future investment. For the purpose of this report the real estate developer is Eagles Real Estate Developers. They are a Boston based firm but operate nationally.

The firm, Eagles Real Estate Developers, has already isolated GDP per capita aggregated by Metropolitan Statistical Area level to be a key indicator of long-run performance. Currently the firm lacks a means to forecast GDP per capita but is capable of monitoring employment trends as a guide to future metro level performance. The firm wants to know what are the key employment categories (NAICS-2 Digit) that will drive metro level GDP growth and what are the trends by employment category for major MSAs. This information will then inform what metro areas the firm should invest in to, as these varibles can be predictors for metro-areas that will have contined growth and therefore need housing. 

In additon to the employment category data, information on the housing sales by region have also been downloaded to also inform on the applicable housing markets that are potential options for the firm to invest in. This provides an added layer of information on the health of the relevant hosuing markets. 

The centeral research question for this report is to answer where Eagles Real Estate Developers should invest in, based on the regional labor markets and economic indicators (GDP and employment).

## Data  

The primary data our team is utilizing for this research was sourced indirectly from the Bureau of Economic Analysis (BEA), Bureau of Labor Statistics (BLS), and the US Census Bureau through Federal Reserve Economic Data (FRED). GDP, Population, Unemployment Rate,  Total Employment, Employment by NAICS 2 Digit Category, and other potential variables for Major MSAs on FRED pretty readily. 

In addition to the primary data, this report utilizes an excursion datset of the Federal Housing Finance Agency (FHFA) data to examine whether metro areas with strong employment-driven GDP growth also experience higher housing price appreciation, providing additional context for Eagles Real Estate Developers. The FHFA data serves as an excellent compliment to our existing data because: a) It is also available through FRED, which is ensures the definition of metropolitan area and formatting is as close as possible; b) the data is reliable and government-backed; and c) the data uses repeated sales of the same property, which accurately shows housing price appreciation.

## Data Summary 

The data includes information for 14 major metro areas as well as the United States as a whole, including the metro areas for the following states; Georgia, Massachusetts & New Hampshire, Illinois & Indiana, Texas, Colorado, Michigan, California, Florida, Minnesota & Wisconsin, New York & New Jersey, Pennsylvania & Maryland & Delaware, Arizona, Washington, and Washington DC & Virginia & West Virginia and Maryland.

The dataset is on an annual level for 2005 to 2014. The variables for each metro area include; the population size, employment broken down by sector, the unemployment rate, and GMP. 
 
### Brief Data Summary

#### Primary Data - Economic Indicators by Region

**Table 1.**

<img width="236" height="117" alt="Screenshot 2026-04-15 at 7 54 35 PM" src="https://github.com/user-attachments/assets/2321398d-d13c-450d-8a51-01dd4bf5c7d7" />

**Table 2.**

<img width="234" height="248" alt="Screenshot 2026-04-15 at 7 54 44 PM" src="https://github.com/user-attachments/assets/11a3ef74-4930-4104-9502-e0c943290e15" />

The data has four main variables; Date, Region, Industry, and Value. The industries are the key employment categories which utilize the NAICS-2 Digit code as an identifier. The industry vairble also contains the the population size, employment broken down by sector, the unemployment rate, and GMP for the applicable metro region. The value listed for each column is the specific value. For example, the value of Altanta population indicates the number of people that live in that metro area. While the NAICS-2 values are those for the employment within that category. 

**Table 3.** 

<img width="1361" height="841" alt="image" src="https://github.com/user-attachments/assets/b585a97c-68a4-4150-9569-2511e3dcb5af" />

There are 4 rows and 3280 columns.

**Table 4.**

<img width="1014" height="913" alt="Screenshot 2026-04-15 at 8 22 34 PM" src="https://github.com/user-attachments/assets/0a9556f4-264f-4c88-8949-ccbb843c6f7b" />

Table 4 inclues the summary statitics by industry across all of the regions and the USA in total. 

#### Exurscion Data - Housing Price Indicators (HPI) by Region

**Table 1.**

XXXX

**Table 2.**

XXXXX

The data has XXXXX main variables; XXXXXXXXX. 

**Table 3.** 

<img width="243" height="136" alt="image" src="https://github.com/user-attachments/assets/11b323a2-4037-491f-8e3b-14140d036c7b" />

There are 150 rows and 6 columns.

**Table 4.**

<img width="212" height="248" alt="image" src="https://github.com/user-attachments/assets/23d87ac7-a92e-4620-9591-154faaf15b0d" />

Table 4 inclues the summary statitics by industry across all of the regions and the USA in total for the HPI. 



## Data Analytics

_Provide data analytics that add clarity to the research question. Thoroughly discuss insight obtained from your visualizations and analysis of aggregated, data. Suggest an excursion, and provide supporting analysis. Plots should be well formatted according to best practices learned in class. Discuss the advantages and challenges of performing analysis in your chosen software tool._

### Tableau Dashboard

The Tableau dashboard was developed to provide a structured, visual analysis of metro-level economic performance and industry composition across major U.S. metropolitan areas. Four primary visualizations were constructed. First, stacked bar charts of the top five and bottom five industries by metro area were created using percent of total employment. This approach standardizes across regions of different sizes and highlights relative industry importance rather than absolute scale. Second, a line chart of Gross Metropolitan Product (GMP) over time (2005–2014) was used to capture differences in economic growth trajectories and to illustrate how metros responded to broader economic shifts over the period. Third, a metro comparison table was built to display key indicators, GMP, population, total employment, and unemployment rate, for each metro in 2014. Because the dataset was originally in long format, the data was restructured within Tableau by pivoting the Industry variable into columns, allowing each metric to be presented clearly and consistently.

Together, these visualizations provide complementary insights into both the structure and performance of metropolitan economies. The industry composition charts identify which sectors dominate or lag within each metro, offering insight into the underlying economic base. The GMP trend visualization adds a temporal dimension, revealing which regions experienced stronger or more stable growth over time. The comparison table provides a clear snapshot of economic scale and labor market conditions, allowing for direct cross-metro comparison. By combining these elements into a single interactive dashboard, the analysis enables a more comprehensive evaluation of regional economic strength and supports the identification of metros with characteristics that may be more favorable for long-term real estate investment.

## Conclusion (10 pts)

_Summarize the analytical methodology and provide closure to your analytical story. Succinctly answer the research questions. Highlight the limitations of your findings and recommend future work. Do not make policy recommendations here._

## Limitations

_Acknowledge any known limitations to data, methods, results_

One limitation is that there are additional varibles outside of the data used within the report that impact the sucess of real estate developers. For example, permiting and zoning laws play a large role in the abilty to add developments, the type of developments and where the siting could occur. All of these factors impact the ability to generate the additonal housing supply, and also impact the desribaility of the hosuing to be added. In the housing market where Eagles Real Estate Developers is sited for example, the addiont of multi-fmaily housing has been increased in recent years in Boston as a result of policy decisons. The MBTA Communities Act was a zoning policy that allowed for an increase in multi-fmaily homes near communter stations (https://www.mass.gov/info-details/multi-family-zoning-requirement-for-mbta-communities). Policys such as there could not be captured through this data analysis. 

## Future Work

_In the future, it would be nice to expand this project with new data sources and analytics tools._

## Policy Recommendation

_Introduce a specific policy decision that your decision maker is facing. Provide a data driven recommendation for their decision. Explain probable first and second order effects of the recommendation. Explain the benefits and risks of the recommendation._
