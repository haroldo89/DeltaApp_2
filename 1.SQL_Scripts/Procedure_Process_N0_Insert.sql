drop procedure INSERT_PROCESS_N0;

DELIMITER $$

CREATE PROCEDURE  INSERT_PROCESS_N0
(
	in procN0_name varchar(45),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N0 where (PROC_N0_NAME = procN0_name)) THEN
		set resultMessage = 'El Nombre del Proceso Ingresado ya existe en el sistema';
    ELSEIF EXISTS (SELECT * from PROCESS_N1 where (PROC_N1_NAME = procN0_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N1';
    ELSEIF EXISTS (SELECT * from PROCESS_N2 where (PROC_N2_NAME = procN0_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N2';
    ELSEIF EXISTS (SELECT * from PROCESS_N3 where (PROC_N3_NAME = procN0_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N3';
    ELSE
		insert	into PROCESS_N0 (PROC_N0_NAME) values(procN0_name);
	END IF;
	
END

