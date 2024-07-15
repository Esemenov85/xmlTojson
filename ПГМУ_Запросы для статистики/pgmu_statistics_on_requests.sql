with pgmu_statistics_on_requests as (
SELECT
DATE_FORMAT(FROM_UNIXTIME(r.request_time), '%Y-%m-01') as date_month,
CASE
	WHEN r.electronic_service_id = 143 AND rp.service_field_id = 124 AND rp.value = 'GetCountersArchiveValues' THEN '5014'
	WHEN r.electronic_service_id = 150 AND rp.service_field_id = 124 AND rp.value = 'ChargeMonthTotals' THEN '5022'
	WHEN r.electronic_service_id = 150 AND rp.service_field_id = 124 AND rp.value = 'GetPayments' THEN '5015'
	WHEN r.electronic_service_id = 257 AND rp.service_field_id = 163 AND rp.value = 'mfc' THEN '5023'
	WHEN es.id IN (73,75) THEN '5008'
	WHEN es.id IN (415, 398) THEN '415'
ELSE
	r.electronic_service_id
END e_service_id,
COUNT(IF(i.id IN (3,46, 710, 55) AND i.test=0 AND (c.customer_id NOT IN (3030942) OR c.customer_id IS NULL), r.id, NULL)) portal_e_services_count,
COUNT(IF(i.id IN (56, 845, 846) AND i.test=0, r.id, NULL)) m_portal_e_services_count,
COUNT(IF(i.id IN (626, 847), r.id, NULL)) IOS_e_services_count,
COUNT(IF(i.id IN (627, 848), r.id, NULL)) android_e_services_count,
COUNT(IF(i.id NOT IN (55,163,160,161,162,3,46,56,626,627,628,710,845,846,847,848, 852,853, 907, 908) AND i.test=0 AND i.infomat_type_id=2643, r.id, NULL)) infomat_e_services_count
FROM gosuslugi.requests r FORCE INDEX(request_time)
LEFT JOIN gosuslugi.clients c ON r.client_id = c.id
INNER JOIN gosuslugi.electronic_services es ON r.electronic_service_id = es.id 
INNER JOIN gosuslugi.infomats i ON r.infomat_id = i.id
LEFT JOIN gosuslugi.services s ON es.service_id = s.id
LEFT JOIN gosuslugi.infomat_models im ON i.infomat_model_id = im.id
LEFT JOIN gosuslugi.request_params rp ON r.id = rp.request_id AND rp.service_field_id IN (124, 163) AND rp.value IN ('GetCountersArchiveValues', 'ChargeMonthTotals', 'GetPayments', 'mfc') AND r.electronic_service_id IN (143, 150, 257)
WHERE r.request_time BETWEEN UNIX_TIMESTAMP('2024-06-01 00:00:00') AND UNIX_TIMESTAMP('2024-06-30 23:59:59')
#Услуги, по которым ведется статистика в "Э-услуги в разрезе ведомств"
AND (es.id IN (1,3,49,52,70,78,84,94,95,96,100,104,136,137,138,140,148,149,150,192,196,210,73,75,228,229,230,282,284,285,286,290,291,300,303,304,305,306,307,308,309,310,311,412,445,446,500,415,399,467,489,472, 466, 540, 608, 398, 504, 804) OR (es.id IN (143, 150, 257) AND rp.service_field_id IN (124, 163) AND rp.value IN ('GetCountersArchiveValues', 'ChargeMonthTotals', 'GetPayments', 'mfc')))
GROUP BY 2
UNION
### Подсчет запросов по конструкторским услугам
SELECT 
DATE_FORMAT(FROM_UNIXTIME(r.request_time), '%Y-%m-01') as date_month,
CASE
	WHEN s.original_id IN (21914, 15029, 21910, 21912, 21913, 21915, 21916, 21917, 21918, 21919, 21920, 21921, 21922, 21923, 21924, 21925,22635,15024, 15014, 15027, 15035, 15034, 15039, 15028, 15043, 15041, 15042, 15025) THEN '21914'
	WHEN s.original_id IN (19894, 19891) THEN 19894
	WHEN s.original_id IN (20589,20594,22209,22214, 2252, 2242, 2256) THEN 20589
	WHEN s.original_id IN (7338, 23070) THEN 7338
	WHEN s.original_id IN (22364, 2220, 24518) THEN 22364
ELSE
	s.original_id
END e_service_id, 
COUNT(r.id) portal_e_services_count, '', '', '', '' 
FROM gosuslugi.requests r FORCE INDEX(request_time) INNER JOIN gosuslugi.request_params rp ON r.id = rp.request_id INNER JOIN gosuslugi.services s ON rp.value = s.id
WHERE r.electronic_service_id = 257 AND rp.service_field_id = 163 AND r.request_time BETWEEN UNIX_TIMESTAMP('2024-06-01 00:00:00') AND UNIX_TIMESTAMP('2024-06-30 23:59:59')
GROUP BY 2
UNION
SELECT 
DATE_FORMAT(scs.datetime, '%Y-%m-01') as date_month,
CASE
WHEN sc.electronic_service_id IN (320, 440) THEN '320'
WHEN sc.electronic_service_id IN (323, 439) THEN '323'
WHEN sc.electronic_service_id IN (447, 448) THEN '447'
WHEN sc.electronic_service_id IN (318, 319) THEN '318'
WHEN sc.electronic_service_id IN (332, 333, 639) THEN '332'
WHEN sc.electronic_service_id IN (330, 331, 638) THEN '330'
ELSE
	sc.electronic_service_id
END e_service_id, COUNT(scs.id) portal_e_services_count, '', '', '', '' 
FROM gosuslugi.service_constructor_statistics scs INNER JOIN gosuslugi.service_constructors sc ON scs.service_constructor_id = sc.id AND sc.title NOT LIKE 'МФЦ%'
INNER JOIN gosuslugi.service_constructor_events sce ON scs.service_constructor_event_id = sce.id AND sce.event_type = 'check_status' AND scs.datetime BETWEEN '2024-06-01 00:00:00' AND '2024-06-30 23:59:59'
AND scs.infomat_id <> '1001'
GROUP BY 2
)
select * from pgmu_statistics_on_requests;