CREATE OR REPLACE FUNCTION get_section_for_waitinglist()
RETURNS TABLE (
    SectionData JSON
) AS $$
BEGIN
    RETURN QUERY
    SELECT json_build_object(
        'Id', s.id,
        'Name', s.name,
        'Description', s.description,
        'Isdeleted', s.isdeleted,
        'Createddate', s.createddate,
        'Createdby', s.createdby,
        'Updateddate', s.updateddate,
        'Updatedby', s.updatedby,
        'Waitingtokens', COALESCE(json_agg(json_build_object(
            'Id', wt.id,
            'Customerid', wt.customerid,
            'Isdeleted', wt.isdeleted,
            'Isassigned', wt.isassigned,
            'Sectionid', wt.sectionid,
            'Noofpersons', wt.noofpersons
        )) FILTER (WHERE wt.id IS NOT NULL), '[]')
    ) AS SectionData
    FROM section s
    LEFT JOIN waitingtoken wt ON s.id = wt.sectionid
    WHERE s.isdeleted = FALSE
    GROUP BY s.id, s.name, s.description, s.isdeleted, s.createddate, s.createdby, s.updateddate, s.updatedby;
END;
$$ LANGUAGE plpgsql;






CREATE OR REPLACE FUNCTION get_waiting_tokens_by_section_id(section_id INT)
RETURNS TABLE (
  SectionData JSON
) AS $$
BEGIN
  RETURN QUERY
  SELECT json_build_object(
  'Id', wt.id,
  'Customerid', wt.customerid,
  'Isdeleted', wt.isdeleted,
  'Isassigned', wt.isassigned,
  'Sectionid', wt.sectionid,
  'Noofpersons', wt.noofpersons,
  'Createddate', wt.createddate,
  'Createdby', wt.createdby,
  'Updateddate', wt.updateddate,
  'Updatedby', wt.updatedby,
  'Customer', json_build_object(
    'Id', c.id,
    'Name', c.name,
	'Email',c.email,
	'Phone',c.phone
  ),
  'Section', json_build_object(
    'Id', s.id,
    'Name', s.name,
    'Description', s.description,
    'Isdeleted', s.isdeleted,
    'Createddate', s.createddate,
    'Createdby', s.createdby,
    'Updateddate', s.updateddate,
    'Updatedby', s.updatedby
  )
) AS WaitingTokenData
FROM waitingtoken wt
LEFT JOIN customer c ON wt.customerid = c.id
LEFT JOIN section s ON wt.sectionid = s.id
WHERE wt.isdeleted = FALSE AND wt.isassigned = FALSE
  AND (s.id = section_id OR section_id = 0)
GROUP BY wt.id, c.id, s.id;
END;
$$ LANGUAGE plpgsql;






CREATE OR REPLACE FUNCTION get_sections_for_wt()
RETURNS TABLE(section_data JSON) AS $$
BEGIN
    RETURN QUERY
    SELECT json_build_object(
        'Id', s.id,
        'Name', s.name,
        'Isdeleted', s.isdeleted,
        'Description', s.description,
        'Createddate', s.createddate,
        'Createdby', s.createdby,
        'Updateddate', s.updateddate,
        'Updatedby', s.updatedby,
        'Tables', (
            SELECT json_agg(json_build_object(
                'Id', t.id,
				'Name', t.name,
				'Capacity', t.capacity,
				'Status', t.status,
                'Isavailable', t.isavailable
            ))
            FROM tables t
            WHERE t.Sectionid = s.id
        )
    ) AS section_data
    FROM section s
    WHERE s.isdeleted = false;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_waiting_token(wt_id INT)
RETURNS TABLE(waiting_token JSON) 
AS $$
BEGIN 
	RETURN QUERY
	SELECT json_build_object(
	'Id',w.id,
	'Customerid',w.customerid,
	'Isdeleted',w.isdeleted,
	'Isassigned',w.isassigned,
	'Sectionid',w.sectionid,
	'Noofpersons',w.noofpersons,
	'Createddate',w.createddate,
	'Createdby',w.createdby,
	'Updateddate',w.updateddate,
	'Updatedby',w.updatedby,
	'Customer', json_build_object(
    	'Id', c.id,
    	'Name', c.name,
		'Email',c.email,
		'Phone',c.phone
  	),
	'Section', json_build_object(
    	'Id', s.id,
    	'Name', s.name,
    	'Description', s.description,
    	'Isdeleted', s.isdeleted,
    	'Createddate', s.createddate,
    	'Createdby', s.createdby,
    	'Updateddate', s.updateddate,
    	'Updatedby', s.updatedby
  	)) AS waiting_token
	FROM waitingtoken w
	LEFT JOIN customer c ON w.customerid = c.id
	LEFT JOIN section s ON w.sectionid = s.id
	WHERE w.id = wt_id AND w.isdeleted = FALSE AND w.isassigned = FALSE
	GROUP BY w.id, c.id, s.id;
END;
$$ LANGUAGE plpgsql;


SELECT * FROM get_waiting_token(21);


