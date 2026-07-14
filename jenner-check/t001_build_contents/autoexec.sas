/* cap input rows for the captured run */
options obs=100;

/* Sample claims data, shaped to the columns the program reads. */
/* Stands in for the imported TSAClaims2002_2017.csv (not distributed with the repo). */
data WORK.claims_cleaned;
  infile datalines dsd dlm='|' truncover;
  length Airport_Code $3 Airport_Name $24 Claim_Type $39 Claim_Site $15
         Item_Category $18 Disposition $23 StateName $10 State $2 City $13 County $13;
  informat Date_Received Incident_Date yymmdd10.;
  format Date_Received Incident_Date date9.;
  input Claim_Number Date_Received Incident_Date Airport_Code $ Airport_Name $
        Claim_Type $ Claim_Site $ Item_Category $ Close_Amount Disposition $
        StateName $ State $ City $ County $;
datalines;
2002001|2003-01-15|2003-01-10|DFW|dallas fort worth intl|Passenger Property Loss/Personal Injury|Checked Baggage|Jewelry|150.00|Approve in Full|texas|tx|Dallas|Dallas
2002002|2004-02-20|2004-02-15|DFW|dallas fort worth intl|Property Damage/Personal Injury|Checkpoint|Clothing|0.00|Deny|texas|tx|Fort Worth|Tarrant
2002003|2005-03-05|2005-03-01|IAH|houston intercontinental|Passenger Property Loss/Personal Injur|Checked Baggage|Electronics|300.00|Closed:Canceled|texas|tx|Houston|Harris
2002004|2006-04-10|2006-04-05|AUS|austin bergstrom|Property Damage|Checkpoint|Cameras|200.00|Deny|texas|tx|Austin|Travis
2002005|2007-05-22|2007-05-18|DFW|dallas fort worth intl|Motor Vehicle|Motor Vehicle|Automobile|1200.00|Settle|texas|tx|Irving|Dallas
2002006|2008-06-30|2008-06-25|LAX|los angeles intl|Property Damage|Checkpoint|Luggage|75.50|Approve in Full|california|ca|Los Angeles|Los Angeles
2002007|2009-07-12|2009-07-08|SFO|san francisco intl|Personal Injury|Other|Medical|500.00|In Review|california|ca|San Francisco|San Francisco
2002008|2010-08-18|2010-08-14|JFK|john f kennedy intl|Property Damage|Checked Baggage|Jewelry|410.00|Closed:Contractor Claim|new york|ny|New York|Queens
2002009|2011-09-25|2011-09-20|ORD|ohare intl|Passenger Theft|Pre-Check|Electronics|225.00|Approve in Full|illinois|il|Chicago|Cook
2002010|2012-10-03|2012-09-28|DFW|dallas fort worth intl|Property Damage|Checked Baggage|Tools|90.00|Deny|texas|tx|Grapevine|Tarrant
2002011|1999-11-14|1999-11-10|DFW|dallas fort worth intl|Property Damage|Checkpoint|Clothing|45.00|Deny|texas|tx|Dallas|Dallas
2002012|2018-12-08|2018-12-04|IAH|houston intercontinental|Property Damage|Checkpoint|Cameras|120.00|Approve in Full|texas|tx|Houston|Harris
2002013|2013-01-19|2013-01-14|DFW|dallas fort worth intl|Missed Flight|Checkpoint|Documents|30.00|Deny|texas|tx|Dallas|Dallas
2002014|2014-02-27|2014-02-22|DEN|denver intl|Complaint|Checkpoint|Other|80.00|Approve in Full|colorado|co|Denver|Denver
2002015|2015-03-11|2015-03-06|SEA|seattle tacoma intl|Property Damage|Checked Baggage|Sporting Equipment|310.00|Deny|washington|wa|Seattle|King
2002016|2016-04-23|2016-04-18|DFW|dallas fort worth intl|Passenger Property Loss/Personal Injury|Checked Baggage|Jewelry|850.00|Approve in Full|texas|tx|Dallas|Dallas
2002017|2017-05-30|2017-05-25|IAH|houston intercontinental|Property Damage|Checkpoint|Electronics|60.00|Settle|texas|tx|Houston|Harris
2002018|2011-06-15|2011-06-10|DFW|dallas fort worth intl|Passenger Property Loss/Personal Injury|Checked Baggage|Clothing|106000.00|Approve in Full|texas|tx|Dallas|Dallas
2002019|2012-07-20|2012-07-15|ATL|hartsfield jackson|Property Damage|Checkpoint|Luggage|200.00|Deny|georgia|ga|Atlanta|Fulton
2002020|2013-08-05|2013-08-01|DFW|dallas fort worth intl|Property Damage|Checked Baggage|Other|15.00|Settle|texas|tx|Dallas|Dallas
;
run;
