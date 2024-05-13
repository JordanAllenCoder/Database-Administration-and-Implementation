/* Ex 6 Migrating ITAM to the Cloud */

/*The deliverable for this exercise is a Word document. 
Put your name and the exercise number (Ex 6) as a header 
in a Word document as you begin the exercise. Name the 
Word document ex6_lastname_firstname_section#.docx.*/

/*Here in the exercise instructions, you are prompted to 
(1) complete tasks, (2) take screen shots that document 
your hands-on work and insert them into the deliverable 
document, and/or (3) write something in the deliverable 
document. Use the Windows Snipping Tool or something like 
it to capture just the portion of the screen you need to 
document your work.

Whenever you capture work with a screenshot, include your 
name in the screenshot. This guideline applies to any 
screenshots you take to document your hands-on work 
throughout the semester. You may not get credit for 
something if you do not include your name in screenshots 
as requested. */

/* ABCCo has generally maintained and managed their own 
server hardware and infrastructure. Your team (the one 
evaluating the schema for IT asset management proposed
by the hired consultants) is charged with also evaluating
the potential of using cloud infrastructure for the IT 
asset management information system.

Your team has acquired limited access to Oracle's cloud
infrastructure to begin evaluating the potential of 
the cloud using Oracle's free tier for testing. */


/* Task 1. Create Users and Set System Privileges 
Your team decides to create four users with privileges 
that enable them to log in to the cloud server and 
create tables and other objects. The privileges that 
need to be set up first are system level privileges 
rather than object level privileges. To create users 
and grant them privileges, you must be logged in to 
your cloud instance as the admin user.

The users to be created are PROF, ITAM, YourUser1, 
and YourUser2 (you choose the usernames for YourUser1 
and YourUser2). Each user must be granted these 
privileges: create session (so they can create a 
session with the RDBMS database engine), create table,
create sequence, create type, create procedure, create
trigger, and create view. Templates are provided for 
the commands. You do not need to document each command 
to create a user and grant privileges. The command to 
use to document your work follows the templates.*/

/*Ex 6 Task 1 Command Templates
--(1) Create a user and designate a quota on the tablespace.
create user name_of_user identified by your_password_string
default tablespce data quota 20 M on data;
--(2) Authorize user to create a session with the RDBMS
database engine by logging in.
grant create session to name_of_user;
(3) Authorize user to create objects in user's own schema.
grant create table to name_of_user;
grant create sequence to name_of_user; 
grant create type to name_of_user;
grant create procedure to name_of_user;
grant create trigger to name_of_user;
grant create view to name_of_user; 
(4) Authorize user to perform a few other tasks.
grant select any sequence to name_of_user ;
grant alter session to name_of_user; */

/* Once your users are created and privileges 
granted, open Oracle SQL Developer and make 3 
connections to your cloud instance, one for each 
user you created except PROF (i.e., connect as ITAM,
YourUser1, YourUser2). Use the same Wallet 
information you downloaded from Oracle cloud 
and used to connect as ADMIN.

Once you have the connections set up, use Oracle SQL 
Developer to connect to your Oracle cloud instance as 
ADMIN. Run a select command that you create from the 
template provided below to retrieve information from 
the system views dba_users and dba_sys_privs. Take a 
screenshot of the command and results for your 
deliverable document.*/

