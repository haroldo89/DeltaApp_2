DROP PROCEDURE INSERT_AREA;
DELIMITER $$
CREATE PROCEDURE  INSERT_AREA
(
	in areaNAME varchar(45),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from AREA where (AREA_NAME = areaName)) THEN
		set resultMessage = 'Ya Existe un Area con ese nombre';
    ELSEIF EXISTS (SELECT * from DIVISION_N1 where (DIV_N1_NAME = areaName)) THEN
		set resultMessage = 'Ya Existe una Division N1 con ese nombre';
    ELSEIF EXISTS (SELECT * from DIVISION_N2 where (DIV_N2_NAME = areaName)) THEN
		set resultMessage = 'Ya Existe una Division N2 con ese nombre';
    ELSEIF EXISTS (SELECT * from DIVISION_N3 where (DIV_N3_NAME = areaName)) THEN
		set resultMessage = 'Ya Existe una Division N3 con ese nombre';
    ELSE
		insert	into AREA (AREA_NAME) values(areaNAME);
	END IF;
	
END

