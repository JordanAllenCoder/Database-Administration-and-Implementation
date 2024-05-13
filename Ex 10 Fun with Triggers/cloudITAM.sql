--Jordan Allen
--Ex 10 Task 1
create or replace trigger use_or_support_auto
before insert or update of use_or_support
on itam.employee_ci
for each row 
when (new.use_or_support != upper(new.use_or_support))
begin
  :new.use_or_support := upper(:new.use_or_support);
end;


--Jordan Allen
--Ex 10 Task 2 Command 1 INSERT or UPDATE
update employee_ci
set use_or_support = 'support'
where ci_inv_id = 69;


--Jordan Allen
--Ex 10 Task 2 Command 2 SELECT
select * from employee_ci
where ci_inv_id = 69;


--Jordan Allen
--Ex 10 Task 3
create or replace trigger check_asset_type
before insert or update 
on computer 
for each row
declare
  asset_type_desc_var char;
begin
  select asset_type_id
  into asset_type_desc_var
  from asset_desc where asset_desc_id = :new.asset_desc_id;
  if (asset_type_desc_var != 2) then 
    RAISE_APPLICATION_ERROR(-20001,
    'Only assets that are computer can be put in the computer subentity table.');    
  end if;
end;


--Jordan Allen
--Ex 10 Task 4
insert into computer values (35,'2.8-GHz Intel Core i7-7700HQ',
'Nvidia GeForce GTX 1650','16GB RAM',
'solid-state drive','512GB','built-in', '15.6" FHD');

select * from computer where asset_desc_id =35;

insert into computer values (22,'Apple Operating System', 
'Apple','Application from Apple',
'Operating System','Iphone','Apple','Excellent Operating System');


--Jordan Allen
--Ex 10 Task 5
--We did at least one like this in class
create or replace trigger emp_id_seq_trig
before insert on employee
for each row
when (new.emp_id is null)
begin
 select emp_id_seq.nextval
 into :new.emp_id 
 from dual;
end;

alter table employee
modify (emp_id number default emp_id_seq.nextval);

create sequence emp_id_seq
start with 26 increment by 1;

--Jordan Allen
--Ex 10 Task 6 Command 1
insert into employee values (null, 'micheal', 'jordan', 5214, 123-456-7891, 
'myemail@abcco.com', 'HIRE', sysdate, 'HR', 'Supervisor', null);

select * from employee where lastfour_ssn = 5214;


--Jordan Allen
--Ex 10 Task 6 Command 2
insert into employee (first_name,last_name,lastfour_ssn,co_mobile,co_email,
action,action_date,dept_code,job_title,supervisor_id) values ('johnny', 'jeffery', 
5478, 123-654-8745, 'mysecondemail@abcco.com', 'HIRE', 
sysdate, 'HR', 'General', null);

select * from employee where lastfour_ssn = 5478;


--Jordan Allen
--Ex 10 Task 6 Command 3
insert into employee values (29, 'jonald', 'donhn', 7894, 987-654-3211, 
'mythirdemail@abcco.com', 'HIRE', sysdate, 'HR', 'Supervisor', null);

select * from employee where lastfour_ssn = 7894;
--trigger allows insert with explicit value


--Jordan Allen
--Ex 10 Task 7
--Implementing: (1) Create an audit table and a trigger on the table with the 
--source data to audit status changes for a CI in the ci_inventory table.
create table ci_status_audit
  (asset_desc_id number not null,
  unique_id varchar2(50) not null,
  ci_status_code varchar2(10) not null,
  action_type varchar2(50) not null,
  action_date date not null
);


--Jordan Allen
--Ex 10 Task 8
--Implementing: (1) Create an audit table and a trigger on the table with the 
--source data to audit status changes for a CI in the ci_inventory table.
create or replace trigger ci_status_change_trig
after insert or update or delete
on ci_inventory
for each row
begin
  if INSERTING then
    insert into ci_status_audit values
    (:new.asset_desc_id, :new.unique_id, 
     :new.ci_status_code, 'INSERTED', sysdate);
 elsif UPDATING then
    insert into ci_status_audit values
    (:old.asset_desc_id, :old.unique_id, 
     :old.ci_status_code, 'UPDATED', sysdate);
 elsif DELETING then
    insert into ci_status_audit values
    (:old.asset_desc_id, :old.unique_id, 
     :old.ci_status_code, 'DELETED', sysdate);
  end if;  
end;


--Jordan Allen
--Ex 10 Task 9 Command 1
/* Here is an insert that fires the trigger created in Task 8. It is an 
insert of data into the source table ci_inventory...*/
INSERT INTO ci_inventory (asset_desc_id,purchase_or_rental,
unique_id,ci_acquired_date,ci_status_code,ci_status_date)
VALUES
(36,'PURCHASE','Serial No. LMK-845712456','06-NOV-22','WORKING',sysdate);
  
select * from ci_status_audit where unique_id='Serial No. LMK-845712456';


--Jordan Allen
--Ex 10 Task 9 Command 2
/* Here is an update that fires the trigger created in Task 8. It is an 
update of the ci_status_code on the ci_inventory table...*/
update ci_inventory
set ci_status_code = 'DISPOSED', ci_status_date = sysdate
where unique_id='Serial No. LMK-845712456';

select * from ci_status_audit where unique_id='Serial No. LMK-845712456';

--Jordan Allen
--Ex 10 Task 9 Command 3
/* Here is a delete that fires the trigger created in Task 8. It is a 
delete of a record in the ci_inventory table...*/
delete from ci_inventory where unique_id='Sernial No. 2103655';

select * from ci_status_audit;

--Jordan Allen
--Ex 10 Task 9 Command 4
/* Here is a statement to select the most recent record added to the 
audit table.*/
select * from ci_status_audit 
where action_date = (select max(action_date) from ci_status_audit); 


--Jordan Allen
--Ex 10 Task 10
select * from employee_ci where ci_inv_id = 7;
update employee_ci set date_unassigned = null where ci_inv_id = 7;


create or replace trigger update_inv_summary
before update of date_unassigned
on employee_ci
for each row
declare
  count_use number;
  asset_id_val number;
  count_avl number;
  count_sup number;
begin
  select asset_desc_id into asset_id_val 
  from ci_inventory where
  ci_inv_id = :new.ci_inv_id;
  
  select count(*) into  count_use 
  from employee_ci eci
  join ci_inventory cii on eci.ci_inv_id = cii.ci_inv_id
  where use_or_support = 'USE' and date_unassigned is null
  and cii.asset_desc_id = asset_id_val;
  
  select count(*) into  count_sup 
  from employee_ci eci
  join ci_inventory cii on eci.ci_inv_id = cii.ci_inv_id
  where use_or_support = 'SUPPORT' and date_unassigned is null
  and cii.asset_desc_id = asset_id_val;
  
  select count(*) into  count_avl 
  from ci_inventory cii 
  where ci_inv_id not in (select ci_inv_id from employee_ci
  where date_unassigned is null) and cii.asset_desc_id = asset_id_val;
  insert into it_asset_inv_summary values
  (it_asset_inv_summary_id_seq.nextval,asset_id_val,sysdate,count_avl,
  count_use,count_sup);
end;
--Jordan Allen
commit;