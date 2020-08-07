DROP PROCEDURE INSERT_PRODUCT;
DELIMITER $$
CREATE PROCEDURE INSERT_PRODUCT
(

	in pdtName	 		VARCHAR(50),
    in pdtHasCode 		TINYINT(1),
    in pdtSigla			VARCHAR(20),
    in procN0_ID		INT,
    in procN1_ID		INT,
    in procN2_ID		INT,
    in procN3_ID		INT,
    in pdtDesc	 		VARCHAR(100),
    in pdtOP_Type		INT,
    in pdtAcc_Date		DATETIME,
    in pdtPoint_Ref		VARCHAR(50),
    in pdtDays			INT,
    in pdtHours			INT,
    in pdtMinutes		INT,
    in pdtGoal_type		INT,
    in pdtQuant_Mont	INT,
    in pdtGoal_Pob		VARCHAR(50),
    in pdtGoal_index	INT,
    in pdtGoal_Samples	INT,
    in inputText		VARCHAR(20000),
    
	out ResultMessage 	VARCHAR (200)
)
BEGIN

DECLARE delChar VARCHAR (1);

DECLARE item VARCHAR(2000);

IF EXISTS (SELECT * FROM PRODUCT WHERE PDT_NAME = pdtName) THEN
	SET ResultMessage = 'Ya Existe in Registro con este nombre';
ELSEIF EXISTS (SELECT * FROM PRODUCT WHERE PDT_SIGLA = pdtSigla) THEN
	SET ResultMessage = 'Ya Existe in Registro con esta Sigla 1';
ELSEIF procN0_ID = NULL THEN
	SET ResultMessage = 'Ingrese un Proceso para el Producto';
ELSEIF NOT EXISTS(SELECT * FROM OPORTUNITY_TYPE WHERE OP_TYPE_ID = pdtOP_Type) THEN
	SET ResultMessage = 'Ingrese un tipo de Oportunidad';
ELSEIF  pdtOP_Type = 3 AND   pdtAcc_Date = NULL THEN
	SET ResultMessage = 'Ingrese una Fecha Valida';
ELSEIF pdtGoal_type = 1 AND pdtQuant_Mont <= 0 THEN
	SET ResultMessage = 'Ingrese Una Cantidad de Muestras a Medir por Mes';
ELSEIF pdtGoal_type = 2 AND pdtGoal_Samples <= 0 THEN
	SET ResultMessage = 'Ingrese Una Cantidad de Muestras a Medir';
ELSE

INSERT INTO planhnd_DeltaBD.`PRODUCT` (`PDT_NAME`,  `PDT_HASCODE`, PDT_SIGLA,
								PDT_DESC,`PROC_N0_ID`, `PROC_N1_ID`, `PROC_N2_ID`,
                                `PROC_N3_ID`, `PDT_OPORTUNITY_TYPE`, `PDT_OPORTUNITY_DATE_ACCORDED`,
                                `PDT_OPORTUNITY_PTO_REF`, `PDT_OPORTUNITY_DAYS`, `PDT_OPORTUNITY_HOURS`,
                                `PDT_OPORTUNITY_MINUTES`, `GOAL_TYPE_ID`, `GOAL_QUANTITY_MONTH`,
                                `GOAL_POBLATION`, `GOAL_CONFIABILITY_INDEX`, `GOAL_SAMPLES`) 
						VALUES ( pdtName, pdtHasCode, pdtSigla,
								pdtDesc,procN0_ID, procN1_ID, procN2_ID, 
                                procN3_ID, pdtOP_Type, pdtAcc_Date,
                                pdtPoint_Ref, pdtDays, pdtHours,
                                pdtMinutes, pdtGoal_type, pdtQuant_Mont,
                                pdtGoal_Pob, pdtGoal_index, pdtGoal_Samples);
END IF;

IF EXISTS(SELECT PDT_ID FROM PRODUCT WHERE PDT_NAME = pdtName)THEN

