create table asset_inventory (
	asset_inv_id number(10),
	--asset_desc_id number(10) not null,
    asset_type varchar2(50) not null,
    asset_make varchar2(50) not null,
    asset_model varchar2(100) not null,
    asset_ext varchar2(50),
    purchase_or_rental char(8),
    unique_id varchar2(50),
    ci_acquired_date date not null,
    ci_status varchar2(50) not null,
    ci_status_date date not null,
    constraint asset_inv_pk PRIMARY KEY(asset_inv_id)
);


--Jordan Allen
--Ex 11 Task 1 Verify Creating a Denormalized Table
--Logged into Class Server as Your User
select owner, table_name,tablespace_name from all_tables 
where owner = 'JMALLE25';--use your class server username
--Scroll down to as needed to get an accurate number of 
--row retrieved and make sure I can see the new table in 
--your screenshot of the results (ASSET_INVENTORY).


--Jordan Allen
-- Ex 11 Task 2 Retrieve Data to Fill the Denormalized Table.
select ci_inv_id,asset_type_desc,asset_make,asset_model,asset_ext,
purchase_or_rental,unique_id,ci_acquired_date,ci_status_description,
ci_status_date
from jaherna42.ci_status cs full join jaherna42.ci_inventory cii
on cs.ci_status_code = cii.ci_status_code
full join jaherna42.asset_desc ad
on cii.asset_desc_id = ad.asset_desc_id
full join jaherna42.asset_type at
on ad.asset_type_id = at.asset_type_id;


--Jordan Allen
-- Ex 11 Task 3 Modify the Task 2 Query to Eliminate Incomplete Data.
select ci_inv_id,asset_type_desc,asset_make,asset_model,asset_ext,
purchase_or_rental,unique_id,ci_acquired_date,ci_status_description,
ci_status_date
from jaherna42.ci_status cs full join jaherna42.ci_inventory cii
on cs.ci_status_code = cii.ci_status_code
join jaherna42.asset_desc ad
on cii.asset_desc_id = ad.asset_desc_id
full join jaherna42.asset_type at
on ad.asset_type_id = at.asset_type_id;


--Jordan Allen
--Ex 11 Task 4 Answer the Question
--"What data is lost from the original tables? That is, 
--what data in the original tables does not get selected with the 
--Task 3 query?"
/* The data that does not get selected in the Task 3 query is the data with 
no business purpose. Essentially, things that are not purchased and not owned 
by the company. Using the full join on inventory and asset_desc was getting 
asset descriptions that are not in inventory. By changing the outer join of 
inventory to asset_desc to an inner join eliminates this data due to the 
requirements set in the query.
*/


--Jordan Allen
--Ex 11 Task 5 Create a View from the Task 3 Query
create or replace view combine_table_data_jmalle25 as
select ci_inv_id,asset_type_desc, asset_make, asset_model, asset_ext,
purchase_or_rental, unique_id, ci_acquired_date,ci_status_description,
ci_status_date
from jaherna42.ci_status cs full join jaherna42.ci_inventory cii
on cs.ci_status_code = cii.ci_status_code
join jaherna42.asset_desc ad
on cii.asset_desc_id = ad.asset_desc_id
full join jaherna42.asset_type at
on ad.asset_type_id = at.asset_type_id;

--Jordan Allen
--Ex 11 Task 5 Create a View from the Task 3 Query
--Logged into Class Server as Your User
select owner,view_name,text_length from all_views 
where view_name like 'COMBINE_TABLE_DATA_JMALLE25';


insert into asset_inventory --use your new table name
select * from combine_table_data_jmalle25;--use your view 

commit;
--Gather the db statistics for the schema
begin 
dbms_stats.gather_schema_stats(ownname => 'JMALLE25', 
estimate_percent => NULL);
end;

--Jordan Allen
--Ex 11 Task 6 Insert the Data into the Denormalized Table
--Logged into the Class Server as Your User
select owner,table_name, num_rows from all_tables
where table_name = 'ASSET_INVENTORY';


--Jordan Allen
--Ex 11 Task 7 Create Comparable Indexes
--Logged into the Class Server as Your User
select table_owner,index_name,table_name 
from all_indexes
where table_name in('ASSET_DESC','CI_INVENTORY','CI_STATUS',
'ASSET_TYPE','ASSET_INVENTORY') and table_owner in 
('JAHERNA42','JMALLE25');-- the result should show 
--only indexes associated with table PKs


