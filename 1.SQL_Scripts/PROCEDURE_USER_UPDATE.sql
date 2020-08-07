DROP PROCEDURE UPDATE_USER;
DELIMITER $$
CREATE PROCEDURE  UPDATE_USER
(
	in usrID int,
    in newUserDocument varchar(15),
    in newUserName varchar(15),
    in newUserPu varchar (15),
    in newUserMail varchar (15),
    in newUserNick varchar(15),
    in newUserPass varchar(10),
    in newUserActive bool,
    in newUserType int,
    
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from USER where (USR_ID = usrID)) THEN
		
        IF EXISTS (SELECT * from USER where (USR_DOCUMENT = newUserDocument AND USR_ID != usrID)) THEN
			
            set resultMessage = 'Ya existe, un usuario con Este Documento';
            
        ELSEIF EXISTS (SELECT * from USER where (USR_NICK = newUserNick AND USR_ID != usrID))  THEN
			
            set resultMessage = 'Ya existe, un Usuario con este Nick';
            
        ELSE
        
			update USER SET USR_DOCUMENT = newUserDocument, USR_NAME = newUserName, 
            USR_PU = newUserPu, USR_MAIL = newUserMail, USR_NICK = newUserNick, 
            USR_PASS = newUserPass, USR_ACTIVE = newUserActive, USR_TYPE = newUserType
            WHERE USR_ID = usrID;
        
        END IF;
    ELSE
		set resultMessage = 'Registro No Existe en el Sistema';
    END IF;
END
