 DROP PROCEDURE INSERT_MEASURE;
DELIMITER $$
CREATE PROCEDURE INSERT_MEASURE
(
	in pdtID 		INT,
    in pdtInitial	VARCHAR (10),
    in msrRastCode	INT,
    in usrID 		INT,
    in areaID		INT,
    in divN1_ID		INT,	
    in divN2_ID		INT,
    in divN3_ID		INT,
    in delTimely	BOOL,
    in msrDays		INT,
    in msrHours		INT,
    in msrMinutes	INT,
	IN msrIsOK		BOOL,
    IN msrPertOk	int,
    in inputText VARCHAR (50000),
    out resultMessage	VARCHAR(100)
    
    
)
BEGIN
DECLARE repCount INT;
DECLARE succesValidation BOOL;
DECLARE msrOK	BOOL;
DECLARE delChar VARCHAR (1);

DECLARE item VARCHAR(2000);
DECLARE item_name	VARCHAR(2000);
DECLARE item_value	TINYINT(1);

DECLARE msrID		INT;
DECLARE pertID		INT;

SET repCount = 0;
SET succesValidation = false;
SET msrOK = false;

IF NOT EXISTS (SELECT * FROM USER WHERE USR_ID = usrID) THEN
	SET resultMessage = 'No Existe el Usuario';
ELSEIF NOT EXISTS(SELECT * FROM AREA WHERE AREA_ID = areaID) THEN
	SET resultMessage = 'El Area No es Valida';
ELSEIF NOT EXISTS(SELECT * FROM DIVISION_N1 = divN1_ID)	THEN
	SET resultMessage = 'La Division de Nivel 1 no es Valida';
ELSEIF NOT EXISTS(SELECT * FROM DIVISION_N2 = divN2_ID)	THEN
	SET resultMessage = 'La Division de Nivel 2 no es Valida';
ELSEIF delTimely = true AND (msrDays = null OR msrHours = null OR msrMinutes = null) THEN
	SET resultMessage = 'Introduzca un valor para cada Campo de entrega Oportuna, Dias, Horas, Minutos';
ELSEIF delTimely = true AND (msrDays < 0 OR msrHours < 0 OR msrMinutes < 0) THEN
	SET resultMessage = 'El Valor para cada campo de Fecha Oportuna debe ser mayor a 0';
ELSEIF delTimely = true AND (msrDays < 0 OR msrHours < 0 OR msrMinutes < 0) THEN
	SET resultMessage = 'El Valor para cada campo de Fecha Oportuna debe ser mayor a 0';
