CALL `DeltaBD`.`INSERT_PRODUCT`('producto_prueba_1150',
								0, 
                                'plog', 
                                2, 
                                2, 
                                2, 
                                null, 
                                'description', 
                                3, 
                                '10/07/16 00:00:00', 
                                '', 
                                null, 
                                null, 
                                null, 
								1, 
								20, 
                                '', 
                                null, 
								null, 
                                "|1-pert|2-perty|3-pert", 
                               @result);
                               select @result;


SELECT PDT_ID FROM PRODUCT WHERE PDT_NAME = 'producto_prueba_9'




INSERT INTO `DeltaBD`.`PRODUCT` (	PDT_NAME, 
									PDT_HASCODE,
									PDT_SIGLA,
									PDT_DESC,
                                    PROC_N0_ID,
                                    PROC_N1_ID,
                                    PROC_N2_ID,
									PROC_N3_ID,
                                    PDT_OPORTUNITY_TYPE, 
                                    PDT_OPORTUNITY_DATE_ACCORDED,
									PDT_OPORTUNITY_PTO_REF,
                                    PDT_OPORTUNITY_DAYS,
                                    PDT_OPORTUNITY_HOURS,
									PDT_OPORTUNITY_MINUTES, 
                                    GOAL_TYPE_ID, 
                                    GOAL_QUANTITY_MONTH,
									GOAL_POBLATION, 
                                    GOAL_CONFIABILITY_INDEX,
                                    GOAL_SAMPLES) 
		
						VALUES ('producto_prueba_3',
								0, 
                                'pp',
                                'description', 
                                2, 
                                2, 
                                2, 
                                null, 
                                3, 
                                '10/07/16 00:00:00', 
                                '', 
                                null, 
                                null, 
                                null, 
								1, 
								20, 
                                '', 
                                null, 
								null);
                                
                                
                                
                                
                                insert Into DETAIL_PERT_PRODUCT (ID_PERTINENCE,PDT_ID) 
							values ((SELECT PDT_ID FROM PRODUCT WHERE PDT_NAME = 'producto_prueba_3'),
									(select PERT_ID from PERTINENCES where PERT_DETAIL = 'Una Pertinencia')) ;
                                    
                                    
                                    
                                    