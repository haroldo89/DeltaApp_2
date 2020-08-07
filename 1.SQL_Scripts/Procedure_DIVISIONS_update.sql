DROP PROCEDURE UPDATE_DIVISION_N1;
DELIMITER $$
CREATE PROCEDURE  UPDATE_DIVISION_N1
(
	in divID int,
    in newDivDetail  varchar(45),
    in newAreaID    int,
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from DIVISION_N1 where (DIV_N1_ID = divID)) THEN
		
        
        
         IF EXISTS (SELECT * from AREA where (AREA_NAME = newDivDetail)) THEN
			
            set resultMessage = 'Ya existe, una Area con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from DIVISION_N1 where (DIV_N1_NAME = newDivDetail AND AREA_ID = 
									(SELECT AREA_ID FROM DIVISION_N1 WHERE DIV_N1_ID = divID ) AND AREA_ID = newAreaID)) THEN
			
            set resultMessage = 'Ya existe, una Division N1 con Este Nombre';
            
			
            
		ELSEIF NOT EXISTS (SELECT * from AREA where (AREA_ID = newAreaID)) THEN
			
            set resultMessage = 'El Area Asociada no Existe';
            
		ELSE
			UPDATE DIVISION_N1 SET DIV_N1_NAME = newDivDetail, AREA_ID = newAreaID WHERE DIV_N1_ID = divID;
        END IF;
    ELSE
		set resultMessage = 'Registro No Existe en el Sistema';
    END IF;
END
DROP PROCEDURE UPDATE_DIVISION_N2;
DELIMITER $$
CREATE PROCEDURE  UPDATE_DIVISION_N2
(
	in divID int,
    in newDivDetail  varchar(45),
    in newDIVFatherID    int,
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from DIVISION_N2 where (DIV_N2_ID = divID)) THEN
		
        
        
         IF EXISTS (SELECT * from AREA where (AREA_NAME = newDivDetail)) THEN
			
            set resultMessage = 'Ya existe, una Area con Este Nombre';
            
		ELSEIF EXISTS (SELECT * from DIVISION_N1 where (DIV_N1_NAME = newDivDetail)) THEN
			
            set resultMessage = 'Ya existe, una dIVISION N1 con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from DIVISION_N2 where (DIV_N2_NAME = newDivDetail AND DIV_N1_ID = 
									(SELECT DIV_N1_ID FROM DIVISION_N2 WHERE DIV_N2_ID = divID) AND DIV_N1_ID = newDIVFatherID)) THEN
			
            set resultMessage = 'Ya existe, una Division N2 con Este Nombre';
            
		ELSEIF NOT EXISTS (SELECT * from DIVISION_N1 where (DIV_N1_ID = newDIVFatherID)) THEN
			
            set resultMessage = 'la Division N1 Asociada no Existe';
            
		ELSE
			UPDATE DIVISION_N2 SET DIV_N2_NAME = newDivDetail, DIV_N1_ID = newDIVFatherID WHERE DIV_N2_ID = divID;
        END IF;
    ELSE
		set resultMessage = 'Registro No Existe en el Sistema';
    END IF;
END
DROP PROCEDURE UPDATE_DIVISION_N3;
DELIMITER $$
CREATE PROCEDURE  UPDATE_DIVISION_N3
(
	in divID int,
    in newDivDetail  varchar(45),
    in newDIVFatherID    int,
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from DIVISION_N3 where (DIV_N3_ID = divID)) THEN
		
        
        
         IF EXISTS (SELECT * from AREA where (AREA_NAME = newDivDetail)) THEN
			
            set resultMessage = 'Ya existe, una Area con Este Nombre';
            
		ELSEIF EXISTS (SELECT * from DIVISION_N1 where (DIV_N1_NAME = newDivDetail)) THEN
			
            set resultMessage = 'Ya existe, una dIVISION N1 con Este Nombre';
            
		ELSEIF EXISTS (SELECT * from DIVISION_N2 where (DIV_N2_NAME = newDivDetail)) THEN
			
            set resultMessage = 'Ya existe, una dIVISION N2 con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from DIVISION_N3 where (DIV_N3_NAME = newDivDetail AND DIV_N2_ID = 
									(SELECT DIV_N2_ID FROM DIVISION_N3 WHERE DIV_N3_ID = divID) AND DIV_N2_ID = newDIVFatherID)) THEN
			
            set resultMessage = 'Ya existe, una Division N3con Este Nombre';
            
		ELSEIF NOT EXISTS (SELECT * from DIVISION_N2 where (DIV_N2_ID = newDIVFatherID)) THEN
			
            set resultMessage = 'la Division N1 Asociada no Existe';
            
		ELSE
			UPDATE DIVISION_N3 SET DIV_N3_NAME = newDivDetail, DIV_N2_ID = newDIVFatherID WHERE DIV_N3_ID = divID;
        END IF;
    ELSE
		set resultMessage = 'Registro No Existe en el Sistema';
    END IF;
END