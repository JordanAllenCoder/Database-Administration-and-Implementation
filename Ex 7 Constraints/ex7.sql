/* Ex 7 Constraints */

/*The deliverable for this exercise is a Word document. Put your name
and the exercise number (Ex 7) as a header in a Word document 
as you begin the exercise. Name the Word document 
ex7_lastname_firstname_section#.docx.*/

/*Here in the exercise instructions, you are prompted to (1) complete 
tasks, (2) take screen shots that document your hands-on work and 
insert them into the deliverable document, and/or (3) write something 
in the deliverable document. Use the Windows Snipping Tool or something 
like it to capture just the portion of the screen you need to document 
your work.

Whenever you capture work with a screenshot, include your name in 
the screenshot. This guideline applies to any screenshots you take 
to document your hands-on work throughout the semester. You may not 
get credit for something if you do not include your name as 
requested. */


/* The tasks refer to the ITAM schema tables that you created on your
own instance of Oracle in the cloud. */


/* Task 1. Create a Default Constraint
A default constraint can added to a column to help assure domain
integrity. These are added using the alter table command as demonstrated in class. 
For example, here are some ITAM business rules that may or may not be supported 
with default constraints.
(1) When an employee is added or an employee action is recorded, the 
action date should be today and should include the current time.
(2) When a CI is added to inventory new, the acquired date should be today
and should include the current time.
(3) When a CI is first added to inventory, the status of the CI should be 
'WORKING'.
(4) When a CI is first added to inventory or when its status changes, the status
date should be today and should include the current time.
(5) When an assignment of a CI to an employee for USE or SUPPORT is first made, 
the date of the assignment should be today and should include the current time.
(6) When a summary record is added to the IT asset inventory summary, the 
inventory summary record date should be today and should include the current time.

In your Word document deliverable for Ex 7, choose one of the business rules 
stated in Task 1 that can be correctly supported by a default constraint. Add 
the default constraint to the corresponding column in the appropriate table 
of the ITAM schema. (Let's not all do the first stated business rule, OK?) After
adding the constraint, write two more commands to demonstrate that the default 
constraint works as planned. As demonstrated in class, to test that a default 
constraint is working, you must (1) perform an insert that leaves the field 
where the default constraint is defined null (without passing a non-value by 
using the keyword null), followed by (2) run a select command that selects the 
particular record you inserted to show that the default value was inserted even 
though no value was provided. */

--Ex 7 Task 1 Command 1 Create the Constraint
--Type your name here
--Implementing: (n) Write the business rule your constraint creation supports
--and replace n with its number



--Ex 7 Task 1 Command 2 Demonstrate the Constraint Working with Insert
--Type your name here
--Implementing: (n) Write the business rule your constraint creation supports
--and replace n with its number



--Ex 7 Task 1 Command 3 Demonstrate the Constraint Working with Select After 
--Insert
--Type your name here
--Implementing: (n) Write the business rule your constraint creation supports
--and replace n with its number



/* Task 2. Create a Unique Constraint
A unique constraint can be added to a column to help assure entity
integrity. These are added using the alter table command as demonstrated in 
class. For example, here are some ITAM business rules that can be supported with
a unique constraint.
(1) Department names are unique.
(2) Once a company email is created for an employee, it is never reused, thus, 
assuring that company emails are unique regardless of the employment status of
an employee.
(3) Asset descriptions (comprised of three columns) are unique.

In your Word document deliverable for Ex 7, choose one of the business rules 
stated and add a unique constraint to the corresponding column or set of columns
in the appropriate table of the ITAM schema. (Let's not all implement the first
stated business rule, OK?) After adding the constraint, write one or more commands
to demonstrate that the unique constraint is working. As demonstrated in class, 
if there is data in your table that violates the uniqueness constraint, you won't
be able to create it enabled. You either have to fix or remove the data that 
violates the constraint, or you must add the constraint in disabled mode and 
then enable it with the novalidate option so that old data will not be checked 
against the constraint. To demonstrate that a unique constraint is working you 
must perform an insert or update command that violates it. And you must perform 
an insert or update command that does not violate it. */

--Ex 7 Task 2 Command 1 - Create a Unique Constraint
--Type your name here
--Implementing: (n) Write the business rule your constraint creation supports
--and replace n with its number.



--Ex 7 Task 2 Command 2 - Demonstrate the Constraint Working (Prevent Incorrect
--Data)
--Type your name here
--Implementing: (n) Write the business rule your constraint creation supports
--and replace n with its number.



--Ex 7 Task 2 Command 3 - Demonstrate the Constraint Working (Allow Correct
--Data)
--Type your name here
--Implementing: (n) Write the business rule your constraint creation supports
--and replace n with its number.



/* Task 3. Create a Check Constraint
A check constraint can be added to a column to help assure domain
integrity. These are added using the alter table command as demonstrated in class. 
For example, here are some ITAM business rules that can be supported with check 
constraints.
(1) An employee email address should use the company domain. That is, the 
email address should end with '@abcco.com'. 
(2)  The values allowed for the purchase or rental attribute of the CI inventory
are limited to IN-HOUSE, LEASE, or PURCHASE.
(3) That date value for a CI's status must be the same as or after the acquired
date for the CI.
(4) The values allowed for the use or support attribute of the employee_CI 
table are either USE or SUPPORT.
(5) The date that a CI is unassigned from an employee must be the same as or 
after the date that a CI is assigned to an employee.


In your Word document deliverable for Ex 7, choose one of the business rules 
stated for Task 3 and add a check constraint to the corresponding column or 
set of columns in the appropriate table of the ITAM schema. After adding the 
constraint, write one or more commands to demonstrate that the check constraint
is working. 
As demonstrated in class, if there is data in your table that violates the
check constraint, you won't be able to create it. You either have to fix 
or remove the data that violates the constraint, or you must add the constraint
in disabled mode and then enable it with the novalidate option so that old data 
will not be checked against the constraint. 
To demonstrate that a check constraint is working you must perform an insert or 
update command that violates it, and you must perform and insert or update 
command that does not violate it.*/

--Ex 7 Task 3 Command 1 - Create the Constraint
--Type your name here
--Implementing: (n) Write the business rule your constraint creation supports
--and replace n with its number.



--Ex 7 Task 3 Command 2 - Demonstrate the Constraint Working (Prevent Bad Data)
--Type your name here
--Implementing: (n) Write the business rule your constraint creation supports
--and replace n with its number.



--Ex 7 Task 3 Command 3 - Demonstrate the Constraint Working (Allow Good Data)
--Type your name here
--Implementing: (1) An employee email address should use the company domain. That is, the 
--email address should end with 'abcco.com'. */












