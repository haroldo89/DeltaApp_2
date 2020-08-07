DROP PROCEDURE UPDATE_ROL;
DELIMITER $$
CREATE PROCEDURE  UPDATE_ROL
(
	in rolID int,
    in newRolName varchar(45),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from ROL where (ROL_ID = rolID)) THEN
		
        IF EXISTS (SELECT * from ROL where (ROL_NAME = newRolName)) THEN
			
            set resultMessage = 'Ya existe, un rol con Este Nombre';
            
        ELSE
        
			update ROL SET ROL_NAME = newRolName WHERE ROL_ID = rolID;
        
        END IF;
    ELSE
		set resultMessage = 'Registro No Existe en el Sistema';
    END IF;
END