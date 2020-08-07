Drop procedure INSERT_PROCESS_N2;
DELIMITER $$
CREATE PROCEDURE  INSERT_PROCESS_N2
(
	in procN2_name varchar(45),
    in procN1_ID int,
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N0 where (PROC_N0_NAME = procN2_name)) THEN
		set resultMessage = 'El Nombre del Proceso ya esta Asociado a un Proceso';
    ELSEIF EXISTS (SELECT * from PROCESS_N1 where (PROC_N1_NAME = procN2_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N1';
    ELSEIF EXISTS (SELECT * from PROCESS_N2 where (PROC_N2_NAME = procN2_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N2';
    ELSEIF EXISTS (SELECT * from PROCESS_N3 where (PROC_N3_NAME = procN2_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N3';
	ELSEIF NOT EXISTS (SELECT * from PROCESS_N1 where (PROC_N1_ID = procN1_ID)) THEN
		set resultMessage = 'El Proceso N1 no existe';
    ELSE
		insert	into PROCESS_N2 (PROC_N2_NAME,PROC_N1_ID) values(procN2_name,procN1_ID);
	END IF;
	
END