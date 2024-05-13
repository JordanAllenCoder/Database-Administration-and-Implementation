--Ex 7 Task 1 Command 1 Create the Constraint
--Jordan Allen
--Implementing: (3) When a CI is first added to inventory, the status 
--of the CI should be 'WORKING'.
alter table ci_inventory
modify ci_status_code default 'WORKING'

--Ex 7 Task 1 Command 2 Demonstrate the Constraint Working with Insert
--Jordan Allen
--Implementing: (3) When a CI is first added to inventory, the status 
--of the CI should be 'WORKING'.
insert into ci_inventory(ci_inv_id, asset_desc_id, purchase_or_rental, 
unique_id, ci_acquired_date, ci_status_date) values (55,35,'PURCHASE', 
'Sernial No. 2103655',to_date('06-JUL-22','DD-MON-RR'),to_date('06-JUL-22','DD-MON-RR'))

--Ex 7 Task 1 Command 3 Demonstrate the Constraint Working with Select After 
--Insert
--Jordan Allen
--Implementing: (3) When a CI is first added to inventory, the status 
--of the CI should be 'WORKING'.
select * from ci_inventory
where ci_inv_id = 55;

--Ex 7 Task 2 Command 1 - Create a Unique Constraint
--Jordan Allen
--Implementing: (2) Once a company email is created for an employee, it is 
--never reused, thus, assuring that company emails are unique regardless of 
--the employment status of an employee.
alter table employee
add constraint uq_email unique(co_email);

--Ex 7 Task 2 Command 2 - Demonstrate the Constraint Working (Prevent Incorrect
--Data)
--Jordan Allen
--Implementing: (2) Once a company email is created for an employee, it is 
--never reused, thus, assuring that company emails are unique regardless of 
--the employment status of an employee.
update employee
set co_email = 'spjohns@abcco.com'
where emp_id = 2;

--Ex 7 Task 2 Command 3 - Demonstrate the Constraint Working (Allow Correct
--Data)
--Jordan Allen
--Implementing: (2) Once a company email is created for an employee, it is 
--never reused, thus, assuring that company emails are unique regardless of 
--the employment status of an employee.
update employee
set co_email = 'ppanadero@abcco.com'
where emp_id = 2

--Ex 7 Task 3 Command 1 - Create the Constraint
--Jordan Allen
--Implementing: (2)  The values allowed for the purchase or rental attribute 
--of the CI inventory are limited to IN-HOUSE, LEASE, or PURCHASE.
alter table ci_inventory
add constraint chk_ci_attribute 
check (purchase_or_rental='IN-HOUSE' or purchase_or_rental='LEASE' 
or purchase_or_rental='PURCHASE');

--Ex 7 Task 3 Command 2 - Demonstrate the Constraint Working (Prevent Bad Data)
--Jordan Allen
--Implementing: (2)  The values allowed for the purchase or rental attribute 
--of the CI inventory are limited to IN-HOUSE, LEASE, or PURCHASE.
update ci_inventory
set purchase_or_rental = 'RENTAL'
where ci_inv_id = 3

--Ex 7 Task 3 Command 3 - Demonstrate the Constraint Working (Allow Good Data)
--Jordan Allen
--Implementing: (2)  The values allowed for the purchase or rental attribute 
--of the CI inventory are limited to IN-HOUSE, LEASE, or PURCHASE.
update ci_inventory
set purchase_or_rental = 'LEASE'
where ci_inv_id = 3
select * from ci_inventory where ci_inv_id = 3
