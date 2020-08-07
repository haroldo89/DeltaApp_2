drop procedure INSERT_USER;

DELIMITER $$

CREATE PROCEDURE  INSERT_USER
(
	in rolID int,
	in userDocument varchar(15),
    in userName varchar(45),
    in userPoblation varchar(15),
    in userEmail varchar(15),
    in userNick varchar(15),
    in userPass varchar(15),
    in userActivate bool,
    in userType int,
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from USER where (USR_DOCUMENT = userDocument)) THEN
		set resultMessage = 'Ya Existe un Usuario con Este Documento';
        
    else if EXISTS (SELECT * from ROL where (ROL_ID = rolID)) THEN
		insert	into USER (ROL_ID, USR_DOCUMENT, USR_NAME, USR_PU, USR_MAIL, USR_NICK, USR_PASS, USR_ACTIVE, USR_TYPE) 
        values(rolID,userDocument,userName,userPoblation,userEmail,userNick,userPass,userActivate,userType);
	else 
		set resultMessage = 'EL ROL NO EXISTE EN EL SISTEMA';
        
    END IF;
	END IF;
END;

