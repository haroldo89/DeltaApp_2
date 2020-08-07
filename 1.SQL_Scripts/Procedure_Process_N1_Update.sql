DROP PROCEDURE UPDATE_PROCESS_N1;
DELIMITER $$
CREATE PROCEDURE  UPDATE_PROCESS_N1
(
	in procID int,
    in newProcDetail  varchar(45),
    in newProcN0ID    int,
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N1 where (PROC_N1_ID = procID)) THEN
		
        IF EXISTS (SELECT * from PROCESS_N0 where (PROC_N0_NAME = procID)) THEN
			
            set resultMessage = 'Ya existe, una Proceso con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from PROCESS_N1 where (PROC_N1_NAME = procID)) THEN
			
            set resultMessage = 'Ya existe, una Procedimiento N1 con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from PROCESS_N2 where (PROC_N2_NAME = procID)) THEN
			
            set resultMessage = 'Ya existe, una Procedimiento N2 con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from PROCESS_N3 where (PROC_N3_NAME = procID)) THEN
			
            set resultMessage = 'Ya existe, una Procedimiento N3 con Este Nombre';
            
        ELSEIF EXISTS (SELECT * FROM PROCESS_N0 WHERE (PROC_N0_ID = newProcN0ID)) THEN       
			update PROCESS_N1 SET PROC_N1_NAME = newProcDetail,PROC_N0_ID = newProcN0ID  WHERE PROC_N1_ID = procID;
		ELSE
			set resultMessage = 'El Proceso no Existe';
        END IF;
    ELSE
		set resultMessage = 'Registro No Existe en el Sistema';
    END IF;
END