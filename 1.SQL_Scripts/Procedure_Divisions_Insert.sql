drop procedure INSERT_DIVISION_N1;

DELIMITER $$

CREATE PROCEDURE  INSERT_DIVISION_N1
(
	in divN1_name varchar(45),
    in areaID INT,
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from AREA where (AREA_NAME = divN1_Name)) THEN
		set resultMessage = 'El Nombre de la Division ya esta Asociado a un Area';
    ELSEIF EXISTS (SELECT * from DIVISION_N1 where (DIV_N1_NAME = divN1_name AND AREA_ID = areaID)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a una Division N1';
	ELSE
    
		insert	into DIVISION_N1 (DIV_N1_NAME,AREA_ID) values(divN1_name,areaID);
	END IF;
	
   
END 

drop procedure INSERT_DIVISION_N2;

DELIMITER $$

CREATE PROCEDURE  INSERT_DIVISION_N2
(
	in divN2_name varchar(45),
    in divN1_ID INT,
    out resultMessage varchar(200)
)
BEGIN
IF EXISTS (SELECT * from AREA where AREA_NAME = divN2_Name) THEN
		set resultMessage = 'El Nombre de la Division ya esta Asociado a un Area';
    ELSEIF EXISTS (SELECT * from DIVISION_N1 where DIV_N1_NAME = divN2_Name) THEN
		set resultMessage = 'El Nombre de la Division ya esta Asociado a una Division N1';
    ELSEIF EXISTS (SELECT * from DIVISION_N2 where DIV_N2_NAME = divN2_name AND DIV_N1_ID = divN1_ID) THEN
		set resultMessage = 'El Nombre ya esta Asociado a una Division N2';
    ELSE
		insert	into DIVISION_N2 (DIV_N2_NAME,DIV_N1_ID) values (divN2_name,divN1_ID);
	END IF;
	
   
END 


drop procedure INSERT_DIVISION_N3;

DELIMITER $$

CREATE PROCEDURE  INSERT_DIVISION_N3
(
	in divN3_name varchar(45),
    in divN2_ID INT,
    out resultMessage varchar(200)
)
BEGIN
IF EXISTS (SELECT * from AREA where (AREA_NAME = divN3_Name)) THEN
		set resultMessage = 'El Nombre de la Division ya esta Asociado a un Area';
    ELSEIF EXISTS (SELECT * from DIVISION_N1 where (DIV_N1_NAME = divN3_Name)) THEN
		set resultMessage = 'El Nombre de la Division ya esta Asociado a una Division N1';
    ELSEIF EXISTS (SELECT * from DIVISION_N2 where (DIV_N2_NAME = divN3_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a una Division N2';
    ELSEIF EXISTS (SELECT * from DIVISION_N3 where (DIV_N3_NAME = divN3_name AND DIV_N2_ID = divN2_ID)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a una Division N3';
    ELSEIF NOT EXISTS (SELECT * from DIVISION_N2 where (DIV_N2_ID = divN2_ID)) THEN
		set resultMessage = 'La Division N3, no Existe';
    ELSE
		insert	into DIVISION_N3 (DIV_N3_NAME,DIV_N2_ID) values(divN3_name,divN2_ID);
	END IF;
	
   
END 