SET delChar = '|';
WHILE LOCATE(delChar,inputText) != 0 DO
 
    	SET item = RTRIM(LTRIM(SUBSTRING(inputText,1, LOCATE(delChar,inputText) - 1)));
    	SET inputText = RTRIM(LTRIM(SUBSTRING(inputText, LOCATE(delChar, inputText) + LENGTH(delChar), LENGTH(inputText))));
    	
    	IF length(item) > 0 THEN
				IF EXISTS(SELECT * FROM PERTINENCES WHERE PERT_DETAIL = item) then
					
					  IF NOT EXISTS(SELECT * FROM DETAIL_PERT_PRODUCT 
										WHERE ID_PERTINENCE = (SELECT PERT_ID FROM PERTINENCES WHERE PERT_DETAIL = item LIMIT 1) 
										AND PDT_ID = (SELECT PDT_ID FROM PRODUCT WHERE PDT_NAME = pdtName LIMIT 1))THEN
					  
							insert Into DETAIL_PERT_PRODUCT (ID_PERTINENCE,PDT_ID) 
								values ((select PERT_ID from PERTINENCES where PERT_DETAIL = item LIMIT 1),
										(SELECT PDT_ID FROM PRODUCT WHERE PDT_NAME = pdtName LIMIT 1)) ;
					END IF;
					
			ELSE
           
			INSERT INTO PERTINENCES (PERT_DETAIL) SELECT item;
			
           insert Into DETAIL_PERT_PRODUCT (ID_PERTINENCE,PDT_ID) 
				values ((select PERT_ID from PERTINENCES where PERT_DETAIL = item LIMIT 1) ,
						(SELECT PDT_ID FROM PRODUCT WHERE PDT_NAME = pdtName LIMIT 1));
			end if;
        end if;
        
	END WHILE;
    
  IF length(inputText) > 0 then
    
		IF EXISTS(SELECT * FROM PERTINENCES WHERE PERT_DETAIL = inputText) then
			 
					  IF NOT EXISTS(SELECT * FROM DETAIL_PERT_PRODUCT 
										WHERE ID_PERTINENCE = (SELECT PERT_ID FROM PERTINENCES WHERE PERT_DETAIL = inputText LIMIT 1) 
										AND PDT_ID = (SELECT PDT_ID FROM PRODUCT WHERE PDT_NAME = pdtName LIMIT 1))THEN
						 
							insert Into DETAIL_PERT_PRODUCT (ID_PERTINENCE,PDT_ID) 
								values ((select PERT_ID from PERTINENCES where PERT_DETAIL = inputText LIMIT 1),
										(SELECT PDT_ID FROM PRODUCT WHERE PDT_NAME = pdtName LIMIT 1)) ;
					END IF;
					
			ELSE
               
			INSERT INTO PERTINENCES (PERT_DETAIL) SELECT inputText;
			 
            insert Into DETAIL_PERT_PRODUCT (ID_PERTINENCE,PDT_ID) 
				values ((select PERT_ID from PERTINENCES where PERT_DETAIL = inputText LIMIT 1) ,
						(SELECT PDT_ID FROM PRODUCT WHERE PDT_NAME = pdtName LIMIT 1));
			end if;
	end if;
    
ELSE
   SET ResultMessage = 'WAIT';
	   IF EXISTS (SELECT * FROM PRODUCT WHERE PDT_NAME = pdtName) THEN
		SET ResultMessage = 'Ya Existe in Registro con este nombre';
	ELSEIF EXISTS (SELECT * FROM PRODUCT WHERE PDT_SIGLA = pdtSigla) THEN
		SET ResultMessage = 'Ya Existe in Registro con esta Sigla_';
	ELSEIF procN0_ID = NULL THEN
		SET ResultMessage = 'Ingrese un Proceso para el Producto';
	ELSEIF NOT EXISTS(SELECT * FROM OPORTUNITY_TYPE WHERE OP_TYPE_ID = pdtOP_Type) THEN
		SET ResultMessage = 'Ingrese un tipo de Oportunidad';
	ELSEIF  pdtOP_Type = 3 AND   pdtAcc_Date = NULL THEN
		SET ResultMessage = 'Ingrese una Fecha Valida';
	ELSEIF pdtGoal_type = 1 AND pdtQuant_Mont <= 0 THEN
		SET ResultMessage = 'Ingrese Una Cantidad de Muestras a Medir por Mes';
	ELSEIF pdtGoal_type = 2 AND pdtGoal_Samples <= 0 THEN
		SET ResultMessage = 'Ingrese Una Cantidad de Muestras a Medir';
   END IF;
   
END IF;  

END;
