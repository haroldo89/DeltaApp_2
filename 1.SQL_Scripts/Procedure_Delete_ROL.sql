DROP PROCEDURE DELETE_ROL;
DELIMITER $$
CREATE PROCEDURE  DELETE_ROL
(
	in rolID varchar(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from ROL where (ROL_ID = rolID)) THEN
    
		IF EXISTS (SELECT * from USER where (ROL_ID = rolID)) THEN
			
            set resultMessage = 'No es posible borrar el registro, 
								 Existen Usuarios Asociados a este';
        
        ELSEIF EXISTS (SELECT * from MEASURE_PRODUCT where (ROL_ID = rolID)) THEN
			
            set resultMessage = 'No es posible borrar el registro, 
								 Existen Productos Asociados a este';
        
        ELSE
			
            DELETE FROM ROL WHERE (ROL_ID = rolId);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END