
/* Ex 8 User-Defined Functions */

/* Through the tasks for this exercise you create several functions
that refer to the tables of the ITAM schema managed by your cloud database 
instance. You create the functions as the user you created as YourUser1 in 
Ex 6. Your were allowed to name this user whatever you wanted, so the name 
of the user is not actually "YourUser1", probably. It is the user to whom 
you granted privileges directly to the ITAM tables (rather than through the 
itam_user role. */

/*From a business perspective, the functions might be used by applications 
used to manage information about the IT assets owned by ABCCo, some of 
which are assigned to their employees to use to do their jobs.*/

/* The deliverable for Ex 8 is a Word document with screen shots documenting 
the creation of each stored procedure or function followed by screen shots 
verifying its use. Each screenshot should contain your name typed in Oracle 
SQL Developer in the pane where you develop your code.*/



/* Task 1. Create a Function to Test YourUser1's Privileges
This task is to assure that the user you created as YourUser1 in Ex6 has 
proper privileges to create functions in his/her schema that refer to 
tables owned by the user ITAM. (You granted table privileges to your 
YourUser1 in Ex 6.) Signed in as the user you created as YourUser1 in 
Ex 6, create the function using the given template code. The function 
returns data from the tables belonging to user ITAM after some processing.
When you use the template code to create the function in your YourUser1's 
schema, name the function and its output variable differently from the 
template. Also explain in commented out statements what the indicated lines 
of code do. In Task 2, you document using the function. */

--Type your name here
--Ex 8 Task 1 Create a Function to Test YourUser1's Privileges
create or replace function testprivs--create your own name for the function
return varchar2
as
gotcha varchar2(50) := 'No make found';--create your own name for the variable
ran_val number;
largest number;
smallest number;
count_rows number;
begin
--State what the next command does.
select round(max(asset_desc_id),0) into largest from itam.asset_desc;
--State what the next command does.
select min(asset_desc_id) into smallest from itam.asset_desc;
--State what the next command does.
select round(dbms_random.value(smallest,largest),0)
    into ran_val from dual;
--State what the next command does.
select count(*) into count_rows 
from itam.asset_desc where asset_desc_id = ran_val;
--State what the next decision structure does.
if count_rows = 0 then gotcha := 'No make found';
else
select asset_make into gotcha
from itam.asset_desc where asset_desc_id = ran_val;
end if;
return gotcha;
end;



/* Task 2. Use the Function
Demonstrate using your function by running the select 
command provided.*/

--Type your name here
--Ex 8 Task 2 Use the Function
select testprivs() from dual;--use the name of your function



/* Task 3. Use the Function in a Loop
Demonstrate using your function a number of times (in a loop) 
to produce at least three different output values. The three 
different values that must be demonstrated are two different 
values of asset_make and at least one occurrence of the value
'No make found.' A code template is provided that uses a while
loop. Change the code to use a FOR loop structure or and UNTIL
loop structure. In order to retrieve the three different output 
values requested, you may have to adjust the number of times the 
function is called by adjusting the loop paramters for your loop. 
You may have to run the block with the loop several times to get 
the output requested. */

--Type your name here
--Ex 8 Task 3 Use the Function in a Loop
declare i number := 1;
make_val varchar2(50) := 'No Make Found';--change the variable name
begin
WHILE i < 10 LOOP
 select testprivs() into make_val from dual;--use the name of your function
 dbms_output.put_line('i: ' || i || ' ' || make_val);
 i := i + 1;
end LOOP;
end; 




/* Here is an example function similar to the one you are asked to 
create for Task 4. jdoe22 created it to run against the invoices 
table in his schema that is like the AP.invoices table. The example 
is loosely based on Figure 15-9 in the Murach book.  What is the 
business purpose of this function; that is, what does it do 
(as you would explain it to your boss)? You do not have to include 
the answer to this question in your deliverable document. The 
question is here to help you think as you complete the exercise.*/

create or replace FUNCTION get_how_many_invoices
(
   vendor_id_param number
)
RETURN number
AS 
  how_many_var number;
begin
  select COUNT(*)
  into how_many_var
  from invoices
  where vendor_id = vendor_id_param
  AND invoice_total - payment_total - credit_total > 0;
  
  RETURN how_many_var;
end;
/

