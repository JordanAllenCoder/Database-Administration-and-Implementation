
/* Ex 9 Stored Procedures */

/* The tasks for this exercise refer to the the tables of the ITAM schema that 
are owned by one of your users in the cloud. Your should be able to connect as
YourUser1, creating the stored procedures and function in that schema, with the
procedures and function accessing the tables of the ITAM user. You can, 
alternatively, create the procedures and function in your schema on the class 
server, and have the procedures and function access the tables of the JAHERNA42
user. The problem with the cloud instance is that it does not have as much data 
as the JAHERNA42 tables, but the JAHERNA42 option has problems due to data 
that does not adhere to all the business rules. */

/*From a business perspective, the stored procedures and the function might be 
used by an application used to manage information about the IT assets owned by 
ABCCo, some of which are assigned to their employees to use to do their jobs.*/

/* The deliverable for Ex 9 is a Word document with screen shots documenting 
the creation of each stored procedure or function followed by screen shots 
verifying its use. Each screenshot should contain your name typed in Oracle 
SQL Developer in the pane where you develop your code.*/



/* Here is an example stored procedure somewhat similar to the one 
you are asked to create for Task 1 (Task 1 follows after the examples 
of calling this procedure.) It inserts into the invoices table based 
on the invoices table of the AP schema. The example is based on 
Figure 15-5 in the Murach book. */
create or replace procedure insert_invoice
(
  vendor_id_param        invoices.vendor_id%type,
  invoice_number_param   invoices.invoice_number%type,
  invoice_date_param     invoices.invoice_date%type,
  invoice_total_param    invoices.invoice_total%type default null,
  payment_total_param    invoices.payment_total%type default null,
  credit_total_param     invoices.credit_total%type default null,
  terms_id_param         invoices.terms_id%type default null,
  invoice_due_date_param invoices.invoice_due_date%type default null,
  payment_date_param     invoices.payment_date%type default null,
  success_param          out char
)
as
  invoice_id_var         invoices.invoice_id%type;
  terms_id_var           invoices.terms_id%type;
  invoice_due_date_var   invoices.invoice_date%type;  
  terms_due_days_var     number(8);  
begin
  select 'S' into success_param from dual;
  
  if invoice_total_param < 0 then
    raise VALUE_ERROR;
  end if;
  
  select invoice_id_seq.nextval into invoice_id_var from dual;

  if terms_id_param IS null then
    select default_terms_id into terms_id_var
    from vendors where vendor_id = vendor_id_param;
  else
    terms_id_var := terms_id_param;
  end if;

  if invoice_due_date_param is null then
    select terms_due_days into terms_due_days_var
      from terms where terms_id = terms_id_var;
    invoice_due_date_var 
      := invoice_date_param + terms_due_days_var;
  else
    invoice_due_date_var := invoice_due_date_param;
  end if;

  insert into invoices values(invoice_id_var, vendor_id_param, invoice_number_param,
    invoice_date_param, invoice_total_param, payment_total_param, credit_total_param, terms_id_var,
    invoice_due_date_var, payment_date_param);
exception
  when VALUE_ERROR then
    select 'VE' into success_param from dual;
  when others then
    select 'F' into success_param from dual;
end;

drop procedure insert_invoice;
/

/* Next are examples of calling the stored procedure, 
capturing the value passed back that indicates success 
or failure of the insert operation to a calling application.
The call examples were performed against jdoe22's invoices 
table that he has in his own schema, not against the AP 
schema's invoices table. The first call produced a success
code of S displayed in the DBMS_OUTPUT window; the second 
one produced a success code of F.*/

declare 
  success_or_fail char;
begin
  insert_invoice(34, 'ZXA-081', '30-SEP-16', 14092.59, 
   null, null, 3, '29-OCT-16', null,success_or_fail);
  dbms_output.put_line(success_or_fail);
end;

declare 
  success_or_fail char;
begin
  insert_invoice(34, 'ZXA-081', '30-SEP-16', -14092.59, 
  null, null, 3, '29-OCT-16', null,success_or_fail);
  dbms_output.put_line(success_or_fail);
end;
/

