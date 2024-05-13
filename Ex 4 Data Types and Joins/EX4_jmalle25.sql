select * from jaherna42.asset_desc
select * from jaherna42.asset_type
select * from jaherna42.ci_status
select * from jaherna42.ci_inventory
select * from jaherna42.employee_ci

--Task 1 Assets in Inventory List
--Jordan Allen
select v.asset_make as "Asset Make",
v.asset_model as "Asset Model",
v.asset_ext as "More Info",
gla.asset_type_desc as "Type"
from jaherna42.asset_desc v join jaherna42.asset_type gla
on v.asset_type_id=gla.asset_type_id
where v.asset_desc_id not in
(select cii.asset_desc_id
from jaherna42.ci_inventory cii
where cii.ci_status_code = 'WORKING')
order by asset_make, asset_model;

having count(*) >1;

--Task 2 Asset Description for Assets in Use
--Jordan Allen
SELECT att.asset_type_desc, ad.asset_make, ad.asset_model, cii.ci_inv_id
FROM jaherna42.asset_type att
LEFT JOIN jaherna42.asset_desc ad ON att.asset_type_id = ad.asset_type_id 
LEFT JOIN jaherna42.ci_inventory cii ON ad.asset_desc_id = cii.asset_desc_id
where
cii.ci_inv_id not in
(select eci.ci_inv_id
from
jaherna42.employee_ci eci
where use_or_support = 'USE' and date_unassigned is null)
and ci_status_code = 'WORKING' and ad.asset_type_id = 2 or ad.asset_type_id = 1
order by ad.asset_make;


--Task 3 Lenovos Supported
--Jordan Allen
select count(asset_make),upper(asset_make)
from jaherna42.asset_desc ad join jaherna42.ci_inventory cii
on ad.asset_desc_id = cii.asset_desc_id
where
cii.ci_inv_id not in
(select eci.ci_inv_id
from
jaherna42.employee_ci eci
where upper(use_or_support) != 'USE' and date_unassigned is null)
and (upper(ad.asset_make) = 'LENOVO')
group by (ad.asset_make, ad.asset_model);


--Task 4 Spare CIs 
--Jordan Allen
select ad.asset_make, ad.asset_model, ad.asset_ext, cii.ci_inv_id
from jaherna42.asset_desc ad join jaherna42.ci_inventory cii
on ad.asset_desc_id=cii.asset_desc_id
where
cii.ci_inv_id not in
(select eci.ci_inv_id
from
jaherna42.employee_ci eci
where use_or_support <> 'USE' and date_assigned is null)
and ci_status_code = 'WORKING' and ad.asset_type_id = 2
order by upper(ad.asset_make);


--Task 5 Count of Spare Lenovos and Dells
--Jordan Allen
select count(asset_make),upper(asset_make)
from jaherna42.asset_desc ad join jaherna42.ci_inventory cii
on ad.asset_desc_id = cii.asset_desc_id
where
cii.ci_inv_id not in
(select eci.ci_inv_id
from
jaherna42.employee_ci eci
where use_or_support = 'USE' and date_unassigned is null)
and ci_status_code = 'WORKING' and ad.asset_type_id = 2
and (upper(ad.asset_make) = 'DELL' or upper(ad.asset_make) = 'LENOVO')
group by upper(ad.asset_make);


--Task 6 Count of Spare Dells and Lenovos From IT Asset Inventory Summary Table
--Jordan Allen
select upper(ad.asset_make),sum(num_available)
from
jaherna42.asset_desc ad join jaherna42.it_asset_inv_summary iais
on ad.asset_desc_id = iais.asset_desc_id
where (upper(ad.asset_make) like '%DELL%' or ad.asset_make like '%Lenovo%')
and ad.asset_type_id = 2
and iais.inv_summary_date >= (select max(inv_summary_date)
from jaherna42.it_asset_inv_summary sum2 where sum2.asset_desc_id = ad.asset_desc_id)
group by upper(ad.asset_make);

