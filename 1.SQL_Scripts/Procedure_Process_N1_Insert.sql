drop procedure INSERT_PROCESS_N1;

DELIMITER $$

CREATE PROCEDURE  INSERT_PROCESS_N1
(
	in procN1_name varchar(45),
    in procN0_ID INT,
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N0 where (PROC_N0_NAME = procN1_name)) THEN
		set resultMessage = 'El Nombre del Proceso ya esta Asociado a un Proceso';
    ELSEIF EXISTS (SELECT * from PROCESS_N1 where (PROC_N1_NAME = procN1_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N1';
    ELSEIF EXISTS (SELECT * from PROCESS_N2 where (PROC_N2_NAME = procN1_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N2';
    ELSEIF EXISTS (SELECT * from PROCESS_N3 where (PROC_N3_NAME = procN1_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N3';
    ELSEIF NOT EXISTS (SELECT * from PROCESS_N0 where (PROC_N0_ID = procN0_ID)) THEN
		set resultMessage = 'El Proceso no existe';
    ELSE
		insert	into PROCESS_N1 (PROC_N1_NAME,PROC_N0_ID) values(procN1_name,procN0_ID);
	END IF;
	
END