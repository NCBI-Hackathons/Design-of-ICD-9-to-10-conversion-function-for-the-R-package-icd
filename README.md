# R function to convert International Classification of Diseases codes from Ninth to Tenth revisions (ICD-9 to ICD-10)

## Project goals: Add components to the existing R icd package to aid research using ICD codes by developing a function to convert between older ICD-9 codes and new ICD-10 codes.

Authors: Emily Ricotta (team lead), Sofia Fernandez Lozano (sys admin), Denise Liberton (writer), Gwynn Sturdevant, Regina Umarova, Elaine Lai

### Introduction
The International Statistical Classification of Diseases and Related Health Problems (ICD) is a medical classification list by the World Health Organization (WHO) used around the world. Every medical visit is associated with one or more ICD codes. ICD codes are regularly used by medical billing, insurance, and epidemiologists to track and evaluate diseases and health problems across the world.  

In 2015, the United States transitioned from the 9th revision (ICD-9) to the 10th revision (ICD-10). The structure of the codes changed signficantly during this transition. In addition, many of the broader ICD-9 codes were broken down into more specific classifications, meaning that entries that had only a single (generally broad) ICD-9 code have been subset into multiple ICD-10 codes. To convert from ICD-9 to ICD-10, we need to take into account the differences in format as well as the potential for one-to-many mappings of codes.

This means that legacy datasets have ICD codes in one format while post-2015 data is coded differently. Being able to easily convert between these two ICD systems will allow for easy combination and analysis of these datasets. We propose to perform this conversion using General Equivalence Mappings (GEMs) proposed by the Centers for Medicare & Medicaid Services (CMS).

### Project Goals
Using 2018 ICD-9 GEM mapping from CMS which provides broad mapping of ICD-9 to ICD-10 along with a set of five flags that specify the mapping of the data. 
Difficulties: Differences in format of codes, specificity of codes, and one to many mapping.
Limitation: GEM codes are currently only mapping ICD-9 diagnosis codes only (not procedure codes).

# Software Flowchart
![Flowchart](https://github.com/NCBI-Hackathons/Design-of-ICD-9-to-10-conversion-function-for-the-R-package-icd/blob/master/Updated%20flowchart.png "Flowchart")

## Workflow 
Required packages: icd
Inputs: a) 2018_I9gem.txt (list of ICD-9 to ICD-10 gem mappings) and 2) dataset with your ICD-9 code(s) in a column to be mapped.

Step 1: Data cleaning/processing:

    Step 1a: Determine if codes being mapped are in ICD-9 or ICD-10 (icd function: guess_version). 
    
    Step 1b: Take only the ICD-9 subset.

    Step 1c: Determine if ICD-9 codes are in short or decimal format (icd hidden function: icd:::guess_short).

    Step 1d: Convert all ICD-9 codes to short format (icd function: decimal_to_short).

Step 2: Using GEM, function converts ICD-9 to ICD-10 (written function: findICD10). 

Step 3: ICD-10 has many more codes than ICD-9 and the GEM map prioritizes based on specificity. 

    Step 3a: Following ICD-10 conversion, pull up all potential children codes (more specific) from the GEM-specified parent code (less specific). 

    Step 3b: Also based on flags, give the correct combinations of ICD-10 codes that are relevent.

