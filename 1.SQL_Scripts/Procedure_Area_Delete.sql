DROP PROCEDURE DELETE_AREA;
DELIMITER $$
CREATE PROCEDURE  DELETE_AREA
(
	in areaID int(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from AREA where (AREA_ID = areaID)) THEN
    
		IF EXISTS (SELECT * from DIVISION_N1 where (AREA_ID = areaID)) THEN
			
            set resultMessage = 'No es posible borrar el registro, 
								 Existen Divisiones Asociados a este';
        
        ELSEIF EXISTS (SELECT * from MEASURE_PRODUCT where (AREA_ID = areaID)) THEN
			
            set resultMessage = 'No es posible borrar el registro, 
								 Mediciones Asociadas a este';
		ELSE
            DELETE FROM AREA WHERE (AREA_ID = areaId);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END

CALL `planhnd_DeltaBD`.`DELETE_AREA`(11, @res);
select @res;
