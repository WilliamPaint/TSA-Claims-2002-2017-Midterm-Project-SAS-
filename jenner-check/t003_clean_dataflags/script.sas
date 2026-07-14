/*Sorting the Incident_Date data in ascending order*/

Proc sort data=claims_cleaned
        out=new_claims_cleaned;
        by Incident_Date;
run;

/*	All missing and "-" values in the columns Claim_Type, Claim_Site, and Disposition are changing to Unknown*/
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

/*Report Requirement*/
/* date issues in the overall data*/
title "Date Issues in the Overall Data";
ods proctitle;
proc freq data=new_claims_cleaned;
	table Date_Issues;
RUN;
title;
