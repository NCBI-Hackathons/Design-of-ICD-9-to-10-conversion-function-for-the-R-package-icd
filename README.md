# R function to convert ICD-9 to ICD-10

![build_language_count](https://img.shields.io/github/languages/count/NCBI-Hackathons/Design-of-ICD-9-to-10-conversion-function-for-the-R-package-icd.svg "build language count") ![forks_count](https://img.shields.io/github/forks/NCBI-Hackathons/Design-of-ICD-9-to-10-conversion-function-for-the-R-package-icd.svg "forks count") ![stars_count](https://img.shields.io/github/stars/NCBI-Hackathons/Design-of-ICD-9-to-10-conversion-function-for-the-R-package-icd.svg "star count") ![license](https://img.shields.io/github/license/NCBI-Hackathons/Design-of-ICD-9-to-10-conversion-function-for-the-R-package-icd.svg "license")

#### Project goals: Develop a function to be incorporated into the R package 'icd' that will convert International Classification of Diseases codes from Ninth to Tenth revisions

Keywords: ICD, billing code, hospital billing code, International Classification of Diseases codes, diagnosis, comorbidity, comorbidities, ICD-9, ICD-10

    Authors: 
    - Emily Ricotta (Team Lead, emily.ricotta@nih.gov)
    - Sofia Fernandez Lozano (SysAdmin, so1.618e@gmail.com)
    - Denise Liberton (Writer, denise.liberton@nih.gov)
    - Gwynn Sturdevant (nzgwynn@gmail.com)
    - Regina Umarova (regina.umarova@nih.gov)
    - Elaine Lai (elaine.lai@nih.gov)
    - Jack Wasey (jack@jackwasey.com)

### Introduction
The International Statistical Classification of Diseases and Related Health Problems (ICD) is a medical classification list by the World Health Organization (WHO) used around the world. Every medical visit is associated with one or more ICD codes. ICD codes are regularly used by medical billing, insurance, and epidemiologists to track and evaluate diseases and health problems across the world.  

In 2015, the United States transitioned from the 9th revision (ICD-9) to the 10th revision (ICD-10). The structure of the codes changed significantly during this transition. In addition, many of the broader ICD-9 codes were broken down into more specific classifications, meaning that entries that had only a single (generally broad) ICD-9 code have been subset into multiple ICD-10 codes. To convert from ICD-9 to ICD-10, we need to take into account the differences in format as well as the potential for one-to-many mappings of codes.

This means that legacy datasets have ICD codes in one format while post-2015 data is coded differently. Being able to easily convert between these two ICD systems will allow for easy combination and analysis of these datasets. We propose to perform this conversion using General Equivalence Mappings (GEMs) proposed by the Centers for Medicare & Medicaid Services (CMS).

### Project Goals
Using 2018 ICD-9 GEM mapping from CMS (https://www.cms.gov/Medicare/Coding/ICD10/2018-ICD-10-CM-and-GEMs.html), which provides broad mapping of ICD-9 to ICD-10 along with a set of five flags that specify the mapping of the data, to allow for conversion between ICD-9 and ICD-10 diagnosis codes for research and/or analysis. Limitation: GEM codes are currently only mapping ICD-9 diagnosis codes only (not procedure codes).

# Software Flowchart
![Flowchart](https://github.com/NCBI-Hackathons/Design-of-ICD-9-to-10-conversion-function-for-the-R-package-icd/blob/master/Updated_Flowchart.png "Flowchart")

### Workflow 
Required packages: ```icd``` (https://github.com/jackwasey/icd)

Required inputs: a) GEM.Rds (list of ICD-9 to ICD-10 gem mappings) and 2) dataset with your ICD-9 code(s) in a column to be mapped.

- [x] Step 1: Data cleaning/processing:

    - [x] Step 1a: Determine if codes being mapped are in ICD-9 or ICD-10 (```guess_version()```). 
    
    - [x] Step 1b: Take only the ICD-9 for next steps via decision tree.

    - [x] Step 1c: Determine if ICD-9 codes are in short or decimal format (```icd:::guess_short()```).

    - [x] Step 1d: Convert all ICD-9 codes to short format (```decimal_to_short()```).

- [x] Step 2: Using GEM, function converts ICD-9 to ICD-10 (```findICD10()``` and ```convertICD9toICD10()```). 

- [in progress] Step 3: ICD-10 has many more codes than ICD-9 and the GEM map prioritizes based on specificity. 

    - [x] Step 3a: Output ICD-10 codes one per row
    
    - [x] Step 3b: Output flags for ICD-10 codes when desired (```convertICD9toICD10(flag=TRUE)```)
    
    - [in progress] Step 3c: Merge ICD-10 codes back to original dataset, adding rows when necessary.

### Vignette

Please see out [vignette](https://github.com/NCBI-Hackathons/Design-of-ICD-9-to-10-conversion-function-for-the-R-package-icd/blob/master/convertICD.md) for examples of data structures and input/output formats (```vignette(convertICD9.md)```)

### Lessons Learned

We need to distinguish between multiple data versions (ICD-9 vs. 10) as well as multiple data formats (short vs. decimal). However, many of the built-in functions are not set up for vectorization, which means the code may run slowly. We have tried to optimize our functions while still including to ability to check which data version and format and also convert based on a logical structure. In the future, use of tidyverse packages as well as parallelization would improve performance in larger datasets.