CREATE OR REPLACE FUNCTION search_customer(customer_email VARCHAR)
RETURNS TABLE(customer_data JSON)
AS $$
BEGIN
	RETURN QUERY
	SELECT json_build_object(
	'Id', c.id,
	'Name', c.name,
	'Email', c.email,
	'Phone', c.phone,
	'Date', c.date
	)AS customer_data
	FROM customer c
	WHERE LOWER(c.email) LIKE customer_email;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM search_customer('gmail');


CREATE OR REPLACE FUNCTION get_available_tables(section_id INT)
RETURNS TABLE(table_data JSON)
AS $$
BEGIN 
	RETURN QUERY
	SELECT json_build_object(
	'Id', t.id,
	'Sectionid', t.sectionid,
	'Name', t.name,
	'Capacity', t.capacity,
	'Status', t.status,
	'Isavailable', t.isavailable
	) AS table_data
	FROM "tables" t
	WHERE t.sectionid = section_id AND t.isdeleted = FALSE AND t.isavailable = TRUE;
END;
$$ LANGUAGE plpgsql;

SELECT * from get_available_tables(4);

CREATE OR REPLACE FUNCTION get_table_view_orderapp()
RETURNS TABLE(table_data JSON)
AS $$
BEGIN 
	RETURN QUERY
	SELECT json_build_object(
    	'Id', s.id,
		'Name', s.name,
		'Isdeleted', s.isdeleted,
		'Description', s.description,
		'Createddate', s.createddate,
		'Createdby', s.createdby,
		'Updateddate', s.updateddate,
		'Updatedby', s.updatedby,
		'Tables', json_build_object(
			'Id', t.id,
			'Sectionid', t.sectionid,
			'Name', t.name,
			'Capacity', t.capacity,
			'Status', t.status,
			'Isavailable', t.isavailable,
			'Isdeleted', t.isdeleted,
			'Createddate', t.createddate,
			'Createdby', t.createdby,
			'Updateddate', t.updateddate,
			'Updatedby', t.updatedby,
			'Tableordermappings', json_build_object(
				'Id', tom.id,
				'Orderid', tom.orderid,
				'Tableid', tom.tableid,
				'Noofpersons', tom.noofpersons,
				'Isdeleted', tom.isdeleted,
				'Createddate', tom.createddate,
				'Createdby', tom.createdby,
				'Updateddate', tom.updateddate,
				'Updatedby', tom.updatedby,
				'Order', json_build_object(
					'Id', o.id,
					'Customerid', o.customerid,
					'Subtotalamount', o.subtotalamount,
					'Totalamount', o.totalamount,
					'Tax', o.tax,
					'Discount', o.discount,
					'Notes', o.notes,
					'Status', o.status,
					'Isgstselected', o.isgstselected,
					'Isdeleted', o.isdeleted,
					'Createddate', o.createddate,
					'Createdby', o.createdby,
					'Updateddate', o.updateddate,
					'Updatedby', o.updatedby,
					'Paymentid', o.paymentid
				)
			)
		)
	) AS table_data
	FROM section s
	LEFT JOIN "tables" t ON s.id = t.sectionid
	LEFT JOIN tableordermapping tom ON t.id = tom.tableid
	LEFT JOIN "order" o ON o.id = tom.orderid
	WHERE s.isdeleted = FALSE
	GROUP BY s.id,t.id,t.sectionid,tom.id,tom.orderid,o.id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION get_table_view_orderapp()
RETURNS json
LANGUAGE 'plpgsql'
AS $$
BEGIN
	RETURN(
		select json_agg(row_to_json(s))
            from
            (
            select s.*,
            (
                select json_agg(row_to_json(tb))
                from
                (
                select tb.*, 
                (
                    select json_agg(row_to_json(tom))
                    from
                    (
                    	select tom.*, o.*
                    	from tableordermapping tom
                    	left join "order" o on tom.orderid = o.id
                    	where tom.tableid = tb.id
                    ) tom
                ) as tableordermappings
                from tables tb
                where tb.sectionid = s.id and tb.isdeleted = 'false'
                ) tb
            ) as tables
            from section s
            where s.isdeleted = 'false'
            order by s.id
            ) s
	);
END;
$$;


SELECT * FROM get_table_view_orderapp();






CREATE OR REPLACE FUNCTION get_table_view_orderapp()
RETURNS json
LANGUAGE 'plpgsql'
AS $$
BEGIN
	RETURN(
		select json_agg(row_to_json(s))
            from
            (
                select s.*,
                (
                    select json_agg(row_to_json(tb))
                    from
                    (
                        select tb.*, 
                        (
                            select json_agg(row_to_json(tom))
                            from
                            (
                                select tom.*, 
                                (
                                    select row_to_json(o)
                                    from "order" o
                                    where o.id = tom.orderid
                                ) as order
                                from tableordermapping tom
                                where tom.tableid = tb.id
                            ) tom
                        ) as tableordermappings
                        from tables tb
                        where tb.sectionid = s.id
                    ) tb
                ) as tables
                from section s
                where s.isdeleted = 'false'
                order by s.id
            ) s
	);
END;
$$;

