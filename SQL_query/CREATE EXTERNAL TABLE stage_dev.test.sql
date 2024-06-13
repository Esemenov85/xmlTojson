-- --- ---- ----- Внешняя таблица для ПГМУ Госуслуг с персональными данными ----- ---- --- --
-- pgmu_gosuslug.ext_pgmu_communications_users definition
-- Drop table
-- DROP EXTERNAL TABLE pgmu_gosuslug.ext_pgmu_communications_users;
CREATE EXTERNAL TABLE stage_dev.pgmu_gosuslug.ext_pgmu_communications_users (
	lastname text,
	firstname text,
	middlename text,
	birthday text,
	email text,
	phone_number text,
	sex text,
	passport_series text,
	passport_number text,
	snils text,
	jkh_account_number text,
	customer_id text,
	snils_is_valid text,
	email_is_valid text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/pgmu_gosuslug/communications/pgmu_users*'
) ON ALL
FORMAT 'CSV' ( delimiter ',' null '' escape '"' quote '"' )
ENCODING 'UTF8'
SEGMENT REJECT LIMIT 5 ROWS;
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

--- ---- ---- ----
-- test.ias definition
-- DROP EXTERNAL TABLE stage_dev.test.ias

CREATE EXTERNAL TABLE stage_dev.test.ias (
	id int8,
	user_id int4,
	quant_id int4,
	start_date timestamp,
	end_date timestamp,
	value numeric,
	input_date timestamp,
	last_modified timestamp,
	"comment" varchar,
	indicator_id int4
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/ias/*'
) ON ALL
FORMAT 'csv' ( delimiter ',' null '' escape '"' quote '"' header )
ENCODING 'UTF8';
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

-- test.ext_perscom_edu_ymarks definition
-- Drop table
-- DROP EXTERNAL TABLE test.ext_perscom_edu_ymarks;

CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_edu_ymarks (
	id text,
	subject_id text,
	student_id text,
	class_id text,
	subject_name text,
	fact text,
	fivepoint_fact text,
	final_fact text,
	fivepoint_final_fact text,
	recent_plan text,
	fivepoint_recent_plan text,
	school_id text,
	class_num text,
	class_year_from text,
	mark_scale_code text,
	mark_scale_value text,
	mark_scale_description text,
	create_datetime text,
	send_datetime text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/asavelejva/perscom_data/YMARKS/*'
) ON ALL
FORMAT 'TEXT' ( delimiter ';' null '\N' escape '\' )
ENCODING 'UTF8';

------------------------------------------------------------------------------------
create table so78 (h text primary key default md5(now()::text),i int)


select subject_name, md5(subject_name), md5(subject_name) from test.perscom_edu_ymarks limit 100;


--------------------------
--perscom_data/YMARKS/
--/home/asavelejva/greenplum_external_tables/...
--LOCATION('gpfdist://10.11.128.215:18081/asavelejva/...')
--FORMAT 'CSV' ( delimiter ',' null '' escape '"' quote '"' header )
--------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- --- ---- ----- Внешние таблицы по персональным коммуникациям ----- ---- --- --
--
--
-- Внешняя Таблица по ymarks
-- test.ext_perscom_edu_ymarks definition
-- Drop table
-- DROP EXTERNAL TABLE test.ext_perscom_edu_ymarks;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_edu_ymarks (
	id int8,
	subject_id int4,
	student_id int4,
	class_id int4,
	subject_name text,
	fact int4,
	fivepoint_fact int4,
	final_fact text,
	fivepoint_final_fact text,
	recent_plan text,
	fivepoint_recent_plan text,
	school_id int4,
	class_num int4,
	class_year_from int4,
	mark_scale_code text,
	mark_scale_value int4,
	mark_scale_description text,
	create_datetime text,
	send_datetime text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/asavelejva/perscom_data/YMARKS/*'
) ON ALL
FORMAT 'CSV' ( delimiter ';' null '\N' escape '\'  header )
ENCODING 'UTF8';
--
--
CREATE TABLE stage_dev.test.perscom_edu_ymarks (
	id int8,
	subject_id int4,
	student_id int4,
	class_id int4,
	subject_name text,
	fact int4,
	fivepoint_fact int4,
	final_fact text,
	fivepoint_final_fact text,
	recent_plan text,
	fivepoint_recent_plan text,
	school_id int4,
	class_num int4,
	class_year_from int4,
	mark_scale_code text,
	mark_scale_value int4,
	mark_scale_description text,
	create_datetime text,
	send_datetime text
)
DISTRIBUTED BY (id);
--
insert into stage_dev.test.perscom_edu_ymarks select * from stage_dev.test.ext_perscom_edu_ymarks;
--
select * from stage_dev.test.perscom_edu_ymarks limit 100;
--
--
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- Внешняя Таблица по students
-- test.ext_perscom_edu_students definition
-- Drop table
-- DROP EXTERNAL TABLE test.ext_perscom_edu_students;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_edu_students (
	id int8,
	oid text,
	auth_link text,
	vk_id text,
	firstname text,
	lastname text,
	patronymic text,
	hash_gost2012 text,
	hash_num text,
	hash_gost2012_2 text,
	hash_num_2 text,
	hash_gost2012_3 text,
	hash_num_3 text,
	birthdate text,
	birthplace text,
	snils text,
	e_mail text,
	numb_passport text,
	ser_passport text,
	data_passport text,
	gender_code text,
	gender_value int4,
	gender_description text,
	start_datetime text,
	end_datetime text,
	"active" text,
	status_code text,
	status_value int4,
	status_description text,
	reason_code text,
	reason_value text,
	reason_description text,
	data_start_study text,
	expect_end_study text,
	data_end_study text,
	rddm_first text,
	create_datetime text,
	send_datetime text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/asavelejva/perscom_data/STUDENTS/*'
) ON ALL
FORMAT 'CSV' ( delimiter ';' null '\N' escape '\'  header )
ENCODING 'UTF8';
---
---
---
CREATE TABLE stage_dev.test.perscom_edu_students (
	id int8,
	oid text,
	auth_link text,
	vk_id text,
	firstname text,
	lastname text,
	patronymic text,
	hash_gost2012 text,
	hash_num text,
	hash_gost2012_2 text,
	hash_num_2 text,
	hash_gost2012_3 text,
	hash_num_3 text,
	birthdate text,
	birthplace text,
	snils text,
	e_mail text,
	numb_passport text,
	ser_passport text,
	data_passport text,
	gender_code text,
	gender_value int4,
	gender_description text,
	start_datetime text,
	end_datetime text,
	"active" text,
	status_code text,
	status_value int4,
	status_description text,
	reason_code text,
	reason_value text,
	reason_description text,
	data_start_study text,
	expect_end_study text,
	data_end_study text,
	rddm_first text,
	create_datetime text,
	send_datetime text
)
DISTRIBUTED BY (id);
---
---
--- Вставка захэшированных перс данных из внешней таблицы 
insert into test.perscom_edu_students (
id,
oid,
auth_link,
vk_id,
firstname,
lastname,
patronymic,
hash_gost2012,
hash_num,
hash_gost2012_2,
hash_num_2,
hash_gost2012_3,
hash_num_3,
birthdate,
birthplace,
snils,
e_mail,
numb_passport,
ser_passport,
data_passport,
gender_code,
gender_value,
gender_description,
start_datetime,
end_datetime,
active,
status_code,
status_value,
status_description,
reason_code,
reason_value,
reason_description,
data_start_study,
expect_end_study,
data_end_study,
rddm_first,
create_datetime,
send_datetime
) select 
"id",
"oid",
auth_link,
vk_id,
md5(firstname),
md5(lastname),
md5(patronymic),
hash_gost2012,
hash_num,
hash_gost2012_2,
hash_num_2,
hash_gost2012_3,
hash_num_3,
birthdate,
birthplace,
md5(snils),
e_mail,
md5(numb_passport),
md5(ser_passport),
md5(data_passport),
gender_code,
gender_value,
gender_description,
start_datetime,
end_datetime,
"active",
status_code,
status_value,
status_description,
reason_code,
reason_value,
reason_description,
data_start_study,
expect_end_study,
data_end_study,
rddm_first,
create_datetime,
send_datetime
from stage_dev.test.ext_perscom_edu_students;
-- -- --
-- -- --
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- Внешняя Таблица по pgmu_users
-- test.ext_perscom_edu_students definition
-- Drop table
-- DROP EXTERNAL TABLE stage_dev.test.ext_perscom_pgmu_users;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_pgmu_users (
	lastname text,
	firstname text,
	middlename text,
	birthday text,
	email text,
	sex int4,
	is_has_app int4,
	driver_license_seria text,
	driver_license_number text,
	customer_id int8
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/pgmu_users/*'
) ON ALL
FORMAT 'CSV' ( delimiter ';' null '\N' escape '\'  header )
ENCODING 'UTF8';
---
---
---
CREATE TABLE stage_dev.test.perscom_pgmu_users (
	lastname text,
	firstname text,
	middlename text,
	birthday text,
	email text,
	sex int4,
	is_has_app int4,
	driver_license_seria text,
	driver_license_number text,
	customer_id int8
)
DISTRIBUTED BY (customer_id);
---
delete from test.perscom_pgmu_users;
truncate table test.perscom_pgmu_users;
---
insert into stage_dev.test.perscom_pgmu_users (
	lastname,
	firstname,
	middlename,
	birthday,
	email,
	sex,
	is_has_app,
	driver_license_seria,
	driver_license_number,
	customer_id
) select 
	case when lastname = '' then null else md5(lastname) end,
	case when firstname = '' then null else md5(firstname) end,
	case when middlename = '' then null else md5(middlename) end,
	birthday,
	email,
	sex,
	is_has_app,
	case when driver_license_seria = '' then null else md5(driver_license_seria) end,
	case when driver_license_number = '' then null else md5(driver_license_number) end,
	customer_id
from stage_dev.test.ext_perscom_pgmu_users;
-- -- --
-- -- --
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- Внешняя Таблица по pgmu_kids
-- DROP EXTERNAL TABLE stage_dev.test.ext_perscom_pgmu_kids;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_pgmu_kids (
	children_lastname text,
	children_firstname text,
	children_middlename text,
	children_birthdate text,
	children_sex text,
	children_document_type text,
	children_document_series text,
	children_document_number text,
	children_document_date text,
	children_document_issuer text,
	children_snils text,
	mpolicy_series text,
	mpolicy_number text,
	edu_login text,
	customer_id int8
)
LOCATION (
	'gpfdist://10.11.128.215:18081/asavelejva/perscom_data/pgmu_kids/*'
) ON ALL
FORMAT 'CSV' ( delimiter ';' null '\N' escape '\'  header )
ENCODING 'UTF8';
---
---
---
CREATE TABLE stage_dev.test.perscom_pgmu_kids (
	children_lastname text,
	children_firstname text,
	children_middlename text,
	children_birthdate text,
	children_sex text,
	children_document_type text,
	children_document_series text,
	children_document_number text,
	children_document_date text,
	children_document_issuer text,
	children_snils text,
	mpolicy_series text,
	mpolicy_number text,
	edu_login text,
	customer_id int8
)
DISTRIBUTED BY (customer_id);
---
delete from stage_dev.test.perscom_pgmu_kids;
truncate table stage_dev.test.perscom_pgmu_kids;
---
insert into stage_dev.test.perscom_pgmu_kids (
	children_lastname,
	children_firstname,
	children_middlename,
	children_birthdate,
	children_sex,
	children_document_type,
	children_document_series,
	children_document_number,
	children_document_date,
	children_document_issuer,
	children_snils,
	mpolicy_series,
	mpolicy_number,
	edu_login,
	customer_id
) select 
	case when children_lastname = '' then null else md5(children_lastname) end,
	case when children_firstname = '' then null else md5(children_firstname) end,
	case when children_middlename = '' then null else md5(children_middlename) end,
	children_birthdate,
	children_sex,
	children_document_type,
	case when children_document_series = '' then null else md5(children_document_series) end,
	case when children_document_number = '' then null else md5(children_document_number) end,
	children_document_date,
	case when children_document_issuer = '' then null else md5(children_document_issuer) end,
	case when children_snils = '' then null else md5(children_snils) end,
	case when mpolicy_series = '' then null else md5(mpolicy_series) end,
	case when mpolicy_number = '' then null else md5(mpolicy_number) end,
	case when edu_login = '' then null else md5(edu_login) end,
	customer_id
from stage_dev.test.ext_perscom_pgmu_kids;
-- -- --
-- -- --
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- Внешняя Таблица по pgmu_gibdd
-- DROP EXTERNAL TABLE stage_dev.test.ext_perscom_pgmu_gibdd;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_pgmu_gibdd (
	customer_id int8,
	title text,
	vehicle_type text,
	vehicle_number text,
	vehicle_region text,
	document_series text,
	document_number text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/asavelejva/perscom_data/pgmu_gibdd/*'
) ON ALL
FORMAT 'CSV' ( delimiter ';' null '\N' escape '\'  header )
ENCODING 'UTF8';
---
---
---
CREATE TABLE stage_dev.test.perscom_pgmu_gibdd (
	customer_id int8,
	title text,
	vehicle_type text,
	vehicle_number text,
	vehicle_region text,
	document_series text,
	document_number text
)
DISTRIBUTED BY (customer_id);
---
delete from stage_dev.test.perscom_pgmu_gibdd;
truncate table stage_dev.test.perscom_pgmu_gibdd;
---
insert into stage_dev.test.perscom_pgmu_gibdd (
customer_id,
title,
vehicle_type,
vehicle_number,
vehicle_region,
document_series,
document_number
) select 
	customer_id,
	title,
	vehicle_type,
	vehicle_number,
	vehicle_region,
	case when document_series = '' then null else md5(document_series) end,
	case when document_series = '' then null else md5(document_number) end
from stage_dev.test.ext_perscom_pgmu_gibdd;
-- -- --
-- -- --
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- Внешняя Таблица по /KINDERGARTEN/Kinder List
-- DROP EXTERNAL TABLE stage_dev.test.ext_perscom_kinder_list;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_kinder_list (
	"табельный номер" int8,
	"дата рождения" text,
	"ФИО ребенка" text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/asavelejva/perscom_data/KINDERGARTEN/kinder_list_1_4_2024.csv'
) ON ALL
FORMAT 'CSV' ( delimiter ',' null '\N' escape '\'  header )
ENCODING 'UTF8';
---
---
---
CREATE TABLE stage_dev.test.perscom_kinder_list (
	tab_number int8,
	date_birth text,
	full_name_child text
)
DISTRIBUTED BY (tab_number);
---
delete from stage_dev.test.perscom_kinder_list;
truncate table stage_dev.test.perscom_kinder_list;
---
insert into stage_dev.test.perscom_kinder_list (
	tab_number,
	date_birth,
	full_name_child
) select 
	"табельный номер",
	"дата рождения",
	case when "ФИО ребенка" = '' then null else md5("ФИО ребенка") end
from stage_dev.test.ext_perscom_kinder_list;
-- -- --
-- -- --
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- Внешняя Таблица по /KINDERGARTEN/Kinder СРН
-- DROP EXTERNAL TABLE stage_dev.test.ext_perscom_kinder_CPH;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_kinder_CPH (
	DDU_CODE int8,
	"NUMBER" int8,
	CHILD text,
	BIRTHDATE text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/reestr_not_compens_from_CPH.csv'
) ON ALL
FORMAT 'CSV' ( delimiter ',' null '\N' escape '\'  header )
ENCODING 'UTF8';
---
---
---
CREATE TABLE stage_dev.test.perscom_kinder_srn (
	ddu_code int8,
	"number" int8,
	child text,
	birthdate text
)
DISTRIBUTED BY ("number");
---
delete from stage_dev.test.perscom_kinder_srn;
truncate table stage_dev.test.perscom_kinder_srn;
---
insert into stage_dev.test.perscom_kinder_srn (
	ddu_code,
	"number",
	child,
	birthdate
) select 
	DDU_CODE,
	"NUMBER",
	case when CHILD = '' then null else md5(CHILD) end,
	BIRTHDATE
from stage_dev.test.ext_perscom_kinder_CPH;
-- -- --
-- -- --



---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- ************************************************************************************************************************************************* --
-- Внешняя Таблица по /KINDERGARTEN/
-- Таблица на основе распарсенного файла по частям из 5 таблиц ("doo666_1.csv" ... и т.д.)
-- DROP EXTERNAL TABLE stage_dev.test.ext_perscom_kinder_doo;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_kinder_doo (
	id int8,
	kod_doo int8,
	tab_n_child text,
	surname_child text,
	firstname_child text,
	patronymic_child text,
	dbirth_child text,
	gender_child text,
	snils_child text,
	series_dul_child text,
	number_dul_child text,
	date_dul_child text,
	whom_dul_child text,
	country_birth_child text,
	region_birth_child text,
	series_dul_delegate text,
	number_dul_delegate text,
	type_delegate text,
	surname_delegate text,
	firstname_delegate text,
	patronymic_delegate text,
	region_reg_address_delegate text,
	place_reg_address_delegate text,
	street_reg_address_delegate text,
	house_reg_address_delegate text,
	corps_reg_address_delegate text,
	flat_reg_address_delegate text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/doo666/doo666_full.csv'
) ON ALL
FORMAT 'CSV' ( delimiter '|' null '\N' escape '\'  header )
ENCODING 'UTF8';
---
select count(*)  from stage_dev.test.ext_perscom_kinder_doo;
---
---
CREATE TABLE stage_dev.test.perscom_kinder_doo (
	id int8,
	kod_doo int8,
	tab_n_child text,
	surname_child text,
	firstname_child text,
	patronymic_child text,
	dbirth_child text,
	gender_child text,
	snils_child text,
	series_dul_child text,
	number_dul_child text,
	date_dul_child text,
	whom_dul_child text,
	country_birth_child text,
	region_birth_child text,
	series_dul_delegate text,
	number_dul_delegate text,
	type_delegate text,
	surname_delegate text,
	firstname_delegate text,
	patronymic_delegate text,
	region_reg_address_delegate text,
	place_reg_address_delegate text,
	street_reg_address_delegate text,
	house_reg_address_delegate text,
	corps_reg_address_delegate text,
	flat_reg_address_delegate text
)
DISTRIBUTED BY (kod_doo);
---
---
delete from stage_dev.test.perscom_kinder_doo;
truncate table stage_dev.test.perscom_kinder_doo;
---
insert into stage_dev.test.perscom_kinder_doo (
	id,
	kod_doo,
	tab_n_child,
	surname_child,
	firstname_child,
	patronymic_child,
	dbirth_child,
	gender_child,
	snils_child,
	series_dul_child,
	number_dul_child,
	date_dul_child,
	whom_dul_child,
	country_birth_child,
	region_birth_child,
	series_dul_delegate,
	number_dul_delegate,
	type_delegate,
	surname_delegate,
	firstname_delegate,
	patronymic_delegate,
	region_reg_address_delegate,
	place_reg_address_delegate,
	street_reg_address_delegate,
	house_reg_address_delegate,
	corps_reg_address_delegate,
	flat_reg_address_delegate
) select 
	id,
	kod_doo,
	tab_n_child,
	case when surname_child = '' then null else md5(surname_child) end,
	case when firstname_child = '' then null else md5(firstname_child) end,
	case when patronymic_child = '' then null else md5(patronymic_child) end,
	dbirth_child,
	gender_child,
	case when snils_child = '' then null else md5(snils_child) end,
	case when series_dul_child = '' then null else md5(series_dul_child) end,
	case when number_dul_child = '' then null else md5(number_dul_child) end,
	date_dul_child,
	whom_dul_child,
	country_birth_child,
	region_birth_child,
	case when series_dul_delegate = '' then null else md5(series_dul_delegate) end,
	case when number_dul_delegate = '' then null else md5(number_dul_delegate) end,
	type_delegate,
	case when surname_delegate = '' then null else md5(surname_delegate) end,
	case when firstname_delegate = '' then null else md5(firstname_delegate) end,
	case when patronymic_delegate = '' then null else md5(patronymic_delegate) end,
	region_reg_address_delegate,
	place_reg_address_delegate,
	street_reg_address_delegate,
	house_reg_address_delegate,
	corps_reg_address_delegate,
	flat_reg_address_delegate
from stage_dev.test.ext_perscom_kinder_doo;
---
---
--- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
---
---
--- Первая часть --- 
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_kinder_doo_1 (
	id int8,
	kod_doo int8,
	tab_n_child text,
	surname_child text,
	firstname_child text,
	patronymic_child text,
	dbirth_child text,
	gender_child text,
	snils_child text,
	series_dul_child text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/doo666_1.csv'
) ON ALL
FORMAT 'CSV' ( delimiter '|' null '\N' escape '\'  header )
ENCODING 'UTF8';
---
select count(*) from test.ext_perscom_kinder_doo_1;
---
CREATE TABLE stage_dev.test.perscom_kinder_doo_1 (
	id int8,
	kod_doo int8,
	tab_n_child text,
	surname_child text,
	firstname_child text,
	patronymic_child text,
	dbirth_child text,
	gender_child text,
	snils_child text,
	series_dul_child text
)
DISTRIBUTED BY (kod_doo);
---
truncate table stage_dev.test.perscom_kinder_doo_1;
---
insert into stage_dev.test.perscom_kinder_doo_1 (
	id,
	kod_doo,
	tab_n_child,
	surname_child,
	firstname_child,
	patronymic_child,
	dbirth_child,
	gender_child,
	snils_child,
	series_dul_child
) select 
	id,
	kod_doo,
	tab_n_child,
	case when surname_child = '' then null else md5(surname_child) end,
	case when firstname_child = '' then null else md5(firstname_child) end,
	case when patronymic_child = '' then null else md5(patronymic_child) end,
	dbirth_child,
	gender_child,
	case when snils_child = '' then null else md5(snils_child) end,
	case when series_dul_child = '' then null else md5(series_dul_child) end
from stage_dev.test.ext_perscom_kinder_doo_1;
---
---
--- Вторая часть --- 
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_kinder_doo_2 (
	id int8,
	number_dul_child text,
	date_dul_child text,
	country_birth_child text,
	region_birth_child text,
	series_dul_delegate text,
	number_dul_delegate text,
	type_delegate text,
	surname_delegate text,
	firstname_delegate text,
	patronymic_delegate text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/doo666_2.csv'
) ON ALL
FORMAT 'CSV' ( delimiter '|' null '\N' escape '\'  header )
ENCODING 'UTF8';
---
select count(*) from test.ext_perscom_kinder_doo_2;
---
CREATE TABLE stage_dev.test.perscom_kinder_doo_2 (
	id int8,
	number_dul_child text,
	date_dul_child text,
	country_birth_child text,
	region_birth_child text,
	series_dul_delegate text,
	number_dul_delegate text,
	type_delegate text,
	surname_delegate text,
	firstname_delegate text,
	patronymic_delegate text
)
DISTRIBUTED BY (id);
---
truncate table stage_dev.test.perscom_kinder_doo_2;
---
insert into stage_dev.test.perscom_kinder_doo_2 (
	id,
	number_dul_child,
	date_dul_child,
	country_birth_child,
	region_birth_child,
	series_dul_delegate,
	number_dul_delegate,
	type_delegate,
	surname_delegate,
	firstname_delegate,
	patronymic_delegate
) select 
	id,
	case when number_dul_child = '' then null else md5(number_dul_child) end,
	date_dul_child,
	country_birth_child,
	region_birth_child,
	case when series_dul_delegate = '' then null else md5(series_dul_delegate) end,
	case when number_dul_delegate = '' then null else md5(number_dul_delegate) end,
	type_delegate,
	case when surname_delegate = '' then null else md5(surname_delegate) end,
	case when firstname_delegate = '' then null else md5(firstname_delegate) end,
	case when patronymic_delegate = '' then null else md5(patronymic_delegate) end
from stage_dev.test.ext_perscom_kinder_doo_2;
---
---
--- Третья часть --- 
-- DROP EXTERNAL TABLE stage_dev.test.ext_perscom_kinder_doo_3;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_kinder_doo_3 (
	id int8,
	whom_dul_child varchar
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/doo666_3.csv'
) ON ALL
FORMAT 'CSV' ( delimiter '|' null '\N' escape '\'  header )
ENCODING 'UTF8';
---
select count(*) from test.ext_perscom_kinder_doo_3;
---
CREATE TABLE stage_dev.test.perscom_kinder_doo_3 (
	id int8,
	whom_dul_child varchar
)
DISTRIBUTED BY (id);
---
truncate table stage_dev.test.perscom_kinder_doo_3;
---
insert into stage_dev.test.perscom_kinder_doo_3 (
	id,
	whom_dul_child
) select 
	id,
	whom_dul_child
from stage_dev.test.ext_perscom_kinder_doo_3;
---
---
--- Четвертая часть --- 
-- DROP EXTERNAL TABLE stage_dev.test.ext_perscom_kinder_doo_4;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_kinder_doo_4 (
	id int8,
	region_reg_address_delegate text,
	place_reg_address_delegate text,
	street_reg_address_delegate text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/doo666_4.csv'
) ON ALL
FORMAT 'CSV' ( delimiter '|' null '\N' escape '\'  header )
ENCODING 'UTF8';
---
select count(*) from test.ext_perscom_kinder_doo_4;
---
CREATE TABLE stage_dev.test.perscom_kinder_doo_4 (
	id int8,
	region_reg_address_delegate text,
	place_reg_address_delegate text,
	street_reg_address_delegate text
)
DISTRIBUTED BY (id);
---
truncate table stage_dev.test.perscom_kinder_doo_4;
---
insert into stage_dev.test.perscom_kinder_doo_4 (
	id,
	region_reg_address_delegate,
	place_reg_address_delegate,
	street_reg_address_delegate
) select 
	id,
	region_reg_address_delegate,
	place_reg_address_delegate,
	street_reg_address_delegate
from stage_dev.test.ext_perscom_kinder_doo_4;
---
---
--- Пятая часть --- 
-- DROP EXTERNAL TABLE stage_dev.test.ext_perscom_kinder_doo_5;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_kinder_doo_5 (
	id int8,
	house_reg_address_delegate text,
	corps_reg_address_delegate text,
	flat_reg_address_delegate text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/doo666_5.csv'
) ON ALL
FORMAT 'CSV' ( delimiter '|' null '\N' escape '\'  header )
ENCODING 'UTF8';
---
select count(*) from test.ext_perscom_kinder_doo_5;
---
CREATE TABLE stage_dev.test.perscom_kinder_doo_5 (
	id int8,
	house_reg_address_delegate text,
	corps_reg_address_delegate text,
	flat_reg_address_delegate text
)
DISTRIBUTED BY (id);
---
truncate table stage_dev.test.perscom_kinder_doo_5;
---
insert into stage_dev.test.perscom_kinder_doo_5 (
	id,
	house_reg_address_delegate,
	corps_reg_address_delegate,
	flat_reg_address_delegate
) select 
	id,
	house_reg_address_delegate,
	corps_reg_address_delegate,
	flat_reg_address_delegate
from stage_dev.test.ext_perscom_kinder_doo_5;
---
-- -- --
-- -- --
-- ************************************************************************************************************************************************* --
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- Внешняя Таблица по pgmu_pay
-- Full Pack
-- DROP EXTERNAL TABLE stage_dev.test.ext_perscom_pgmu_pay;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_pgmu_pay (
	lastname varchar
	,firstname varchar
	,middlename varchar
	,birthday text
	,email text
	,phone_number text
	,sex text
	,passport_series text
	,passport_number text
	,snils text
	,jkh_account_number text
	,customer_id int8
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/pgmu_pay/full_pack/*'
) ON ALL
FORMAT 'CSV' ( delimiter '|' null '\N' escape '\'  header )
ENCODING 'UTF8';
---
select count(*) from stage_dev.test.ext_perscom_pgmu_pay;
---
---
CREATE TABLE stage_dev.test.perscom_pgmu_pay (
	lastname varchar
	,firstname varchar
	,middlename varchar
	,birthday text
	,email text
	,phone_number text
	,sex text
	,passport_series text
	,passport_number text
	,snils text
	,jkh_account_number text
	,customer_id int8
)
DISTRIBUTED BY (customer_id);
---
truncate table stage_dev.test.perscom_pgmu_pay;
---
insert into stage_dev.test.perscom_pgmu_pay (
	lastname
	,firstname
	,middlename
	,birthday
	,email
	,phone_number
	,sex
	,passport_series
	,passport_number
	,snils
	,jkh_account_number
	,customer_id
) select 
	case when lastname = '' then null else md5(lastname) end
	,case when firstname = '' then null else md5(firstname) end
	,case when middlename = '' then null else md5(middlename) end
	,birthday
	,email
	,case when phone_number = '' then null else md5(phone_number) end
	,sex
	,case when passport_series = '' then null else md5(passport_series) end
	,case when passport_number = '' then null else md5(passport_number) end
	,case when snils = '' then null else md5(snils) end
	,jkh_account_number
	,customer_id
from stage_dev.test.ext_perscom_pgmu_pay;
---
---
--- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Первая часть
-- DROP EXTERNAL TABLE stage_dev.test.ext_perscom_pgmu_pay_1;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_pgmu_pay_1 (
	customer_id int8
	,lastname varchar
	,firstname varchar
	,middlename varchar
	,birthday text
--	,email text
--	,phone_number text
--	,sex text
--	,passport_series text
--	,passport_number text
--	,snils text
--	,jkh_account_number text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/pgmu_pay/pack01/*'
) ON ALL
FORMAT 'CSV' ( delimiter '|' null '\N' escape '\'  header )
ENCODING 'UTF8';
---
select count(*) from stage_dev.test.ext_perscom_pgmu_pay_1;
---
CREATE TABLE stage_dev.test.perscom_pgmu_pay_1 (
	customer_id int8
	,lastname varchar
	,firstname varchar
	,middlename varchar
	,birthday text
)
DISTRIBUTED BY (customer_id);
---
truncate table stage_dev.test.perscom_pgmu_pay_1;
---
insert into stage_dev.test.perscom_pgmu_pay_1 (
	customer_id
	,lastname
	,firstname
	,middlename
	,birthday
) select 
	customer_id
	,case when lastname = '' then null else md5(lastname) end
	,case when firstname = '' then null else md5(firstname) end
	,case when middlename = '' then null else md5(middlename) end
	,birthday
from stage_dev.test.ext_perscom_pgmu_pay_1;
---
--- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Вторая часть
-- DROP EXTERNAL TABLE stage_dev.test.ext_perscom_pgmu_pay_2;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_pgmu_pay_2 (
	customer_id int8
--	,lastname varchar
--	,firstname varchar
--	,middlename varchar
--	,birthday text
	,email text
--	,phone_number text
--	,sex text
--	,passport_series text
--	,passport_number text
--	,snils text
--	,jkh_account_number text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/pgmu_pay/pack02/*'
) ON ALL
FORMAT 'CSV' ( delimiter '|' null '\N' escape '\'  header )
ENCODING 'UTF8';
---
select count(*) from stage_dev.test.ext_perscom_pgmu_pay_2;
---
---
CREATE TABLE stage_dev.test.perscom_pgmu_pay_2 (
	customer_id int8
	,email text
)
DISTRIBUTED BY (customer_id);
---
truncate table stage_dev.test.perscom_pgmu_pay_2;
---
insert into stage_dev.test.perscom_pgmu_pay_2 (
	customer_id
	,email
) select 
	customer_id
	,email
from stage_dev.test.ext_perscom_pgmu_pay_2;
---
--- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- ************************************************************************************************************************************************* --
-- ************************************************************************************************************************************************* --
-- ************************************************************************************************************************************************* --
---
-- 1. kinder_doo
-- DROP EXTERNAL TABLE stage_dev.test.ext_perscom_kinder_doo;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_kinder_doo (
	id int8, kod_doo int8, tab_n_child text, surname_child text, firstname_child text, patronymic_child text, 
	dbirth_child text, 
	gender_child text, snils_child text, series_dul_child text, number_dul_child text, date_dul_child text, whom_dul_child text, country_birth_child text, region_birth_child text, 
	series_dul_delegate text, number_dul_delegate text, type_delegate text, surname_delegate text, firstname_delegate text, patronymic_delegate text, region_reg_address_delegate text, 
	place_reg_address_delegate text, street_reg_address_delegate text, house_reg_address_delegate text, corps_reg_address_delegate text, flat_reg_address_delegate text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/doo666/doo666_full.csv'
) ON ALL
FORMAT 'CSV' ( delimiter '|' null '\N' escape '\'  header )
ENCODING 'UTF8'
--
-- DROP SCHEMA perscom;
CREATE SCHEMA perscom AUTHORIZATION edw;
-- DROP EXTERNAL TABLE stage_dev.perscom.ext_kinder_doo;
CREATE EXTERNAL TABLE stage_dev.perscom.ext_kinder_doo (
	id int8, kod_doo int8, tab_n_child text, surname_child text, firstname_child text, patronymic_child text, 
	dbirth_child text, 
	gender_child text, snils_child text, series_dul_child text, number_dul_child text, date_dul_child text, whom_dul_child text, country_birth_child text, region_birth_child text, 
	series_dul_delegate text, number_dul_delegate text, type_delegate text, surname_delegate text, firstname_delegate text, patronymic_delegate text, region_reg_address_delegate text, 
	place_reg_address_delegate text, street_reg_address_delegate text, house_reg_address_delegate text, corps_reg_address_delegate text, flat_reg_address_delegate text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/doo666/doo666_full.csv'
) ON ALL
FORMAT 'CSV' ( delimiter '|' null '\N' escape '\'  header )
ENCODING 'UTF8';
--
select count(*) from stage_dev.test.ext_perscom_kinder_doo;
select count(*) from stage_dev.perscom.ext_kinder_doo; 
---
-- 2. kinder_list
-- DROP EXTERNAL TABLE stage_dev.test.ext_perscom_kinder_list;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_kinder_list (
	"табельный номер" int8,
	"дата рождения" text,
	"ФИО ребенка" text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/kindergarten/kinder_list_1_4_2024.csv'
) ON ALL
FORMAT 'CSV' ( delimiter ',' null '\N' escape '\'  header )
ENCODING 'UTF8';
--
-- DROP EXTERNAL TABLE stage_dev.perscom.ext_kinder_list;
CREATE EXTERNAL TABLE stage_dev.perscom.ext_kinder_list (
	"табельный номер" int8,
	"дата рождения" text,
	"ФИО ребенка" text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/kindergarten/kinder_list_1_4_2024.csv'
) ON ALL
FORMAT 'CSV' ( delimiter ',' null '\N' escape '\'  header )
ENCODING 'UTF8';
--
select count(*) from stage_dev.test.ext_perscom_kinder_list;
---
-- 3. kinder_CPH
-- DROP EXTERNAL TABLE stage_dev.test.ext_perscom_kinder_CPH;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_kinder_CPH (
	DDU_CODE int8,
	"NUMBER" int8,
	CHILD text,
	BIRTHDATE text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/reestr_not_compens_from_CPH.csv'
) ON ALL
FORMAT 'CSV' ( delimiter ',' null '\N' escape '\'  header )
ENCODING 'UTF8';
--
-- DROP EXTERNAL TABLE stage_dev.perscom.ext_kinder_CPH;
CREATE EXTERNAL TABLE stage_dev.perscom.ext_kinder_CPH (
	DDU_CODE int8,
	"NUMBER" int8,
	CHILD text,
	BIRTHDATE text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/reestr_not_compens_from_CPH.csv'
) ON ALL
FORMAT 'CSV' ( delimiter ',' null '\N' escape '\'  header )
ENCODING 'UTF8';
--
select count(*) from stage_dev.test.ext_perscom_kinder_CPH;
---
-- 4. pgmu_kids
-- DROP EXTERNAL TABLE stage_dev.test.ext_perscom_pgmu_kids;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_pgmu_kids (
	children_lastname text,
	children_firstname text,
	children_middlename text,
	children_birthdate text,
	children_sex text,
	children_document_type text,
	children_document_series text,
	children_document_number text,
	children_document_date text,
	children_document_issuer text,
	children_snils text,
	mpolicy_series text,
	mpolicy_number text,
	edu_login text,
	customer_id int8
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/pgmu_kids/*'
) ON ALL
FORMAT 'CSV' ( delimiter ';' null '\N' escape '\'  header )
ENCODING 'UTF8';
--
-- DROP EXTERNAL TABLE stage_dev.perscom.ext_pgmu_kids;
CREATE EXTERNAL TABLE stage_dev.perscom.ext_pgmu_kids (
	children_lastname text,
	children_firstname text,
	children_middlename text,
	children_birthdate text,
	children_sex text,
	children_document_type text,
	children_document_series text,
	children_document_number text,
	children_document_date text,
	children_document_issuer text,
	children_snils text,
	mpolicy_series text,
	mpolicy_number text,
	edu_login text,
	customer_id int8
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/pgmu_kids/*'
) ON ALL
FORMAT 'CSV' ( delimiter ';' null '\N' escape '\'  header )
ENCODING 'UTF8';
--
select count(*) from stage_dev.test.ext_perscom_pgmu_kids;
---
-- 5. pgmu_users
-- DROP EXTERNAL TABLE stage_dev.test.ext_perscom_pgmu_users;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_pgmu_users (
	lastname text,
	firstname text,
	middlename text,
	birthday text,
	email text,
	sex int4,
	is_has_app int4,
	driver_license_seria text,
	driver_license_number text,
	customer_id int8
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/pgmu_users/*'
) ON ALL
FORMAT 'CSV' ( delimiter ';' null '\N' escape '\'  header )
ENCODING 'UTF8';
--
-- DROP EXTERNAL TABLE stage_dev.perscom.ext_pgmu_users;
CREATE EXTERNAL TABLE stage_dev.perscom.ext_pgmu_users (
	lastname text,
	firstname text,
	middlename text,
	birthday text,
	email text,
	sex int4,
	is_has_app int4,
	driver_license_seria text,
	driver_license_number text,
	customer_id int8
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/pgmu_users/*'
) ON ALL
FORMAT 'CSV' ( delimiter ';' null '\N' escape '\'  header )
ENCODING 'UTF8';
--
select count(*) from stage_dev.test.ext_perscom_pgmu_users;
---
--- 6. edu_students
-- DROP EXTERNAL TABLE test.ext_perscom_edu_students;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_edu_students (
	id int8,
	oid text,
	auth_link text,
	vk_id text,
	firstname text,
	lastname text,
	patronymic text,
	hash_gost2012 text,
	hash_num text,
	hash_gost2012_2 text,
	hash_num_2 text,
	hash_gost2012_3 text,
	hash_num_3 text,
	birthdate text,
	birthplace text,
	snils text,
	e_mail text,
	numb_passport text,
	ser_passport text,
	data_passport text,
	gender_code text,
	gender_value int4,
	gender_description text,
	start_datetime text,
	end_datetime text,
	"active" text,
	status_code text,
	status_value int4,
	status_description text,
	reason_code text,
	reason_value text,
	reason_description text,
	data_start_study text,
	expect_end_study text,
	data_end_study text,
	rddm_first text,
	create_datetime text,
	send_datetime text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/asavelejva/perscom_data/STUDENTS/*'
) ON ALL
FORMAT 'CSV' ( delimiter ';' null '\N' escape '\'  header )
ENCODING 'UTF8';
--
-- DROP EXTERNAL TABLE stage_dev.perscom.ext_perscom_edu_students;
CREATE EXTERNAL TABLE stage_dev.perscom.ext_edu_students (
	id int8,
	oid text,
	auth_link text,
	vk_id text,
	firstname text,
	lastname text,
	patronymic text,
	hash_gost2012 text,
	hash_num text,
	hash_gost2012_2 text,
	hash_num_2 text,
	hash_gost2012_3 text,
	hash_num_3 text,
	birthdate text,
	birthplace text,
	snils text,
	e_mail text,
	numb_passport text,
	ser_passport text,
	data_passport text,
	gender_code text,
	gender_value int4,
	gender_description text,
	start_datetime text,
	end_datetime text,
	"active" text,
	status_code text,
	status_value int4,
	status_description text,
	reason_code text,
	reason_value text,
	reason_description text,
	data_start_study text,
	expect_end_study text,
	data_end_study text,
	rddm_first text,
	create_datetime text,
	send_datetime text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/asavelejva/perscom_data/STUDENTS/*'
) ON ALL
FORMAT 'CSV' ( delimiter ';' null '\N' escape '\'  header )
ENCODING 'UTF8';
--
select count(*) from stage_dev.test.ext_perscom_edu_students;
---
--- 7. edu_ymarks
-- DROP EXTERNAL TABLE test.ext_perscom_edu_ymarks;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_edu_ymarks (
	id int8,
	subject_id int4,
	student_id int4,
	class_id int4,
	subject_name text,
	fact int4,
	fivepoint_fact int4,
	final_fact text,
	fivepoint_final_fact text,
	recent_plan text,
	fivepoint_recent_plan text,
	school_id int4,
	class_num int4,
	class_year_from int4,
	mark_scale_code text,
	mark_scale_value int4,
	mark_scale_description text,
	create_datetime text,
	send_datetime text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/asavelejva/perscom_data/YMARKS/*'
) ON ALL
FORMAT 'CSV' ( delimiter ';' null '\N' escape '\'  header )
ENCODING 'UTF8';
--
-- DROP EXTERNAL TABLE stage_dev.perscom.ext_edu_ymarks;
CREATE EXTERNAL TABLE stage_dev.perscom.ext_edu_ymarks (
	id int8,
	subject_id int4,
	student_id int4,
	class_id int4,
	subject_name text,
	fact int4,
	fivepoint_fact int4,
	final_fact text,
	fivepoint_final_fact text,
	recent_plan text,
	fivepoint_recent_plan text,
	school_id int4,
	class_num int4,
	class_year_from int4,
	mark_scale_code text,
	mark_scale_value int4,
	mark_scale_description text,
	create_datetime text,
	send_datetime text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/asavelejva/perscom_data/YMARKS/*'
) ON ALL
FORMAT 'CSV' ( delimiter ';' null '\N' escape '\'  header )
ENCODING 'UTF8';
--
select count(*) from stage_dev.test.ext_perscom_edu_ymarks;
---
--- 8. pgmu_gibdd
-- DROP EXTERNAL TABLE stage_dev.test.ext_perscom_pgmu_gibdd;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_pgmu_gibdd (
	customer_id int8,
	title text,
	vehicle_type text,
	vehicle_number text,
	vehicle_region text,
	document_series text,
	document_number text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/asavelejva/perscom_data/pgmu_gibdd/*'
) ON ALL
FORMAT 'CSV' ( delimiter ';' null '\N' escape '\'  header )
ENCODING 'UTF8';
--
-- DROP EXTERNAL TABLE stage_dev.perscom.ext_pgmu_gibdd;
CREATE EXTERNAL TABLE stage_dev.perscom.ext_pgmu_gibdd (
	customer_id int8,
	title text,
	vehicle_type text,
	vehicle_number text,
	vehicle_region text,
	document_series text,
	document_number text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/asavelejva/perscom_data/pgmu_gibdd/*'
) ON ALL
FORMAT 'CSV' ( delimiter ';' null '\N' escape '\'  header )
ENCODING 'UTF8';
--
select count(*) from stage_dev.test.ext_perscom_pgmu_gibdd;
---
--- 9. fkgs
-- DROP EXTERNAL TABLE stage_dev.test.ext_perscom_data_fkgs;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_data_fkgs (
	"Фамилия" text
	,"Имя" text
	,"Отчество" text
	,"email" text
	,"Телефон" text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/fkgs/fkgs_2024-05-02.csv'
) ON ALL
FORMAT 'CSV' ( delimiter ';' null '\N' escape '\'  header )
ENCODING 'UTF8';
--
-- DROP EXTERNAL TABLE stage_dev.perscom.ext_data_fkgs;
CREATE EXTERNAL TABLE stage_dev.perscom.ext_data_fkgs (
	"Фамилия" text
	,"Имя" text
	,"Отчество" text
	,"email" text
	,"Телефон" text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/fkgs/fkgs_2024-05-02.csv'
) ON ALL
FORMAT 'CSV' ( delimiter ';' null '\N' escape '\'  header )
ENCODING 'UTF8';
--
select count(*) from test.ext_perscom_data_fkgs;
---
---
--- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
--- Join внешних таблиц и создание витрины данных коммуникации_кейс_садики
with mart_perscom_kindergarten as (
select pkd.kod_doo
--,lower(pkl."ФИО ребенка") as full_name_kids
,coalesce(replace(lower(pkd.surname_child), ' ', '')||' '||replace(lower(pkd.firstname_child), ' ', '')||' '||replace(lower(pkd.patronymic_child), ' ', ''),'') as full_name_kids
,replace(lower(pkd.surname_child), ' ', '') as surname_kids
,replace(lower(pkd.firstname_child), ' ', '') as firstname_kids
,replace(lower(pkd.patronymic_child), ' ', '') as patronymic_kids
,date(pkd.dbirth_child) as dbirth_kids
,pkl."табельный номер" as "tab_number"
,pksrn."NUMBER" as number_srn
,pksrn.DDU_CODE as ddu_code
,ppk.edu_login
--,ppk.customer_id as customer_id_from_pgmu
--,ppu.customer_id as customer_id_from_pgmu_users
,coalesce(replace(lower(ppu.lastname),' ','')||' '||replace(lower(ppu.firstname),' ','')||' '||replace(lower(ppu.middlename),' ',''),'') as full_name_parent
,replace(lower(coalesce(ppu.lastname,'')),' ','') as surname_parent
,replace(lower(coalesce(ppu.firstname,'')),' ','') as firstname_parent
,replace(lower(coalesce(ppu.middlename,'')),' ','') as patronymic_parent
,coalesce(ppu.birthday,'') as dbirth_parrent
,coalesce(ppu.email,'') as email_from_pgmu_users
,ppu.sex as sex_from_pgmu_users
,ppu.is_has_app
,coalesce(ppu.driver_license_seria||'-'||ppu.driver_license_number,'') as driver_document
--,pkd.snils_child as snils_kids
--,ppk.children_snils as snils_from_pgmu_kids
,case when pkd.snils_child = '' then coalesce(ppk.children_snils,'') else replace(replace(pkd.snils_child, ' ', ''), '-', '') end as snils_kids
,case when ppu.email <> '' then 1 else 0 end as "is_has_email"
from stage_dev.test.ext_perscom_kinder_doo pkd
left join stage_dev.test.ext_perscom_kinder_list pkl on date(pkd.dbirth_child) = date(pkl."дата рождения")
	and replace(pkd.surname_child, ' ', '')||replace(pkd.firstname_child, ' ', '')||replace(pkd.patronymic_child, ' ', '') = replace(pkl."ФИО ребенка", ' ', '')
left join stage_dev.test.ext_perscom_kinder_CPH pksrn on replace(pkd.surname_child, ' ', '')||replace(pkd.firstname_child, ' ', '') = replace(pksrn.CHILD, ' ', '') 
	and date(pkd.dbirth_child) = date(pksrn.BIRTHDATE)
left join stage_dev.test.ext_perscom_pgmu_kids ppk on replace(lower(pkd.surname_child), ' ', '')||
														replace(lower(pkd.firstname_child), ' ', '')||
														replace(lower(pkd.patronymic_child), ' ', '') = replace(lower(ppk.children_lastname), ' ', '')||
																										replace(lower(ppk.children_firstname), ' ', '')||
																										replace(lower(ppk.children_middlename), ' ', '') 
--														and date(pkd.dbirth_child) = date(ppk.children_birthdate)
left join stage_dev.test.ext_perscom_pgmu_users ppu on ppk.customer_id = ppu.customer_id
)
select * from mart_perscom_kindergarten 
where email_from_pgmu_users in ('lilenarash@mail.ru') /*<> '' and email_from_pgmu_users is not null*/;

select * from test.ext_perscom_kinder_cph where child ilike ('%сабиров султан%')
select * from test.ext_perscom_kinder_doo where surname_child ilike ('%сабиров%') and firstname_child ilike ('%султан%')
---
--- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
---
--Создание витрины "коммуникации_кейс_садики"
CREATE TABLE stage_dev.test.mart_perscom_case_kindergarten (
	kod_doo int8,
	full_name_kids text,
	surname_kids text,
	firstname_kids text,
	patronymic_kids text,
	dbirth_kids date,
	tab_number int8,
	number_srn int8,
	ddu_code int8,
	edu_login text,
	full_name_parent text,
	surname_parent text,
	firstname_parent text,
	patronymic_parent text,
	dbirth_parrent text,
	email_from_pgmu_users text,
	sex_from_pgmu_users int4,
	is_has_app int4,
	driver_document text,
	snils_kids text,
	is_has_email text
)
DISTRIBUTED BY (tab_number);
---
truncate table stage_dev.test.mart_perscom_case_kindergarten;
---
-- Вставка данных с хэшированием персональных данных
insert into stage_dev.test.mart_perscom_case_kindergarten (
	kod_doo
	,full_name_kids
	,surname_kids
	,firstname_kids
	,patronymic_kids
	,dbirth_kids
	,tab_number
	,number_srn
	,ddu_code
	,edu_login
	,full_name_parent
	,surname_parent
	,firstname_parent
	,patronymic_parent
	,dbirth_parrent
	,email_from_pgmu_users
	,sex_from_pgmu_users
	,is_has_app
	,driver_document
	,snils_kids
	,is_has_email
) 
with mart_perscom_kindergarten as (
select pkd.kod_doo
,lower(pkl."ФИО ребенка") as full_name_kids
,replace(lower(pkd.surname_child), ' ', '') as surname_kids
,replace(lower(pkd.firstname_child), ' ', '') as firstname_kids
,replace(lower(pkd.patronymic_child), ' ', '') as patronymic_kids
,date(pkd.dbirth_child) as dbirth_kids
,pkl."табельный номер" as "tab_number"
,pksrn."NUMBER" as number_srn
,pksrn.DDU_CODE as ddu_code
,ppk.edu_login
,coalesce(replace(lower(ppu.lastname),' ','')||' '||replace(lower(ppu.firstname),' ','')||' '||replace(lower(ppu.middlename),' ',''),'') as full_name_parent
,replace(lower(coalesce(ppu.lastname,'')),' ','') as surname_parent
,replace(lower(coalesce(ppu.firstname,'')),' ','') as firstname_parent
,replace(lower(coalesce(ppu.middlename,'')),' ','') as patronymic_parent
,coalesce(ppu.birthday,'') as dbirth_parrent
,coalesce(ppu.email,'') as email_from_pgmu_users
,ppu.sex as sex_from_pgmu_users
,ppu.is_has_app
,coalesce(ppu.driver_license_seria||'-'||ppu.driver_license_number,'') as driver_document
,case when pkd.snils_child = '' then coalesce(ppk.children_snils,'') else replace(replace(pkd.snils_child, ' ', ''), '-', '') end as snils_kids
,case when ppu.email <> '' then 1 else 0 end as "is_has_email"
from stage_dev.test.ext_perscom_kinder_doo pkd
left join stage_dev.test.ext_perscom_kinder_list pkl on date(pkd.dbirth_child) = date(pkl."дата рождения")
	and replace(pkd.surname_child, ' ', '')||replace(pkd.firstname_child, ' ', '')||replace(pkd.patronymic_child, ' ', '') = replace(pkl."ФИО ребенка", ' ', '')
left join stage_dev.test.ext_perscom_kinder_CPH pksrn on replace(pkd.surname_child, ' ', '')||replace(pkd.firstname_child, ' ', '') = replace(pksrn.CHILD, ' ', '') 
	and date(pkd.dbirth_child) = date(pksrn.BIRTHDATE)
left join stage_dev.test.ext_perscom_pgmu_kids ppk on replace(lower(pkd.surname_child), ' ', '')||
														replace(lower(pkd.firstname_child), ' ', '')||
														replace(lower(pkd.patronymic_child), ' ', '') = replace(lower(ppk.children_lastname), ' ', '')||
																										replace(lower(ppk.children_firstname), ' ', '')||
																										replace(lower(ppk.children_middlename), ' ', '') 
left join stage_dev.test.ext_perscom_pgmu_users ppu on ppk.customer_id = ppu.customer_id
)
select 
	kod_doo
	,case when full_name_kids = '' then null else md5(full_name_kids) end
	,case when surname_kids = '' then null else md5(surname_kids) end
	,case when firstname_kids = '' then null else md5(firstname_kids) end
	,case when patronymic_kids = '' then null else md5(patronymic_kids) end
	,dbirth_kids
	,tab_number
	,number_srn
	,ddu_code
	,edu_login
	,case when full_name_parent = '' then null else md5(full_name_parent) end
	,case when surname_parent = '' then null else md5(surname_parent) end
	,case when firstname_parent = '' then null else md5(firstname_parent) end
	,case when patronymic_parent = '' then null else md5(patronymic_parent) end
	,dbirth_parrent
	,email_from_pgmu_users
	,sex_from_pgmu_users
	,is_has_app
	,case when driver_document = '' then null else md5(driver_document) end
	,case when snils_kids = '' then null else md5(snils_kids) end
	,is_has_email
from mart_perscom_kindergarten;
--
-- Выдача прав доступа
GRANT UPDATE, REFERENCES, TRUNCATE, INSERT, SELECT, DELETE, TRIGGER ON TABLE test.mart_perscom_case_kindergarten TO asaveljeva;
--
--
select * from test.mart_perscom_case_kindergarten limit 100;
---
---
--- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
---
--- Join внешних таблиц и создание витрины данных коммуникации_кейс_ученики
with mart_perscom_students as (
select 
ppk.customer_id as customer_id_kids
,replace(lower(ppk.children_lastname),' ','') as lastname_kids
,replace(lower(ppk.children_firstname),' ','') as firstname_kids
,replace(lower(ppk.children_middlename),' ','') as middlename_kids
,ppk.children_birthdate as birthdate_kids
,ppk.children_sex as sex_kids
,ppk.children_document_type as document_type_kids
,ppk.children_document_series as document_series_kids
,ppk.children_document_number as document_number_kids
,ppk.children_snils as snils_kids
,ppk.edu_login as edu_login
,ppu.customer_id as customer_id_users
,replace(lower(ppu.lastname),' ','') as lastname_users
,replace(lower(ppu.firstname),' ','') as firstname_users
,replace(lower(ppu.middlename),' ','') as middlename_users
,ppu.email as email_users
,ppu.sex as sex_users
,ppu.is_has_app as is_has_app_users
,pes.id as id_students
,pes.snils as snils_students
,pes.e_mail as email_students
,pes.ser_passport as ser_passport_students
,pes.numb_passport as numb_passport_students
,pes.data_start_study
,pes.expect_end_study
--,pey.id as id_yamarks
--,pey.subject_id as subject_id_yamarks
,pey.student_id as student_id_yamarks
,pey.class_id as class_id_yamarks
,pey.subject_name as subject_name_yamarks
,pey.fact as fact_yamarks
,pey.fivepoint_fact as fivepoint_fact_yamarks
,pey.final_fact as final_fact_yamarks
,pey.fivepoint_final_fact as fivepoint_final_fact_yamarks
,pey.recent_plan as recent_plan_yamarks
,pey.fivepoint_recent_plan as fivepoint_recent_plan_yamarks
,pey.school_id as school_id_yamarks
,pey.class_num as class_num_yamarks
,pey.class_year_from as class_year_from_yamarks
,pey.mark_scale_code as mark_scale_code_yamarks
,pey.mark_scale_value as mark_scale_value_yamarks
,pey.mark_scale_description as mark_scale_description_yamarks
,pey.create_datetime as create_datetime_yamarks
,pey.send_datetime as send_datetime_yamarks
from stage_dev.test.ext_perscom_pgmu_kids ppk
left join stage_dev.test.ext_perscom_pgmu_users ppu on ppk.customer_id = ppu.customer_id
left join stage_dev.test.ext_perscom_edu_students pes on ppk.children_snils = pes.snils
left join stage_dev.test.ext_perscom_edu_ymarks pey on pes.id = pey.student_id
where /*pes.e_mail <> '' */ /*or*/ /* ppu.email <> ''*/ pes.snils <> ''
)
select * from mart_perscom_students 
--where 
--	snils_students <> '' 
--	email_users <> ''
order by lastname_kids, firstname_kids, middlename_kids;
---
---
select * from test.ext_perscom_pgmu_kids limit 100;
select * from test.ext_perscom_pgmu_kids where children_snils <> '';

select * from test.ext_perscom_pgmu_kids 
where replace(lower(children_lastname),' ','') in ('ахметшин', 'галиев') and replace(lower(children_firstname),' ','') in ('марсель') and children_snils <> ''
order by children_lastname, children_firstname, children_lastname, children_firstname, children_middlename;
--
select * from test.ext_perscom_pgmu_users limit 100;

select * from test.ext_perscom_pgmu_users 
where replace(lower(lastname),' ','') in ('ахметшин', 'галиев') and customer_id in (3036060, 113922, 4768065, 4685055, 3933727, 390020, 405906, 3161031, 1420699, 2324395, 941619, 3582963, 3609702, 1248529, 2540352, 124353)
order by lastname, firstname, middlename;
--
select * from test.ext_perscom_edu_students limit 100;
select * from test.ext_perscom_edu_students where snils <> '';
---
---
--- Создание витрины ---
--Создание витрины "коммуникации_кейс_ученики"
CREATE TABLE stage_dev.test.mart_perscom_case_students (
	customer_id_kids int8
	,lastname_kids text
	,firstname_kids text
	,middlename_kids text
	,birthdate_kids text
	,sex_kids text
	,document_type_kids text
	,document_series_kids text
	,document_number_kids text
	,snils_kids text
	,edu_login text
	,customer_id_users int8
	,lastname_users text
	,firstname_users text
	,middlename_users text
	,email_users text
	,sex_users int4
	,is_has_app_users  int4
	,id_students int8
	,snils_students text
	,email_students text
	,ser_passport_students text
	,numb_passport_students text
	,data_start_study text
	,expect_end_study text
	,student_id_yamarks int8
	,class_id_yamarks int8
	,subject_name_yamarks text
	,fact_yamarks int4
	,fivepoint_fact_yamarks int4
	,final_fact_yamarks text
	,fivepoint_final_fact_yamarks text
	,recent_plan_yamarks text
	,fivepoint_recent_plan_yamarks text
	,school_id_yamarks int4
	,class_num_yamarks int4
	,class_year_from_yamarks int4
	,mark_scale_code_yamarks text
	,mark_scale_value_yamarks int4
	,mark_scale_description_yamarks text
	,create_datetime_yamarks timestamp
	,send_datetime_yamarks timestamp
)
WITH (
	compresstype=zstd,
	orientation=column,
	appendonly=true
)
DISTRIBUTED BY (customer_id_kids);
--
ALTER TABLE test.mart_perscom_case_students ALTER COLUMN create_datetime_yamarks TYPE text USING create_datetime_yamarks::text;
ALTER TABLE test.mart_perscom_case_students ALTER COLUMN send_datetime_yamarks TYPE text USING send_datetime_yamarks::text;
--
-- Временная таблица
CREATE TABLE stage_dev.test.mart_perscom_case_students_tmp (
	customer_id_kids int8
	,lastname_kids text
	,firstname_kids text
	,middlename_kids text
	,birthdate_kids text
	,sex_kids text
	,document_type_kids text
	,document_series_kids text
	,document_number_kids text
	,snils_kids text
	,edu_login text
	,customer_id_users int8
	,lastname_users text
	,firstname_users text
	,middlename_users text
	,email_users text
	,sex_users int4
	,is_has_app_users  int4
	,id_students int8
	,snils_students text
	,email_students text
	,ser_passport_students text
	,numb_passport_students text
	,data_start_study text
	,expect_end_study text
	,student_id_yamarks int8
	,class_id_yamarks int8
	,subject_name_yamarks text
	,fact_yamarks int4
	,fivepoint_fact_yamarks int4
	,final_fact_yamarks text
	,fivepoint_final_fact_yamarks text
	,recent_plan_yamarks text
	,fivepoint_recent_plan_yamarks text
	,school_id_yamarks int4
	,class_num_yamarks int4
	,class_year_from_yamarks int4
	,mark_scale_code_yamarks text
	,mark_scale_value_yamarks int4
	,mark_scale_description_yamarks text
	,create_datetime_yamarks text
	,send_datetime_yamarks text
)
WITH (
	compresstype=zstd,
	orientation=column,
	appendonly=true
)
DISTRIBUTED BY (customer_id_kids);
--
--
truncate table stage_dev.test.mart_perscom_case_students;
-- Вставка данных с хэшированием персональных данных
insert into stage_dev.test.mart_perscom_case_students (
	customer_id_kids
	,lastname_kids
	,firstname_kids
	,middlename_kids
	,birthdate_kids
	,sex_kids
	,document_type_kids
	,document_series_kids
	,document_number_kids
	,snils_kids
	,edu_login
	,customer_id_users
	,lastname_users
	,firstname_users
	,middlename_users
	,email_users
	,sex_users
	,is_has_app_users
	,id_students
	,snils_students
	,email_students
	,ser_passport_students
	,numb_passport_students
	,data_start_study
	,expect_end_study
	,student_id_yamarks
	,class_id_yamarks
	,subject_name_yamarks
	,fact_yamarks
	,fivepoint_fact_yamarks
	,final_fact_yamarks
	,fivepoint_final_fact_yamarks
	,recent_plan_yamarks
	,fivepoint_recent_plan_yamarks
	,school_id_yamarks
	,class_num_yamarks
	,class_year_from_yamarks
	,mark_scale_code_yamarks
	,mark_scale_value_yamarks
	,mark_scale_description_yamarks
	,create_datetime_yamarks
	,send_datetime_yamarks
) 
with mart_perscom_students as (
select 
ppk.customer_id as customer_id_kids
,replace(lower(ppk.children_lastname),' ','') as lastname_kids
,replace(lower(ppk.children_firstname),' ','') as firstname_kids
,replace(lower(ppk.children_middlename),' ','') as middlename_kids
,ppk.children_birthdate as birthdate_kids
,ppk.children_sex as sex_kids
,ppk.children_document_type as document_type_kids
,ppk.children_document_series as document_series_kids
,ppk.children_document_number as document_number_kids
,ppk.children_snils as snils_kids
,ppk.edu_login as edu_login
,ppu.customer_id as customer_id_users
,replace(lower(ppu.lastname),' ','') as lastname_users
,replace(lower(ppu.firstname),' ','') as firstname_users
,replace(lower(ppu.middlename),' ','') as middlename_users
,ppu.email as email_users
,ppu.sex as sex_users
,ppu.is_has_app as is_has_app_users
,pes.id as id_students
,pes.snils as snils_students
,pes.e_mail as email_students
,pes.ser_passport as ser_passport_students
,pes.numb_passport as numb_passport_students
,pes.data_start_study
,pes.expect_end_study
,pey.student_id as student_id_yamarks
,pey.class_id as class_id_yamarks
,pey.subject_name as subject_name_yamarks
,pey.fact as fact_yamarks
,pey.fivepoint_fact as fivepoint_fact_yamarks
,pey.final_fact as final_fact_yamarks
,pey.fivepoint_final_fact as fivepoint_final_fact_yamarks
,pey.recent_plan as recent_plan_yamarks
,pey.fivepoint_recent_plan as fivepoint_recent_plan_yamarks
,pey.school_id as school_id_yamarks
,pey.class_num as class_num_yamarks
,pey.class_year_from as class_year_from_yamarks
,pey.mark_scale_code as mark_scale_code_yamarks
,pey.mark_scale_value as mark_scale_value_yamarks
,pey.mark_scale_description as mark_scale_description_yamarks
,pey.create_datetime as create_datetime_yamarks
,pey.send_datetime as send_datetime_yamarks
from stage_dev.test.ext_perscom_pgmu_kids ppk
left join stage_dev.test.ext_perscom_pgmu_users ppu on ppk.customer_id = ppu.customer_id
left join stage_dev.test.ext_perscom_edu_students pes on ppk.children_snils = pes.snils
left join stage_dev.test.ext_perscom_edu_ymarks pey on pes.id = pey.student_id
where pes.snils <> ''
)
select 
	customer_id_kids
	,case when lastname_kids = '' then null else md5(lastname_kids) end
	,case when firstname_kids = '' then null else md5(firstname_kids) end
	,case when middlename_kids = '' then null else md5(middlename_kids) end
	,birthdate_kids
	,sex_kids
	,document_type_kids
	,case when document_series_kids = '' then null else md5(document_series_kids) end
	,case when document_number_kids = '' then null else md5(document_number_kids) end
	,case when document_number_kids = '' then null else md5(snils_kids) end
	,edu_login
	,customer_id_users
	,case when lastname_users = '' then null else md5(lastname_users) end
	,case when firstname_users = '' then null else md5(firstname_users) end
	,case when middlename_users = '' then null else md5(middlename_users) end
	,email_users
	,sex_users
	,is_has_app_users
	,id_students
	,case when snils_students = '' then null else md5(snils_students) end
	,email_students
	,case when ser_passport_students = '' then null else md5(ser_passport_students) end
	,case when numb_passport_students = '' then null else md5(numb_passport_students) end
	,data_start_study
	,expect_end_study
	,student_id_yamarks
	,class_id_yamarks
	,subject_name_yamarks
	,fact_yamarks
	,fivepoint_fact_yamarks
	,final_fact_yamarks
	,fivepoint_final_fact_yamarks
	,recent_plan_yamarks
	,fivepoint_recent_plan_yamarks
	,school_id_yamarks
	,class_num_yamarks
	,class_year_from_yamarks
	,mark_scale_code_yamarks
	,mark_scale_value_yamarks
	,mark_scale_description_yamarks
	,create_datetime_yamarks
	,send_datetime_yamarks
from mart_perscom_students;
--
-- Выдача прав доступа
GRANT UPDATE, REFERENCES, TRUNCATE, INSERT, SELECT, DELETE, TRIGGER ON TABLE test.mart_perscom_case_students TO asaveljeva;
--


select concat('cnt_all'), count(*) from test.perscom_pgmu_users
union all
select concat('cnt_with_email'), count(*) from test.perscom_pgmu_users where email <> ''
union all
select concat('cnt_trust_email'), count(*) from (select *, regexp_matches(email, '^[^_.0-9][a-z0-9._]+@[a-z]+\.[a-z]+$') from test.perscom_pgmu_users) as t;

--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
--- ФКГС
----- DROP EXTERNAL TABLE stage_dev.test.ext_perscom_data_fkgs;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_data_fkgs (
	"Фамилия" text
	,"Имя" text
	,"Отчество" text
	,"email" text
	,"Телефон" text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/asavelejva/perscom_data/fkgs/*'
) ON ALL
FORMAT 'CSV' ( delimiter ';' null '\N' escape '\'  header )
ENCODING 'UTF8';
---
---
-- DROP EXTERNAL TABLE stage_dev.test.ext_perscom_data_fkgs;
CREATE EXTERNAL TABLE stage_dev.test.ext_perscom_data_fkgs (
	"Фамилия" text
	,"Имя" text
	,"Отчество" text
	,"email" text
	,"Телефон" text
)
LOCATION (
	'gpfdist://10.11.128.215:18081/esemenov/perscom_data/fkgs/fkgs_2024-05-02.csv'
) ON ALL
FORMAT 'CSV' ( delimiter ';' null '\N' escape '\'  header )
ENCODING 'UTF8';
--
select count(*) from test.ext_perscom_data_fkgs;
---
-- DROP TABLE stage_dev.test.perscom_data_fkgs;
-- truncate table test.perscom_data_fkgs;
CREATE TABLE stage_dev.test.perscom_data_fkgs (
	id bigserial NOT NULL
	,lastname text
	,firstname text
	,middlename text
	,email text
	,tel_number text
--	,CONSTRAINT perscom_data_fkgs_tel_number_key UNIQUE (tel_number||lastname||firstname||middlename)
)
WITH (
	compresstype=zstd,
	orientation=column,
	appendonly=true
)
DISTRIBUTED BY (tel_number);
--
---
insert into stage_dev.test.perscom_data_fkgs (
	lastname
	,firstname
	,middlename
	,email
	,tel_number
) select 
	"Фамилия"
	,"Имя"
	,"Отчество"
	,"email"
	,"Телефон"
from stage_dev.test.ext_perscom_data_fkgs;
---
-- Выдача прав доступа
GRANT UPDATE, REFERENCES, TRUNCATE, INSERT, SELECT, DELETE, TRIGGER ON TABLE stage_dev.test.perscom_data_fkgs TO asaveljeva;
--
--
select concat('cnt_all'), count(*) from test.perscom_data_fkgs
union all 
select concat('cnt_trust_email'), count(*) from (select *, regexp_matches(email, '^[^_.0-9][a-z0-9._]+@[a-z]+\.[a-z]+$') from test.perscom_data_fkgs) as t;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
with mart_perscom_kindergarten as (
select pkd.kod_doo
,coalesce(replace(lower(pkd.surname_child), ' ', '')||' '||replace(lower(pkd.firstname_child), ' ', '')||' '||replace(lower(pkd.patronymic_child), ' ', ''),'') as full_name_kids
,case when coalesce(replace(lower(pkd.surname_child), ' ', '')||' '||replace(lower(pkd.firstname_child), ' ', '')||' '||replace(lower(pkd.patronymic_child), ' ', ''),'') = '' 
		then null 
		else md5(coalesce(replace(lower(pkd.surname_child), ' ', '')||' '||replace(lower(pkd.firstname_child), ' ', '')||' '||replace(lower(pkd.patronymic_child), ' ', ''),'')) 
		end as full_name_kids_md5
,replace(lower(pkd.surname_child), ' ', '') as surname_kids
,replace(lower(pkd.firstname_child), ' ', '') as firstname_kids
,replace(lower(pkd.patronymic_child), ' ', '') as patronymic_kids
,date(pkd.dbirth_child) as dbirth_kids
,pkl."табельный номер" as "tab_number"
,pksrn."NUMBER" as number_srn
,pksrn.DDU_CODE as ddu_code
,ppk.edu_login
,coalesce(replace(lower(ppu.lastname),' ','')||' '||replace(lower(ppu.firstname),' ','')||' '||replace(lower(ppu.middlename),' ',''),'') as full_name_parent
,case when coalesce(replace(lower(ppu.lastname),' ','')||' '||replace(lower(ppu.firstname),' ','')||' '||replace(lower(ppu.middlename),' ',''),'') = ''
		then null
		else md5(coalesce(replace(lower(ppu.lastname),' ','')||' '||replace(lower(ppu.firstname),' ','')||' '||replace(lower(ppu.middlename),' ',''),''))
		end as full_name_parent_md5
,replace(lower(coalesce(ppu.lastname,'')),' ','') as surname_parent
,replace(lower(coalesce(ppu.firstname,'')),' ','') as firstname_parent
,replace(lower(coalesce(ppu.middlename,'')),' ','') as patronymic_parent
,coalesce(ppu.birthday,'') as dbirth_parrent
,coalesce(ppu.email,'') as email_from_pgmu_users
,ppu.sex as sex_from_pgmu_users
,ppu.is_has_app
,coalesce(ppu.driver_license_seria||'-'||ppu.driver_license_number,'') as driver_document
,case when pkd.snils_child = '' then coalesce(ppk.children_snils,'') else replace(replace(pkd.snils_child, ' ', ''), '-', '') end as snils_kids
,case when ppu.email <> '' then 1 else 0 end as "is_has_email"
from stage_dev.test.ext_perscom_kinder_doo pkd
left join stage_dev.test.ext_perscom_kinder_list pkl on date(pkd.dbirth_child) = date(pkl."дата рождения")
	and replace(pkd.surname_child, ' ', '')||replace(pkd.firstname_child, ' ', '')||replace(pkd.patronymic_child, ' ', '') = replace(pkl."ФИО ребенка", ' ', '')
left join stage_dev.test.ext_perscom_kinder_CPH pksrn on replace(pkd.surname_child, ' ', '')||replace(pkd.firstname_child, ' ', '') = replace(pksrn.CHILD, ' ', '') 
	and date(pkd.dbirth_child) = date(pksrn.BIRTHDATE)
left join stage_dev.test.ext_perscom_pgmu_kids ppk on replace(lower(pkd.surname_child), ' ', '')||
														replace(lower(pkd.firstname_child), ' ', '')||
														replace(lower(pkd.patronymic_child), ' ', '') = replace(lower(ppk.children_lastname), ' ', '')||
																										replace(lower(ppk.children_firstname), ' ', '')||
																										replace(lower(ppk.children_middlename), ' ', '') 
left join stage_dev.test.ext_perscom_pgmu_users ppu on ppk.customer_id = ppu.customer_id
)
select *
from mart_perscom_kindergarten
where full_name_parent > '0'
order by full_name_parent, full_name_kids; 
--
--
--
--
with mart_perscom_kindergarten as (
select pkd.kod_doo
,coalesce(replace(lower(pkd.surname_child), ' ', '')||' '||replace(lower(pkd.firstname_child), ' ', '')||' '||replace(lower(pkd.patronymic_child), ' ', ''),'') as full_name_kids
,replace(lower(pkd.surname_child), ' ', '') as surname_kids
,replace(lower(pkd.firstname_child), ' ', '') as firstname_kids
,replace(lower(pkd.patronymic_child), ' ', '') as patronymic_kids
,date(pkd.dbirth_child) as dbirth_kids
,pkl."табельный номер" as "tab_number"
,pksrn."NUMBER" as number_srn
,pksrn.DDU_CODE as ddu_code
,ppk.edu_login
,coalesce(replace(lower(ppu.lastname),' ','')||' '||replace(lower(ppu.firstname),' ','')||' '||replace(lower(ppu.middlename),' ',''),'') as full_name_parent
,replace(lower(coalesce(ppu.lastname,'')),' ','') as surname_parent
,replace(lower(coalesce(ppu.firstname,'')),' ','') as firstname_parent
,replace(lower(coalesce(ppu.middlename,'')),' ','') as patronymic_parent
,coalesce(ppu.birthday,'') as dbirth_parrent
,coalesce(ppu.email,'') as email_from_pgmu_users
,ppu.sex as sex_from_pgmu_users
,ppu.is_has_app
,coalesce(ppu.driver_license_seria||'-'||ppu.driver_license_number,'') as driver_document
,case when pkd.snils_child = '' then coalesce(ppk.children_snils,'') else replace(replace(pkd.snils_child, ' ', ''), '-', '') end as snils_kids
,case when ppu.email <> '' then 1 else 0 end as "is_has_email"
from stage_dev.test.ext_perscom_kinder_doo pkd
left join stage_dev.test.ext_perscom_kinder_list pkl on date(pkd.dbirth_child) = date(pkl."дата рождения")
	and replace(pkd.surname_child, ' ', '')||replace(pkd.firstname_child, ' ', '')||replace(pkd.patronymic_child, ' ', '') = replace(pkl."ФИО ребенка", ' ', '')
left join stage_dev.test.ext_perscom_kinder_CPH pksrn on replace(pkd.surname_child, ' ', '')||replace(pkd.firstname_child, ' ', '') = replace(pksrn.CHILD, ' ', '') 
	and date(pkd.dbirth_child) = date(pksrn.BIRTHDATE)
left join stage_dev.test.ext_perscom_pgmu_kids ppk on replace(lower(pkd.surname_child), ' ', '')||
														replace(lower(pkd.firstname_child), ' ', '')||
														replace(lower(pkd.patronymic_child), ' ', '') = replace(lower(ppk.children_lastname), ' ', '')||
																										replace(lower(ppk.children_firstname), ' ', '')||
																										replace(lower(ppk.children_middlename), ' ', '') 
left join stage_dev.test.ext_perscom_pgmu_users ppu on ppk.customer_id = ppu.customer_id
)
select 
full_name_parent
,full_name_kids	
,case when full_name_parent = '' then null else md5(full_name_parent) end as full_name_parent_md5
,case when full_name_kids = '' then null else md5(full_name_kids) end as full_name_kids_md5
from mart_perscom_kindergarten
where full_name_parent > '0'
group by 1,2
order by full_name_parent, full_name_kids; 


--- Уникальные пользователи в таблице данных "pgmu_users" ---
with pgmu_users as (
select 
coalesce(replace(lower(lastname), ' ', '')||' '||replace(lower(firstname), ' ', '')||' '||replace(lower(middlename), ' ', ''),'') as full_name_users
,birthday
--,case when birthday = '' then null else cast(birthday as timestamp) end as birthday
,case when email = '' then null else email end as email
--,(select email as trust_email from (select *, regexp_matches(email, '^[^_.0-9][a-z0-9._]+@[a-z]+\.[a-z]+$') from test.perscom_pgmu_users) as t )
from test.ext_perscom_pgmu_users
)
select * from pgmu_users;

--- Данные из ФКГС ---
with fkgs as (
select 
coalesce(replace(lower("Фамилия"), ' ', '')||' '||replace(lower("Имя"), ' ', '')||' '||replace(lower("Отчество"), ' ', ''),'') as full_name_users
,case when email = '' then null else email end as email
,"Телефон" as telephone_num
from test.ext_perscom_data_fkgs
)
select * from fkgs;

--- Данные из таблицы edu_students ---
select * from test.ext_perscom_edu_students limit 100;


--- ---- ------ 
with t as (
select *, coalesce(replace(lower("Фамилия"), ' ', '')||' '||replace(lower("Имя"), ' ', '')||' '||replace(lower("Отчество"), ' ', ''),'') as full_name_users 
from test.ext_perscom_data_fkgs
)
select * from t where full_name_users in ('александрова татьяна александровна')

with t as(
select *
		,coalesce(replace(lower(eppu.lastname), ' ', '')||' '||replace(lower(eppu.firstname), ' ', '')||' '||replace(lower(eppu.middlename), ' ', ''),'') as full_name_users_from_users
from test.ext_perscom_pgmu_users eppu
)
select * from t where full_name_users_from_users in ('александрова татьяна александровна')

--- --- ---
with fkgs as (
select 
coalesce(replace(lower("Фамилия"), ' ', '')||' '||replace(lower("Имя"), ' ', '')||' '||replace(lower("Отчество"), ' ', ''),'') as full_name_users
,case when email = '' then null else email end as email
,"Телефон" as telephone_num
from test.ext_perscom_data_fkgs
)
select f.full_name_users
		,coalesce(replace(lower(eppu.lastname), ' ', '')||' '||replace(lower(eppu.firstname), ' ', '')||' '||replace(lower(eppu.middlename), ' ', ''),'') as full_name_users_from_users
		,f.email
		,f.telephone_num 
		,eppu.email 
from fkgs f
left join test.ext_perscom_pgmu_users eppu 
			on f.full_name_users = coalesce(replace(lower(eppu.lastname), ' ', '')||' '||replace(lower(eppu.firstname), ' ', '')||' '||replace(lower(eppu.middlename), ' ', ''),'') 
			and f.email = eppu.email 
group by 1,2,3,4,5
order by 1
---
---
---

with fkgs as (
select 
coalesce(replace(lower("Фамилия"), ' ', '')||' '||replace(lower("Имя"), ' ', '')||' '||replace(lower("Отчество"), ' ', ''),'') as full_name_users
,case when email = '' then null else email end as email
,"Телефон" as telephone_num
from perscom.ext_data_fkgs
)
select f.full_name_users
		,u.full_name_users_from_users
		,f.email
		,f.telephone_num 
		,u.email as email_from_users
		,u.driver_document as driver_document_from_users
		,u.birthday as birthday_from_users
from fkgs f
right join (
select coalesce(replace(lower(lastname), ' ', '')||' '||replace(lower(firstname), ' ', '')||' '||replace(lower(middlename), ' ', ''),'') as full_name_users_from_users
,birthday
,email
,driver_license_seria || driver_license_number as driver_document
from perscom.ext_pgmu_users) u on f.full_name_users = u.full_name_users_from_users and f.email = u.email 
--where u.full_name_users_from_users is not null
group by 1,2,3,4,5,6,7
order by 1

--
--
ALTER TABLE child ADD CONSTRAINT fk_parent FOREIGN KEY (parent_id) REFERENCES parent(id);
--
--

select * from perscom.ext_pgmu_gibdd limit 100
select * from perscom.ext_kinder_doo order by id limit 1000
--
--
with t as (
select 
coalesce(replace(lower(lastname), ' ', '')||' '||replace(lower(firstname), ' ', '')||' '||replace(lower(middlename), ' ', ''),'') as full_name_users
,birthday
,email
,case when driver_license_seria = '' then driver_license_seria ||'-'|| driver_license_number else '' end as driver_document
from perscom.ext_pgmu_users
)
select t.full_name_users
		,t.email as email_from_users
		,t.driver_document as driver_document_from_users
		,t.birthday as birthday_from_users
from t order by 1 limit 1000;
--
--
--
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
with users as (
select 
coalesce(replace(lower(lastname), ' ', '')||' '||replace(lower(firstname), ' ', '')||' '||replace(lower(middlename), ' ', ''),'') as full_name_users
,birthday
,email
,case when driver_license_seria = '' then driver_license_seria ||'-'|| driver_license_number else '' end as driver_document
from perscom.ext_pgmu_users
)
select users.full_name_users
		,users.email as email_from_users
		,users.driver_document as driver_document_from_users
		,users.birthday as birthday_from_users
		,fkgs.telephone_num as telephone_num_from_fkgs
		,gibdd.vehicle_number||gibdd.vehicle_region
from users
-- подтягивание номера телефона из fkgs на пересечении фио и email
left join 
(select 
coalesce(replace(lower("Фамилия"), ' ', '')||' '||replace(lower("Имя"), ' ', '')||' '||replace(lower("Отчество"), ' ', ''),'') as full_name_users
,case when email = '' then null else email end as email
,"Телефон" as telephone_num
from perscom.ext_data_fkgs) fkgs 
on users.full_name_users = fkgs.full_name_users or users.email = fkgs.email
-- подтягивание номера авто из gibdd на пересечении водительского удостоверения
left join 
(select *, document_series||'-'||document_number as driver_document from perscom.ext_pgmu_gibdd) gibdd
on users.driver_document = gibdd.driver_document
--left join
--(select * from perscom.ext_kinder_doo) kids on 
where users.full_name_users <> '' and users.email <> '' and users.driver_document <> '' and users.birthday <> ''
order by 1 limit 1000;



with t as (
select 
coalesce(replace(lower(lastname), ' ', '')||' '||replace(lower(firstname), ' ', '')||' '||replace(lower(middlename), ' ', ''),'') as full_name_users
,birthday
,email
,case when driver_license_seria = '' then driver_license_seria ||'-'|| driver_license_number else '' end as driver_document
,customer_id
from perscom.ext_pgmu_users
)
select t.customer_id,
		t.full_name_users
		,t.email as email_from_users
		,t.driver_document as driver_document_from_users
		,t.birthday as birthday_from_users
from t where t.full_name_users <> '' and t.email <> '' and t.driver_document <> '' and t.birthday <> ''
order by 2 limit 1000;
--
--
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Вывод студентов достигших 18 лет.
with stusdents_adult as (
select 
id
,coalesce(replace(lower(lastname), ' ', '')||' '||replace(lower(firstname), ' ', '')||' '||replace(lower(patronymic), ' ', ''),'') as full_name_students
,firstname
,lastname
,patronymic
,e_mail as "email"
,snils 
,date(birthdate) as birthdate
,age(current_date, date(birthdate)) as age
,case when age(current_date, date(birthdate)) >= '18 years' then 'adult' else 'teenager' end as reached
,ser_passport||' '||numb_passport as passport
,length(ser_passport)
,length(numb_passport)
from perscom.ext_edu_students 
where numb_passport <> ''
group by 1,2,3,4,5,6,7,8,9,10,11,12,13
having age(current_date, date(birthdate)) >= '18 years'
order by 2
)
select * from stusdents_adult where reached in ('adult') order by 2;
--
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Вывод детей достигших 18 лет.
select
coalesce(replace(lower(children_lastname), ' ', '')||' '||replace(lower(children_firstname), ' ', '')||' '||replace(lower(children_middlename), ' ', ''),'') as full_name_children
,date(children_birthdate) as birthdate
,age(current_date, date(children_birthdate)) as age
,case when age(current_date, date(children_birthdate)) >= '18 years' then 'adult' else 'kids' end as reached
,children_document_type
,children_document_series||' '||children_document_number as document_child
,children_snils
,mpolicy_number
,edu_login
,customer_id
from perscom.ext_pgmu_kids
where children_birthdate <> ''
group by 1,2,3,4,5,6,7,8,9,10
having age(current_date, date(children_birthdate))>= '18 years'
order by 10;
--
--select * from perscom.ext_pgmu_users where customer_id in (53,66,68)
--
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Связка PGMU kids и EDU kids
with j as (
select 
coalesce(replace(lower(epk.children_lastname), ' ', '')||' '||replace(lower(epk.children_firstname), ' ', '')||' '||replace(lower(epk.children_middlename), ' ', ''),'') as full_name_children
,case when epk.children_birthdate = '' then null else date(epk.children_birthdate) end as birthdate
,case when epk.children_birthdate = '' then null else date_part('year', age(current_date, date(epk.children_birthdate))) end as age
,epk.customer_id
,coalesce(replace(lower(epu.lastname), ' ', '')||' '||replace(lower(epu.firstname), ' ', '')||' '||replace(lower(epu.middlename), ' ', ''),'') as full_name_users
,epu.birthday as birthday_users
,epu.email as email_users
,ees.id as id_from_students
,coalesce(replace(lower(ees.lastname), ' ', '')||' '||replace(lower(ees.firstname), ' ', '')||' '||replace(lower(ees.patronymic), ' ', ''),'') as full_name_students
from perscom.ext_pgmu_kids epk
left join perscom.ext_pgmu_users epu on epk.customer_id = epu.customer_id 
left join perscom.ext_edu_students ees 
	on coalesce(replace(lower(epk.children_lastname), ' ', '')||' '||replace(lower(epk.children_firstname), ' ', '')||' '||replace(lower(epk.children_middlename), ' ', ''),'') = 
		coalesce(replace(lower(ees.lastname), ' ', '')||' '||replace(lower(ees.firstname), ' ', '')||' '||replace(lower(ees.patronymic), ' ', ''),'')
		and epk.children_birthdate = ees.birthdate
where epk.children_lastname ilike '%семенова%' and (epk.children_firstname ilike '%дарья%' or epk.children_firstname ilike '%софья%' or epk.children_firstname ilike '%юлия%')
group by 1,2,3,4,5,6,7,8,9
)
select * from j order by 1; 
--
--
select concat('kinder_list'),count(*) from perscom.ext_kinder_list
union 
select concat('pgmu_kids'),count(*) from perscom.ext_pgmu_kids
union
select concat('kinder_doo'),count(*) from perscom.ext_kinder_doo;
--
select distinct whom_dul_child from perscom.ext_kinder_doo
-- --
select * from perscom.ext_pgmu_users where customer_id = 3164566 or customer_id = 2850634;
--
with u as (
select *,
count(customer_id) over (partition by customer_id) as double_id
from perscom.ext_pgmu_users
group by 1,2,3,4,5,6,7,8,9,10
)
select * from u where double_id >1 order by 10
--
select * from perscom.ext_data_fkgs where email = 'avhadievagz@mail.ru'
--
select count(phone_number) from perscom.ext_pgmu_pay where phone_number <> '';
---
---
---
drop external table test.s1;
