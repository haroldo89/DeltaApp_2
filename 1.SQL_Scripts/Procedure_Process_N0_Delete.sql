DROP PROCEDURE DELETE_PROCESS_N0;
DELIMITER $$
CREATE PROCEDURE  DELETE_PROCESS_N0
(
	in procN0_ID int(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N0 where (PROC_N0_ID = procN0_ID)) THEN
    
		IF EXISTS (SELECT * from PROCESS_N1 where (PROC_N0_ID = procN0_ID)) THEN
			
            set resultMessage = 'No es posible borrar el registro, 
								 Existen Procesos N1_Asociados Asociados a este';
        
        ELSEIF EXISTS (SELECT * from PRODUCT where (PROC_N0_ID = procN0_ID)) THEN
        
			set resultMessage = 'No es posible borrar el registro, 
								 Existen Productos Asociados a este';
		else
			
            DELETE FROM PROCESS_N0 WHERE (PROC_N0_ID = procN0_ID);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END