--Type your name here
--Connected as user_you_are_connected_as
--Ex 6 Task 1 Deliverable Command for Create Users
-- Remember to capture an accurate number of rows returned.
select username,'none' as privilege, created 
from dba_users 
where 
username in ('ITAM','PROF','YOURUSER1','YOURUSER2')
union
select grantee,privilege,sysdate 
from dba_sys_privs 
where 
grantee in ('ITAM','PROF','YOURUSER1','YOURUSER2')
order by username;
--Replace YOURUSER1 and YOURUSER2 with the names of the users
--you created for which you invented the names (we have been
--referring to those names as YourUser1 and YourUser2.




/* Task 2. Create ITAM Tables and Objects and Add Data
Connect to your Oracle cloud instance as the user who 
will own the tables of the ITAM schema. That user should 
be ITAM, but if you get it done with a different user, 
that can work, too. Open the student_create_itam.sql SQL 
commands provided in the .zip for the Ex. Create the ITAM 
schema tables and sequences in your cloud instance and add 
the sample data as demonstrated in class and as instructed
in student_create_itam.sql.
*Note that it is not critical that every single piece of 
data gets inserted, but you want to have as much of the 
limited amount of sample data as possible inserted.

Once you have the tables created and the data inserted, 
connect to your Oracle cloud instance as ADMIN and run 
the following select command that retrieves information 
from the system view dba_tables. Take a screenshot of the  
command and results for your deliverable document.*/ 

--Type your name here
--Connected as user_you_are_connected_as
--Ex 6 Task 2 Create ITAM Tables and Objects and Add Data
select owner, table_name,num_rows,tablespace_name 
from dba_tables where owner = 'USERNAME' 
order by num_rows desc;
--Replace USERNAME with the name of the user that owns 
--the tables of the ITAM schema on your instance 
--(probably this is ITAM).




/* Task 3. Add Your Ex 2 Scenario Data to Your ITAM 
Tables in the Cloud
Connected to your Oracle cloud instance as the user 
who is owner of the ITAM tables (probably ITAM) insert 
the data you inserted into JAHERNA42's ITAM schema 
tables for Ex 2, making corrections as needed based 
on the feedback you received for Ex 2. 

Once you have the data added, connect to your Oracle 
cloud instance as ADMIN and run a command based on the
following select command template. The command retrieves 
information from the system view dba_tables. Take a 
screenshot of the command and results for your 
deliverable document.*/

--Type your name here
--Connected as user_you_are_connected_as
--Ex Task 3
select table_name, num_rows from dba_tables 
where owner = 'USERNAME' 
order by num_rows desc;
--Replace USERNAME with with the name of the 
--user that owns the tables of the ITAM schema 
--on your instance.




/* Task 4. Grant a User Access to ITAM's Data
Connect to your Oracle cloud instance as 
ADMIN to grant a user for which you chose the name
(YourUser1 or YourUser2) privileges to create, 
retrieve, change, and destroy data from the 
ITAM user's tables in that schema. Also grant 
the same user privileges to select 
values from the sequences of the ITAM schema. */ 

--Ex 6 Task 4 Instructions and Command Templates
--grant select on each ITAM schema table to youruser
grant insert,select,update,delete on 
owner.table_name to youruser;
--there are 18 tables
--Replace owner with the username of the user who 
--owns the ITAM tables.
--Replace table_name with the name of each ITAM 
--table (one at a time).
--Replace youruser with the name of YourUser1 or 
--YourUser2 (a user for which you chose the name).
grant select on owner.name_of_sequence to youruser;
--there are 7 sequences
--Preplace owner with the username of the user who 
--owns the ITAM sequences.
--Replace name_of_sequence with the name of each 
--ITAM sequence (one at a time).
--Replace youruser with the name of YourUser1 or 
--YourUser2 (a user for which you chose the name).

/* Once you have granted one of your users privileges, 
connect to your Oracle cloud instance as ADMIN and run 
the following select command that retrieves information 
from the system view dba_tab_privs. Scroll down in the 
result set so that the total number of rows retrieved 
is visible. Take a screenshot of the command and results 
for your deliverable document.*/ 

--Type your name here
--Connected as user_you_are_connected_as
--Ex 6 Task 4 Grant a User Access to ITAM's Data
select grantee,owner,table_name,grantor,privilege
from dba_tab_privs where grantee = 'YOURUSER'
order by table_name;
--Replace YOURUSER with the name of your user
--(YourUser1 or YourUser2 for which you chose
--the name)




/* Task 5. Access Data in ITAM's Table Connected as YourUser
Connect to your Oracle cloud instance as the user to 
whom you granted access to the tables belonging to ITAM.
Demonstrate that youruser has privileges to create, retrieve, 
change, and delete data in at least one table of the ITAM 
schema that belongs to another user (should be ITAM). I 
recommend working with a table without too many 
dependecies, such as asset_desc, employee, department, or 
related_assets. Once you choose a table, write and run six
SQL commands (described next).

Command 1. Insert a New Record
Write and run commands to insert a new record into the
table you have chosen and commit the data. Follow all 
the business rules about that data.
Command 2. Retrieve the New Record
Write and run a query to retrieve the data you inserted 
with Command 1.
Command 3. Change the New Data
Write and run command to change the data you 
inserted with Command 1 and commit the data change. 
Command 4. Retrieve the Changed Data
Write and run a query to retrieve the changed data you 
changed with Command 3.
Command 5.Delete the Data
Write and run commands to delete the data you inserted 
and changed with Command 3 and commit the data deletion.
Command 6. Retrieve the Data
Write and run a query to retireve the data you 
deleted. The query you write should return no rows.*/


--Type your name here
--Connected as user_you_are_connected_as
--Ex 6 Task 5 Command 1

--Type your name here
--Connected as user_you_are_connected_as
--Ex 6 Task 5 Command 2

--Type your name here
--Connected as user_you_are_connected_as
--Ex 6 Task 5 Command 3

--Type your name here
--Connected as user_you_are_connected_as
--Ex 6 Task 5 Command 4

--Type your name here
--Connected as user_you_are_connected_as
--Ex 6 Task 5 Command 5

--Type your name here
--Connected as user_you_are_connected_as
--Ex 6 Task 5 Command 6




/* Task 6. Create a Role and Grant Privileges Through 
the Role
Connect to your Oracle cloud instance as ADMIN and 
create a role named itam_user so that users granted 
the role are able to create, retrieve, change, and 
destroy data from the ITAM user's tables in that 
schema. Also grant privileges the role to select 
values from the sequences of the ITAM 
schema. */

--Ex 6 Task 6 Instructions and Command Templates
--create the role
create role itam_user; -- connect as ADMIN
--Grant select on each ITAM schema table to the role.
grant insert,select,update,delete 
on owner.table_name to itam_user;--there are 18 tables
--Replace owner with the username of the user who owns the ITAM tables.
--Replace table_name with the name of each ITAM table (one at a time).
grant select on owner.name_of_sequence to itam_user;--there are 7 sequences
--Preplace owner with the username of the user who owns the ITAM sequences.
--Replace name_of_sequence with the name of each ITAM sequence (one at a time).

/*Once you have the role created and have granted it 
privileges, connect to your Oracle cloud instance as 
ADMIN and run the following select command that 
retrieves information from the system view 
dba_tab_privs. Scroll down in the result set so 
that the total number of rows retrieved is visible. 
Take a screenshot of the command and results for 
your deliverable document.*/ 

--Type your name here
--Connected as user_you_are_connected_as
--Ex 6 Task 6
select grantee,owner,table_name,grantor,privilege
from dba_tab_privs where grantee = 'ITAM_USER'
order by table_name;




/* Task 7. Grant the Role to YourUser2
Grant to YourUser2 the role itam_user that you created. */
grant itam_user to username;
--Replace username with the name of YourUser2 
--YourUser2 must be different from YourUser1 who was
--granted privileges to the data in the ITAM table in 
--Task 4. 

/*Once you have granted the role itam_user to YourUser2, 
connect to your Oracle cloud instance as ADMIN and run 
the following select command that retrieves information 
from the system view dba_role_privs. Take a screenshot 
of the command and results for your deliverable document.*/ 


--Type your name here
--Connected as:
--Ex 6 Task 7
select * from dba_role_privs 
where grantee = 'USERNAME';
--Replace USERNAME with the name of YourUser2.




/* Task 8. Check Privs in DBA_TAB_PRIVS System View
Select from the system view dba_tab_privs to see if 
YourUser2 has been granted privileges to any of the 
individual ITAM tables.*/

--Type your name here
--Connected as ADMIN
--Ex 6 Task 8
select grantee,owner,table_name,grantor,privilege
from dba_tab_privs where grantee = 'USERNAME'
order by table_name;
--Replace USERNAME with the name of the user to whom
--you granted the role.




/* Task 9. Test YourUser2's Privileges Set Through the Role
Connect to your Oracle cloud instance as YourUser2. 
Redo the 6 commands of Task 6 to verify that YourUser2 
has been granted privileges to create, retrieve, change 
and delete data in the tables owned by user ITAM.*/

--Type your name here
--Connected as: YourUser2 --name the user
--Ex 6 Task 9 Command 1

--Type your name here
--Connected as YourUser2 --name the user
--Ex 6 Task 9 Command 2

--Type your name here
--Connected as YourUser2 --name the user
--Ex 6 Task 9 Command 3

--Type your name here
--Connected as YourUser2 --name the user
--Ex 6 Task 9 Command 4

--Type your name here
--Connected as YourUser2 --name the user
--Ex 6 Task 9 Command 5

--Type your name here
--Connected as YourUser2 --name the user
--Ex 6 Task 9 Command 6




/* Task 10. Do Some Research
You should have been able to verify that both YourUser1 and 
YourUser2 have privileges to create, retrieve, change, and 
destroy data in the ITAM schema tables. YourUser1 was granted 
privileges directly and YourUser2 was granted privileges through 
the role itam_user. Do research to answer (in a very short 
paragraph) the question, "If a user is granted table 
privileges directly through a grant to them, is this level of 
privilege equivalent to granting a table privilege through a role?"  */

--Type your name here
--Ex 6 Task 10 




/* Task 11. YourUser1 Creates a View
Connect to your Oracle cloud instance as YourUser1
(the user whose name you created). Attempt to create 
a view on the tables of the ITAM schema. The base query 
of your view does not have to be complex. There are no 
points added for query complexity. */

--Type your name here
--Connected as YourUser1 -- replace with the name of your user
--Ex 6 Task 11
create view name_of_view
as
select ...;




/* Task 12. Use the YourUser1 View
If the view creation was successful, write and run a command
to use the view. That is, write a command to retrieve data through the
view.*/

--Type your name here
----Connected as YourUser1 -- replace with the name of youruser
--Ex 6 Task 12




/* Task 13. YourUser2 Creates a View
Connect to your Oracle cloud instance as YourUser2. 
Attempt to create the same view you created in Task 12.*/

--Type your name here
--Connected as YourUser2 -- name the user
--Ex 6 Task 13




/* Task 14. Do some research to see how the privileges of 
YourUser2 could be upgraded so that the user can 
successfully create the view of Task 14. Write a very 
brief explanation.*/

--Type your name here
--Ex 4 Task 14

