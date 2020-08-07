DROP PROCEDURE DELETE_PERTINENCE;
DELIMITER $$
CREATE PROCEDURE  DELETE_PERTINENCE
(
	in pertID int(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PERTINENCES where (PERT_ID = pertID)) THEN
    
		IF EXISTS (SELECT * from DETAIL_PERT_PRODUCT where ( ID_PERTINENCE = pertID)) THEN
			
            set resultMessage = 'No es posible borrar el registro, 
								 Existen Registros Asociados a este';
        
        ELSE
			
            DELETE FROM PERTINENCES WHERE (PERT_ID = pertID);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END