DROP PROCEDURE DELETE_PROCESS_N2;
DELIMITER $$
CREATE PROCEDURE  DELETE_PROCESS_N2
(
	in procN2_ID int(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N2 where (PROC_N2_ID = procN2_ID)) THEN
    
		IF EXISTS (SELECT * from PROCESS_N3 where (PROC_N2_ID = procN2_ID)) THEN
			
            set resultMessage = 'No es posible borrar el registro, 
								 Existen Procesos N3_Asociados Asociados a este';
        
        ELSEIF EXISTS (SELECT * from PRODUCT where (PROC_N2_ID = procN2_ID)) THEN
        
			set resultMessage = 'No es posible borrar el registro, 
								 Existen Productos Asociados a este';
		else
			
            DELETE FROM PROCESS_N2 WHERE (PROC_N2_ID = procN2_ID);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END