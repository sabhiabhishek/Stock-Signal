use assignment;
SET SQL_MODE= ' ';

# QUESTION 1   111111111111111111111111   1111111111111111111111111     111111111111111111111     111111111111111111111

###  QUESTION-1   ###### moving average 20 days, 50 days for bajaj1 table -    
CREATE TABLE BAJAJ1 AS select date,close_price,avg(close_price) over(order by date rows between 19 preceding and current row) as '20_Day_MA',
avg(close_price) over(order by date rows between 49 preceding and current row) as '50_Day_MA' from bajaj;

#it will give some default value for upto 19 row so we do not need them, then we set them null
update bajaj1
set 20_day_MA= NULL LIMIT 19;
UPDATE bajaj1
SET 50_DAY_MA=NULL LIMIT 49;

SELECT*FROM BAJAJ1;


###QUESTION --1  ########## moving average 20 days, 50 days for eicher1 table-
create TABLE EICHER1 AS
select date,close_price,avg(close_price) over(order by date rows between 19 preceding and current row) as '20_Day_MA',
avg(close_price) over(order by date rows between 49 preceding and current row) as '50_Day_MA' from eicher;

#it will give some default value for upto 19 row so we do not need them, then we set them null
update eicher1
set 20_day_MA= NULL LIMIT 19;
UPDATE eicher1
SET 50_DAY_MA=NULL LIMIT 49;

SELECT*FROM EICHER1;


###  QUESTION --1 ############# moving average 20 days, 50 days for hero1 table-
CREATE TABLE HERO1 AS
select date,close_price,avg(close_price) over(order by date rows between 19 preceding and current row) as '20_Day_MA',
avg(close_price) over(order by date rows between 49 preceding and current row) as '50_Day_MA' from hero;

#it will give some default value for upto 19 row so we do not need them, then we set them null
update hero1
set 20_day_MA= NULL LIMIT 19;
UPDATE hero1
SET 50_DAY_MA=NULL LIMIT 49;

SELECT *FROM HERO1;


###  QUESTION --1  ########## moving average 20 days, 50 days for infosys1 table-
drop table infosys1;
CREATE TABLE INFOSYS1
select date,close_price,avg(close_price) over(order by date rows between 19 preceding and current row) as '20_Day_MA',
avg(close_price) over(order by date rows between 49 preceding and current row) as '50_Day_MA' from infosys;

#it will give some default value for upto 19 row so we do not need them, then we set them null
update infosys1
set 20_day_MA= NULL LIMIT 19;
UPDATE infosys1
SET 50_DAY_MA=NULL LIMIT 49;

SELECT*FROM INFOSYS1;

### QUESTION-1 ###### moving average 20 days, 50 days for tcs1 table-
CREATE TABLE TCS1
select date,close_price,avg(close_price) over(order by date rows between 19 preceding and current row) as '20_Day_MA',
avg(close_price) over(order by date rows between 49 preceding and current row) as '50_Day_MA' from tcs;

#it will give some default value for upto 19 row so we do not need them, then we set them null
update tcs1
set 20_day_MA= NULL LIMIT 19;
UPDATE tcs1
SET 50_DAY_MA=NULL LIMIT 49;

SELECT*FROM TCS1;


## QUESTION-1  ########### moving average 20 days, 50 days for tvs1 table-

CREATE TABLE TVS1 AS
select date,close_price,avg(close_price) over(order by date rows between 19 preceding and current row) as '20_Day_MA',
avg(close_price) over(order by date rows between 49 preceding and current row) as '50_Day_MA' from tvs;
#it will give some default value for upto 19 row so we do not need them, then we set them null
update tvs1
set 20_day_MA= NULL LIMIT 19;
UPDATE tvs1
SET 50_DAY_MA=NULL LIMIT 49;

SELECT*FROM TVS1;

### QUESTION-2          222222222222     2222222222222222222222222222222      2222222222222222222222222222222222        2222222222222222222222222222222222222222

