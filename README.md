# Design-of-ICD-9-to-10-conversion-function-for-the-R-package-icd

## Project goals: Add components to the existing R icd package to aid research using ICD codes by developing a function to convert between older ICD-9 codes and new ICD-10 codes.

Using 2018 ICD-9 GEM mapping from CMS which provides broad mapping of ICD-9 to ICD-10 along with a set of five flags that specify the mapping of the data. 
Difficulties include differences in format of codes, specificity of codes, and one to many mapping
Limitation: GEM codes are currently only mapping ICD-9 diagnosis codes only (not procedure codes)

## Workflow 
Input: a) 2018_I9gem.txt (list of ICD-9 to ICD-10 gem mappings) and 2) your ICD-9 code(s) to be mapped.

Step 1: Data cleaning/processing:

    Step 1a: Determine if codes being mapped are in ICD-9 or ICD-10. Take only the ICD-9 subset

    Step 1b: Determine if are in short or decimal format

    Step 1c: Convert all codes to short format

Step 2: Using GEM, function converts ICD-9 to ICD-10. 

Step 3: ICD-10 has many more codes than ICD-9 and the GEM map prioritizes based on specificity. 

    Step 3a: Following ICD-10 conversion, pull up all potential children codes (more specifc) from the GEM-specified parent code (less specific). 

    Step 3b: Also based on flags, give the correct combinations of ICD-10 codes that are relevent.

# Flowchart for project
![Flowchart](https://github.com/NCBI-Hackathons/Design-of-ICD-9-to-10-conversion-function-for-the-R-package-icd/blob/master/ICD_flowchart.png "Flowchart")


