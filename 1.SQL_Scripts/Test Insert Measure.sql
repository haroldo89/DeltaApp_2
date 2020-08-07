SELECT * FROM MEASURE_PRODUCT;


SELECT SPLIT_STR( 'Una Pertinencia/1', '/', 2) as third;


CALL `DeltaBD`.`INSERT_MEASURE`(17, 'pp', 144,1,
								3, 1, null,null,
                               0, 30,30,30,
                               1,
                                '|Una Pertinencia/1', @res);
                                select @res;

UPDATE DeltaBD.PERT_MEASURE
				SET
				PERT_VALUE = item_Value
				WHERE MSR_ID = msrID AND PERT_ID = 
                (SELECT PERT_ID FROM MEASURE_PERTINENCES_VIEW 
                WHERE MSR_ID = msrID AND PDT_RAST_CODE = msrRastCode  AND PERT_DETAIL = item_name);