# Master table containig the date and close price of all the six stocks
# using  join 
CREATE TABLE master as select bajaj1.date,bajaj1.close_price as bajaj,tcs1.close_price as TCS,tvs1.close_price as TVS,infosys1.close_price as Infosys,
eicher1.close_price as Eicher,hero1.close_price as Hero from bajaj1
inner join tcs1 on bajaj1.date=tcs1.date 
inner join tvs1 on bajaj1.date=tvs1.date
inner join infosys1 on bajaj1.date=infosys1.date
inner join eicher1 on bajaj1.date=eicher1.date
inner join hero1 on bajaj1.date=hero1.date;
     
select*from master;


#### QUESTION-3____33333333      33333333333333     333333333333333333   3333333333333333333     333333333333333333333  3333333333333333333333333333

                                                  ### bajaj Stock ###  bajaj Stock

# from table which use in question 1 we create a new table to add rownumber and add code for predict CODE-0 if 20MA<50MA CODE-1 IF 20MA>50MA
create table bajajx as   
 select date,row_number() over (order by date) as rownumber,close_price,
          CASE
          WHEN 20_day_ma> 50_day_ma  THEN '1'
          WHEN 20_day_ma < 50_day_ma THEN '0'
		ELSE null
       END as code
FROM  bajaj1;

# FROM Previous table We Use LEAD() Function we create a new row which lead by 1 row which will help to predict sign 
create table bajajx1 as
select date,rownumber,close_price,code,lead(code,1)over(order by date)code1 from bajajx;

# Final table to show sign,when to sell when to buy and when to hold 
create table bajaj2 as
select date,close_price,
case 
when code <>code1 and code='0' then 'buy'
when code<>code1 and code='1' then ' sell'
when rownumber<50 then null
else 'hold'
end as Sign
from bajajx1;

select*from bajaj2;


 ### QUESTION-3    For       TCS          Stock           TCS            TCS             TCS            TCS            TCS          TCS  

# from table which use in question 1 we create a new table to add rownumber and add code for predict CODE-0 if 20MA<50MA CODE-1 IF 20MA>50MA
create table TCSx as   
 select date,row_number() over (order by date) as rownumber,close_price,
          CASE
          WHEN 20_day_ma> 50_day_ma  THEN '1'
          WHEN 20_day_ma < 50_day_ma THEN '0'
		ELSE null
       END as code
FROM  TCS1;

# FROM Previous table We Use LEAD() Function we create a new row which lead by 1 row which will help to predict sign 
create table TCSx1 as
select date,rownumber,close_price,code,lead(code,1)over(order by date)code1 from TCSx;

# Final table to show sign,when to sell when to buy and when to hold 
create table TCS2 as
select date,close_price,
case 
when code <>code1 and code='0' then 'buy'
when code<>code1 and code='1' then ' sell'
when rownumber<50 then null
else 'hold'
end as Sign
from TCSx1;

select*from TCS2;

 # QUESTION-3         TVS     TVS     TVS      TVS     TVS     TVS     TVS     TVS     TVS     TVS        TVS      TVS       TVS
 
 # from table which use in question 1 we create a new table to add rownumber and add code for predict CODE-0 if 20MA<50MA CODE-1 IF 20MA>50MA
create table TVSx as   
 select date,row_number() over (order by date) as rownumber,close_price,
          CASE
          WHEN 20_day_ma> 50_day_ma  THEN '1'
          WHEN 20_day_ma < 50_day_ma THEN '0'
		ELSE null
       END as code
FROM  TVS1;

# FROM Previous table We Use LEAD() Function we create a new row which lead by 1 row which will help to predict sign 
create table TVSx1 as
select date,rownumber,close_price,code,lead(code,1)over(order by date)code1 from TVSx;

# Final table to show sign,when to sell when to buy and when to hold 
create table TVS2 as
select date,close_price,
case 
when code <>code1 and code='0' then 'buy'
when code<>code1 and code='1' then ' sell'
when rownumber<50 then null
else 'hold'
end as Sign
from TVSx1;

select*from TVS2;

