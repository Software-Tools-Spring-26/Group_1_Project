# Checkpoint #1

## Topic:
A real estate developer is considering opportunities for future investment. For the purpose of this report the real estate developer is Eagles Real Estate Developers. They are a Boston based firm but operate nationally.

The firm has already isolated GDP per capita aggregated by Metropolitan Statistical Area (MSA) level to be a key indicator of long-run performance. Currently the firm lacks a means to forecast GDP per capita but is capable of monitoring employment trends as possible indicators of future metro level performance. The firm is seeking information on  what employment categories (NAICS-2 Digit) most directly drive metro level GDP growth and the trends by employment category for major MSAs. This information will inform what metro areas the firm will invest into.
##Data Analysis 

The primary data our team is utilizing was sourced indirectly from the Bureau of Economic Analysis (BEA), Bureau of Labor Statistics (BLS), and the US Census Bureau through Federal Reserve Economic Data (FRED). GDP, Population, Unemployment Rate,  Total Employment, Employment by NAICS 2 Digit Category, and other potential variables for Major* MSAs on FRED pretty readily. 

Our team is also proposing an excursion that utilizes Federal Housing Finance Agency (FHFA) data to examine whether metro areas with strong employment-driven GDP growth also experience higher housing price appreciation, providing additional context for. The FHFA data serves as an excellent compliment to our existing data because: a) It is also available through FRED, which is ensures the definition of metropolitan area and formatting is as close as possible; b) the data is reliable and government-backed; and c) the data uses repeated sales of the same property, which accurately shows housing price appreciation.

## Progress and Challenges: 

The main progress our team has made so far has been downloading the applicable datasets for both the main data analysis and the excursion dataset. The data has been selected and cleaned and uploaded to the Git. The report drafting has also begun with some write up on what the question is and what the data is that we have so far. The next steps will be to generate the different plots and graphics to understand what is going on in the datasets. 

## Progress and Challenges Area 1: Data Cleaning
Our first roadblock involves the cleaning and pulling of the data from FRED that Grant has been working on in Python. There was a mismatch in the data and inconsistent time periods. As such we had a group call last weekend to discuss what was going on with the data and to try and help troubleshoot. Our decision was to use a narrowed scope of the data available using only some of the metro areas and narrowing the year range. While initially we settled on a range of 2015-2020, as Grant continued to refine the employment indicators data he found that the best NAICS 2 employment data was for the Atlanta, Boston, Dallas, Denver, Houston, Los Angeles, New York City, Orlando, Phoenix, Riverside- San Bernadino, San Diego, San Francisco, and Seattle MSAs. This can cover the pacific coast, east coast, and a decent chunk of the southwest/mountain region.

Nick originally was going to use data he collected from Redfin Real Estate at the zip code level, but realized a couple of issues quickly: 1) The data Nick collected was massive, with upwards of 9 million disorganized observations in a .tsv file, and required Nick to use Stata to initially clean the data. 2) The data may not be comparable to the existing data from FRED, and zip code level data may not make for a good comparison with our existing project.  Nick ultimately decided to use FHFA data for the reasons listed in the “Data Analysis” section. 

## Progress and Challenges Area 2: Git Access

The second roadblock has been the use of Git. Both Hannah and Aurora can access and edit the Git but Grant’s and Nick's access expired, which will only allow them to comment rather than upload or edit any of the files in the Git. While working through the bugs in Git that have continued to prevent this access, the team is using a shared google drive folder where we have been leaving notes and editing the data. 

## Team Members: 
All group members have been collaborative and communicative, offering help and ideas on our team project.

### Aurora: 
* Created the Git repository for the team to work in.
* Proposed an initial structure for our team to work in to account for our team’s schedules.
* Troubleshooting for access in Git.
* Will begin working on initial visuals in Tableau once Nick and Grant finish the first set of changes to the data.

### Grant: 
* Proposed the initial topic and began the data collection. 
* Worked to pull and clean the main dataset. 

### Hannah: 
* Set up a group Google Drive.
* Submitted our topic for review.
* Took initial meeting minutes
* Updated the markdown and created and edited the drafting write-up 
* Did additional cleaning/reformatting of Grants data
* Worked to create the folders in the repository.

### Nick: 
* Proposed the excursion topic.
* Worked to pull and clean supporting datasets.
* Wrote and edited in the drafting write-up.



