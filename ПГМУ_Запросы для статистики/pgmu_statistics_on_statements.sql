with pgmu_statistics_on_statements as (
SELECT 
DATE_FORMAT(FROM_UNIXTIME(r.request_time), '%Y-%m-01') as date_month,
CASE 
	WHEN r.`electronic_service_id` = 143 AND rp.`value` = 'EnterCountersValues' THEN '5013'
	WHEN t.id IS NOT NULL THEN '5027'
ELSE
	r.electronic_service_id
END e_service_id, 
COUNT(DISTINCT IF(r.infomat_id IN (3,46, 710, 55, 13), r.id, NULL)) portal_e_statement_count, 
COUNT(DISTINCT IF(r.infomat_id IN (56, 845, 846), r.id, NULL)) m_portal_e_statement_count, 
COUNT(DISTINCT IF(r.infomat_id IN (626, 847), r.id, NULL)) IOS_e_statement_count, 
COUNT(DISTINCT IF(r.infomat_id IN (627, 848), r.id, NULL)) android_e_statement_count, 
COUNT(DISTINCT IF(r.infomat_id  NOT IN (55,163,160,161,162,3,46,56,626,627,628,710,845,846,847,848, 852,853, 907, 908, 909, 13), r.id, NULL)) infomat_e_statement_count
FROM gosuslugi.requests r FORCE INDEX(request_time) -- оптимальный индекс для небольших периодов(до нескольких дней, чем меньше тем лучше)
LEFT JOIN gosuslugi.request_answers ra ON r.id = ra.request_id 
LEFT JOIN gosuslugi.request_params rp ON r.id = rp.request_id AND rp.`service_field_id` = 124 AND rp.`value` = 'EnterCountersValues' AND r.electronic_service_id = 143
LEFT JOIN gosuslugi.transport_applications t ON t.request_id = r.id
LEFT JOIN gosuslugi.clients c ON r.client_id = c.id
INNER JOIN gosuslugi.electronic_services es ON r.electronic_service_id = es.id 
INNER JOIN gosuslugi.infomats i ON r.infomat_id = i.id
LEFT JOIN gosuslugi.services s ON es.service_id = s.id
LEFT JOIN gosuslugi.infomat_models im ON i.infomat_model_id = im.id
WHERE ((r.electronic_service_id IN (113,116,119,122) AND ra.id IS NOT NULL) OR (r.electronic_service_id IN (143) AND rp.value IS NOT NULL) OR (r.electronic_service_id IN (109) AND t.id IS NOT NULL)
OR r.electronic_service_id IN (264,276,470,456,452, 83,139, 143)
)
AND r.request_time BETWEEN UNIX_TIMESTAMP('2024-06-01 00:00:00') AND UNIX_TIMESTAMP('2024-06-30 23:59:59')
GROUP BY 2
UNION
-- --
-- Количество выгруженных заявлений по ДОУ - услугу убрали с ПГМУ с 2021 года
SELECT 
CASE WHEN DATE_FORMAT(ca.create_date, '%Y-%m-01') IS NULL 
		THEN DATE_FORMAT('2024-06-01 00:00:00', '%Y-%m-01') 
		ELSE DATE_FORMAT(ca.create_date, '%Y-%m-01') END as date_month,
'5005' el_statement, 
SUM(IF(r.infomat_id IN (3,46, 710, 55), 1, 0)) portal_e_statement_count, 
SUM(IF(r.infomat_id IN (56, 845, 846), 1, 0)) m_portal_e_statement_count, 
SUM(IF(r.infomat_id IN (626, 847), 1, 0)) IOS_e_statement_count, 
SUM(IF(r.infomat_id IN (627, 848), 1, 0)) android_e_statement_count, 
'' infomat_e_statement_count
FROM gosuslugi.cei_applications ca INNER JOIN gosuslugi.requests r ON ca.request_id = r.id
WHERE ca.create_date BETWEEN '2024-06-01 00:00:00' AND '2024-06-30 23:59:59' AND ca.status = 'sended'
UNION
 -- Количество выгруженных заявлений по Минзем
 SELECT 
 DATE_FORMAT(ms.date, '%Y-%m-01') as date_month,
 '5018', COUNT(ms.id), '', '', '', '' infomat_e_statement_count
  FROM gosuslugi.mnogodet_statements ms 
 WHERE ms.request_id IS NOT NULL AND ms.date BETWEEN '2024-06-01 00:00:00' AND '2024-06-30 23:59:59'
UNION
-- --
-- Оценка качества на uslugi.tatarstan.ru
SELECT 
DATE_FORMAT(rt.create_date, '%Y-%m-01') as date_month,
'2004', COUNT(*), ' ', ' ', ' ','' FROM gosuslugi_rating.rt_estimates rt
WHERE rt.create_date BETWEEN '2024-06-01 00:00:00' AND '2024-06-30 23:59:59'
UNION
-- --
-- Статистика заявлений по конструкторским услугам
SELECT 
DATE_FORMAT(scr.date, '%Y-%m-01') as date_month,
CONCAT(CASE
WHEN sc.electronic_service_id IN (320, 440) THEN '320'
WHEN sc.electronic_service_id IN (323, 439) THEN '323'
WHEN sc.electronic_service_id IN (345, 350, 347, 348, 346, 349, 357, 356, 355, 358, 351, 390, 353, 354, 352, 389) THEN '345'
WHEN sc.electronic_service_id IN (447, 448) THEN '447'
WHEN sc.electronic_service_id IN (340, 341, 342, 343, 344) THEN '340'
WHEN sc.electronic_service_id IN (318, 319) THEN '318'
WHEN sc.electronic_service_id IN (327, 328, 329, 559, 633) THEN '327'
WHEN sc.electronic_service_id IN (332, 333, 639) THEN '332'
WHEN sc.electronic_service_id IN (330, 331, 638) THEN '330'
WHEN sc.electronic_service_id IN (359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 688) THEN '359'
WHEN sc.electronic_service_id IN (507, 508, 509, 620) THEN '507'
WHEN sc.electronic_service_id IN (558, 559) THEN '558'
WHEN sc.electronic_service_id IN (524, 530) THEN '524'
WHEN sc.electronic_service_id IN (515, 621) THEN '515'
ELSE
	sc.electronic_service_id
END, '_st') e_service_id,
COUNT(DISTINCT scr.unique_code) portal_e_statement_count, ' ', ' ', ' ', ' '
FROM gosuslugi.service_constructor_requests scr
INNER JOIN gosuslugi.service_constructors sc ON scr.`service_constructor_id` = sc.`id` INNER JOIN gosuslugi.requests r ON scr.request_id = r.id
WHERE scr.date BETWEEN '2024-06-01 00:00:00' AND '2024-06-30 23:59:59'
AND scr.unique_code NOT LIKE ('%-1001-%') AND scr.send_from = 0
AND sc.title NOT LIKE 'МФЦ%'
GROUP BY 2
UNION
-- --
-- Статистика заявлений по конструкторским услугам на виджетах
SELECT 
CASE 
	WHEN DATE_FORMAT(scr.date, '%Y-%m-01') IS NOT NULL THEN DATE_FORMAT(scr.date, '%Y-%m-01')
	WHEN DATE_FORMAT(FROM_UNIXTIME(r.request_time), '%Y-%m-01') IS NOT NULL THEN DATE_FORMAT(FROM_UNIXTIME(r.request_time), '%Y-%m-01')
	ELSE DATE_FORMAT('2024-06-01 00:00:00', '%Y-%m-01')
END as date_month,
tbl.department_id, COUNT(DISTINCT r.request_code), '', '', '', ''
FROM gosuslugi.`service_constructors` sc 
LEFT JOIN gosuslugi.`service_constructor_requests` scr ON scr.`service_constructor_id` = sc.`id` AND scr.unique_code NOT LIKE ('%-1001-%') AND scr.send_from = 0 AND scr.date BETWEEN '2024-06-01 00:00:00' AND '2024-06-30 23:59:59'
LEFT JOIN gosuslugi.requests r  ON scr.request_id = r.id AND r.request_time BETWEEN UNIX_TIMESTAMP('2024-06-01 00:00:00') AND UNIX_TIMESTAMP('2024-06-30 23:59:59')
INNER JOIN  gosuslugi.services s ON sc.service_id = s.original_id
INNER JOIN (
SELECT '1' AS id, 3 AS sort_id, '4_st' AS `department_id`, '24446' AS service_id, 'evolenta' AS `type` UNION
SELECT '2', 3, '4_st', '24540', 'evolenta' UNION
SELECT '3', 3, '4_st', '24547', 'evolenta' UNION
SELECT '4', 3, '4_st', '24541', 'evolenta' UNION
SELECT '5', 3, '4st', '24549', 'evolenta' UNION
SELECT '6', 3, '4_st', '24535', 'evolenta' UNION
SELECT '7', 3, '4_st', '24558', 'evolenta' UNION
SELECT '8', 3, '4_st', '24556', 'evolenta' UNION
SELECT '8.5', 3, '4_st', '27532', 'evolenta' UNION
SELECT '9', 3, '4_st', '24468', 'evolenta' UNION
SELECT '9.2', 3, '4_st', '27557', 'evolenta' UNION
SELECT '9.3', 3, '4_st', '27558', 'evolenta' UNION
SELECT '9.4', 3, '4_st', '27604', 'evolenta' UNION
SELECT '9.41', 3, '4_st', '27612', 'evolenta' UNION
SELECT '9.42', 3, '4_st', '27613', 'evolenta' UNION
SELECT '9.43', 3, '4_st', '27614', 'evolenta' UNION
SELECT '9.44', 3, '4_st', '27615', 'evolenta' UNION
SELECT '9.45', 3, '4_st', '27617', 'evolenta' UNION
SELECT '9.46', 3, '4_st', '27618', 'evolenta' UNION
SELECT '9.47', 3, '4_st', '27619', 'evolenta' UNION
SELECT '9.48', 3, '4_st', '27620', 'evolenta' UNION
SELECT '9.49', 3, '4_st', '27621', 'evolenta' UNION
SELECT '9.50', 3, '4_st', '27622', 'evolenta' UNION
SELECT '9.51', 3, '4_st', '27623', 'evolenta' UNION
SELECT '9.52', 3, '4_st', '27624', 'evolenta' UNION
SELECT '9.53', 3, '4_st', '27625', 'evolenta' UNION
SELECT '9.54', 3, '4_st', '27626', 'evolenta' UNION
SELECT '9.55', 3, '4_st', '27627', 'evolenta' UNION
SELECT '9.56', 3, '4_st', '27628', 'evolenta' UNION
SELECT '9.57', 3, '4_st', '27629', 'evolenta' UNION
SELECT '9.58', 3, '4_st', '27630', 'evolenta' UNION
SELECT '9.59', 3, '4_st', '27631', 'evolenta' UNION
SELECT '9.60', 3, '4_st', '27632', 'evolenta' UNION
SELECT '9.61', 3, '4_st', '27633', 'evolenta' UNION
SELECT '9.62', 3, '4_st', '27634', 'evolenta' UNION
SELECT '9.63', 3, '4_st', '27636', 'evolenta' UNION
SELECT '9.64', 3, '4_st', '27590', 'evolenta' UNION
SELECT '10', 2, '3_st', '24447', 'evolenta' UNION
SELECT '11', 2, '3_st', '24534', 'evolenta' UNION
SELECT '12', 2, '3_st', '24553', 'evolenta' UNION
SELECT '13', 2, '3_st', '22844', 'evolenta' UNION
SELECT '13.1', 2, '3_st', '27534', 'evolenta' UNION
SELECT '13.2', 2, '3_st', '27536', 'evolenta' UNION
SELECT '13.3', 2, '3_st', '27537', 'evolenta' UNION
SELECT '13.4', 2, '3_st', '27538', 'evolenta' UNION
SELECT '13.41', 2, '3_st', '27470', 'evolenta' UNION
SELECT '13.42', 2, '3_st', '27459', 'evolenta' UNION
SELECT '13.43', 2, '3_st', '27464', 'evolenta' UNION
SELECT '13.44', 2, '3_st', '27607', 'evolenta' UNION
SELECT '13.45', 2, '3_st', '27608', 'evolenta' UNION
SELECT '14', 2, '3_st', '27471', 'evolenta' UNION
SELECT '15', 6, '13_st', '24420', 'evolenta' UNION
SELECT '15.1', 6, '13_st', '27568', 'evolenta' UNION
SELECT '16', 6, '13_st', '24430', 'evolenta' UNION
SELECT '17', 6, '13_st', '16151', 'evolenta' UNION
SELECT '18', 6, '13_st', '24462', 'evolenta' UNION
SELECT '19', 6, '13_st', '24428', 'evolenta' UNION
SELECT '20', 6, '13_st', '24476', 'evolenta' UNION
SELECT '21', 6, '13_st', '24449', 'evolenta' UNION
SELECT '22', 6, '13_st', '15697', 'evolenta' UNION
SELECT '23', 6, '13_st', '24427', 'evolenta' UNION
SELECT '24', 6, '13_st', '24544', 'evolenta' UNION
SELECT '24.1', 6, '13_st', '27539', 'evolenta' UNION
SELECT '25', 6, '13_st', '24537', 'evolenta' UNION
SELECT '26', 6, '13_st', '27389', 'evolenta' UNION
SELECT '27', 6, '13_st', '27392', 'evolenta' UNION
SELECT '28', 6, '13_st', '27391', 'evolenta' UNION
SELECT '29', 6, '13_st', '27393', 'evolenta' UNION
SELECT '30', 6, '13_st', '27394', 'evolenta' UNION
SELECT '31', 6, '13_st', '27395', 'evolenta' UNION
SELECT '32', 6, '13_st', '27396', 'evolenta' UNION
SELECT '33', 6, '13_st', '27398', 'evolenta' UNION
SELECT '34', 6, '13_st', '27399', 'evolenta' UNION
SELECT '35', 6, '13_st', '27402', 'evolenta' UNION
SELECT '36', 6, '13_st', '27460', 'evolenta' UNION
SELECT '37', 6, '13_st', '27373', 'evolenta' UNION
SELECT '38', 6, '13_st', '27375', 'evolenta' UNION
SELECT '39', 6, '13_st', '27381', 'evolenta' UNION
SELECT '40', 6, '13_st', '27385', 'evolenta' UNION
SELECT '41', 6, '13_st', '27386', 'evolenta' UNION
SELECT '42', 6, '13_st', '27379', 'evolenta' UNION
SELECT '43', 6, '13_st', '27376', 'evolenta' UNION
SELECT '44', 6, '13_st', '27377', 'evolenta' UNION
SELECT '45', 6, '13_st', '27378', 'evolenta' UNION
SELECT '45.1', 6, '13_st', '27606', 'evolenta' UNION
SELECT '45.2', 6, '13_st', '27649', 'evolenta' UNION
SELECT '46', 6, '13_st', '27384', 'evolenta' UNION
SELECT '47', 6, '13_st', '27397', 'evolenta' UNION
SELECT '48', 6, '13_st', '27380', 'evolenta' UNION
SELECT '49', 6, '13_st', '27419', 'evolenta' UNION
SELECT '50', 6, '13_st', '24452', 'evolenta' UNION
SELECT '51', 6, '13_st', '17812', 'evolenta' UNION
SELECT '52', 6, '13_st', '24472', 'evolenta' UNION
SELECT '53', 6, '13_st', '24424', 'evolenta' UNION
SELECT '54', 6, '13_st', '24418', 'evolenta' UNION
SELECT '55', 6, '13_st', '16058', 'evolenta' UNION
SELECT '56', 6, '13_st', '24545', 'evolenta' UNION
SELECT '57', 6, '13_st', '24536', 'evolenta' UNION
SELECT '58', 6, '13_st', '27387', 'evolenta' UNION
SELECT '59', 6, '13_st', '27468', 'evolenta' UNION
SELECT '60', 6, '13_st', '27388', 'evolenta' UNION
SELECT '61', 6, '13_st', '27469', 'evolenta' UNION
SELECT '62', 6, '13_st', '27439', 'evolenta' UNION
SELECT '63', 6, '13_st', '27461', 'evolenta' UNION
SELECT '64', 6, '13_st', '27462', 'evolenta' UNION
SELECT '65', 6, '13_st', '27463', 'evolenta' UNION
SELECT '66', 6, '13_st', '27465', 'evolenta' UNION
SELECT '66.1', 6, '13_st', '27578', 'evolenta' UNION
SELECT '66.2', 6, '13_st', '27586', 'evolenta' UNION
SELECT '66.3', 6, '13_st', '27585', 'evolenta' UNION
SELECT '66.4', 6, '13_st', '27583', 'evolenta' UNION
SELECT '66.5', 6, '13_st', '27582', 'evolenta' UNION
SELECT '66.6', 6, '13_st', '27581', 'evolenta' UNION
SELECT '66.7', 6, '13_st', '27580', 'evolenta' UNION
SELECT '66.8', 6, '13_st', '27579', 'evolenta' UNION
SELECT '66.9', 6, '13_st', '27584', 'evolenta' UNION
SELECT '66.91', 6, '13_st', '27575', 'evolenta' UNION
SELECT '66.92', 6, '13_st', '27640', 'evolenta' UNION
SELECT '66.93', 6, '13_st', '27641', 'evolenta' UNION
SELECT '66.94', 6, '13_st', '27642', 'evolenta' UNION
SELECT '67', 6, '13_st', '19517', 'evolenta' UNION
SELECT '68', 15, '31_st', '24485', 'evolenta' UNION
SELECT '69', 15, '31_st', '24419', 'evolenta' UNION
SELECT '70', 15, '31_st', '22802', 'evolenta' UNION
SELECT '71', 15, '31_st', '6578', 'evolenta' UNION
SELECT '72', 15, '31_st', '24530', 'evolenta' UNION
SELECT '72.1', 15, '31_st', '27533', 'evolenta' UNION
SELECT '72.1', 15, '31_st', '27567', 'evolenta' UNION
SELECT '72.1', 15, '31_st', '27572', 'evolenta' UNION
SELECT '73', 15, '31_st', '27383', 'evolenta' UNION
SELECT '74', 4, '12_st', '24450', 'evolenta' UNION
SELECT '75', 4, '12_st', '27374', 'evolenta' UNION
SELECT '76', 4, '12_st', '24510', 'evolenta' UNION
SELECT '77', 4, '12_st', '24517', 'evolenta' UNION
SELECT '77.1', 4, '12_st', '27556', 'evolenta' UNION
SELECT '77.2', 4, '12_st', '27610', 'evolenta' UNION
SELECT '77.3', 4, '12_st', '27611', 'evolenta' UNION
SELECT '78', 4, '12_st', '15821', 'evolenta' UNION
SELECT '79', 20, '44_st', '24490', 'evolenta' UNION
SELECT '80', 20, '44_st', '24448', 'evolenta' UNION
SELECT '80.1', 20, '44_st', '27531', 'evolenta' UNION
SELECT '81', 20, '44_st', '13544', 'evolenta' UNION
SELECT '81.1', 20, '44_st', '27555', 'evolenta' UNION
SELECT '82', 8, '21_st', '24467', 'evolenta' UNION
SELECT '83', 8, '21_st', '24465', 'evolenta' UNION
SELECT '84', 8, '21_st', '24477', 'evolenta' UNION
SELECT '85', 8, '21_st', '24469', 'evolenta' UNION
SELECT '86', 8, '21_st', '24429', 'evolenta' UNION
SELECT '87', 8, '21_st', '24423', 'evolenta' UNION
SELECT '88', 8, '21_st', '24481', 'evolenta' UNION
SELECT '89', 8, '21_st', '24542', 'evolenta' UNION
SELECT '90', 8, '21_st', '24529', 'evolenta' UNION
SELECT '90.1', 8, '21_st', '27519', 'evolenta' UNION
SELECT '90.2', 8, '21_st', '27518', 'evolenta' UNION
SELECT '90.3', 8, '21_st', '27520', 'evolenta' UNION
SELECT '90.4', 8, '21_st', '27522', 'evolenta' UNION
SELECT '90.5', 8, '21_st', '27523', 'evolenta' UNION
SELECT '90.6', 8, '21_st', '27524', 'evolenta' UNION
SELECT '90.7', 8, '21_st', '27525', 'evolenta' UNION
SELECT '90.8', 8, '21_st', '27526', 'evolenta' UNION
SELECT '90.9', 8, '21_st', '27527', 'evolenta' UNION
SELECT '90.91', 8, '21_st', '27528', 'evolenta' UNION
SELECT '90.92', 8, '21_st', '27529', 'evolenta' UNION
SELECT '90.93', 8, '21_st', '24489', 'evolenta' UNION
SELECT '90.94', 8, '21_st', '24474', 'evolenta' UNION
SELECT '90.95', 8, '21_st', '27605', 'evolenta' UNION
SELECT '90.96', 8, '21_st', '27648', 'evolenta' UNION
SELECT '91', 8, '21_st', '24443', 'evolenta' UNION
SELECT '92', 16, '40_st', '24587', 'evolenta' UNION
SELECT '93', 16, '40_st', '23760', 'evolenta' UNION
SELECT '94', 16, '40_st', '22639', 'evolenta' UNION
SELECT '95', 16, '40_st', '12713', 'evolenta' UNION
SELECT '96', 16, '40_st', '22888', 'evolenta' UNION
SELECT '97', 16, '40_st', '22640', 'evolenta' UNION
SELECT '98', 16, '40_st', '24459', 'evolenta' UNION
SELECT '98.1', 16, '40_st', '27142', 'evolenta' UNION
SELECT '98.2', 16, '40_st', '27472', 'evolenta' UNION
SELECT '99', 16, '40_st', '24461', 'evolenta' UNION
SELECT '100', 9, '22_st', '24543', 'evolenta' UNION
SELECT '101', 9, '22_st', '24478', 'evolenta' UNION
SELECT '102', 9, '22_st', '24475', 'evolenta' UNION
SELECT '103', 9, '22_st', '598', 'evolenta' UNION
SELECT '103.1', 9, '22_st', '27535', 'evolenta' UNION
SELECT '103.2', 9, '22_st', '27574', 'evolenta' UNION
SELECT '103.3', 9, '22_st', '27573', 'evolenta' UNION
SELECT '104', 9, '22_st', '24464', 'evolenta' UNION
SELECT '104.1', 11, '24_st', '27569', 'evolenta' UNION
SELECT '104.2', 11, '24_st', '27563', 'evolenta' UNION
SELECT '104.3', 11, '24_st', '27562', 'evolenta' UNION
SELECT '104.4', 11, '24_st', '27561', 'evolenta' UNION
SELECT '104.5', 11, '24_st', '27560', 'evolenta' UNION
SELECT '104.6', 11, '24_st', '27559', 'evolenta' UNION
SELECT '104.7', 11, '24_st', '27637', 'evolenta' UNION
SELECT '104.8', 11, '24_st', '27638', 'evolenta' UNION
SELECT '104.9', 11, '24_st', '27647', 'evolenta' UNION
SELECT '105', 11, '24_st', '27473', 'evolenta' UNION
SELECT '106', 19, '43_st', '24466', 'evolenta' UNION
SELECT '107', 19, '43_st', '24528', 'evolenta' UNION
SELECT '107.1', 19, '43_st', '27551', 'evolenta' UNION
SELECT '107.2', 19, '43_st', '27643', 'evolenta' UNION
SELECT '107.3', 19, '43_st', '27644', 'evolenta' UNION
SELECT '107.4', 19, '43_st', '27645', 'evolenta' UNION
SELECT '107.5', 19, '43_st', '27646', 'evolenta' UNION
SELECT '108', 19, '43_st', '24532', 'evolenta' UNION
SELECT '109', 1, '2_st', '27069', 'evolenta' UNION
SELECT '109.1', 1, '2_st', '27517', 'evolenta' UNION
SELECT '109.2', 1, '2_st', '27548', 'evolenta' UNION
SELECT '109.3', 1, '2_st', '27549', 'evolenta' UNION
SELECT '109.4', 1, '2_st', '27639', 'evolenta' UNION
SELECT '110', 1, '2_st', '27467', 'evolenta' UNION
SELECT '111', 18, '42_st', '27475', 'evolenta' UNION
SELECT '112', 18, '42_st', '24473', 'evolenta' UNION
SELECT '112.1', 12, '25_st', '27570', 'evolenta' UNION
SELECT '112.2', 12, '25_st', '27564', 'evolenta' UNION
SELECT '113', 12, '25_st', '27382', 'evolenta' UNION
SELECT '114', 21, '45_st', '27371', 'evolenta' UNION
SELECT '115', 21, '45_st', '27489', 'evolenta' UNION
SELECT '116', 21, '45_st', '27490', 'evolenta' UNION
SELECT '117', 21, '45_st', '27491', 'evolenta' UNION
SELECT '118', 21, '45_st', '27501', 'evolenta' UNION
SELECT '119', 21, '45_st', '27502', 'evolenta' UNION
SELECT '120', 21, '45_st', '27503', 'evolenta' UNION
SELECT '121', 21, '45_st', '27504', 'evolenta' UNION
SELECT '122', 21, '45_st', '27505', 'evolenta' UNION
SELECT '123', 21, '45_st', '27506', 'evolenta' UNION
SELECT '124', 21, '45_st', '27507', 'evolenta' UNION
SELECT '125', 21, '45_st', '27508', 'evolenta' UNION
SELECT '126', 21, '45_st', '27509', 'evolenta' UNION
SELECT '127', 7, '20_st', '431', 'evolenta' UNION
SELECT '127.1', 17, '41_st', '27566', 'evolenta' UNION
SELECT '128', 17, '41_st', '24453', 'evolenta' UNION
SELECT '128.1', 23, '47_st', '27530', 'evolenta' UNION
SELECT '129', 5, '39_st', '24270', 'umu' UNION
SELECT '130', 5, '39_st', '8274', 'umu' UNION
SELECT '131', 5, '39_st', '15465', 'umu' UNION
SELECT '132', 5, '39_st', '24152', 'umu' UNION
SELECT '133', 5, '39_st', '20960', 'umu' UNION
SELECT '134', 5, '39_st', '23865', 'umu' UNION
SELECT '135', 5, '39_st', '15874', 'umu' UNION
SELECT '136', 5, '39_st', '23864', 'umu' UNION
SELECT '137', 5, '39_st', '15966', 'umu' UNION
SELECT '138', 5, '39_st', '16334', 'umu' UNION
SELECT '139', 5, '39_st', '23904', 'umu' UNION
SELECT '140', 5, '39_st', '20714', 'umu' UNION
SELECT '141', 5, '39_st', '24065', 'umu' UNION
SELECT '142', 5, '39_st', '24060', 'umu' UNION
SELECT '143', 5, '39_st', '22959', 'umu' UNION
SELECT '144', 5, '39_st', '19098', 'umu' UNION
SELECT '145', 5, '39_st', '17903', 'umu' UNION
SELECT '146', 5, '39_st', '18715', 'umu' UNION
SELECT '147', 5, '39_st', '23903', 'umu' UNION
SELECT '148', 5, '39_st', '24013', 'umu' UNION
SELECT '149', 5, '39_st', '24242', 'umu' UNION
SELECT '150', 5, '39_st', '24243', 'umu' UNION
SELECT '151', 5, '39_st', '24247', 'umu' UNION
SELECT '152', 5, '39_st', '24136', 'umu' UNION
SELECT '153', 5, '39_st', '24068', 'umu' UNION
SELECT '154', 5, '39_st', '24151', 'umu' UNION
SELECT '155', 5, '39_st', '24275', 'umu' UNION
SELECT '156', 5, '39_st', '24273', 'umu' UNION
SELECT '157', 5, '39_st', '24271', 'umu' UNION
SELECT '158', 5, '39_st', '24266', 'umu' UNION
SELECT '159', 5, '39_st', '24254', 'umu' UNION
SELECT '160', 5, '39_st', '24272', 'umu' UNION
SELECT '161', 5, '39_st', '24278', 'umu' UNION
SELECT '162', 5, '39_st', '24277', 'umu' UNION
SELECT '163', 5, '39_st', '24246', 'umu' UNION
SELECT '164', 5, '39_st', '24268', 'umu' UNION
SELECT '165', 5, '39_st', '24274', 'umu' UNION
SELECT '166', 5, '39_st', '24276', 'umu' UNION
SELECT '167', 5, '39_st', '24264', 'umu' UNION
SELECT '168', 5, '39_st', '24248', 'umu' UNION
SELECT '169', 5, '39_st', '7338', 'umu' UNION
SELECT '170', 5, '39_st', '24499', 'umu' UNION
SELECT '171', 5, '39_st', '24501', 'umu' UNION
SELECT '172', 5, '39_st', '24507', 'umu' UNION
SELECT '173', 5, '39_st', '24502', 'umu' UNION
SELECT '174', 5, '39_st', '24503', 'umu' UNION
SELECT '175', 5, '39_st', '24504', 'umu' UNION
SELECT '176', 5, '39_st', '24505', 'umu' UNION
SELECT '177', 5, '39_st', '24500', 'umu' UNION
SELECT '178', 5, '39_st', '19236', 'umu' UNION
SELECT '179', 5, '39_st', '24244', 'umu' UNION
SELECT '180', 5, '39_st', '24249', 'umu' UNION
SELECT '181', 5, '39_st', '24262', 'umu' UNION
SELECT '182', 22, '46_st', '24396', 'kaskad' UNION
SELECT '183', 24, '48_st', '27552', 'evolenta' UNION
SELECT '184', 24, '48_st', '27553', 'evolenta' UNION
SELECT '185', 25, '49_st', '27576', 'evolenta' UNION
SELECT '186', 10, '37_st', '27565', 'evolenta' UNION
SELECT '187', 14, '29_st', '27577', 'evolenta' UNION
SELECT '188', 13, '28_st', '27601', 'evolenta' UNION
SELECT '189', 13, '28_st', '27603', 'evolenta' UNION
SELECT '190', 26, '50_st', '27609', 'evolenta'
) 
AS tbl ON s.id = tbl.service_id
WHERE 
sc.title NOT LIKE 'МФЦ:%' 
GROUP BY tbl.department_id
UNION
-- --
-- Подписка на штрафы админкомиссии
SELECT 
DATE_FORMAT(scr.date, '%Y-%m-01') as date_month,
CONCAT(sc.code, '_' /*,scs.code*/), COUNT(DISTINCT scr.id), '', '', '', ''
FROM  gosuslugi.`service_constructor_requests` scr
INNER JOIN gosuslugi.`service_constructors` sc ON scr.`service_constructor_id` = sc.`id`
INNER JOIN gosuslugi.requests r ON scr.request_id = r.id
# INNER JOIN gosuslugi.service_constructor_request_status_histories h ON scr.id = h.service_constructor_request_id
# INNER JOIN gosuslugi.service_constructor_statuses scs ON h.service_constructor_status_id = scs.id
WHERE /*h.datetime BETWEEN UNIX_TIMESTAMP('2024-05-01 00:00:00') AND UNIX_TIMESTAMP('2024-05-31 23:59:59')
AND */sc.code = 'admincom' AND scr.date BETWEEN '2024-06-01 00:00:00' AND '2024-06-30 23:59:59'
GROUP BY 2
)
select * from pgmu_statistics_on_statements;