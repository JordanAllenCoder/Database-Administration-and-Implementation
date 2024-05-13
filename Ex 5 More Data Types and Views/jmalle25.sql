--Ex 5 Task 1 Command 1 Most Recent Download
--Jordan Allen
SELECT c.cust_firstname, c.cust_lastname, d.app_code, d.srvr_timestamp
FROM jaherna42.customer c join jaherna42.download d  
on d.cust_id = c.cust_id
order by d.srvr_timestamp desc


--Ex 5 Task 2 Compare to Your Time Zone
--Jordan Allen
select 'Central' as zone, tz_offset('America/Chicago')
from dual
union
select 'CEST' as zone, 
tz_offset('Europe/Prague') from dual;


--Ex 5 Task 3 Time Zone Arithmetic
--Jordan Allen
/*select
    to_timestamp_tz('07-SEP-2022 11.42.18.157960000 PM EUROPE/PRAGUE') as app_download,
    systimestamp as current_time,
    app_download - current_time as difference
from dual*/
/* I left the origanal code that I was trying to write back when Ex 5 was no 
more than a week or two late. This was one of the 2 questions that I was 
unable to answer when Ex 5 was origanally due. This code below was formed 
with both a reference to Oracle.com and Stacksoverflow.com */
select extract( day from diff ) days,
    extract( hour from diff ) hours,
    extract( minute from diff ) minutes,
    extract( second from diff ) seconds
    from (select systimestamp - to_timestamp_tz('07-SEP-2022 11.42.18.157960000 PM EUROPE/PRAGUE') diff
    from dual);
--Write your sentence to state the data type here
-- The data type being used here is the TIMESTAMP data type.


--Ex 5 Task 4 More than One Dowload
--Jordan Allen
select cust_id
from jaherna42.download
group by cust_id
having count(cust_id) > 1


--Ex 5 Task 5 Time Between Earliest and Latest Download for
--Customers with More than One Download
--Jordan Allen
select cust_id, download_id, srvr_timestamp, 
numtodsinterval(max(srvr_timestamp)-min(srvr_timestamp),'DAY') 
as time_diff
from jaherna42.download
where cust_id = cust_id and numtodsinterval(
max(srvr_timestamp)-min(srvr_timestamp),'DAY') 
AND having count(cust_id) > 1;
/* I tried quite a few different methods in order to complete this query, but 
no matter what I did I would eventually refine my error to 
"group function is not allowed here".
*/


-- Ex 5 Task 6 Write the Query
--*Note that it is OK if you use hard-coded dates in the where clause
--Jordan Allen
SELECT ec.date_assigned, 
       ci.unique_id,
       ad.asset_make,
       ad.asset_model,
       ad.asset_ext,
       att.asset_type_desc 
FROM jaherna42.employee_ci ec
INNER JOIN jaherna42.ci_inventory ci ON ec.ci_inv_id = ci.ci_inv_id
INNER JOIN jaherna42.asset_desc ad ON ci.asset_desc_id = ad.asset_desc_id
INNER JOIN jaherna42.asset_type att ON ad.asset_type_id = att.asset_type_id
WHERE ec.date_assigned between to_date('01/JAN/2022','dd/mon/yyyy') and
to_date('30/SEP/2022','dd/mon/yyyy') and ec.use_or_support = 'USE';


/* I never made it to question 7. After deciding to move on from question 
5 and answering question 6, I decided that I would have to try and turn 
this assignment in by the end of the semester. Then Ex 6 was a very long 
assignment and it led me to get behind on 7. Thankfully I finished all 
the assignments, and this is my last Ex to submit! I have learned ALOT about 
operating database's and it has helped me tremendously in my other courses. 
The reason this message is important is because the dates from the question 
6 and question 7 query’s do not add up like they would have if I didn't have 
a two month gap in between completing the questions.
*/


--Ex 5 Task 7 Create the View
--Jordan Allen
create or replace view vw_nine_month_ci_review_jmalle25
as
SELECT ec.date_assigned, 
       ci.unique_id,
       ci.ci_inv_id,
       ad.asset_make,
       ad.asset_model,
       ad.asset_ext,
       att.asset_type_desc 
FROM jaherna42.employee_ci ec
INNER JOIN jaherna42.ci_inventory ci ON ec.ci_inv_id = ci.ci_inv_id
INNER JOIN jaherna42.asset_desc ad ON ci.asset_desc_id = ad.asset_desc_id
INNER JOIN jaherna42.asset_type att ON ad.asset_type_id = att.asset_type_id
WHERE ec.date_assigned between to_date('01/MAR/2022','dd/mon/yyyy') and
to_date('30/NOV/2022','dd/mon/yyyy') and ec.use_or_support = 'USE';


--Ex 5 Task 8 Use the View to Return Data
--Jordan Allen
select * from vw_nine_month_ci_review_jmalle25;


--Ex 5 Task 9 Change Data Through the View
--Jordan Allen
--The column that is insertable, updateable, etc. through the view is date_assigned
--Screenshot 1 - The command to insert, update, or delete through the view
--and result
update VW_NINE_MONTH_CI_REVIEW_JMALLE25
set date_assigned = to_date('08/MAR/2022','dd/mon/yyyy')
where ci_inv_id = '407';
--Screenshot 2 - A select from the base tables that verifies the
--success of the change-through-the-view operation
select * from jaherna42.employee_ci
where unique_id = 'Serial No. 273613';

--Ex 5 Task 10 Modify the View and Use the View
--Jordan Allen
create or replace view vw_nine_month_ci_review_jmalle25
as
SELECT ec.date_assigned, 
       ci.unique_id,
       ad.asset_make,
       ad.asset_model,
       ad.asset_ext,
       att.asset_type_desc 
FROM jaherna42.employee_ci ec
INNER JOIN jaherna42.ci_inventory ci ON ec.ci_inv_id = ci.ci_inv_id
INNER JOIN jaherna42.asset_desc ad ON ci.asset_desc_id = ad.asset_desc_id
INNER JOIN jaherna42.asset_type att ON ad.asset_type_id = att.asset_type_id
WHERE ec.date_assigned between to_date('01/MAR/2022','dd/mon/yyyy') and
to_date('30/NOV/2022','dd/mon/yyyy') and ec.use_or_support = 'USE' and 
ec.date_unassigned is null;

--Ex 5 Task 10 Answer the Question Asked
--Jordan Allen
/* No. I was not able to get either of the views to update. I could 
not figure out why. I think it may have to do with the way I joined 
the tables in the query. I tried modifying my query a few times but 
everytime Ifelt like I was going to be able to excute an update I 
would get an error saying that I was not allowed to change or remove
data inserted by another user.
*/

