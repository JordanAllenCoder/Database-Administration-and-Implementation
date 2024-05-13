
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

create user PROF identified by pr0fPassword
default tablespace data quota 20 M on data;

--Jordan Allen
--Connected as CloudAdmin
--Ex 6 Task 1 Deliverable Command for Create Users
-- Remember to capture an accurate number of rows returned.
select username,'none' as privilege, created 
from dba_users 
where 
username in ('ITAM','PROF','TB12','JA10')
union
select grantee,privilege,sysdate 
from dba_sys_privs 
where 
grantee in ('ITAM','PROF','TB12','JA10')
order by username;


--Jordan Allen
--Connected as CloudAdmin
--Ex 6 Task 2 Create ITAM Tables and Objects and Add Data
select owner, table_name,num_rows,tablespace_name 
from dba_tables where owner = 'ITAM' 
order by num_rows desc;



--Jordan Allen
--Connected as CloudAdmin
--Ex Task 3
select table_name, num_rows from dba_tables 
where owner = 'ITAM' 
order by num_rows desc;


--Ex 6 Task 4 Instructions and Command Templates
--grant select on each ITAM schema table to youruser
grant insert,select,update,delete on 
ITAM.server to TB12;
--there are 18 tables
--Replace owner with the username of the user who 
--owns the ITAM tables.
--Replace table_name with the name of each ITAM 
--table (one at a time).
--Replace youruser with the name of YourUser1 or 
--YourUser2 (a user for which you chose the name).
grant select on ITAM.it_asset_inv_summary_id_seq to TB12;
--there are 7 sequences
--Preplace owner with the username of the user who 
--owns the ITAM sequences.
--Replace name_of_sequence with the name of each 
--ITAM sequence (one at a time).
--Replace youruser with the name of YourUser1 or 
--YourUser2 (a user for which you chose the name).

--Jordan Allen
--CloudAdmin
--Ex 6 Task 4 Grant a User Access to ITAM's Data
select grantee,owner,table_name,grantor,privilege
from dba_tab_privs where grantee = 'TB12'
order by table_name;

--Ex 6 Task 6 Instructions and Command Templates
--create the role
create role itam_user; -- connect as ADMIN
--Grant select on each ITAM schema table to the role.
grant insert,select,update,delete 
on ITAM.server to itam_user;--there are 18 tables
--Replace owner with the username of the user who owns the ITAM tables.
--Replace table_name with the name of each ITAM table (one at a time).
grant select on ITAM.it_asset_inv_summary to itam_user;--there are 7 sequences
--Preplace owner with the username of the user who owns the ITAM sequences.
--Replace name_of_sequence with the name of each ITAM sequence (one at a time).

--Jordan Allen
--Connected as CloudAdmin
--Ex 6 Task 6
select grantee,owner,table_name,grantor,privilege
from dba_tab_privs where grantee = 'ITAM_USER'
order by table_name;



grant ITAM_USER to JA10;


--Jordan Allen
--Connected as: cloudAdmin
--Ex 6 Task 7
select * from dba_role_privs 
where grantee = 'JA10';

--Jordan Allen
--Connected as cloudAdmin
--Ex 6 Task 8
select grantee,owner,table_name,grantor,privilege
from dba_tab_privs where grantee = 'JA10'
order by table_name;


commit;

