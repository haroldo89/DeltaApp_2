DROP PROCEDURE spSplitData;
DELIMITER $$
CREATE PROCEDURE spSplitData
(
	in 	inputText VARCHAR (2000),
    in  delChar   VARCHAR (1)
	
)
BEGIN

DECLARE item VARCHAR(2000);

DROP TABLE IF EXISTS elementList;

CREATE TEMPORARY TABLE elementList (item VARCHAR(2000));

WHILE LOCATE(delChar,inputText) != 0 DO
 
    	SET item = RTRIM(LTRIM(SUBSTRING(inputText,1, LOCATE(delChar,inputText) - 1)));
    	SET inputText = RTRIM(LTRIM(SUBSTRING(inputText, LOCATE(delChar, inputText) + LENGTH(delChar), LENGTH(inputText))));
    	
    	IF length(item) > 0 THEN
			INSERT INTO elementList SELECT item;
		end if;
        
	END WHILE;
    
    IF length(inputText) > 0 then
		INSERT INTO elementList SELECT inputText;
	end if;
	
    SELECT * FROM elementList;

END;
delimiter ..


