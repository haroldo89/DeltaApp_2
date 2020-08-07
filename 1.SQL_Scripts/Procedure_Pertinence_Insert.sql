drop procedure INSERT_PERTINENCE;

DELIMITER $$

CREATE PROCEDURE  INSERT_PERTINENCE
(
	in pertDETAIL varchar(45),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PERTINENCES where (PERT_DETAIL = pertDETAIL)) THEN
		set resultMessage = 'El Nombre de la pertinencia  Seleccionado ya existe en el sistema';
    ELSE
		insert	into PERTINENCES (PERT_DETAIL) values(pertDETAIL);
	END IF;
	
END

