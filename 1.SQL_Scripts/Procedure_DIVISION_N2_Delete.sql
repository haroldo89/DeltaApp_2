DROP PROCEDURE DELETE_DIVISION_N2;
DELIMITER $$
CREATE PROCEDURE  DELETE_DIVISION_N2
(
	in divN2_ID int(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from DIVISION_N2 where (DIV_N2_ID = divN2_ID)) THEN
    
		IF EXISTS (SELECT * from DIVISION_N3 where (DIV_N2_ID = divN2_ID)) THEN
			
            set resultMessage = 'No es posible borrar el registro, 
								 Existen Divisiones N2_Asociadas Asociados a este';
        
        ELSEIF EXISTS (SELECT * from MEASURE_PRODUCT where (DIV_N2_ID = divN2_ID)) THEN
        
			set resultMessage = 'No es posible borrar el registro, 
								 Existen Mediciones Asociados a este';
		else
			
            DELETE FROM DIVISION_N2 WHERE (DIV_N2_ID = divN2_ID);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END