/* Task 1. Create a stored procedure in your YourUser1's schema on your 
cloud Oracle server instance or in your normal user's schema on the 
class server. Name the procedure insert_asset_YourUser1. The purpose of
the procedure is to insert into ITAM user's asset_desc table, performing 
some data validation first. Your procedure must accept as input values 
for the type of asset (by description), the make of the asset, the model, 
the asset_ext attribute information, and a value for an output variable 
whose value can mean an error state or success. The procedure should  
attempt an insert of the input values into the asset_desc table of
ITAM in the cloud, but the insert whould be attempted only if the 
combination of asset type, asset_make, asset_model, and asset_ext does 
not match exactly to an asset description row already in asset_desc table.
(It serves no business purpose to have duplicate asset descriptions in the 
asset_desc table). The procedure should return a value to the calling 
application that signifies a successful insert or a failure to insert. 
Errors from the RDBMS should be handled by an exception block so that 
the calling application receives the "success" or "failure" value from 
the output parameter of the procedure based on the error type. Your 
procedure should handle for at least one named error plus others. 
Note that the example stored procedure from the Murach book (preceding 
Task 1) has a lot of data validation built into it that is not necessary 
for an insert into the asset_desc table. Adjust your code accordingly, 
but perform necessary data validation as indicated in the task instructions.
For Task 1, document the code of your procedure and your success with 
creating it. For Task 2 you document using it. */


--Type your name here
--Ex 9 Task 1
create or replace procedure insert_asset_profm
(
--Declare a parameter of the correct type to hold the asset type description passed in,
--Declare a parameter of the correct type to hold the asset make passed in,
--Declare a parameter of the correct type to hold the asset model passed in,
--Declare a parameter of the correct type to hold the asset extended information passed in,
  success_param  out char --Declare an output parameter
)
is -- or as
  --Declare a variable of the correct type to hold an asset type id value (*note
  --that a value for this variable is not passed to the procedure when it is called)
  --I'm providing the code for the first one next:
  asset_type_id_var   jaherna42.asset_type.asset_type_id%type;
 --Declare a variable of the correct type to hold an asset id value
  
begin
  select 'S' into success_param from dual;--initialize the success state

--Write a command to retrieve the asset_type_id that matches the asset type desciption
--that the user enters (by passing it into the procedure) - the value passed is
--stored in the parameter you set up to hold the type description.
  
--Write a command to see if the asset make, asset model, asset extended 
--information, and asset type id is already in the asset_desc table, since
--there is no reason to insert a duplicate of an asset that already exists.
--The best way to find out is to select a count of how many rows match to the 
--values for make, model, extension info, and type that are passed into the 
--procedure and saved in parameters. The count must be selected into a variable 
--you declare for that purpose. The declaration should be done with the other
--variable declarations.

--Once you have the count, you must check that the count is 0 before proceeding.
--If the count is not zero, you should raise an error (such as the value_error), 
--and then handle the error with an exception block.
--In other words, set up a decision structure (if-then) so that if the count is 
--0 the processing continues, but if it's not 0 then the processing stops.

if [some variable] = 0 then 

--Write a command so that, if proceeding with the processing, you
--get and store the asset description id for the insert you are going to do.
--You need to get the value for the asset_desc id from the sequence created
--for that purpose.
  
--Write a command to insert the data held in parameters and variables into 
--the asset_desc table.

--Write a command to commit the data.
else
--Stop the processing by raising an error

--Write the command to end your decision structure 
   exception 
    when --look for at least one specific named error and handle it
    
    when others then
    --update the success parameter's value to indicate failure
end;


/* Task 2. Next provide an example of calling the stored procedure, capturing 
the value passed back (in the output variable) that indicates success or failure
to a calling application. This call example should demonstrate a success state 
result. In a separate command select from the table the data inserted by the  
procedure. */

--Type your name here
--Ex 9 Task 2 Command 1
--Call the stored procedure and get a success result
/*Success*/
declare 
  my_out datatype;
begin
  begin
  insert_asset_yourusername('Application', 'TechSmith', 'SnagIt',
  'v. 19',my_out);
  dbms_output.put_line(my_out);
end;


--Type your name here
--Ex 9 Task 2 Command 2
--Select the inserted record from the table.
select * from itam.asset_desc join itam.asset_type
using(asset_type_id)
where 
asset_make = 'xxxxx'
and asset_model = 'xxxxx'
and asset_ext = 'xxxxxxx'
and asset_type_desc = 'xxxxxx';


/* Task 3. Next provide an example of calling the stored procedure, capturing 
the value passed back (in the output variable) that indicates success or failure
to a calling application. This call example should demonstrate a failure state 
result. In a separate command select from the table the data inserted by the  
procedure. */

--Type your name here
--Ex 9 Task 3 Command 1
/* Failure */
declare 
  success_or_fail char(50);
