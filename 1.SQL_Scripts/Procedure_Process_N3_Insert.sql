Drop procedure INSERT_PROCESS_N3;
DELIMITER $$

CREATE PROCEDURE  INSERT_PROCESS_N3
(
	in procN3_name varchar(45),
    in procN2_ID int,
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N0 where (PROC_N0_NAME = procN3_name)) THEN
		set resultMessage = 'El Nombre del Proceso Ingresado ya existe en el sistema';
    ELSEIF EXISTS (SELECT * from PROCESS_N1 where (PROC_N1_NAME = procN3_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N1';
    ELSEIF EXISTS (SELECT * from PROCESS_N2 where (PROC_N2_NAME = procN3_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N2';
    ELSEIF EXISTS (SELECT * from PROCESS_N3 where (PROC_N3_NAME = procN3_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N3';
    ELSEIF NOT EXISTS (SELECT * from PROCESS_N2 where (PROC_N2_ID = procN2_ID)) THEN
		set resultMessage = 'El Proceso N2 no existe';
    ELSE
		insert	into PROCESS_N3 (PROC_N3_NAME,PROC_N2_ID) values(procN3_name,procN2_ID);
	END IF;
	
END