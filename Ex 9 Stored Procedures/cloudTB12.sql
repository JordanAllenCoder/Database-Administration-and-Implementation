--Jordan Allen
--Ex 9 Task 1
create or replace procedure INSERT_ASSET_TB12
(
  asset_type_desc_param  itam.asset_type.asset_type_desc%type,
  asset_make_param       itam.asset_desc.asset_make%type,
  asset_model_param      itam.asset_desc.asset_model%type,
  asset_ext_param        itam.asset_desc.asset_ext%type,
  success_param          out char
)
as
  asset_type_id_var      itam.asset_type.asset_type_id%type;
  asset_desc_id_var      itam.asset_desc.asset_desc_id%type;
  count_make_var         number;
  count_model_var        number;
  count_ext_var          number;
  count_type_var         number;
begin
  select 'S' into success_param from dual;
  
  if asset_type_desc_param is not null then
    select asset_type_id into asset_type_id_var
    from itam.asset_type where asset_type_desc_param=asset_type_id;
  else
    asset_type_id_var := asset_type_desc_param;
  end if;
  
  select count(*) into count_make_var from itam.asset_desc
  where asset_make=asset_make_param;
  if count_make_var > 0 then
    raise VALUE_ERROR;
  end if;
  
  select count(*) into count_model_var from itam.asset_desc
  where asset_model=asset_model_param;
  if count_model_var > 0 then
    raise value_error;
  end if;

  select count(*) into count_ext_var from itam.asset_desc
  where asset_ext=asset_ext_param;
  if count_ext_var > 0 then
    raise value_error;
  end if;
  
  select count(*) into count_type_var from itam.asset_desc
  where asset_type_id=asset_type_id_var;
  if count_type_var > 0 then
    raise value_error;
  end if;

  insert into itam.asset_desc values(asset_desc_id_var, asset_type_id_var, asset_make_param,
  asset_model_param, asset_ext_param);
  commit;
exception
  when VALUE_ERROR then
    select 'VE' into success_param from dual;
  when others then
    select 'F' into success_param from dual;
end;


--Jordan Allen
--Ex 9 Task 2 Command 1
--Call the stored procedure and get a success result
/*Success*/
declare 
  success_or_fail char;
begin
  INSERT_ASSET_TB12('Application', 'TechSmith', 'SnagIt',
  'v. 19',success_or_fail);
  dbms_output.put_line(success_or_fail);
end;



--Jordan Allen
--Ex 9 Task 2 Command 2
--Select the inserted record from the table.
select * from itam.asset_desc join itam.asset_type 
using(asset_type_id)
where 
asset_make = 'TechSmith'
and asset_model = 'SnagIt'
and asset_ext = 'v. 19'
and asset_type_desc = 'Application';


--Jordan Allen
--Ex 9 Task 3 Command 1
/* Failure */
declare 
  success_or_fail char(50);
begin
  insert_asset_TB12('Dinosaur', 'Acer', 
  'Swift 3 Laptop',
  '14in. Full HD Intel Core i5-6200U 8GB DDR4 256GB',
  success_or_fail);
  dbms_output.put_line(success_or_fail);
end;


--Jordan Allen
/*Ex 9 Task 4 Create a stored procedure */
create or replace procedure insert_ci_TB12
(
  asset_type_desc_param      itam.asset_type.asset_type_desc%type,
  asset_make_param           itam.asset_desc.asset_make%type,
  asset_model_param          itam.asset_desc.asset_model%type,
  asset_ext_param            itam.asset_desc.asset_ext%type,
  purchase_or_rental_param   itam.ci_inventory.purchase_or_rental%type,
  unique_id_param            itam.ci_inventory.unique_id%type,
  ci_acquired_date_param     itam.ci_inventory.ci_acquired_date%type,
  ci_status_code_param       itam.ci_inventory.ci_status_code%type,
  ci_status_date_param       itam.ci_inventory.ci_status_date%type,
  success_param              out char 
)
is
  ci_inv_id_var        itam.ci_inventory.ci_inv_id%TYPE;
  asset_type_id_var    itam.asset_type.asset_type_id%type;
  asset_desc_id_var    itam.asset_desc.asset_desc_id%type;
begin
  select 'S' into success_param from dual;--initialize success_param with S

  select asset_type_id into asset_type_id_var
  from itam.asset_type
  where asset_type_desc=asset_type_desc_param;

  select asset_desc_id into asset_desc_id_var
  from itam.asset_desc where
  asset_make = asset_make_param and
  asset_model = asset_model_param and
  asset_ext = asset_ext_param;
  
  select itam.ci_inv_id_seq.nextval
  into ci_inv_id_var from dual;

  insert into itam.ci_inventory values(ci_inv_id_var, asset_desc_id_var, purchase_or_rental_param,
  unique_id_param, ci_acquired_date_param, ci_status_code_param, ci_status_date_param);
  commit;
exception
  when VALUE_ERROR then
    select 'VE' into success_param from dual;
  when others then
    select 'F' into success_param from dual;
end;


--Jordan Allen
--Ex 9 Task 5 Command 1
--Call the stored procedure and get a success result
/*Success*/
declare 
  success_or_fail char;
begin
  insert_ci_TB12(2, 'Acer', 'Swift 3 Laptop',
  '14 in. Full HD Intel Core i5-6200U 8GB DDR4 256GB',
  'PURCHASE','Serial No. A1023444',
  to_date('28-OCT-2022 11:33:32 AM','DD-MON-YYYY HH:MI:SS AM'),
  'WORKING',sysdate, success_or_fail);--make up your own success data
  dbms_output.put_line(success_or_fail);
end;


--Jordan Allen
--Ex 9 Task 5 Command 2
--Verify the success result by selecting the inserted record
select * from itam.ci_inventory 
where unique_id = 'Serial No. A1023444';


--Jordan Allen
--Ex 9 Task 6 Command 1
--Call the stored procedure and get a failure result
/*Failure*/
declare 
  success_or_fail char;
begin
  insert_ci_TB12('Computer', 'Wefffffler', 'Swift 3 Laptop',
  '14 in. Full HD Intel Core i5-6200U 8GB DDR4 256GB',
  'PURCHASE','Serial No. A1023446',
  to_date('28-OCT-2022 11:33:32 AM','DD-MON-YYYY HH:MI:SS AM'),
  'WORKING',sysdate,  success_or_fail);-- make up your own fail data
  dbms_output.put_line(success_or_fail);
end;
