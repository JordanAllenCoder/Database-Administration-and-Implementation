select * from jaherna42.department
order by dept_name, dept_code;

select * from jaherna42.employee
order by emp_id;
select * from jaherna42.CI_Inventory

insert into jaherna42.employee
values (13,'Laura','Scott',5698,'346-447-6363','lmscott@abcco.com','HIRE',
to_date('23-AUG-22','DD-MON-RR'),'ACCT','Accountant',2,user,sysdate);

insert into jaherna42.employee
values (12,'Mikey','Wong',8514,'346-825-7863','mswong@abcco.com','HIRE',
to_date('06-JUL-22','DD-MON-RR'),'ITHELP','Systems Analyst',1,user,sysdate);

insert into jaherna42.employee
values (14,'Lamar','Littles',6515,'832-688-8743','lllittles@abcco.com','HIRE',
to_date('21-MAR-22','DD-MON-RR'),'ITHELP','IT Help Desk Manager',null,user,sysdate);

commit;
select * from jaherna42.employee;

select * from jaherna42.asset_type

insert into jaherna42.asset_desc
values (35,2,'Dell','XPS 15 Laptop','11th Gen Intel® Core™ i7-11800H',user,sysdate); 

insert into jaherna42.asset_desc
values (36,1,'Microsoft','Windows OS','Windows 11 Home',user,sysdate); 

select * from jaherna42.asset_desc
order by asset_desc_id;

insert into jaherna42.other
values (35,'11th Gen Intel® Core™ i7-11800H (24 MB cache, 8 cores, 16 threads, up to 4.60 GHz Turbo)',
'15.6", 3.5K 3456x2160, 60Hz, OLED, Touch, Anti-Reflect, 400 nit, InfinityEdge',user,sysdate);

insert into jaherna42.other
values (36,'11','factory installed on laptop',user,sysdate);
commit;

select * from jaherna42.CI_inventory
where ci_inv_id = 68;

insert into jaherna42.CI_inventory
values (68,35,'PURCHASE','Serial No. CN-0 68MCF -74261-55N-07AL',to_date('30-AUG-22','DD-MON-SS'),'WORKING',
to_date('01-SEP-22','DD-MON-SS'),user,sysdate);

insert into jaherna42.it_asset_inv_summary
values (89,35,to_date('01-SEP-22','DD-MON-RR'),0+1,0,0,user,sysdate);

insert into jaherna42.CI_inventory
values (69,35,'PURCHASE','Serial No. CN-0 69KCF -52761-54N-07OP',to_date('30-AUG-22','DD-MON-SS'),'WORKING',
to_date('01-SEP-22','DD-MON-SS'),user,sysdate);

insert into jaherna42.it_asset_inv_summary
values (95,35,to_date('01-SEP-22','DD-MON-RR'),1+1,0,0,user,sysdate);

insert into jaherna42.CI_inventory
values (70,35,'PURCHASE','Serial No. CN-0 45MCF -52333-54N-89PO',to_date('30-AUG-22','DD-MON-SS'),'WORKING',
to_date('01-SEP-22','DD-MON-SS'),user,sysdate);

insert into jaherna42.it_asset_inv_summary
values (96,35,to_date('01-SEP-22','DD-MON-RR'),2+1,0,0,user,sysdate);

commit;

select * from jaherna42.ci_inventory where asset_desc_id = 35;
select * from jaherna42.employee where last_name like '%W%';

insert into jaherna42.employee_ci
values (68,13,'USE',to_date('01-SEP-22','DD-MON-RR'),null,user,sysdate);

commit;

select * from jaherna42.employee_ci where emp_id = 13 and ci_inv_id = 68;

insert into jaherna42.it_asset_inv_summary
values (jaherna42.it_asset_inv_summary_id_seq.nextval,35,to_date('08-SEP-22','DD-MON-RR'),3-1,0+1,0,user,sysdate);

commit;

select * from jaherna42.employee_ci
where it_asset_inv_summary_id = 

insert into jaherna42.employee_ci
values (68,31,'Support',to_date('01-SEP-22','DD-MON-RR'),null,user,sysdate);

insert into jaherna42.it_asset_inv_summary
values (jaherna42.it_asset_inv_summary_id_seq.nextval,35,to_date('08-SEP-22','DD-MON-RR'),3-1,0+1,0+1,user,sysdate);

insert into jaherna42.employee_ci
values (69,31,'Support',to_date('01-SEP-22','DD-MON-RR'),null,user,sysdate);

insert into jaherna42.it_asset_inv_summary
values (jaherna42.it_asset_inv_summary_id_seq.nextval,35,to_date('08-SEP-22','DD-MON-RR'),1,1,1,user,sysdate);
select * from jaherna42.employee_ci

update jaherna42.ci_inventory
SET
ci_status_code = 'DISPOSED'
where ci_inv_id = 69;

select * from jaherna42.ci_inventory

insert into jaherna42.related_assets values (35,'RO',36,user,sysdate);
commit;

--Task 2 Command 1
--Jordan Allen
select emp_id,first_name,last_name,co_email,action,action_date,dept_code,
job_title from jaherna42.employee where changed_by_user = 'JMALLE25';
--replace YOURUSERNAME in the command with your user name on the class server

--Task 2 Command 2
--Jordan Allen
select asset_desc_id,asset_type_id,asset_make,asset_model,asset_ext
from jaherna42.asset_desc where changed_by_user = 'JMALLE25';
--replace YOURUSERNAME in the command with your user name on the class server

--Task 2 Command 3
-- Jordan Allen
select * from jaherna42.computer
--the ITAM documents explain what tables represent sub-entities
--the sub-entity table you select from correspondes to the asset type of the
--asset description you inserted
where changed_by_user = 'JMALLE25';
--replace YOURUSERNAME in the command with your user name on the class server

--Task 2 Command 4
-- Jordan Allen
select ci_inv_id,asset_desc_id,purchase_or_rental,unique_id,ci_acquired_date,
ci_status_code,ci_status_date from jaherna42.ci_inventory 
where changed_by_user = 'JMALLE25';
--replace YOURUSERNAME in the command with your user name on the class server

--Task 2 Command 5
--Jordan Allen
select ci_inv_id,emp_id,use_or_support,date_assigned,date_unassigned
from jaherna42.employee_ci where changed_by_user = 'JMALLE25';
--replace YOURUSERNAME in the command with your user name on the class server

--Task 2 Command 6
--Jordan Allen
select * from jaherna42.it_asset_inv_summary 
where changed_by_user = 'JMALLE25'
order by asset_desc_id,it_asset_inv_summary_id;
--replace YOURUSERNAME in the command with your user name on the class server

--Task 2 Command 7
--Jordan Allen
select * from jaherna42.Computer
where changed_by_user = 'JMALLE25' ;
--replace YOURUSERNAME in the command with your user name on the class server