ELSE
	IF EXISTS (SELECT * FROM MEASURE_PRODUCT WHERE MEASURE_PRODUCT.PDT_RAST_CODE = msrRastCode AND PDT_ID = pdtID) THEN
		SET msrID = (SELECT MSR_ID FROM MEASURE_PRODUCT  WHERE MEASURE_PRODUCT.PDT_RAST_CODE = msrRastCode AND PDT_ID = pdtID);
		SET repCount = (SELECT REPROCES_COUNT FROM MEASURE_PRODUCT WHERE MEASURE_PRODUCT.MSR_ID = msrID) + 1;
        
        SET delChar = '|';
		WHILE LOCATE(delChar,inputText) != 0 DO
			SET item = RTRIM(LTRIM(SUBSTRING(inputText,1, LOCATE(delChar,inputText) - 1)));
			SET inputText = RTRIM(LTRIM(SUBSTRING(inputText, LOCATE(delChar, inputText) + LENGTH(delChar), LENGTH(inputText))));
			SET resultMessage = item
               ;
			IF length(item) > 0 THEN
				SET item_name = (SELECT SPLIT_STR(item, '/', 1));
                SET item_value = (SELECT SPLIT_STR(item, '/', 2));
				SET pertID = (SELECT PERT_ID FROM MEASURE_PERTINENCES_VIEW WHERE MSR_ID = msrID AND PDT_RAST_CODE = msrRastCode  AND PERT_DETAIL = item_name);
				SET SQL_SAFE_UPDATES=0;
               /* SET resultMessage = ( SELECT CONCAT(resultMessage,'-',item_name));*/
              
              SET resultMessage = CONCAT(item_name,item_value,'-',pertID);
                UPDATE planhnd_DeltaBD.PERT_MEASURE
					SET
					PERT_VALUE = item_Value
					WHERE MSR_ID = msrID AND PERT_ID = pertID;
				SET SQL_SAFE_UPDATES=1;
			end if;
			
		END WHILE;
    
		IF length(inputText) > 0 then
			SET item_name = (SELECT SPLIT_STR(inputText, '/', 1));
			SET item_value = (SELECT SPLIT_STR(inputText, '/', 2));
			SET pertID = (SELECT PERT_ID FROM MEASURE_PERTINENCES_VIEW WHERE MSR_ID = msrID AND PDT_RAST_CODE = msrRastCode  AND PERT_DETAIL = item_name);
			SET SQL_SAFE_UPDATES=0;
			UPDATE planhnd_DeltaBD.PERT_MEASURE
				SET
				PERT_VALUE = item_Value
				WHERE MSR_ID = msrID AND PERT_ID = pertID;
			SET SQL_SAFE_UPDATES=1;
		end if;
        SET SQL_SAFE_UPDATES=0;
		UPDATE planhnd_DeltaBD.MEASURE_PRODUCT
			SET
			REPROCES_COUNT = repCount,
			AREA_ID = areaID,
			DIV_N1_ID = divN1_ID,
			DIV_N2_ID = divN2_ID,
			DIV_N3_ID = divN3_ID,
			PDT_DELIVERY_OPT = delTimely,
			MSR_DAYS = msrDays,
			MSR_HOUR = msrHours,
			MSR_MINUTES = msrMinutes,
			MSR_DATE = NOW(),
			MSR_OK = msrIsOK,
			MSR_PERTINENCES_OK = msrPertOk
			WHERE PDT_RAST_CODE = msrRastCode AND MSR_ID = msrID ;
		SET SQL_SAFE_UPDATES=1;

			
			
	ELSE
		
		
		INSERT INTO planhnd_DeltaBD.MEASURE_PRODUCT
		(
			PDT_ID,
			PDT_RAST_CODE,
			USR_ID,
			REPROCES_COUNT,
			AREA_ID,
			DIV_N1_ID,
			DIV_N2_ID,
			DIV_N3_ID,
			PDT_DELIVERY_OPT,
			MSR_DAYS,
			MSR_HOUR,
			MSR_MINUTES,
			MSR_OK,
            MSR_PERTINENCES_OK
		)
		VALUES
		(
			pdtID,
			msrRastCode,
			usrID,
			0,
			areaID,
			divN1_ID,
			divN2_ID,
			divN3_ID,
			delTimely,
			msrDays,
			msrHours,
			msrMinutes,
			msrIsOK,
            msrPertOk
            
		);
		
		SET msrID = (SELECT MSR_ID FROM MEASURE_PRODUCT  WHERE MEASURE_PRODUCT.PDT_RAST_CODE = msrRastCode AND PDT_ID = pdtID);
		SET delChar = '|';
		WHILE LOCATE(delChar,inputText) != 0 DO
			SET item = RTRIM(LTRIM(SUBSTRING(inputText,1, LOCATE(delChar,inputText) - 1)));
			SET inputText = RTRIM(LTRIM(SUBSTRING(inputText, LOCATE(delChar, inputText) + LENGTH(delChar), LENGTH(inputText))));
			
			IF length(item) > 0 THEN
				SET item_name = (SELECT SPLIT_STR(item, '/', 1));
                SET item_value = (SELECT SPLIT_STR(item, '/', 2));
				
				SET pertID =  (SELECT ID_PERTINENCE FROM PRODUCT_PERTINENCES_VIEW WHERE PERT_DETAIL = item_name AND PDT_ID = pdtID);
                INSERT INTO planhnd_DeltaBD.PERT_MEASURE
					(
						MSR_ID,
						PERT_ID,
						PERT_VALUE
					)
					VALUES
					(
						msrID,
						pertID,
						item_Value
					);
						
			end if;
			
		END WHILE;
		
		
		IF length(inputText) > 0 then
			SET item_name = (SELECT SPLIT_STR(inputText, '/', 1));
			SET item_value = (SELECT SPLIT_STR(inputText, '/', 2));
			SET pertID =  (SELECT ID_PERTINENCE FROM PRODUCT_PERTINENCES_VIEW WHERE PERT_DETAIL = item_name AND PDT_ID = pdtID);
			
			INSERT INTO planhnd_DeltaBD.PERT_MEASURE
					(
						MSR_ID,
						PERT_ID,
						PERT_VALUE
					)
					VALUES
					(
						msrID,
						pertID,
						item_Value
					);
		end if;
			
		
	END IF;
END IF;

END;

/*
	Funcion para obtener un campo de texto de una cadena de caracteres separada por un delimitador


DELIMITER $$
CREATE FUNCTION SPLIT_STR(
x VARCHAR(255),
delim VARCHAR(12),
pos INT
)
RETURNS VARCHAR(255)
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
delim, '');
DELIMITER;

drop function SPLIT_STR;
DELIMITER $$
CREATE FUNCTION `SPLIT_STR`(
x VARCHAR(255),
splitChar VARCHAR(12),
pos INT
) RETURNS varchar(255) CHARSET latin1
BEGIN
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, splitChar, pos),
LENGTH(SUBSTRING_INDEX(x, splitChar, pos -1)) + 1),
splitChar, '');
END$$
DELIMITER ;


*/