--Jordan Allen
--Ex 11 Task 8 Run a Query against the Normalized Tables
--Ex 4 Task 3 Query - user as NORMALIZED
--Logged into Class Server as Your User
select count(ad.asset_make), ad.asset_make, ad.asset_model
from jaherna42.asset_desc ad join jaherna42.ci_inventory cii
on ad.asset_desc_id = cii.asset_desc_id
where
cii.ci_inv_id not in
(select eci.ci_inv_id
from
jaherna42.employee_ci eci
where upper(eci.use_or_support) != 'USE' and eci.date_unassigned is null)
and (upper(ad.asset_make) = 'LENOVO')
group by (ad.asset_make, ad.asset_model);


--Jordan Allen
--Ex 11 Task 9 Run a Query against the Denormalized Tables
--Ex 4 Task 3 Query - user as DENORMALIZED
--Logged into the Class Server as Your User
select count(asset_make), asset_make, asset_model
from asset_inventory
where
asset_inv_id not in
(select ci_inv_id
from
jaherna42.employee_ci
where upper(use_or_support) != 'USE' and date_unassigned is null)
and (upper(asset_make) = 'LENOVO')
group by (asset_make, asset_model);


--Jordan Allen
--Ex 11 Task 10 Explain the Plan for the Task 8 Query on 
--the Normalized Tables
--Logged into the Class Server as Your User
explain plan for 
select user as NORMALIZED, --rest of your Task 8 query
count(ad.asset_make), ad.asset_make, ad.asset_model
from jaherna42.asset_desc ad join jaherna42.ci_inventory cii
on ad.asset_desc_id = cii.asset_desc_id
where
cii.ci_inv_id not in
(select eci.ci_inv_id
from
jaherna42.employee_ci eci
where upper(eci.use_or_support) != 'USE' and eci.date_unassigned is null)
and (upper(ad.asset_make) = 'LENOVO')
group by (ad.asset_make, ad.asset_model);


--Jordan Allen
--Ex 11 Task 10 Retrieve the Plan for the Task 8 Query
--on the Normalized Tables
--Logged into the Class Server as Your User
select plan_table_output from table(dbms_xplan.display());


--Jordan Allen
--Ex 11 Task 11 Explain the plan for the Task 9 Query on 
--the Denormalized Tables
--Logged into Class Server as Your User
explain plan for 
select user as DENORMALIZED, --rest of your Task 9 query
count(asset_make), asset_make, asset_model
from asset_inventory
where
asset_inv_id not in
(select ci_inv_id
from
jaherna42.employee_ci
where upper(use_or_support) != 'USE' and date_unassigned is null)
and (upper(asset_make) = 'LENOVO')
group by (asset_make, asset_model);


--Jordan Allen
--Ex 11 Task 11 Retrieve the Plan for the Task 9 Query
--on the Denormalized Tables
--Logged into Class Server as Your User
select plan_table_output from table(dbms_xplan.display());


--Jordan Allen
--Ex 11 Task 12 Verify Privileges
--Logged into the Class Server as Your User
select  * from v$sql;


--Jordan Allen
--Ex 11 Task 13 CPU Time for the Task 8 Query
--Logged into the Class Server as Your User
select sql_id,parsing_schema_name,
rows_processed,cpu_time,elapsed_time,sql_fulltext from v$sql where
upper(sql_fulltext) like 'SELECT USER AS NORMAL%' and parsing_schema_name
= 'JMALLE25';


--Jordan Allen
--Ex 11 Task 14 CPU Time for the Task 8 and Task 9 Query
--Logged into the Class Server as Your User
select sql_id,parsing_schema_name,
rows_processed,cpu_time,elapsed_time,sql_fulltext from v$sql where
parsing_schema_name = 'JMALLE25' and
(upper(sql_fulltext) like 'SELECT USER AS NORMAL%' or upper(sql_fulltext) like 
'SELECT USER AS DENORMAL%');

commit;

--Jordan Allen
--Ex 11 Task 15 Compare Denormalized to Normalized
/* In the task 10 query we can see that the explanation for the normalized 
query takes 10 steps. Using the explanation for the denormalized query in task 
11 we can see that the denormalized query takes 4 steps. Using these results 
alone we could hypothesize that the denormalized query in task 11 will perform 
better than the normalized query used in task 10. However, using the results 
from task 14 we can see that the denormalized query does perform better. The 
results show that the denormalized query processed the same number of rows 
with a faster CPU_TIME and a faster ELAPSED_TIME. In conclusion, it appears 
that denormalization does improve the performance of the query.
*/








