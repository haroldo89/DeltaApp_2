DROP PROCEDURE DELETE_DIVISION_N3;
DELIMITER $$
CREATE PROCEDURE  DELETE_DIVISION_N3
(
	in divN3_ID int(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from DIVISION_N3 where (DIV_N3_ID = divN3_ID)) THEN
    
		IF EXISTS (SELECT * from MEASURE_PRODUCT where (DIV_N3_ID = divN3_ID)) THEN
        
			set resultMessage = 'No es posible borrar el registro, 
								 Existen Mediciones Asociados a este';
		else
			
            DELETE FROM DIVISION_N3 WHERE (DIV_N3_ID = divN3_ID);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END