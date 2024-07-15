with pgmu_statistics_on_payments as (
SELECT /*EXTRACT(YEAR_MONTH FROM FROM_UNIXTIME(p.updated)),*/
		DATE_FORMAT(FROM_UNIXTIME(p.updated), '%Y-%m-01') as date_month,
         CASE
		WHEN es.id IN (55,59,60,61,66,68,69) THEN '5002'
		WHEN es.id IN (79,80) THEN '5003'
		WHEN es.id IN (28,29,30,31,261,475,476) THEN '5010'
		WHEN es.id IN (37,38,39,40,41,42,43,45,259,260, 299, 385, 409,477,478) THEN '5011'
		WHEN es.id IN (32,33,34,35,36,44,410,480,481,482,483,484) THEN '5012'
		WHEN es.id IN (22,24,56,57,58, 275, 651, 752) THEN '5016'
		WHEN es.id IN (97,98,99) THEN '5017'
		WHEN es.id IN (302,400) THEN '5024'
		WHEN es.id IN (213,214,215,216,217,218,219,220) THEN '5019'
		WHEN es.id IN (287,289) THEN '5020'
		WHEN es.id IN (72,278) THEN '5021'
		WHEN es.id IN (81, 426, 956, 957, 958) THEN '5028'
		WHEN es.id IN (62, 449, 450) THEN '5029'
		WHEN es.id IN (487, 557) THEN '487'
		WHEN p.summ = '150.00' AND es.id IN (48) THEN '4001'
		WHEN r.infomat_id = 628 AND r.electronic_service_id = 7 THEN '4002'
		WHEN r.infomat_id = 628 AND r.electronic_service_id = 85 THEN '4003'
		WHEN es.id IN (226, 407) THEN '226'
         ELSE
		es.id
         END e_service_id, 
	 COUNT(IF(r.infomat_id IN (3, 46,710, 55), p.id, NULL)) portal_e_payment_count,
	 SUM(IF(r.infomat_id IN (3, 46,710, 55), p.summ, NULL)) portal_e_payment_summ,
	 COUNT(IF(r.infomat_id IN (56, 845, 846), p.id, NULL)) m_portal_e_payment_count,
	 SUM(IF(r.infomat_id IN (56, 845, 846), p.summ, NULL)) m_portal_e_payment_summ,
	 COUNT(IF(r.infomat_id IN (626, 847, 907), p.id, NULL)) IOS_e_payment_count,
	 SUM(IF(r.infomat_id IN (626, 847, 907), p.summ, NULL)) IOS_e_payment_summ,
	 COUNT(IF(r.infomat_id IN (627, 848, 908), p.id, NULL)) android_e_payment_count,
	 SUM(IF(r.infomat_id IN (627, 848, 908), p.summ, NULL)) android_e_payment_summ,
	 COUNT(IF(r.infomat_id NOT IN(46,56,626,627,628,55,163,160,161,162,710,845,846,847,848, 907, 908) AND i.test = 0, p.id, NULL)) infomat_e_payment_count,
	 SUM(IF(r.infomat_id NOT IN(46,56,626,627,628,55,163,160,161,162,710,845,846,847,848, 907, 908) AND i.test = 0, p.summ, NULL)) infomat_e_payment_summ
	 FROM gosuslugi.payments p FORCE INDEX(updated_idx)
         INNER JOIN gosuslugi.requests r 
	   ON p.request_id = r.id
         INNER JOIN gosuslugi.electronic_services es
           ON r.electronic_service_id = es.id
         INNER JOIN gosuslugi.infomats i
           ON r.infomat_id = i.id
       WHERE p.updated BETWEEN UNIX_TIMESTAMP('2024-06-01 00:00:00')
           AND UNIX_TIMESTAMP('2024-06-30 23:59:59')
           AND p.status = 2
           AND (p.response_xml NOT LIKE '%epcdemo.akbars.ru%' OR p.response_xml IS NULL)
       GROUP BY 2
)
select * from pgmu_statistics_on_payments;