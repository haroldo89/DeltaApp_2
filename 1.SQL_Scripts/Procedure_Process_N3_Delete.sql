DROP PROCEDURE DELETE_PROCESS_N3;
DELIMITER $$
CREATE PROCEDURE  DELETE_PROCESS_N3
(
	in procN3_ID int(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N3 where (PROC_N3_ID = procN3_ID)) THEN
    
		IF EXISTS (SELECT * from PRODUCT where (PROC_N3_ID = procN3_ID)) THEN
        
			set resultMessage = 'No es posible borrar el registro, 
								 Existen Productos Asociados a este';
		else
			
            DELETE FROM PROCESS_N3 WHERE (PROC_N3_ID = procN3_ID);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END