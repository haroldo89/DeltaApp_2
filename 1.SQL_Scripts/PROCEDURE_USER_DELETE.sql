DROP PROCEDURE DELETE_USER;
DELIMITER $$
CREATE PROCEDURE  DELETE_USER
(
	in userID int(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from USER where (USR_ID = userID)) THEN
    
		IF EXISTS (SELECT * from MEASURE_PRODUCT where (USR_ID = userID)) THEN
			
            set resultMessage = 'No es posible borrar el Usuario, 
								 Existen Registros Asociados a este';
        
        ELSE
			
            DELETE FROM USER WHERE (USR_ID = userId);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END