--Other query for task 7
select count(ad.asset_make),upper(asset_make)
from
jaherna42.asset_desc ad join jaherna42.it_asset_inv_summary iais
on ad.asset_desc_id = iais.asset_desc_id
where (upper(ad.asset_make) like '%DELL%' or ad.asset_make like '%Lenovo%')
and ad.asset_type_id = 2
and iais.inv_summary_date >= (select max(inv_summary_date)
from jaherna42.it_asset_inv_summary sum2 where sum2.asset_desc_id = ad.asset_desc_id)
group by upper(ad.asset_make);

--Task 7 Compare Spare Dells and Lenovos Results from Task 5 and Task 6
--Jordan Allen
select 'Task 5' as "Which Task",
count(asset_make),upper(asset_make)
from jaherna42.asset_desc ad join jaherna42.ci_inventory cii
on ad.asset_desc_id = cii.asset_desc_id
where
cii.ci_inv_id not in
(select eci.ci_inv_id
from
jaherna42.employee_ci eci
where use_or_support = 'USE' and date_unassigned is null)
and ci_status_code = 'WORKING' and ad.asset_type_id = 2
and (upper(ad.asset_make) = 'DELL' or upper(ad.asset_make) = 'LENOVO')
group by upper(ad.asset_make)
union
select 'Task 6' as "Which Task",
count(ad.asset_make),upper(asset_make)
from
jaherna42.asset_desc ad join jaherna42.it_asset_inv_summary iais
on ad.asset_desc_id = iais.asset_desc_id
where (upper(ad.asset_make) like '%DELL%' or ad.asset_make like '%Lenovo%')
and ad.asset_type_id = 2
and iais.inv_summary_date >= (select max(inv_summary_date)
from jaherna42.it_asset_inv_summary sum2 where sum2.asset_desc_id = ad.asset_desc_id)
group by upper(ad.asset_make);


--Task 8 Assets Assigned After a Specific Date/Time Value
--Jordan Allen
SELECT emp.first_name, emp.last_name, eci.date_assigned, cii.ci_inv_id, ad.asset_make, ad.asset_model
FROM jaherna42.employee emp
LEFT JOIN jaherna42.employee_ci eci ON emp.emp_id = eci.emp_id 
LEFT JOIN jaherna42.ci_inventory cii ON eci.ci_inv_id = cii.ci_inv_id
left join jaherna42.asset_desc ad on cii.asset_desc_id = ad.asset_desc_id
where
eci.date_assigned > to_date('12/JAN/2022 11:00:00','dd/mon/yyyy hh24:mi:ss')
and eci.use_or_support = ('USE') and eci.date_unassigned is null;


--Task 9 Assets Assigned in One Month of All Years
--Jordan Allen
SELECT emp.first_name, emp.last_name, eci.date_assigned, cii.ci_inv_id, ad.asset_make, ad.asset_model
FROM jaherna42.employee emp
LEFT JOIN jaherna42.employee_ci eci ON emp.emp_id = eci.emp_id 
LEFT JOIN jaherna42.ci_inventory cii ON eci.ci_inv_id = cii.ci_inv_id
left join jaherna42.asset_desc ad on cii.asset_desc_id = ad.asset_desc_id
where
eci.date_assigned = to_date('APR','MON')
and eci.use_or_support = ('USE');

--Task 10 Assets Assigned on a Specific Date
--Jordan Allen
SELECT emp.first_name, emp.last_name, eci.date_assigned, cii.ci_inv_id, ad.asset_make, ad.asset_model
FROM jaherna42.employee emp
LEFT JOIN jaherna42.employee_ci eci ON emp.emp_id = eci.emp_id 
LEFT JOIN jaherna42.ci_inventory cii ON eci.ci_inv_id = cii.ci_inv_id
left join jaherna42.asset_desc ad on cii.asset_desc_id = ad.asset_desc_id
where
eci.date_assigned=to_date('30/AUG/2022','dd/mon/yyyy');

commit;
