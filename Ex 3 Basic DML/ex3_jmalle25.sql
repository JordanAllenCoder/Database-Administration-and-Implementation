/* Task 1 My Solution Command for 
Select From One Table and Use a Where Clause */
--Type your full name here

/* Task 2 My Solution Command for Inner Join (A Join B) */
--Jordan Allen
--My A table is jaherna42.asset_desc
--My B table is jaherna42.asset_type
select a.asset_make,a.asset_model,b.asset_type_desc
from
jaherna42.asset_desc a inner join
jaherna42.asset_type b
on a.asset_type_id = b.asset_type_id;


/* Task 3 My Solution Command for Count Query for Inner Join (A join B)*/
--Jordan Allen
--My A table is jaherna42.asset_desc 
--My B table is jaherna42.asset_type 
select 'A' as my_table,count(*) 
from jaherna42.asset_desc --replace A (but not 'A') with your A table name
union 
select 'B' as my_table,count(*) 
from jaherna42.asset_type --replace B (but not 'B') with your B table name
union 
select 'A join B' as my_table, count(*) 
from jaherna42.asset_desc inner join jaherna42.asset_type
on jaherna42.asset_desc.asset_type_id = jaherna42.asset_type.asset_type_id;


/* Task 4 My Solution Summary Statements 
Table A refers to the asset_desc table. The count for table A
refers to the number of rows inside the asset_desc table. Table B refers to the 
asset_type table. The count for table B is the number of rows inside the 
asset_type table. Table A join B refers to join of tables A and B. The count for
table A joins B refers to the number of rows returned by the join statement.
As you can see the count for A joins B is the same as the count for A. This is 
due to the on condition. The results indicate that there are 286 records that 
meet the conditions of the on statement. Essentially saying that every asset
has successfully been inserted into the asset_desc table with its asset_type 
associated with it.
*/
--Jordan Allen


/* Task 5 My Solution Command for Inner Join Query (B join A) */
--Jordan Allen
--My A table is jaherna42.asset_desc
--My B table is jaherna42.asset_type
select a.asset_type_desc,b.asset_make,b.asset_model
from
jaherna42.asset_desc b inner join
jaherna42.asset_type a 
on b.asset_type_id = a.asset_type_id;


/* Task 6 My Solution Command for Count Query for Inner Join (B join A) */
--Jordan Allen
--My A table is jaherna42.asset_desc 
--My B table is jaherna42.asset_type 
select 'B' as my_table,count(*) 
from jaherna42.asset_type 
union 
select 'A' as my_table,count(*) 
from jaherna42.asset_desc 
union 
select 'B join A' as my_table, count(*) 
from jaherna42.asset_type inner join jaherna42.asset_desc
on jaherna42.asset_type.asset_type_id = jaherna42.asset_desc.asset_type_id;


/* Task 7 My Solution Summary Statements for Compare A join B to B join A 
Ultimately the count stays the same for A join B and B join A. The only 
difference is the format in which the results are displayed. When A joins B the 
result set has A in row 1, A join B in row 2, and B in the third row. 
The count for A is 286, A join B is 286, and B is 7. For the B join A results 
it displays A in row 1, B in row 2, and B join A in row 3. The count for A is 
286, B is 7, and B join A is 286. Even though the command was different it 
yielded the same counts. Since we switched A with B, you can see that the 
values switch from B having 7 to A having 7. The same can be seen in task 2 and
task 5. The format of the output was different but the information being shown
did not change.
*/
--Jordan Allen


/* Task 8 My Solution Command for X Inner Join Y */
--Jordan Allen
--My X table is jaherna42.ci_inventory
--My Y table is jaherna42.employee_ci
select x.asset_desc_id,x.purchase_or_rental,y.use_or_support,y.date_assigned
from
jaherna42.ci_inventory x inner join
jaherna42.employee_ci y
on x.ci_inv_id = y.ci_inv_id;


/* Task 9 My Solution Command for X Left Outer Join Y */
--Jordan Allen
--My X table is jaherna42.ci_inventory
--My Y table is jaherna42.employee_ci
select x.asset_desc_id,x.purchase_or_rental,y.use_or_support,y.date_assigned
from
jaherna42.ci_inventory x left outer join
jaherna42.employee_ci y
on x.ci_inv_id = y.ci_inv_id;


/*Task 10 My Solution Command for X Right Outer Join Y*/
--Jordan Allen
--My X table is jaherna42.ci_inventory
--My Y table is jaherna42.employee_ci
select x.asset_desc_id,x.purchase_or_rental,y.use_or_support,y.date_assigned
from
jaherna42.ci_inventory x right outer join
jaherna42.employee_ci y
on x.ci_inv_id = y.ci_inv_id;


/* Task 11 My Solution Commands for X Full Join Y */
--Type your full name here
--My X table is jaherna42.ci_inventory
--My Y table is jaherna42.employee_ci
select x.asset_desc_id,x.purchase_or_rental,y.use_or_support,y.date_assigned
from
jaherna42.ci_inventory x full join
jaherna42.employee_ci y
on x.ci_inv_id = y.ci_inv_id;


