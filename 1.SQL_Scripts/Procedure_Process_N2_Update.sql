DROP PROCEDURE UPDATE_PROCESS_N2;
DELIMITER $$
CREATE PROCEDURE  UPDATE_PROCESS_N2
(
	in procID int,
    in newProcDetail varchar(15),
    in newProcFatherid int,
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N2 where (PROC_N2_ID = procID)) THEN
		
        IF EXISTS (SELECT * from PROCESS_N0 where (PROC_N0_NAME = newProcDetail)) THEN
			
            set resultMessage = 'Ya existe, una Proceso con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from PROCESS_N1 where (PROC_N1_NAME = newProcDetail)) THEN
			
            set resultMessage = 'Ya existe, una Procedimiento N1 con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from PROCESS_N2 where (PROC_N2_NAME = newProcDetail)) THEN
			
            set resultMessage = 'Ya existe, una Procedimiento N2 con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from PROCESS_N3 where (PROC_N3_NAME = newProcDetail)) THEN
			
            set resultMessage = 'Ya existe, una Procedimiento N3 con Este Nombre';
            
		ELSEIF exists (SELECT * FROM PROCESS_N1 WHERE (PROC_N1_ID = newProcFatherid)) THEN        
        
			update PROCESS_N2 SET PROC_N2_NAME= newProcDetail, PROC_N1_ID =newProcFatherid  WHERE PROC_N2_ID = procID;
            
		ELSE   
			set resultMessage = 'el Procedimiento N1 no existe';
        END IF;
    ELSE
		set resultMessage = 'Registro No Existe en el Sistema';
    END IF;
END