/*Here is an example of using the the function.*/
select get_how_many_invoices(34) from dual;



/* Task 4. Create a Function to Get the Number of CIs
Create a function that returns how many of a particular IT asset
description are accounted for in inventory. The assignement 
status of each CI is not important for this count. Create the 
function to require four values to be passed into the function 
upon use. Three of the four values are string literals, which 
correspond to the make, model, and extended information of the 
asset description in the asset description table. The fourth 
value is the asset type number in the asset_description table. 
After creating the function for Task 4, provide examples of using 
it for Task 5. */

--Type your name here
--Ex 8 Task 4 Create a Function to Get the Number of CIs
create or replace function name_your_function
(
   --declare parameter for asset make
   --declare parameter for asset model 
   --declare parameter for asset extended information
   --declare parameter for asset type number
)
return --set the data type to be returned by the function
as
  --declare variable to hold the count to be derived by the function
begin
  select count(*)
  into --where you will hold the value
  from itam.ci_inventory cii 
  join itam.asset_desc ad
  on --write the proper condition for the join
  where asset_make = --match to a parameter value
  and asset_model = --match to a paramter value
  and  ext_info_param = --match to a parameter value
  and  asset_type_id = --match to a paramter value;
  return how_many_var;
end;



/* Task 5. Use the Function from Task 4 */
/* Use the function you created in Task 4 in a select statement (from dual)
where you pass values valid to identify an asset description that at least
one CI in inventory has. */

--Type your name here
--Ex 8 Task 5 Use the Function From Task 4 */




/* Task 6 Use the Function from Task 4 */
/* Use the function you created in Task 4 in a select statement (from dual)
where you pass values that are not valid to identify an asset description 
that at least one CI in inventory has. */

--Type your name here
--Ex 8 Task 6 Use the Function From Task 4 */




/* Task 7. No Data Found Exception
Briefly explain why the function does not cause the No Data Found exception
to be thrown for Task 6 even though you do not handle for that exception. */




/* Task 8. Create a function that returns the number of spare CIs
there are for a particular IT asset description that has one or 
more instances in inventory (these are configuration items). Spare 
means that the CI is inventory but is not currently assigned for use 
by an employee and is not disposed of or in repair. Pass four values 
into the function, all of which are string literals. The four inputs 
are the make,the model, and the extended information of the CI's 
description, as well as the type description of the CI. After creating 
the function for Task 8, provide at least two examples of using it for 
Task 9.*/

--Type your name here
/*Ex 8 Task 8 Create a function */

create or replace function name_your_function
(
   --declare parameter for asset make
   --declare parameter for asset model 
   --declare parameter for asset extended information
   --declare parameter for asset type descripttion
)
return --say what type of data the function returns
as
 --declare a varialbe to hold the number derived for the count
 --declare a variable to hold the number of the type for the asset description
begin
  select asset_type_id into --variable to hold the type number
  from itam.asset_type where asset_type_desc = --match to a parameter;
  select count(distinct cii.ci_inv_id)
  into --variable to hold the derived count
  from --the table with the inventory information
  join --the table with the asset descriptions
  on --write a proper join condition
  where (--the field for make matches the parameter for make 
  and --the field for model matches the parameter for model 
  and --the field for extended information matches the parameter for it 
  and --the field for type number matches the variable holding that number
  and  (--field from the join operation
  not in (--result set of the same type as the field from the join operation
  --selected from the table where CIs get assigned to employees
  where upper(use_or_support) = --match to a value meaning its in use
  and date_unassigned --match to a value that means it's currently in use))
  and upper(cii.ci_status_code) = --match to a value to indicate it's not broken or gone
  ;
  return --the variable with the count
end;
  

/* Task 9. Use the Function to Get a Count for a CI you Added to the Tables
Demonstrate using the function to retrieve a count for a CI that
you added to the tables of the schema (in Ex 2 and in Ex 6). */

--Type your name here
/*Ex 8 Task 9 Use the Function to Get a Count for a CI you Added to the Tables */



/* Task 10. Use the Function from Task 8 to Get a Count of 0
Demonstrate using the function to retrieve a count for a CI for 
which there are no spares. */

--Type your name here
/*Ex 8 Task 10 Use the Function from Task 8 to Get a Count of 0 */








