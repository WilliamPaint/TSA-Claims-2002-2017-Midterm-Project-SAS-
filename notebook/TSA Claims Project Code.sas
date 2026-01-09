
/*SAS for Business Analytics */
/*Business Analytics Modeling Midterm Project 2025*/ 

/* Accessing Data*/
/*Importing the raw data file TSAClaims2002_2017.csv*/
/*The final data is in the WORK library, and the data set named claims_cleaned*/

FILENAME REFFILE '/home/u64128359/DSCI_507/PG1/TSAClaims2002_2017.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.claims_cleaned;
	GETNAMES=YES;
	Guessingrows=max;
RUN;

PROC CONTENTS DATA=WORK.claims_cleaned;
RUN;

/* Exploring the data */
/* creating frequency table for categorical variables*/

/* obtaining frequency table of claim_type to identify the required action*/
title "Frequency Table of Claim_Type";
Proc freq data=claims_cleaned;
           Tables Claim_Type;
run;

/* obtaining frequency table of claim_site to identify the required action*/
title "Frequency Table of Claim_Site";
Proc freq data=claims_cleaned;
           Tables Claim_Site;
run;

/* obtaining frequency table of disposition to identify the required action*/
title "Frequency Table of Disposition";
Proc freq data=claims_cleaned;
           Tables Disposition;
run;

/* obtaining statiscal details of numeric variables */
title "Statistics Summary of Incident_Date";
Proc univariate data=claims_cleaned;
           var Incident_Date;
run;

title "Statistics Summary of Date_Received";
Proc univariate data=claims_cleaned;
           var Date_Received;
run;


/*Preparing data*/
/*duplicate records are removing  from the data set*/

PROC SORT DATA=claims_cleaned
	OUT=claims_cleaned2
	Nodupkey
	dupout=work;
	BY _ALL_; /* Sort by all variables to identify duplicates */
run;

/*Sorting the Incident_Date data in ascending order*/

Proc sort data=claims_cleaned
        out=new_claims_cleaned;
        by Incident_Date;
run;
       
 
PROC CONTENTS DATA=new_claims_cleaned; 
RUN;


/*	All missing and “-“ values in the columns Claim_Type, Claim_Site, and Disposition are changing to Unknown*/
/*Cleaning the variables individually*/

Data new_claims_cleaned;
    set new_claims_cleaned;
    if Claim_Type in ("-", "") then Claim_Type="Unknown";
    else if Claim_Type="Passenger Property Loss/Personal Injur" then Claim_Type="Personal Property Loss";
    else if Claim_Type="Passenger Property Loss/Personal Injury" then Claim_Type="Personal Property Loss";
    else if Claim_Type="Property Damage/Personal Injury" then Claim_Type="Property Damage";   /* cleaning the Claim_Type data*/


    if Claim_Site in ("-", "") then Claim_Site="Unknown";   /* cleaning the Claim_Site data*/
  
    if Disposition in ("-", "") then Disposition="Unknown";
    else if Disposition="Closed:Canceled" then Disposition="Closed: Canceled";
    else if Disposition="Closed:Contractor Claim" then Disposition="Closed: Contractor Claim";
    else if Disposition="losed: Contractor Claim" then Disposition="Closed:Contractor Claim";  /* cleaning the Disposition data*/

     StateName=PROPCASE(StateName);  /*All StateName values are keeping in the proper case*/

     State=UPCASE(State);          /*All State values are Keeping in uppercase*/
 
    If (Incident_Date=. 
    or Date_Received=.
    or Year(Incident_Date)<2002
    or Year(Date_Received)<2002
    or Year(Incident_Date)>2017
    or Year(Date_Received)>2017)
    then Date_Issues="Needs Review";     /*Creating a new column to indicate data issues*/

/*Currency should be permanently formatted with a dollar sign and include two decimal points*/
	format Close_Amount DOLLAR10.2;
/*All dates should be permanently formatted in style 01JAN2000*/
	format Date_Received DATE9. Incident_Date DATE9.;
/*lables*/
  	label Claim_Type="Claim Type" 
        Claim_Site="Claim Site"
        Close_Amount="Close Amount" 
        Incident_Date="Incident Date"
        Date_Received="Date Received"
        Claim_Number="Claim Number"
        Airport_Code=" Airport Code"
        Airport_Name=" Airport Name"
        Item_Category="Item Category"; /* Permanent labels assigning by replacing the underscores with a space */          
    drop City County;    /* Removing the County and City Columns*/            
