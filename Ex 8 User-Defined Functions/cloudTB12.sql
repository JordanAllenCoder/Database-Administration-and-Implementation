--Jordan Allen
--Ex 8 Task 1 Create a Function to Test YourUser1's Privileges
create or replace function tb12privledges--create your own name for the function
return varchar2
as
matching_ids varchar2(50) := 'No make found';--create your own name for the variable
ran_val number;
largest number;
smallest number;
count_rows number;
begin
--the statement selects the largest asset_desc_id and places it in largest
select round(max(asset_desc_id),0) into largest from itam.asset_desc;
--the statement selects the smallest asset_desc_id and places it in smallest
select min(asset_desc_id) into smallest from itam.asset_desc;
--dbms_random.value selects a random value between the smallest 
--and largest and places it into ran_val
select round(dbms_random.value(smallest,largest),0)
    into ran_val from dual;
--this command counts the rows of all the instances where the random value 
--from above equals a value in the asset_desc_id column
select count(*) into count_rows 
from itam.asset_desc where asset_desc_id = ran_val;
--if there are no matching ids, then print the 'no make found' statement.
--If there are matching ids found then print the asset make where 
--there are matching ids.
if count_rows = 0 then matching_ids := 'No make found';
else
select asset_make into matching_ids
from itam.asset_desc where asset_desc_id = ran_val;
end if;
return matching_ids;
end;

--Jordan Allen
--Ex 8 Task 2 Use the Function
select tb12privledges() from dual;--use the name of your function


--Jordan Allen
--Ex 8 Task 3 Use the Function in a Loop
declare i number := 1;
returninfo varchar2(50) := 'No Make Found';--change the variable name
begin
WHILE i < 10 LOOP
 select tb12privledges() into returninfo from dual;--use the name of your function
 dbms_output.put_line('i: ' || i || ' ' || returninfo);
 i := i + 1;
end LOOP;
end; 

select * from itam.asset_desc

--Jordan Allen
--Ex 8 Task 4 Create a Function to Get the Number of CIs
create or replace function get_num_cis
(
   asset_make varchar2,--declare parameter for asset make
   asset_model varchar2,--declare parameter for asset model 
   ext_info_param varchar2,--declare parameter for asset extended information
   asset_type_id_a number--declare parameter for asset type number
)
return varchar2--set the data type to be returned by the function
as
  get_cis varchar2(50);--declare variable to hold the count to be derived by the function
begin
  select count(*)
  into get_cis--where you will hold the value
  from itam.ci_inventory cii 
  join itam.asset_desc ad
  on cii.asset_desc_id = ad.asset_desc_id--write the proper condition for the join
  where asset_make = asset_make--match to a parameter value
  and asset_model = asset_model--match to a paramter value
  and  ext_info_param = asset_ext--match to a parameter value
  and  asset_type_id = asset_type_id;--match to a paramter value;
  return get_cis;
end;

--Jordan Allen
--Ex 8 Task 5 Use the Function From Task 4
select get_num_cis('Microsoft', 'Windows Server 2019', 'Factory installed on HP Server', 7) from dual;


--Jordan Allen
--Ex 8 Task 6 Use the Function From Task 4
select get_num_cis('Apple', 'In-house build', 'Factory Installation', 100) from dual;


--Jordan Allen
/*Ex 8 Task 8 Create a function */
create or replace function get_spare_cis
(
   asset_make varchar2,--declare parameter for asset make
   asset_model varchar2,--declare parameter for asset model 
   ext_info_param varchar2,--declare parameter for asset extended information
   asset_type_id number--declare parameter for asset type number
)
return varchar2
as
 hold_count--declare a varialbe to hold the number derived for the count
 hold_asset_desc;--declare a variable to hold the number of the type for the asset description
begin
  select asset_type_id into hold_asset_desc--variable to hold the type number
  from itam.asset_type where asset_type_desc = asset_type_id--match to a parameter;
  select count(distinct cii.ci_inv_id)
  into hold_count--variable to hold the derived count
  from itam.ci_inventory cii--the table with the inventory information
  join itam.asset_desc ad--the table with the asset descriptions
  on cii.asset_desc_id = ad.asset_desc_id--write a proper join condition
  where (asset_make = asset_make--the field for make matches the parameter for make 
  and asset_model = asset_model--the field for model matches the parameter for model 
  and ext_info_param = asset_ext--the field for extended information matches the parameter for it 
  and asset_type_id = asset_type_id--the field for type number matches the variable holding that number
  and  (--field from the join operation
  not in (--result set of the same type as the field from the join operation
  --selected from the table where CIs get assigned to employees
  where upper(use_or_support) = 'USE'--match to a value meaning its in use
  and date_unassigned is null--match to a value that means it's currently in use))
  and upper(cii.ci_status_code) = 'WORKING';--match to a value to indicate it's not broken or gone
  return hold_count;--the variable with the count
end;


--Jordan Allen
/*Ex 8 Task 9 Use the Function to Get a Count for a CI you Added to the Tables */
select get_spare_cis('Microsoft', 'Windows Server 2019', 'Factory installed on HP Server', 7) from dual;


--Jordan Allen
/*Ex 8 Task 10 Use the Function from Task 8 to Get a Count of 0 */
select get_spare_cis('Apple', 'In-house build', 'Factory Installation', 100) from dual;




select * from itam.asset_desc
select * from itam.ci_inventory
select * from itam.employee_ci