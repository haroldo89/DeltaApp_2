DROP PROCEDURE UPDATE_AREA;
DELIMITER $$
CREATE PROCEDURE  UPDATE_AREA
(
	in areaID int,
    in newAreaName varchar(45),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from AREA where (AREA_ID = areaID)) THEN
		
        IF EXISTS (SELECT * from AREA where (AREA_NAME = newAreaName)) THEN
			
            set resultMessage = 'Ya existe, un Area con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from DIVISION_N1 where (DIV_N1_NAME = newAreaName)) THEN
			set resultMessage = 'Ya Existe una Division N1 con ese nombre';
		ELSEIF EXISTS (SELECT * from DIVISION_N2 where (DIV_N2_NAME = newAreaName)) THEN
			set resultMessage = 'Ya Existe una Division N2 con ese nombre';
		ELSEIF EXISTS (SELECT * from DIVISION_N3 where (DIV_N3_NAME = newAreaName)) THEN
			set resultMessage = 'Ya Existe una Division N3 con ese nombre';
        ELSE
        
			update AREA  SET AREA_NAME = newAreaName WHERE AREA_ID = areaID;
        
        END IF;
    ELSE
		set resultMessage = 'Registro No Existe en el Sistema';
    END IF;
END