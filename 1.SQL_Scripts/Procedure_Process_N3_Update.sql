DROP PROCEDURE UPDATE_PROCESS_N3;
DELIMITER $$
CREATE PROCEDURE  UPDATE_PROCESS_N3
(
	in procID int,
    in newProcFatherid int,
    in newProcDetail varchar(45),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N3 where (PROCESS_N3.PROC_N3_ID = procID)) THEN
		
        IF EXISTS (SELECT * from PROCESS_N0 where (PROC_N0_NAME = procID)) THEN
			
            set resultMessage = 'Ya existe, una Proceso con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from PROCESS_N1 where (PROC_N1_NAME = procID)) THEN
			
            set resultMessage = 'Ya existe, una Procedimiento N1 con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from PROCESS_N2 where (PROC_N2_NAME = procID)) THEN
			
            set resultMessage = 'Ya existe, una Procedimiento N2 con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from PROCESS_N3 where (PROC_N3_NAME = procID)) THEN
			
            set resultMessage = 'Ya existe, una Procedimiento N3 con Este Nombre';
            
        ELSEIF exists (SELECT * FROM PROCESS_N2 WHERE (PROC_N2_ID = newProcFatherid)) THEN        
			update PROCESS_N3 SET PROC_N3_NAME = newProcDetail, PROC_N2_ID =newProcFatherid  WHERE PROC_N3_ID = procID;
		ELSE   
			set resultMessage = 'el Procedimiento N2 no existe';
        END IF;
    ELSE
		set resultMessage = 'Registro No Existe en el Sistema';
    END IF;
END