/* Task 12 Write About Your Observations - Compare Inner, Outer, and Full Joins*/
/*The different selections of joins produced different number of rows. 
Due to the structure of the inner join and right outer join they both only 
produced 410 records. There is no null data in any of the records due to the 
structure of the join. The full join and left outer join returned 564 records. 
This is also due to the structure of the joins. These joins returned null data.
All joins run the exact same syntax other than the type of join being performed.
The type of join controls what data you will get back from the command.
*/
--Jordan Allen


/* Task 13 My Solution Command to Compare Inner, Outer, and Full Joins 
Based on Counts */
--Jordan Allen
--My X table is jaherna42.ci_inventory
--My Y table is jaherna42.employee_ci
select 'X' as my_table, count(*)
from jaherna42.ci_inventory --replace X (but not 'X') with ci_inventory
union
select 'Y' as my_table, count(*) 
from jaherna42.employee_ci -- replace Y (but not 'Y') with employee_ci
union
select 'X join Y' as my_table,count(*)  
from jaherna42.ci_inventory x join jaherna42.employee_ci y -- replace X and Y with correct table names 
on x.ci_inv_id = y.ci_inv_id
union
select 'X left join Y' as my_table, count(*)
from jaherna42.ci_inventory x left join jaherna42.employee_ci y 
on x.ci_inv_id = y.ci_inv_id
union
select 'X right join Y' as my_table, count(*)
from jaherna42.ci_inventory x right join jaherna42.employee_ci y 
on x.ci_inv_id = y.ci_inv_id
union
select 'X full join Y' as my_table, count(*)
from jaherna42.ci_inventory x full join jaherna42.employee_ci y  
on x.ci_inv_id = y.ci_inv_id;
/*The values differ due to what the joins allow. The X full join Y and X 
left join Y both have a higher row count due to accepting different values.  
They are also the result of multiple employees using the same ci. X full join 
Y and X right join Y both only have 410 records. Since Y only has 410 rows, we 
know that it is only comparing the ci_inv_id of the records in Y to X since Y 
only has 410 rows.
*/


/* Task 14 My Solution Command for Q Inner Join R */
--Type your full name here
--My Q table is jaherna42.employee 
--My R table is jaherna42.employee_ci
select q.first_name,q.last_name,r.ci_inv_id,r.use_or_support
from
jaherna42.employee q inner join
jaherna42.employee_ci r
on q.emp_id = r.emp_id;


/* Task 15 My Solution Command for Q Left Outer Join R*/
--Type your full name here
--My Q table is jaherna42.employee
--My R table is jaherna42.employee_ci
select q.first_name,q.last_name,r.ci_inv_id,r.use_or_support
from
jaherna42.employee q left outer join
jaherna42.employee_ci r
on q.emp_id = r.emp_id;


/* Task 16 My Solution Command for Q Right Outer Join R */
--Type your full name here
--My Q table is jaherna42.employee
--My R table is jaherna42.employee_ci
select q.first_name,q.last_name,r.ci_inv_id,r.use_or_support
from
jaherna42.employee q right outer join
jaherna42.employee_ci r
on q.emp_id = r.emp_id;


/* Task 17 My Solution Command for Q Full Join R*/
--Type your full name here
--My Q table is jaherna42.employee
--My R table is jaherna42.employee_ci
select q.first_name,q.last_name,r.ci_inv_id,r.use_or_support
from
jaherna42.employee q full join
jaherna42.employee_ci r
on q.emp_id = r.emp_id;


/* My Solution Commands for Task 18 Compare Inner, Outer, and Full Joins 
Based on Counts */
--Type your full name here
--My Q table is jaherna42.employee 
--My R table is jaherna42.employee_ci
select 'Q' as my_table, count(*)
from jaherna42.employee 
union
select 'R' as my_table, count(*) 
from jaherna42.employee_ci 
union
select 'Q join R' as my_table,count(*)  
from jaherna42.employee Q join jaherna42.employee_ci R 
on Q.emp_id = R.emp_id
union
select 'Q left join R' as my_table, count(*)
from jaherna42.employee Q left join jaherna42.employee_ci R 
on Q.emp_id = R.emp_id
union
select 'Q right join R' as my_table, count(*)
from jaherna42.employee Q right join jaherna42.employee_ci R 
on Q.emp_id = R.emp_id
union
select 'Q full join R' as my_table, count(*)
from jaherna42.employee Q full join jaherna42.employee_ci R  
on Q.emp_id = R.emp_id;


select * from jaherna42.asset_type
select * from jaherna42.asset_desc
select * from jaherna42.ci_inventory
select * from jaherna42.employee_ci


/*Task 20 Write a business reason for a SQL data retrieval command
against the tables of user jaherna42's IT asset management schema 
tables.*/
--Jordan Allen
select a.asset_make, a.asset_model, c.ci_status_code, d.use_or_support
from
jaherna42.asset_desc a left join jaherna42.ci_inventory c
on a.asset_desc_id = c.asset_desc_id
left join jaherna42.employee_ci d on c.ci_inv_id = d.ci_inv_id;


commit;

