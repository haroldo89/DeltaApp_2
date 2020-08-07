DROP PROCEDURE UPDATE_PRODUCT;
DELIMITER $$
CREATE PROCEDURE  UPDATE_PRODUCT
(
	in pdtId				INT,
	in NewPdtName	 		VARCHAR(50),
    in NewPdtSigla	 		VARCHAR(20),
    in NewPdtHasCode 		TINYINT(1),
    in NewProcN0_ID			INT,
    in NewProcN1_ID			INT,
    in NewProcN2_ID			INT,
    in NewProcN3_ID			INT,
    in NewProcDesc			VARCHAR(100),
    in NewPdtOP_Type		INT,
    in NewPdtAcc_Date		DATETIME,
    in NewPdtPoint_Ref		VARCHAR(10),
    in NewPdtDays			INT,
    in NewPdtHours			INT,
    in NewPdtMinutes		INT,
    in NewPdtGoal_type		INT,
    in NewPdtQuant_Mont	INT,
    in NewPdtGoal_Pob		VARCHAR(50),
    in NewPdtGoal_index	INT,
    in NewPdtGoal_Samples	INT,
    in inputText		VARCHAR(2000),
    
	out ResultMessage 	VARCHAR (200)
)
BEGIN

DECLARE item VARCHAR(2000);
DECLARE DELCHAR VARCHAR(1);
IF (SELECT COUNT(*) FROM PRODUCT WHERE PRODUCT.PDT_SIGLA = NewPdtSigla AND PDT_ID != pdtId) > 0 THEN
	SET ResultMessage = 'Ya existe un Producto asociado a este codigo de Rastreo';
    /*SET ResultMessage = NewPdtSigla;*/
ELSEIF  NewpdtOP_Type = 3 AND   NewpdtAcc_Date = NULL THEN
	SET ResultMessage = 'Ingrese una Fecha Valida';
ELSEIF NewpdtGoal_type = 1 AND NewpdtQuant_Mont <= 0 THEN
	SET ResultMessage = 'Ingrese Una Cantidad de Muestras a Medir por Mes';
ELSEIF NewpdtGoal_type = 2 AND NewpdtGoal_Samples <= 0 THEN
	SET ResultMessage = 'Ingrese Una Cantidad de Muestras a Medir';
ELSE

		UPDATE PRODUCT
		SET
		PDT_NAME 						= NewPdtName,
		PDT_SIGLA 					= NewPdtSigla,
		PDT_HASCODE 					= NewPdtHasCode,
		PROC_N0_ID 					= NewProcN0_ID,
		PROC_N1_ID 					= NewProcN1_ID,
		PROC_N2_ID 					= NewProcN2_ID,
		PROC_N3_ID 					= NewProcN3_ID,
        PDT_DESC 					= NewProcDesc,
		PDT_OPORTUNITY_TYPE 			= NewPdtOP_Type,
		PDT_OPORTUNITY_DATE_ACCORDED 	= NewPdtAcc_Date,
		PDT_OPORTUNITY_PTO_REF 		= NewPdtPoint_Ref,
		PDT_OPORTUNITY_DAYS 			= NewPdtDays,
		PDT_OPORTUNITY_HOURS 			= NewPdtHours,
		PDT_OPORTUNITY_MINUTES			= NewPdtMinutes,
		GOAL_TYPE_ID					= NewPdtGoal_type,
		GOAL_QUANTITY_MONTH 			= NewPdtQuant_Mont,
		GOAL_POBLATION 				= NewPdtGoal_Pob,
		GOAL_CONFIABILITY_INDEX 		= NewPdtGoal_index,
		GOAL_SAMPLES 					= NewPdtGoal_Samples
		WHERE PDT_ID 					= pdtId;
        
        
        DELETE FROM DeltaBD.DETAIL_PERT_PRODUCT WHERE DETAIL_PERT_PRODUCT.PDT_ID = pdtId;

        
        
SET delChar = '|';
WHILE LOCATE(delChar,inputText) != 0 DO
 
    	SET item = RTRIM(LTRIM(SUBSTRING(inputText,1, LOCATE(delChar,inputText) - 1)));
    	SET inputText = RTRIM(LTRIM(SUBSTRING(inputText, LOCATE(delChar, inputText) + LENGTH(delChar), LENGTH(inputText))));
    	
    	IF length(item) > 0 THEN
				IF EXISTS(SELECT * FROM PERTINENCES WHERE PERT_DETAIL = item) then
			 
					  IF NOT EXISTS(SELECT * FROM DETAIL_PERT_PRODUCT 
										WHERE ID_PERTINENCE = (SELECT PERT_ID FROM PERTINENCES WHERE PERT_DETAIL = item) 
										AND PDT_ID = (SELECT PDT_ID FROM PRODUCT WHERE PDT_NAME = NewPdtName))THEN
							
							insert Into DETAIL_PERT_PRODUCT (ID_PERTINENCE,PDT_ID) 
								values ((select PERT_ID from PERTINENCES where PERT_DETAIL = item),
										(SELECT PDT_ID FROM PRODUCT WHERE PDT_NAME = NewPdtName)) ;
					END IF;
					
			ELSE
               
			INSERT INTO PERTINENCES (PERT_DETAIL) SELECT item;
            insert Into DETAIL_PERT_PRODUCT (ID_PERTINENCE,PDT_ID) 
				values ((select PERT_ID from PERTINENCES where PERT_DETAIL = item) ,
						(SELECT PDT_ID FROM PRODUCT WHERE PDT_NAME = NewPdtName));
			end if;
        end if;
        
	END WHILE;
    
    IF length(inputText) > 0 then
		IF EXISTS(SELECT * FROM PERTINENCES WHERE PERT_DETAIL = inputText) then
			 
					  IF NOT EXISTS(SELECT * FROM DETAIL_PERT_PRODUCT 
										WHERE ID_PERTINENCE = (SELECT PERT_ID FROM PERTINENCES WHERE PERT_DETAIL = inputText) 
										AND PDT_ID = (SELECT PDT_ID FROM PRODUCT WHERE PDT_NAME = NewPdtName))THEN
							
							insert Into DETAIL_PERT_PRODUCT (ID_PERTINENCE,PDT_ID) 
								values ((select PERT_ID from PERTINENCES where PERT_DETAIL = inputText),
										(SELECT PDT_ID FROM PRODUCT WHERE PDT_NAME = NewPdtName)) ;
					END IF;
					
			ELSE
               
			INSERT INTO PERTINENCES (PERT_DETAIL) SELECT inputText;
            insert Into DETAIL_PERT_PRODUCT (ID_PERTINENCE,PDT_ID) 
				values ((select PERT_ID from PERTINENCES where PERT_DETAIL = inputText) ,
						(SELECT PDT_ID FROM PRODUCT WHERE PDT_NAME = NewPdtName));
			end if;
	end if;

END IF;
END