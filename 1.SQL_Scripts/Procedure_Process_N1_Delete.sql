DROP PROCEDURE DELETE_PROCESS_N1;
DELIMITER $$
CREATE PROCEDURE  DELETE_PROCESS_N1
(
	in procN1_ID int(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N1 where (PROC_N1_ID = procN1_ID)) THEN
    
		IF EXISTS (SELECT * from PROCESS_N2 where (PROC_N1_ID = procN1_ID)) THEN
			
            set resultMessage = 'No es posible borrar el registro, 
								 Existen Procesos N2_Asociados Asociados a este';
        
         ELSEIF EXISTS (SELECT * from PRODUCT where (PROC_N1_ID = procN1_ID)) THEN
        
			set resultMessage = 'No es posible borrar el registro, 
								 Existen Productos Asociados a este';
		else
			
            DELETE FROM PROCESS_N1 WHERE (PROC_N1_ID = procN1_ID);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END