#QUESTION -3    INFOSYS           INFOSYS                  INFOSYS                   INFOSYS                  INFOSYS               INFOSYS 
  
  # from table which use in question 1 we create a new table to add rownumber and add code for predict CODE-0 if 20MA<50MA CODE-1 IF 20MA>50MA
  create table INFOSYSx as   
 select date,row_number() over (order by date) as rownumber,close_price,
          CASE
          WHEN 20_day_ma> 50_day_ma  THEN '1'
          WHEN 20_day_ma < 50_day_ma THEN '0'
		ELSE null
       END as code
FROM  INFOSYS1;

# FROM Previous table We Use LEAD() Function we create a new row which lead by 1 row which will help to predict sign 
create table INFOSYSx1 as
select date,rownumber,close_price,code,lead(code,1)over(order by date)code1 from INFOSYSx;

# Final table to show sign,when to sell when to buy and when to hold 
create table INFOSYS2 as
select date,close_price,
case 
when code <>code1 and code='0' then 'buy'
when code<>code1 and code='1' then ' sell'
when rownumber<50 then null
else 'hold'
end as Sign
from INFOSYSx1;

select*from INFOSYS2;

#QUESTION-3					### For  Eicher stock     ###   for  Eicher stock       EICHER        EICHER         EICHER    

# from table which use in question 1 we create a new table to add rownumber and add code for predict CODE-0 if 20MA<50MA CODE-1 IF 20MA>50MA
create table eicherx as
 select date,row_number() over (order by date) as rownumber,close_price,
          CASE
          WHEN 20_day_ma> 50_day_ma  THEN '1'
          WHEN 20_day_ma < 50_day_ma THEN '0'
		ELSE null
       END as code
FROM  eicher1;
# FROM Previous table We Use LEAD() Function we create a new row which lead by 1 row which will help to predict sign 
create table eicherx1 as
select date,rownumber,close_price,code,lead(code,1)over(order by date)code1 from eicherx;

# final table to show sign,when to sell when to buy and when to hold 
create table eicher2 as
select date,close_price,
case 
when code <>code1 and code='0' then 'buy'
when code<>code1 and code='1' then ' sell'
when rownumber<50 then null
else 'hold'
end as Sign
from eicherx1;

select*from eicher2;


#QUESTION -3	  # FOR     HERO                       HERO                       HERO                        HERO
                        
# from table which use in question 1 we create a new table to add rownumber and add code for predict CODE-0 if 20MA<50MA CODE-1 IF 20MA>50MA
create table HEROx as
 select date,row_number() over (order by date) as rownumber,close_price,
          CASE
          WHEN 20_day_ma> 50_day_ma  THEN '1'
          WHEN 20_day_ma < 50_day_ma THEN '0'
		ELSE null
       END as code
FROM  HERO1;
# FROM Previous table We Use LEAD() Function we create a new row which lead by 1 row which will help to predict sign 
create table HEROx1 as
select date,rownumber,close_price,code,lead(code,1)over(order by date)code1 from HEROx;

# final table to show sign,when to sell when to buy and when to hold 
create table HERO2 as
select date,close_price,
case 
when code <>code1 and code='0' then 'buy'
when code<>code1 and code='1' then ' sell'
when rownumber<50 then null
else 'hold'
end as Sign
from HEROx1;

select*from HERO2;


# QUESTION 4 -------444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
#
### USER DEFINE FUNCTION TO RETURN SIGNAL AT A PERTICULAR DATE, FUNCTION TAKE  DATE AS INPUT AND RETURN SIGNAL

create function signal_show (dates date)
returns char(50) deterministic
return (select sign from bajaj2 where date = dates);

#  enter date format yyyy-mm-dd    
select signal_show ('2015-12-10') as 'signal ';
select signal_show('2017-01-16') as 'signal';
select signal_show('2015-06-16') as 'signal';

# TRY- SOME DATES '2015-05-15','2015-08-21','2017-01-16','2015-12-10','2018-01-01' etc....
# we can fetch some additionnal information like which stock is good for investment etc like that using SQL queries. I mention some info in pdf summary















