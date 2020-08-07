drop procedure INSERT_ROL;

DELIMITER $$

CREATE PROCEDURE  INSERT_ROL
(
	in rolNAME varchar(45),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from ROL where (ROL_NAME = rolName)) THEN
		set resultMessage = 'El Nombre del Rol Seleccionado ya existe en el sistema';
    ELSE
		insert	into ROL (ROL_NAME) values(rolNAME);
	END IF;
	
END

