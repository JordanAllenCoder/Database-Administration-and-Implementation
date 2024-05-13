select * from itam.department
--Jordan Allen
--cloudJA10
--Ex 6 Task 9 Command 1
insert into itam.department(Dept_code, Dept_name) Values ('ACCT', 'Accounting');
commit;

--Jordan Allen
--Connected as cloudJA10
--Ex 6 Task 9 Command 2
select * from itam.department where Dept_code='ACCT';


--Jordan Allen
--Connected as cloudJA10
--Ex 6 Task 9 Command 3
Update ITAM.DEPARTMENT
set DEPT_CODE ='MGMT', DEPT_NAME ='Management'
where DEPT_CODE ='ACCT';
commit;

--Jordan Allen
--Connected as cloudJA10
--Ex 6 Task 9 Command 4
select * from itam.department where Dept_code='MGMT';


--Jordan Allen
--Connected as cloudJA10
--Ex 6 Task 9 Command 5
DELETE FROM ITAM.DEPARTMENT WHERE DEPT_CODE='MGMT';
COMMIT;


--Jordan Allen
--Connected as cloudJA10
--Ex 6 Task 9 Command 6
select * from itam.department where dept_code='MGMT';


--Jordan Allen
--Ex 6 Task 10 
/* No, there are some differences. I was unable to access the tables with the
user JA10 at first. When privledges are granted straight to the user you can 
access the tables instantly. If the table permissions are granted to a user 
through a role, then the user must log out and log back in to to have access 
to the tables.*/

--Jordan Allen
--Connected as cloudJA10
--Ex 6 Task 13
create view vw_itam_employees_info
as
select first_name, last_name, co_mobile, co_email, dept_code, Job_title
from itam.employee;


--Jordan Allen
--Ex 4 Task 14
/*In order to create a view with user JA10 I would need to grant JA10
with the CREATE VIEW privilege. This would have to be done additionally 
because the privilege is not granted by default.*/

commit;
