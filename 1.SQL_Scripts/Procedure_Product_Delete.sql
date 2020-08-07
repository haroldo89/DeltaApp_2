DROP PROCEDURE DELETE_PRODUCT;
DELIMITER $$
CREATE PROCEDURE  DELETE_PRODUCT
(
	in pdt_ID int(15),
    out resultMessage varchar(200)
)
BEGIN
DECLARE pdtID int;
set pdtID = pdt_ID;
	IF EXISTS (SELECT * from PRODUCT where (PDT_ID = pdtID)) THEN
    
		IF (SELECT  count(*) from MEASURE_PRODUCT where (PDT_ID = pdtID)) > 1 THEN
        
       
			set resultMessage = 'No es posible borrar el registro, 
								 Existen Mediciones Asociados a este';
		else
        
			DELETE FROM DETAIL_PERT_PRODUCT WHERE DETAIL_PERT_PRODUCT.PDT_ID = pdtID;
            DELETE FROM ROL_PRODUCT WHERE ROL_PRODUCT.PDT_ID = pdtID;
            DELETE FROM PRODUCT WHERE (PRODUCT.PDT_ID = pdtID);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END

CALL `planhnd_DeltaBD`.`DELETE_PRODUCT`(36, @res);
select @res;
 DELETE FROM PRODUCT WHERE (PRODUCT.PDT_ID = 36);