/*Question 3* a, b, c */
/* the frequency values for Claim_Type Claim_Site and Disposition for the selected state */

%let StateName=Texas;   /* Example of dynamic input */

title Frequency Distribution Claim Type, Claim Site and Disposition of Texas State;
proc freq data=new_claims_cleaned;
          table Claim_Type Claim_Site Disposition / nocum nopercent;
          where StateName="&StateName" and Date_Issues is missing;
run;
title;

/*Question 3) d) */
/*the mean, minimum, maximum, and sum of Close_Amount for selected state*/

title "Summary Statistics of Close Amount by StateName";

proc means data=new_claims_cleaned mean min max maxdec=0;
	var Close_Amount;
    where StateName="&StateName" and Date_Issues is missing;
run;
title;