begin
  insert_asset_profm('Dinosaur', 'Acer', 
  'Swift 3 Laptop',
  '14in. Full HD Intel Core i5-6200U 8GB DDR4 256GB',
  success_or_fail);
  dbms_output.put_line(success_or_fail);
end;




/* Task 4. Create a stored procedure in your YourUser1's schema on your 
cloud Oracle server instance or in your normal user's schema on the 
class server. Name the procedure insert_CI_YourUser1. The purpose of
the procedure is to insert into ITAM user's CI table, performing 
some data validation first. Your procedure must accept as input values 
for the type of asset (by description), the make of the asset, the model, 
and the asset_ext attribute information. In addition, input parameters for
all the fields of the ci_inventory are also needed, except for the ci_inv_id
field (since that value can be generated by a sequence). A parameter to 
hold an output variable whose value can mean an error state or success is 
sldo needed. The procedure should use the asset make, asset model, asset 
extended information, and asset type to determine the asset_desc_id for 
the CI to be inserted. After determining the asset_desc_id for the CI, 
the procedure should use the other parameter values to insert a record 
into the ci_inventory table for the new CI. If no match to an asset_desc)id
can be made, then the insert into ci_inventory should not be attempted.
The procedure should return a value to the calling application that signifies
a successful insert or a failure to insert. 
Errors from the RDBMS should be handled by an exception block so that 
the calling application receives the "success" or "failure" value from 
the output parameter of the procedure based on the error type. Your 
procedure should handle for at least one named error plus others. 
 You document using the stored procedure in Task 4. */

--type your name here
/*Ex 9 Task 4 Create a stored procedure */

create or replace procedure insert_ci_profm
(
--Declare a parameter of the correct type to hold the asset type description passed in,
--Declare a parameter of the correct type to hold the asset make passed in,
--Declare a parameter of the correct type to hold the asset model passed in,
--Declare a parameter of the correct type to hold the asset extended information passed in,
--Declare a parameter of the correct type to hold the purchase or rental information passed in,
--Declare a parameter of the correct type to hold the unique id information passed in,
--Declare a parameter of the correct type to hold the CI acquired date information passed in,
--Declare a parameter of the correct type to hold the CI status code information passed in,
--Declare a parameter of the correct type to hold the CI status date information passed in,
success_param  out char --Declare an output parameter
)
is
  --Declare variables to be used in processing
begin
  select 'S' into success_param from dual;--initialize success_param with S
  
  --Write code to determine if the asset description information 
  --passed in matches to an asset description id.
  --If there is at least one match, select one asset_desc_id value
  --into a variable you declared for that purpose. You can use MIN
  --or MAX to select just one id value.
  
  --Write code to insert the ci_inventory information into the 
  --ci_inventory table and commit the inserted data.

  exception 

    when --look for at least one specific named error and handle it
    
    when others then
    --update the success parameter's value to indicate failure
end;
  
  

/* Task 5. Demonstrate using the procedure created in Task 4 to successfully
insert a CI with an existing asset description. */


--Type your name here
--Ex 9 Task 5 Command 1
--Call the stored procedure and get a success result
/*Success*/
declare 
  myout datatype;
begin
  insert_ci_username('Computer', 'Acer', 'Swift 3 Laptop',
  '14 in. Full HD Intel Core i5-6200U 8GB DDR4 256GB',
  'PURCHASE','Serial No. A1023444',
  to_date('28-OCT-2022 11:33:32 AM','DD-MON-YYYY HH:MI:SS AM'),
  'WORKING',sysdate,  myout);--make up your own success data
  dbms_output.put_line(success_or_fail);
end;

--Type your name here
--Ex 9 Task 5 Command 2
--Verify the success result by selecting the inserted record
select * from ci_inventory --where ;--do not return all rows





/* Task 6. Use the stored procedure from Task 3 again to demonstarte the 
procedure not inserting a CI because no match to an asset description was found.*/

--Type your name here
--Ex 9 Task 6 Command 1
--Call the stored procedure and get a failure result
/*Failure*/
declare 
  success_or_fail char;
begin
  insert_ci_profm('Computer', 'Wefffffler', 'Swift 3 Laptop',
  '14 in. Full HD Intel Core i5-6200U 8GB DDR4 256GB',
  'PURCHASE','Serial No. A1023446',
  to_date('28-OCT-2022 11:33:32 AM','DD-MON-YYYY HH:MI:SS AM'),
  'WORKING',sysdate,  success_or_fail);-- make up your own fail data
  dbms_output.put_line(success_or_fail);
end;




