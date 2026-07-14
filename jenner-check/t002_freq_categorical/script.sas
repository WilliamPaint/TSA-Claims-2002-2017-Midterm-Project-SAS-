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