run;

title "TSA Claims 2002_2017";

PROC CONTENTS DATA=new_claims_cleaned;
RUN;


/*Report Requirement*/
/* Excluding all rows with date issues in the following analysis*/
/*Question 1*/
/* date issues in the overall data*/

title "Date Issues in the Overall Data";
ods proctitle;
proc freq data=new_claims_cleaned; 
	table Date_Issues;
	RUN;

/*Answers*/
/*There are 2539 date issues in the overall data */

/*Question 2*/
/* Obtaining claims per year of Incident_Date are in the overall data */

title "Claims per year of Incident Date";
ods proctitle;
ods graphics on;
proc freq Data=new_claims_cleaned;
	table Incident_Date/ nocum nopercent
	plots=freqplot;
	format Incident_Date Year4.;	
	where Date_Issues is missing;
RUN;
title;

/*Answers*/
/* Claims per year is different according to the year.*/
/*We got the results where 2002 has 2158 claims wherease 2017 has 8403 claims in the overall data.*/

/*Question 3* a, b, c */
/* the frequency values for Claim_Type Claim_Site and Disposition for the selected state */
    
%let StateName=Texas;   /* Example of dynamic input */

title Frequency Distribution Claim Type, Claim Site and Disposition of Texas State;
proc freq data=new_claims_cleaned;
          table Claim_Type Claim_Site Disposition / nocum nopercent
          plots=freqplot;
          where StateName="&StateName" and Date_Issues is missing;
run;
title;

/*Answers*/
/* a) The frequency values for claim_type variable in Texas are complaint has 2, Wmployee Loss has 31, Missed flight has 4
motor vehicle has 9, passenger property loss has 8134, passenger theft has 30, personal injury has 108,
personal property loss has 3, property damage has 5639, property loss has 2 and 349 unknown.*/

/*b) The frequency values for claim_site variable in Texas are checked baggage 11210, checkpoint 2979, 
motor vehicle 9, pre-check 1, other 74 and 38 unknown*/

/*c) The frequency values for disposition variable in Texas are 128 *Insufficient, 3305 approve in full, 
37 closed:canceled, 4 closed:contractor claim, 6421 deny, 756 in review, 1 received, 2311 settle, 1348 Unknown.*/

/*Question 3) d) */
/*the mean, minimum, maximum, and sum of Close_Amount for selected state*/

title "Summary Statistics of Close Amount by StateName";

proc means data=new_claims_cleaned mean min max maxdec=0;
	var Close_Amount;
    where StateName="&StateName" and Date_Issues is missing;
run;
title;

/*Answers*/
/* The mean is 101, minimum is 0 and maximum is 106000*/
           
/*Exporting the results in pdf format*/
/*Exporting the results of date issues in the overall data*/

ods pdf file="/home/u64128359/DSCI_507/PG1/output/ClaimsReport.pdf" startpage=no style=journal
           pdftoc=1;
           ods noproctitle;
           
   ods proclabel "ClaimsReport";
   title "Date Issues in the Overall Data";
ods proctitle;
proc freq data=new_claims_cleaned; 
	table Date_Issues;
	
/*Exporting the results of claims per year of Incident_Date in the overall data*/   

title "Claims per year of Incident Date";
ods proctitle;
ods graphics on;
proc freq Data=new_claims_cleaned;
	table Incident_Date/ nocum nopercent
	plots=freqplot;
	format Incident_Date Year4.;	
	where Date_Issues is missing;

/*Exporting the results of Frequency Distribution of Claim Site, Claim Type and Disposition in the overall data in a pdf format*/ 

%let StateName=Texas;   /* Example of dynamic input */

title Frequency Distribution of Claim Type, Claim Site and Disposition of Texas State;
proc freq data=new_claims_cleaned;
          table Claim_Type Claim_Site Disposition / nocum nopercent
          plots=freqplot;
          where StateName="&StateName" and Date_Issues is missing;
      
 /*Exporting the results of Summary Statistics of Close Amount in a pdf format*/

title "Summary Statistics of Close Amount by StateName";

proc means data=new_claims_cleaned mean min max maxdec=0;
	var Close_Amount;
    where StateName="&StateName" and Date_Issues is missing;
run;
title;

ods proctitle;
ods pdf close;

 
 
       
       
       
       
       
       
       
       
       
       
       
       
       
       