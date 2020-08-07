DROP PROCEDURE UPDATE_PERTINENCE;
DELIMITER $$
CREATE PROCEDURE  UPDATE_PERTINENCE
(
	in pertID int,
    in newPertDetail varchar(45),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PERTINENCES where (PERT_ID = pertID)) THEN
		
        IF EXISTS (SELECT * from PERTINENCES where (PERT_DETAIL = newPertDetail)) THEN
			
            set resultMessage = 'Ya existe, una Pertinencia con Este Nombre';
            
        ELSE
        
			update PERTINENCES SET PERT_DETAIL = newPertDetail WHERE PERT_ID = pertID;
        
        END IF;
    ELSE
		set resultMessage = 'Registro No Existe en el Sistema';
    END IF;
END