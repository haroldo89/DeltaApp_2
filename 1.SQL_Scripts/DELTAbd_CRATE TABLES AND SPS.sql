-- MySQL Workbench Synchronization
-- Generated: 2016-08-15 17:06
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Camilo

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `planhnd_DeltaBD` DEFAULT CHARACTER SET latin1 ;

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`AREA` (
  `AREA_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `AREA_NAME` VARCHAR(45) CHARACTER SET 'latin1' NOT NULL,
  PRIMARY KEY (`AREA_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_general_ci;

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`DETAIL_PERT_PRODUCT` (
  `ID_PERTINENCE` INT(11) NOT NULL,
  `PDT_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ID_PERTINENCE`, `PDT_ID`),
  INDEX `fk_DETAIL_PERT_PRODUCT_PERTINENCES1_idx` (`ID_PERTINENCE` ASC),
  INDEX `fk_DETAIL_PERT_PRODUCT_PRODUCT1_idx` (`PDT_ID` ASC),
  CONSTRAINT `fk_DETAIL_PERT_PRODUCT_PERTINENCES1`
    FOREIGN KEY (`ID_PERTINENCE`)
    REFERENCES `planhnd_DeltaBD`.`PERTINENCES` (`PERT_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_DETAIL_PERT_PRODUCT_PRODUCT1`
    FOREIGN KEY (`PDT_ID`)
    REFERENCES `planhnd_DeltaBD`.`PRODUCT` (`PDT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`DIVISION_N1` (
  `DIV_N1_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `DIV_N1_NAME` VARCHAR(45) NULL DEFAULT NULL,
  `AREA_ID` INT(11) NOT NULL,
  PRIMARY KEY (`DIV_N1_ID`),
  INDEX `fk_DIVISION_N1_AREA1_idx` (`AREA_ID` ASC),
  CONSTRAINT `fk_DIVISION_N1_AREA1`
    FOREIGN KEY (`AREA_ID`)
    REFERENCES `planhnd_DeltaBD`.`AREA` (`AREA_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 33
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`DIVISION_N2` (
  `DIV_N2_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `DIV_N2_NAME` VARCHAR(45) CHARACTER SET 'latin1' NOT NULL,
  `DIV_N1_ID` INT(11) NOT NULL,
  PRIMARY KEY (`DIV_N2_ID`),
  INDEX `fk_DIVISION_N2_DIVISION_N11_idx` (`DIV_N1_ID` ASC),
  CONSTRAINT `fk_DIVISION_N2_DIVISION_N11`
    FOREIGN KEY (`DIV_N1_ID`)
    REFERENCES `planhnd_DeltaBD`.`DIVISION_N1` (`DIV_N1_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_general_ci
COMMENT = 'fk';

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`DIVISION_N3` (
  `DIV_N3_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `DIV_N3_NAME` VARCHAR(45) CHARACTER SET 'latin1' NOT NULL,
  `DIV_N2_ID` INT(11) NOT NULL,
  PRIMARY KEY (`DIV_N3_ID`),
  INDEX `fk_DIVISION_N3_DIVISION_N21_idx` (`DIV_N2_ID` ASC),
  CONSTRAINT `fk_DIVISION_N3_DIVISION_N21`
    FOREIGN KEY (`DIV_N2_ID`)
    REFERENCES `planhnd_DeltaBD`.`DIVISION_N2` (`DIV_N2_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_general_ci
COMMENT = 'fk';

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`GOAL_CONFIABILITY_INDEX` (
  `ID_INDEX` INT(11) NOT NULL,
  `INDEX_VALUE` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_INDEX`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`GOAL_TYPE` (
  `GOAL_TYPE_ID` INT(11) NOT NULL,
  `GOAL_TYPE_NAME` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`GOAL_TYPE_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`HISTORY_OPERATIONS` (
  `ID_OPERATION` INT(11) NOT NULL,
  `OPERATION_DESCRIPTION` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_OPERATION`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`MEASURE_PRODUCT` (
  `MSR_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `PDT_ID` INT(11) NOT NULL,
  `PDT_RAST_CODE` VARCHAR(45) NULL DEFAULT NULL,
  `USR_ID` INT(10) NOT NULL,
  `REPROCES_COUNT` INT(11) NULL DEFAULT NULL,
  `AREA_ID` INT(11) NOT NULL,
  `DIV_N1_ID` INT(11) NULL DEFAULT NULL,
  `DIV_N2_ID` INT(11) NULL DEFAULT NULL,
  `DIV_N3_ID` INT(11) NULL DEFAULT NULL,
  `PDT_DELIVERY_OPT` TINYINT(1) NULL DEFAULT NULL,
  `MSR_DAYS` INT(11) NULL DEFAULT NULL,
  `MSR_HOUR` INT(11) NULL DEFAULT NULL,
  `MSR_MINUTES` INT(11) NULL DEFAULT NULL,
  `MSR_OK` TINYINT(1) NULL DEFAULT NULL,
  `MSR_PERTINENCES_OK` INT(11) NULL DEFAULT NULL,
  `MSR_DATE` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`MSR_ID`),
  INDEX `fk_MEASURE_PRODUCT_USER1_idx` (`USR_ID` ASC),
  INDEX `fk_MEASURE_PRODUCT_AREA1_idx` (`AREA_ID` ASC),
  INDEX `fk_MEASURE_PRODUCT_DIVISION_N11_idx` (`DIV_N1_ID` ASC),
  INDEX `fk_MEASURE_PRODUCT_DIVISION_N21_idx` (`DIV_N2_ID` ASC),
  INDEX `fk_MEASURE_PRODUCT_DIVISION_N31_idx` (`DIV_N3_ID` ASC),
  INDEX `fk_MEASURE_PRODUCT_PRODUCT1_idx` (`PDT_ID` ASC),
  CONSTRAINT `fk_MEASURE_PRODUCT_AREA_`
    FOREIGN KEY (`AREA_ID`)
    REFERENCES `planhnd_DeltaBD`.`AREA` (`AREA_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MEASURE_PRODUCT_DIVISION_N1_`
    FOREIGN KEY (`DIV_N1_ID`)
    REFERENCES `planhnd_DeltaBD`.`DIVISION_N1` (`DIV_N1_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MEASURE_PRODUCT_DIVISION_N2_`
    FOREIGN KEY (`DIV_N2_ID`)
    REFERENCES `planhnd_DeltaBD`.`DIVISION_N2` (`DIV_N2_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MEASURE_PRODUCT_DIVISION_N3_`
    FOREIGN KEY (`DIV_N3_ID`)
    REFERENCES `planhnd_DeltaBD`.`DIVISION_N3` (`DIV_N3_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MEASURE_PRODUCT_PRODUCT1`
    FOREIGN KEY (`PDT_ID`)
    REFERENCES `planhnd_DeltaBD`.`PRODUCT` (`PDT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MEASURE_PRODUCT_USER_`
    FOREIGN KEY (`USR_ID`)
    REFERENCES `planhnd_DeltaBD`.`USER` (`USR_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`MODULES` (
  `MODULE_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `MODULE_NAME` VARCHAR(45) NULL DEFAULT NULL,
  `MODULES_ALIAS` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`MODULE_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 20
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`OPORTUNITY_TYPE` (
  `OP_TYPE_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `OP_TYPE_NAME` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`OP_TYPE_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`PERTINENCES` (
  `PERT_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `PERT_DETAIL` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`PERT_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 39
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`PERT_MEASURE` (
  `MSR_ID` INT(11) NOT NULL,
  `PERT_ID` INT(11) NOT NULL,
  `PERT_VALUE` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`MSR_ID`, `PERT_ID`),
  INDEX `fk_PERT_MEASURE_MEASURE_PRODUCT1_idx` (`MSR_ID` ASC),
  INDEX `fk_PERT_MEASURE_PERTINENCES1_idx` (`PERT_ID` ASC),
  CONSTRAINT `fk_PERT_MEASURE_MEASURE_PRODUCT1`
    FOREIGN KEY (`MSR_ID`)
    REFERENCES `planhnd_DeltaBD`.`MEASURE_PRODUCT` (`MSR_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PERT_MEASURE_PERTINENCES1`
    FOREIGN KEY (`PERT_ID`)
    REFERENCES `planhnd_DeltaBD`.`PERTINENCES` (`PERT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`PROCESS_N0` (
  `PROC_N0_ID` INT(10) NOT NULL AUTO_INCREMENT,
  `PROC_N0_NAME` VARCHAR(45) CHARACTER SET 'latin1' NOT NULL,
  PRIMARY KEY (`PROC_N0_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_general_ci;

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`PROCESS_N1` (
  `PROC_N1_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `PROC_N1_NAME` VARCHAR(45) NULL DEFAULT NULL,
  `PROC_N0_ID` INT(10) NOT NULL,
  PRIMARY KEY (`PROC_N1_ID`),
  INDEX `fk_PROCESS_N1_PROCESS1_idx` (`PROC_N0_ID` ASC),
  CONSTRAINT `fk_PROCESS_N1_PROCESS1`
    FOREIGN KEY (`PROC_N0_ID`)
    REFERENCES `planhnd_DeltaBD`.`PROCESS_N0` (`PROC_N0_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`PROCESS_N2` (
  `PROC_N2_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `PROC_N2_NAME` VARCHAR(45) CHARACTER SET 'latin1' NOT NULL,
  `PROC_N1_ID` INT(11) NOT NULL,
  PRIMARY KEY (`PROC_N2_ID`),
  INDEX `fk_PROCESS_N2_PROCESS_N11_idx` (`PROC_N1_ID` ASC),
  CONSTRAINT `fk_PROCESS_N2_PROCESS_N11`
    FOREIGN KEY (`PROC_N1_ID`)
    REFERENCES `planhnd_DeltaBD`.`PROCESS_N1` (`PROC_N1_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_general_ci;

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`PROCESS_N3` (
  `PROC_N3_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `PROC_N3_NAME` VARCHAR(45) CHARACTER SET 'latin1' NOT NULL,
  `PROC_N2_ID` INT(11) NOT NULL,
  PRIMARY KEY (`PROC_N3_ID`),
  INDEX `fk_PROCESS_N2_copy1_PROCESS_N21_idx` (`PROC_N2_ID` ASC),
  CONSTRAINT `fk_PROCESS_N2_copy1_PROCESS_N21`
    FOREIGN KEY (`PROC_N2_ID`)
    REFERENCES `planhnd_DeltaBD`.`PROCESS_N2` (`PROC_N2_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_general_ci;

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`PRODUCT` (
  `PDT_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `PDT_NAME` VARCHAR(45) NULL DEFAULT NULL,
  `PDT_SIGLA` VARCHAR(10) NULL DEFAULT NULL,
  `PDT_HASCODE` TINYINT(1) NOT NULL,
  `PROC_N0_ID` INT(10) NULL DEFAULT NULL,
  `PROC_N1_ID` INT(11) NULL DEFAULT NULL,
  `PROC_N2_ID` INT(11) NULL DEFAULT NULL,
  `PROC_N3_ID` INT(11) NULL DEFAULT NULL,
  `PDT_DESC` VARCHAR(100) NULL DEFAULT NULL,
  `PDT_OPORTUNITY_TYPE` INT(11) NOT NULL,
  `PDT_OPORTUNITY_DATE_ACCORDED` DATE NULL DEFAULT NULL,
  `PDT_OPORTUNITY_PTO_REF` VARCHAR(45) NULL DEFAULT NULL,
  `PDT_OPORTUNITY_DAYS` INT(11) NULL DEFAULT NULL,
  `PDT_OPORTUNITY_HOURS` INT(11) NULL DEFAULT NULL,
  `PDT_OPORTUNITY_MINUTES` INT(11) NULL DEFAULT NULL,
  `GOAL_TYPE_ID` INT(11) NOT NULL,
  `GOAL_QUANTITY_MONTH` VARCHAR(45) NULL DEFAULT NULL,
  `GOAL_POBLATION` VARCHAR(10) NULL DEFAULT NULL,
  `GOAL_CONFIABILITY_INDEX` INT(11) NULL DEFAULT NULL,
  `GOAL_SAMPLES` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`PDT_ID`),
  INDEX `fk_PRODUCT_PROCESS_N01_idx` (`PROC_N0_ID` ASC),
  INDEX `fk_PRODUCT_PROCESS_N11_idx` (`PROC_N1_ID` ASC),
  INDEX `fk_PRODUCT_PROCESS_N21_idx` (`PROC_N2_ID` ASC),
  INDEX `fk_PRODUCT_PROCESS_N31_idx` (`PROC_N3_ID` ASC),
  INDEX `fk_PRODUCT_OPORTUNITY_TYPE1_idx` (`PDT_OPORTUNITY_TYPE` ASC),
  INDEX `fk_PRODUCT_GOAL_TYPE1_idx` (`GOAL_TYPE_ID` ASC),
  INDEX `fk_PRODUCT_GOAL_CONFIABILITY_INDEX1_idx` (`GOAL_CONFIABILITY_INDEX` ASC),
  CONSTRAINT `fk_PRODUCT_GOAL_CONFIABILITY_INDEX1`
    FOREIGN KEY (`GOAL_CONFIABILITY_INDEX`)
    REFERENCES `planhnd_DeltaBD`.`GOAL_CONFIABILITY_INDEX` (`ID_INDEX`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCT_GOAL_TYPE1`
    FOREIGN KEY (`GOAL_TYPE_ID`)
    REFERENCES `planhnd_DeltaBD`.`GOAL_TYPE` (`GOAL_TYPE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCT_OPORTUNITY_TYPE1`
    FOREIGN KEY (`PDT_OPORTUNITY_TYPE`)
    REFERENCES `planhnd_DeltaBD`.`OPORTUNITY_TYPE` (`OP_TYPE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCT_PROCESS_N01`
    FOREIGN KEY (`PROC_N0_ID`)
    REFERENCES `planhnd_DeltaBD`.`PROCESS_N0` (`PROC_N0_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCT_PROCESS_N11`
    FOREIGN KEY (`PROC_N1_ID`)
    REFERENCES `planhnd_DeltaBD`.`PROCESS_N1` (`PROC_N1_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCT_PROCESS_N21`
    FOREIGN KEY (`PROC_N2_ID`)
    REFERENCES `planhnd_DeltaBD`.`PROCESS_N2` (`PROC_N2_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCT_PROCESS_N31`
    FOREIGN KEY (`PROC_N3_ID`)
    REFERENCES `planhnd_DeltaBD`.`PROCESS_N3` (`PROC_N3_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 34
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`ROL` (
  `ROL_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `ROL_NAME` VARCHAR(45) CHARACTER SET 'latin1' NOT NULL,
  PRIMARY KEY (`ROL_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 134
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_general_ci;

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`ROL_PRODUCT` (
  `PDT_ID` INT(11) NOT NULL,
  `ROL_ID` INT(11) NOT NULL,
  PRIMARY KEY (`PDT_ID`, `ROL_ID`),
  INDEX `fk_ROL_PRODUCT_PRODUCT1_idx` (`PDT_ID` ASC),
  INDEX `fk_ROL_PRODUCT_ROL1_idx` (`ROL_ID` ASC),
  CONSTRAINT `fk_ROL_PRODUCT_PRODUCT1`
    FOREIGN KEY (`PDT_ID`)
    REFERENCES `planhnd_DeltaBD`.`PRODUCT` (`PDT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ROL_PRODUCT_ROL1`
    FOREIGN KEY (`ROL_ID`)
    REFERENCES `planhnd_DeltaBD`.`ROL` (`ROL_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`USER` (
  `USR_ID` INT(10) NOT NULL AUTO_INCREMENT,
  `ROL_ID` INT(11) NOT NULL,
  `USR_DOCUMENT` VARCHAR(15) NOT NULL,
  `USR_NAME` VARCHAR(45) NOT NULL,
  `USR_PU` VARCHAR(10) NOT NULL,
  `USR_MAIL` VARCHAR(15) NOT NULL,
  `USR_NICK` VARCHAR(10) NOT NULL,
  `USR_PASS` VARCHAR(10) NOT NULL,
  `USR_ACTIVE` TINYINT(1) NOT NULL,
  `USR_TYPE` INT(11) NOT NULL,
  PRIMARY KEY (`USR_ID`),
  INDEX `fk_USER_ROL1_idx` (`ROL_ID` ASC),
  INDEX `fk_USER_PROFILES1_idx` (`USR_TYPE` ASC),
  CONSTRAINT `fk_USER_PROFILES1`
    FOREIGN KEY (`USR_TYPE`)
    REFERENCES `planhnd_DeltaBD`.`USR_TYPES` (`TYPE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_ROL1`
    FOREIGN KEY (`ROL_ID`)
    REFERENCES `planhnd_DeltaBD`.`ROL` (`ROL_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`USR_MODULES_DETAIL` (
  `USR_TYPES_TYPE_ID` INT(11) NOT NULL,
  `MODULES_MODULE_ID` INT(11) NOT NULL,
  PRIMARY KEY (`USR_TYPES_TYPE_ID`, `MODULES_MODULE_ID`),
  INDEX `fk_USR_MODULES_DETAIL_MODULES1_idx` (`MODULES_MODULE_ID` ASC),
  CONSTRAINT `fk_USR_MODULES_DETAIL_MODULES1`
    FOREIGN KEY (`MODULES_MODULE_ID`)
    REFERENCES `planhnd_DeltaBD`.`MODULES` (`MODULE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USR_MODULES_DETAIL_USR_TYPES1`
    FOREIGN KEY (`USR_TYPES_TYPE_ID`)
    REFERENCES `planhnd_DeltaBD`.`USR_TYPES` (`TYPE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`USR_TYPES` (
  `TYPE_ID` INT(11) NOT NULL,
  `TYPE_NAME` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`TYPE_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`AREA_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`AREA_VIEW` (`AREA_ID` INT, `AREA_NAME` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`DIVISION_N1_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`DIVISION_N1_VIEW` (`DIV_N1_ID` INT, `DIV_N1_NAME` INT, `AREA_ID` INT, `AREA_NAME` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`DIVISION_N2_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`DIVISION_N2_VIEW` (`DIV_N2_ID` INT, `DIV_N2_NAME` INT, `DIV_N1_ID` INT, `DIV_N1_NAME` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`DIVISION_N3_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`DIVISION_N3_VIEW` (`DIV_N3_ID` INT, `DIV_N3_NAME` INT, `DIV_N2_ID` INT, `DIV_N2_NAME` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`EFECTIVITY_OK_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`EFECTIVITY_OK_VIEW` (`MSR_ID` INT, `MSR_DATE` INT, `AREA_NAME` INT, `PDT_NAME` INT, `OK` INT, `TOTAL` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`EFECTIVITY_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`EFECTIVITY_VIEW` (`MSR_ID` INT, `MSR_DATE` INT, `AREA_NAME` INT, `PDT_NAME` INT, `DEFECTS` INT, `TOTAL` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`GENERAL_RESUME_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`GENERAL_RESUME_VIEW` (`PROC_N0_NAME` INT, `PDT_ID` INT, `PDT_NAME` INT, `REPROCES_COUNT` INT, `MEASURES_COUNT` INT, `MEASURES_DEFECTS` INT, `MSR_DATE` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`MEASURE_CODE_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`MEASURE_CODE_VIEW` (`PDT_RAST_CODE` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`MEASURE_NO_PRODUCTS_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`MEASURE_NO_PRODUCTS_VIEW` (`PDT_ID` INT, `PROC_N0_NAME` INT, `PDT_NAME` INT, `MEASURE_GOAL` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`MEASURE_PERTINENCES_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`MEASURE_PERTINENCES_VIEW` (`MSR_ID` INT, `PDT_ID` INT, `PDT_SIGLA` INT, `PDT_RAST_CODE` INT, `PERT_ID` INT, `PERT_DETAIL` INT, `PERT_VALUE` INT, `AREA_ID` INT, `AREA_NAME` INT, `DIV_N1_ID` INT, `DIV_N1_NAME` INT, `DIV_N2_ID` INT, `DIV_N2_NAME` INT, `DIV_N3_ID` INT, `DIV_N3_NAME` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`MEASURE_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`MEASURE_VIEW` (`MSR_ID` INT, `PDT_ID` INT, `PDT_NAME` INT, `PDT_SIGLA` INT, `PDT_RAST_CODE` INT, `USR_ID` INT, `USR_NAME` INT, `REPROCES_COUNT` INT, `AREA_ID` INT, `AREA_NAME` INT, `DIV_N1_ID` INT, `DIV_N1_NAME` INT, `DIV_N2_ID` INT, `DIV_N2_NAME` INT, `DIV_N3_ID` INT, `DIV_N3_NAME` INT, `PDT_DELIVERY_OPT` INT, `MSR_DAYS` INT, `MSR_HOUR` INT, `MSR_MINUTES` INT, `MSR_OK` INT, `MSR_PERTINENCES_OK` INT, `MSR_DATE` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`PERTINENCES_BY_MEASURE_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`PERTINENCES_BY_MEASURE_VIEW` (`MSR_ID` INT, `PDT_RAST_CODE` INT, `PERT_ID` INT, `PERT_DETAIL` INT, `PERT_VALUE` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`PERTINENCES_DEFECTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`PERTINENCES_DEFECTS` (`PERT_DETAIL` INT, `PERT_ID` INT, `PROC_N0_NAME` INT, `PDT_NAME` INT, `TOTAL_NO_OK` INT, `TOTAL_MEDICIONES` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`PERTINENCES_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`PERTINENCES_VIEW` (`PERT_ID` INT, `PERT_DETAIL` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`PROCESS_N0_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`PROCESS_N0_VIEW` (`PROC_N0_ID` INT, `PROC_N0_NAME` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`PROCESS_N1_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`PROCESS_N1_VIEW` (`PROC_N1_ID` INT, `PROC_N1_NAME` INT, `PROC_N0_ID` INT, `PROC_N0_NAME` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`PROCESS_N2_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`PROCESS_N2_VIEW` (`PROC_N2_ID` INT, `PROC_N2_NAME` INT, `PROC_N1_ID` INT, `PROC_N1_NAME` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`PROCESS_N3_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`PROCESS_N3_VIEW` (`PROC_N3_ID` INT, `PROC_N3_NAME` INT, `PROC_N2_ID` INT, `PROC_N2_NAME` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`PRODUCT_DEFECTS_DETAIL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`PRODUCT_DEFECTS_DETAIL` (`PDT_ID` INT, `PROC_N0_ID` INT, `PROC_N0_NAME` INT, `PDT_NAME` INT, `TOTAL_MEASURES` INT, `OP_DEFECTS` INT, `PERT_DEFECTS` INT, `TOTAL_DEFECTS` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`PRODUCT_PERTINENCES_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`PRODUCT_PERTINENCES_VIEW` (`ID_PERTINENCE` INT, `PERT_DETAIL` INT, `PDT_ID` INT, `PDT_NAME` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`PRODUCT_ROL_QUERY_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`PRODUCT_ROL_QUERY_VIEW` (`PDT_ID` INT, `PDT_NAME` INT, `IS_RELATIONED` INT, `TIME_COLUMN` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`PRODUCT_ROL_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`PRODUCT_ROL_VIEW` (`PDT_ID` INT, `PDT_NAME` INT, `ROL_ID` INT, `ROL_NAME` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`PRODUCT_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`PRODUCT_VIEW` (`PDT_ID` INT, `PDT_NAME` INT, `PDT_HASCODE` INT, `PDT_SIGLA` INT, `PROC_N0_ID` INT, `PROC_N0_NAME` INT, `PROC_N1_ID` INT, `PROC_N1_NAME` INT, `PROC_N2_ID` INT, `PROC_N2_NAME` INT, `PROC_N3_ID` INT, `PROC_N3_NAME` INT, `PDT_DESC` INT, `OP_TYPE_ID` INT, `OP_TYPE_NAME` INT, `PDT_OPORTUNITY_DATE_ACCORDED` INT, `PDT_OPORTUNITY_PTO_REF` INT, `PDT_OPORTUNITY_DAYS` INT, `PDT_OPORTUNITY_HOURS` INT, `PDT_OPORTUNITY_MINUTES` INT, `GOAL_TYPE_ID` INT, `GOAL_TYPE_NAME` INT, `GOAL_QUANTITY_MONTH` INT, `GOAL_POBLATION` INT, `GOAL_CONFIABILITY_INDEX` INT, `INDEX_VALUE` INT, `GOAL_SAMPLES` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`ROL_RELATION_MEASURE_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`ROL_RELATION_MEASURE_VIEW` (`MSR_ID` INT, `ROL_NAME` INT, `TOTAL_MEASURES` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`ROL_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`ROL_VIEW` (`ROL_ID` INT, `ROL_NAME` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`USERS_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`USERS_VIEW` (`USR_ID` INT, `ROL_ID` INT, `USR_DOCUMENT` INT, `USR_NAME` INT, `USR_PU` INT, `USR_MAIL` INT, `USR_NICK` INT, `USR_PASS` INT, `USR_ACTIVE` INT, `USR_TYPE` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`USER_PU_RELATION_MEASURE_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`USER_PU_RELATION_MEASURE_VIEW` (`MSR_ID` INT, `USR_PU` INT, `TOTAL_MEASURES` INT);

-- -----------------------------------------------------
-- Placeholder table for view `planhnd_DeltaBD`.`USER_TYPE_MODULES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planhnd_DeltaBD`.`USER_TYPE_MODULES` (`TYPE_ID` INT, `TYPE_NAME` INT, `MODULES_MODULE_ID` INT, `MODULE_NAME` INT, `MODULE_ID` INT, `MODULES_ALIAS` INT);


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`AREA_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`AREA_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`AREA_VIEW` AS select `planhnd_DeltaBD`.`AREA`.`AREA_ID` AS `AREA_ID`,`planhnd_DeltaBD`.`AREA`.`AREA_NAME` AS `AREA_NAME` from `planhnd_DeltaBD`.`AREA`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`DIVISION_N1_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`DIVISION_N1_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`DIVISION_N1_VIEW` AS select `planhnd_DeltaBD`.`DIVISION_N1`.`DIV_N1_ID` AS `DIV_N1_ID`,`planhnd_DeltaBD`.`DIVISION_N1`.`DIV_N1_NAME` AS `DIV_N1_NAME`,`planhnd_DeltaBD`.`DIVISION_N1`.`AREA_ID` AS `AREA_ID`,`planhnd_DeltaBD`.`AREA`.`AREA_NAME` AS `AREA_NAME` from (`planhnd_DeltaBD`.`DIVISION_N1` left join `planhnd_DeltaBD`.`AREA` on((`planhnd_DeltaBD`.`DIVISION_N1`.`AREA_ID` = `planhnd_DeltaBD`.`AREA`.`AREA_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`DIVISION_N2_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`DIVISION_N2_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`DIVISION_N2_VIEW` AS select `planhnd_DeltaBD`.`DIVISION_N2`.`DIV_N2_ID` AS `DIV_N2_ID`,`planhnd_DeltaBD`.`DIVISION_N2`.`DIV_N2_NAME` AS `DIV_N2_NAME`,`planhnd_DeltaBD`.`DIVISION_N2`.`DIV_N1_ID` AS `DIV_N1_ID`,`planhnd_DeltaBD`.`DIVISION_N1`.`DIV_N1_NAME` AS `DIV_N1_NAME` from (`planhnd_DeltaBD`.`DIVISION_N2` left join `planhnd_DeltaBD`.`DIVISION_N1` on((`planhnd_DeltaBD`.`DIVISION_N2`.`DIV_N1_ID` = `planhnd_DeltaBD`.`DIVISION_N1`.`DIV_N1_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`DIVISION_N3_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`DIVISION_N3_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`DIVISION_N3_VIEW` AS select `planhnd_DeltaBD`.`DIVISION_N3`.`DIV_N3_ID` AS `DIV_N3_ID`,`planhnd_DeltaBD`.`DIVISION_N3`.`DIV_N3_NAME` AS `DIV_N3_NAME`,`planhnd_DeltaBD`.`DIVISION_N3`.`DIV_N2_ID` AS `DIV_N2_ID`,`planhnd_DeltaBD`.`DIVISION_N2`.`DIV_N2_NAME` AS `DIV_N2_NAME` from (`planhnd_DeltaBD`.`DIVISION_N3` left join `planhnd_DeltaBD`.`DIVISION_N2` on((`planhnd_DeltaBD`.`DIVISION_N3`.`DIV_N2_ID` = `planhnd_DeltaBD`.`DIVISION_N2`.`DIV_N2_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`EFECTIVITY_OK_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`EFECTIVITY_OK_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`EFECTIVITY_OK_VIEW` AS select `PERTINENCES_BY_MEASURE_VIEW`.`MSR_ID` AS `MSR_ID`,`MEASURE_VIEW`.`MSR_DATE` AS `MSR_DATE`,`MEASURE_VIEW`.`AREA_NAME` AS `AREA_NAME`,`MEASURE_VIEW`.`PDT_NAME` AS `PDT_NAME`,sum(`PERTINENCES_BY_MEASURE_VIEW`.`PERT_VALUE`) AS `OK`,count(0) AS `TOTAL` from (`planhnd_DeltaBD`.`PERTINENCES_BY_MEASURE_VIEW` left join `planhnd_DeltaBD`.`MEASURE_VIEW` on((`MEASURE_VIEW`.`MSR_ID` = `PERTINENCES_BY_MEASURE_VIEW`.`MSR_ID`))) group by `PERTINENCES_BY_MEASURE_VIEW`.`MSR_ID`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`EFECTIVITY_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`EFECTIVITY_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`EFECTIVITY_VIEW` AS select `PERTINENCES_BY_MEASURE_VIEW`.`MSR_ID` AS `MSR_ID`,`MEASURE_VIEW`.`MSR_DATE` AS `MSR_DATE`,`MEASURE_VIEW`.`AREA_NAME` AS `AREA_NAME`,`MEASURE_VIEW`.`PDT_NAME` AS `PDT_NAME`,(count(0) - sum(`PERTINENCES_BY_MEASURE_VIEW`.`PERT_VALUE`)) AS `DEFECTS`,count(0) AS `TOTAL` from (`planhnd_DeltaBD`.`PERTINENCES_BY_MEASURE_VIEW` left join `planhnd_DeltaBD`.`MEASURE_VIEW` on((`MEASURE_VIEW`.`MSR_ID` = `PERTINENCES_BY_MEASURE_VIEW`.`MSR_ID`))) group by `PERTINENCES_BY_MEASURE_VIEW`.`MSR_ID`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`GENERAL_RESUME_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`GENERAL_RESUME_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`GENERAL_RESUME_VIEW` AS select `planhnd_DeltaBD`.`PROCESS_N0`.`PROC_N0_NAME` AS `PROC_N0_NAME`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_ID` AS `PDT_ID`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_NAME` AS `PDT_NAME`,sum(`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`REPROCES_COUNT`) AS `REPROCES_COUNT`,(select count(0) from `planhnd_DeltaBD`.`MEASURE_PRODUCT` where (`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_ID` = `planhnd_DeltaBD`.`PRODUCT`.`PDT_ID`)) AS `MEASURES_COUNT`,(select count(0) from `planhnd_DeltaBD`.`MEASURE_PRODUCT` where ((`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_ID` = `planhnd_DeltaBD`.`PRODUCT`.`PDT_ID`) and (`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_OK` = 0))) AS `MEASURES_DEFECTS`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_DATE` AS `MSR_DATE` from ((`planhnd_DeltaBD`.`PRODUCT` left join `planhnd_DeltaBD`.`PROCESS_N0` on((`planhnd_DeltaBD`.`PROCESS_N0`.`PROC_N0_ID` = `planhnd_DeltaBD`.`PRODUCT`.`PROC_N0_ID`))) left join `planhnd_DeltaBD`.`MEASURE_PRODUCT` on((`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_ID` = `planhnd_DeltaBD`.`PRODUCT`.`PDT_ID`))) where ((select count(0) from `planhnd_DeltaBD`.`MEASURE_PRODUCT` where (`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_ID` = `planhnd_DeltaBD`.`PRODUCT`.`PDT_ID`)) > 0) group by `planhnd_DeltaBD`.`PRODUCT`.`PDT_NAME`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`MEASURE_CODE_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`MEASURE_CODE_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`MEASURE_CODE_VIEW` AS select `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_RAST_CODE` AS `PDT_RAST_CODE` from `planhnd_DeltaBD`.`MEASURE_PRODUCT`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`MEASURE_NO_PRODUCTS_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`MEASURE_NO_PRODUCTS_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`MEASURE_NO_PRODUCTS_VIEW` AS select `PRODUCT_VIEW`.`PDT_ID` AS `PDT_ID`,`PRODUCT_VIEW`.`PROC_N0_NAME` AS `PROC_N0_NAME`,`PRODUCT_VIEW`.`PDT_NAME` AS `PDT_NAME`,(case when isnull(`PRODUCT_VIEW`.`GOAL_QUANTITY_MONTH`) then `PRODUCT_VIEW`.`GOAL_SAMPLES` else `PRODUCT_VIEW`.`GOAL_QUANTITY_MONTH` end) AS `MEASURE_GOAL` from (`planhnd_DeltaBD`.`PRODUCT_VIEW` left join `planhnd_DeltaBD`.`MEASURE_VIEW` on((`PRODUCT_VIEW`.`PDT_ID` = `MEASURE_VIEW`.`PDT_ID`))) where isnull(`MEASURE_VIEW`.`MSR_ID`);


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`MEASURE_PERTINENCES_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`MEASURE_PERTINENCES_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`MEASURE_PERTINENCES_VIEW` AS select `planhnd_DeltaBD`.`PERT_MEASURE`.`MSR_ID` AS `MSR_ID`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_ID` AS `PDT_ID`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_SIGLA` AS `PDT_SIGLA`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_RAST_CODE` AS `PDT_RAST_CODE`,`planhnd_DeltaBD`.`PERT_MEASURE`.`PERT_ID` AS `PERT_ID`,`planhnd_DeltaBD`.`PERTINENCES`.`PERT_DETAIL` AS `PERT_DETAIL`,`planhnd_DeltaBD`.`PERT_MEASURE`.`PERT_VALUE` AS `PERT_VALUE`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`AREA_ID` AS `AREA_ID`,`planhnd_DeltaBD`.`AREA`.`AREA_NAME` AS `AREA_NAME`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N1_ID` AS `DIV_N1_ID`,`planhnd_DeltaBD`.`DIVISION_N1`.`DIV_N1_NAME` AS `DIV_N1_NAME`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N2_ID` AS `DIV_N2_ID`,`planhnd_DeltaBD`.`DIVISION_N2`.`DIV_N2_NAME` AS `DIV_N2_NAME`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N3_ID` AS `DIV_N3_ID`,`planhnd_DeltaBD`.`DIVISION_N3`.`DIV_N3_NAME` AS `DIV_N3_NAME` from (((((((`planhnd_DeltaBD`.`PERT_MEASURE` left join `planhnd_DeltaBD`.`PERTINENCES` on((`planhnd_DeltaBD`.`PERTINENCES`.`PERT_ID` = `planhnd_DeltaBD`.`PERT_MEASURE`.`PERT_ID`))) left join `planhnd_DeltaBD`.`MEASURE_PRODUCT` on((`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_ID` = `planhnd_DeltaBD`.`PERT_MEASURE`.`MSR_ID`))) left join `planhnd_DeltaBD`.`PRODUCT` on((`planhnd_DeltaBD`.`PRODUCT`.`PDT_ID` = `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_ID`))) left join `planhnd_DeltaBD`.`AREA` on((`planhnd_DeltaBD`.`AREA`.`AREA_ID` = `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`AREA_ID`))) left join `planhnd_DeltaBD`.`DIVISION_N1` on((`planhnd_DeltaBD`.`DIVISION_N1`.`DIV_N1_ID` = `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N1_ID`))) left join `planhnd_DeltaBD`.`DIVISION_N2` on((`planhnd_DeltaBD`.`DIVISION_N2`.`DIV_N2_ID` = `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N2_ID`))) left join `planhnd_DeltaBD`.`DIVISION_N3` on((`planhnd_DeltaBD`.`DIVISION_N3`.`DIV_N3_ID` = `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N3_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`MEASURE_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`MEASURE_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`MEASURE_VIEW` AS select `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_ID` AS `MSR_ID`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_ID` AS `PDT_ID`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_NAME` AS `PDT_NAME`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_SIGLA` AS `PDT_SIGLA`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_RAST_CODE` AS `PDT_RAST_CODE`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`USR_ID` AS `USR_ID`,`planhnd_DeltaBD`.`USER`.`USR_NAME` AS `USR_NAME`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`REPROCES_COUNT` AS `REPROCES_COUNT`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`AREA_ID` AS `AREA_ID`,`planhnd_DeltaBD`.`AREA`.`AREA_NAME` AS `AREA_NAME`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N1_ID` AS `DIV_N1_ID`,`planhnd_DeltaBD`.`DIVISION_N1`.`DIV_N1_NAME` AS `DIV_N1_NAME`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N2_ID` AS `DIV_N2_ID`,`planhnd_DeltaBD`.`DIVISION_N2`.`DIV_N2_NAME` AS `DIV_N2_NAME`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N3_ID` AS `DIV_N3_ID`,`planhnd_DeltaBD`.`DIVISION_N3`.`DIV_N3_NAME` AS `DIV_N3_NAME`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_DELIVERY_OPT` AS `PDT_DELIVERY_OPT`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_DAYS` AS `MSR_DAYS`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_HOUR` AS `MSR_HOUR`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_MINUTES` AS `MSR_MINUTES`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_OK` AS `MSR_OK`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_PERTINENCES_OK` AS `MSR_PERTINENCES_OK`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_DATE` AS `MSR_DATE` from ((((((`planhnd_DeltaBD`.`MEASURE_PRODUCT` left join `planhnd_DeltaBD`.`PRODUCT` on((`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_ID` = `planhnd_DeltaBD`.`PRODUCT`.`PDT_ID`))) left join `planhnd_DeltaBD`.`USER` on((`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`USR_ID` = `planhnd_DeltaBD`.`USER`.`USR_ID`))) left join `planhnd_DeltaBD`.`AREA` on((`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`AREA_ID` = `planhnd_DeltaBD`.`AREA`.`AREA_ID`))) left join `planhnd_DeltaBD`.`DIVISION_N1` on((`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N1_ID` = `planhnd_DeltaBD`.`DIVISION_N1`.`DIV_N1_ID`))) left join `planhnd_DeltaBD`.`DIVISION_N2` on((`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N2_ID` = `planhnd_DeltaBD`.`DIVISION_N2`.`DIV_N2_ID`))) left join `planhnd_DeltaBD`.`DIVISION_N3` on((`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N3_ID` = `planhnd_DeltaBD`.`DIVISION_N3`.`DIV_N3_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PERTINENCES_BY_MEASURE_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PERTINENCES_BY_MEASURE_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PERTINENCES_BY_MEASURE_VIEW` AS select `planhnd_DeltaBD`.`PERT_MEASURE`.`MSR_ID` AS `MSR_ID`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_RAST_CODE` AS `PDT_RAST_CODE`,`planhnd_DeltaBD`.`PERT_MEASURE`.`PERT_ID` AS `PERT_ID`,`planhnd_DeltaBD`.`PERTINENCES`.`PERT_DETAIL` AS `PERT_DETAIL`,`planhnd_DeltaBD`.`PERT_MEASURE`.`PERT_VALUE` AS `PERT_VALUE` from ((`planhnd_DeltaBD`.`PERT_MEASURE` left join `planhnd_DeltaBD`.`PERTINENCES` on((`planhnd_DeltaBD`.`PERTINENCES`.`PERT_ID` = `planhnd_DeltaBD`.`PERT_MEASURE`.`PERT_ID`))) left join `planhnd_DeltaBD`.`MEASURE_PRODUCT` on((`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_ID` = `planhnd_DeltaBD`.`PERT_MEASURE`.`MSR_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PERTINENCES_DEFECTS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PERTINENCES_DEFECTS`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PERTINENCES_DEFECTS` AS select `MEASURE_PERTINENCES_VIEW`.`PERT_DETAIL` AS `PERT_DETAIL`,`MEASURE_PERTINENCES_VIEW`.`PERT_ID` AS `PERT_ID`,`PRODUCT_VIEW`.`PROC_N0_NAME` AS `PROC_N0_NAME`,`PRODUCT_VIEW`.`PDT_NAME` AS `PDT_NAME`,(count(0) - sum(`MEASURE_PERTINENCES_VIEW`.`PERT_VALUE`)) AS `TOTAL_NO_OK`,count(0) AS `TOTAL_MEDICIONES` from (`planhnd_DeltaBD`.`MEASURE_PERTINENCES_VIEW` left join `planhnd_DeltaBD`.`PRODUCT_VIEW` on((`PRODUCT_VIEW`.`PDT_ID` = `MEASURE_PERTINENCES_VIEW`.`PDT_ID`))) group by `MEASURE_PERTINENCES_VIEW`.`PERT_DETAIL` order by `TOTAL_NO_OK` desc;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PERTINENCES_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PERTINENCES_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PERTINENCES_VIEW` AS select `planhnd_DeltaBD`.`PERTINENCES`.`PERT_ID` AS `PERT_ID`,`planhnd_DeltaBD`.`PERTINENCES`.`PERT_DETAIL` AS `PERT_DETAIL` from `planhnd_DeltaBD`.`PERTINENCES`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PROCESS_N0_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PROCESS_N0_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PROCESS_N0_VIEW` AS select `COMMIT`.`PROC_N0_ID` AS `PROC_N0_ID`,`COMMIT`.`PROC_N0_NAME` AS `PROC_N0_NAME` from `planhnd_DeltaBD`.`PROCESS_N0` `COMMIT`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PROCESS_N1_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PROCESS_N1_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PROCESS_N1_VIEW` AS select `planhnd_DeltaBD`.`PROCESS_N1`.`PROC_N1_ID` AS `PROC_N1_ID`,`planhnd_DeltaBD`.`PROCESS_N1`.`PROC_N1_NAME` AS `PROC_N1_NAME`,`planhnd_DeltaBD`.`PROCESS_N1`.`PROC_N0_ID` AS `PROC_N0_ID`,`planhnd_DeltaBD`.`PROCESS_N0`.`PROC_N0_NAME` AS `PROC_N0_NAME` from (`planhnd_DeltaBD`.`PROCESS_N1` left join `planhnd_DeltaBD`.`PROCESS_N0` on((`planhnd_DeltaBD`.`PROCESS_N1`.`PROC_N0_ID` = `planhnd_DeltaBD`.`PROCESS_N0`.`PROC_N0_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PROCESS_N2_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PROCESS_N2_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PROCESS_N2_VIEW` AS select `planhnd_DeltaBD`.`PROCESS_N2`.`PROC_N2_ID` AS `PROC_N2_ID`,`planhnd_DeltaBD`.`PROCESS_N2`.`PROC_N2_NAME` AS `PROC_N2_NAME`,`planhnd_DeltaBD`.`PROCESS_N2`.`PROC_N1_ID` AS `PROC_N1_ID`,`planhnd_DeltaBD`.`PROCESS_N1`.`PROC_N1_NAME` AS `PROC_N1_NAME` from (`planhnd_DeltaBD`.`PROCESS_N2` left join `planhnd_DeltaBD`.`PROCESS_N1` on((`planhnd_DeltaBD`.`PROCESS_N2`.`PROC_N1_ID` = `planhnd_DeltaBD`.`PROCESS_N1`.`PROC_N1_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PROCESS_N3_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PROCESS_N3_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PROCESS_N3_VIEW` AS select `planhnd_DeltaBD`.`PROCESS_N3`.`PROC_N3_ID` AS `PROC_N3_ID`,`planhnd_DeltaBD`.`PROCESS_N3`.`PROC_N3_NAME` AS `PROC_N3_NAME`,`planhnd_DeltaBD`.`PROCESS_N3`.`PROC_N2_ID` AS `PROC_N2_ID`,`planhnd_DeltaBD`.`PROCESS_N2`.`PROC_N2_NAME` AS `PROC_N2_NAME` from (`planhnd_DeltaBD`.`PROCESS_N3` left join `planhnd_DeltaBD`.`PROCESS_N2` on((`planhnd_DeltaBD`.`PROCESS_N3`.`PROC_N2_ID` = `planhnd_DeltaBD`.`PROCESS_N2`.`PROC_N2_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PRODUCT_DEFECTS_DETAIL`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PRODUCT_DEFECTS_DETAIL`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PRODUCT_DEFECTS_DETAIL` AS select `PRODUCT_VIEW`.`PDT_ID` AS `PDT_ID`,`PRODUCT_VIEW`.`PROC_N0_ID` AS `PROC_N0_ID`,`PRODUCT_VIEW`.`PROC_N0_NAME` AS `PROC_N0_NAME`,`PRODUCT_VIEW`.`PDT_NAME` AS `PDT_NAME`,count(0) AS `TOTAL_MEASURES`,(count(0) - sum(`MEASURE_VIEW`.`PDT_DELIVERY_OPT`)) AS `OP_DEFECTS`,(count(0) - sum(`MEASURE_VIEW`.`MSR_PERTINENCES_OK`)) AS `PERT_DEFECTS`,((count(0) - sum(`MEASURE_VIEW`.`PDT_DELIVERY_OPT`)) + (count(0) - sum(`MEASURE_VIEW`.`MSR_PERTINENCES_OK`))) AS `TOTAL_DEFECTS` from (`planhnd_DeltaBD`.`MEASURE_VIEW` left join `planhnd_DeltaBD`.`PRODUCT_VIEW` on((`PRODUCT_VIEW`.`PDT_ID` = `MEASURE_VIEW`.`PDT_ID`))) group by `PRODUCT_VIEW`.`PDT_NAME`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PRODUCT_PERTINENCES_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PRODUCT_PERTINENCES_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PRODUCT_PERTINENCES_VIEW` AS select `planhnd_DeltaBD`.`DETAIL_PERT_PRODUCT`.`ID_PERTINENCE` AS `ID_PERTINENCE`,`planhnd_DeltaBD`.`PERTINENCES`.`PERT_DETAIL` AS `PERT_DETAIL`,`planhnd_DeltaBD`.`DETAIL_PERT_PRODUCT`.`PDT_ID` AS `PDT_ID`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_NAME` AS `PDT_NAME` from ((`planhnd_DeltaBD`.`DETAIL_PERT_PRODUCT` left join `planhnd_DeltaBD`.`PERTINENCES` on((`planhnd_DeltaBD`.`PERTINENCES`.`PERT_ID` = `planhnd_DeltaBD`.`DETAIL_PERT_PRODUCT`.`ID_PERTINENCE`))) left join `planhnd_DeltaBD`.`PRODUCT` on((`planhnd_DeltaBD`.`PRODUCT`.`PDT_ID` = `planhnd_DeltaBD`.`DETAIL_PERT_PRODUCT`.`PDT_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PRODUCT_ROL_QUERY_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PRODUCT_ROL_QUERY_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PRODUCT_ROL_QUERY_VIEW` AS select `PRODUCT_VIEW`.`PDT_ID` AS `PDT_ID`,`PRODUCT_VIEW`.`PDT_NAME` AS `PDT_NAME`,(case when (`planhnd_DeltaBD`.`ROL_PRODUCT`.`ROL_ID` = 1) then 1 else 0 end) AS `IS_RELATIONED`,now() AS `TIME_COLUMN` from ((`planhnd_DeltaBD`.`PRODUCT_VIEW` left join `planhnd_DeltaBD`.`ROL_PRODUCT` on((`PRODUCT_VIEW`.`PDT_ID` = `planhnd_DeltaBD`.`ROL_PRODUCT`.`PDT_ID`))) left join `planhnd_DeltaBD`.`ROL_VIEW` on((`ROL_VIEW`.`ROL_ID` = `planhnd_DeltaBD`.`ROL_PRODUCT`.`ROL_ID`))) group by `PRODUCT_VIEW`.`PDT_NAME`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PRODUCT_ROL_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PRODUCT_ROL_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PRODUCT_ROL_VIEW` AS select `PRODUCT_VIEW`.`PDT_ID` AS `PDT_ID`,`PRODUCT_VIEW`.`PDT_NAME` AS `PDT_NAME`,`planhnd_DeltaBD`.`ROL_PRODUCT`.`ROL_ID` AS `ROL_ID`,`ROL_VIEW`.`ROL_NAME` AS `ROL_NAME` from ((`planhnd_DeltaBD`.`PRODUCT_VIEW` left join `planhnd_DeltaBD`.`ROL_PRODUCT` on((`PRODUCT_VIEW`.`PDT_ID` = `planhnd_DeltaBD`.`ROL_PRODUCT`.`PDT_ID`))) left join `planhnd_DeltaBD`.`ROL_VIEW` on((`planhnd_DeltaBD`.`ROL_PRODUCT`.`ROL_ID` = `ROL_VIEW`.`ROL_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PRODUCT_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PRODUCT_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PRODUCT_VIEW` AS select `planhnd_DeltaBD`.`PRODUCT`.`PDT_ID` AS `PDT_ID`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_NAME` AS `PDT_NAME`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_HASCODE` AS `PDT_HASCODE`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_SIGLA` AS `PDT_SIGLA`,`planhnd_DeltaBD`.`PROCESS_N0`.`PROC_N0_ID` AS `PROC_N0_ID`,`planhnd_DeltaBD`.`PROCESS_N0`.`PROC_N0_NAME` AS `PROC_N0_NAME`,`planhnd_DeltaBD`.`PROCESS_N1`.`PROC_N1_ID` AS `PROC_N1_ID`,`planhnd_DeltaBD`.`PROCESS_N1`.`PROC_N1_NAME` AS `PROC_N1_NAME`,`planhnd_DeltaBD`.`PROCESS_N2`.`PROC_N2_ID` AS `PROC_N2_ID`,`planhnd_DeltaBD`.`PROCESS_N2`.`PROC_N2_NAME` AS `PROC_N2_NAME`,`planhnd_DeltaBD`.`PROCESS_N3`.`PROC_N3_ID` AS `PROC_N3_ID`,`planhnd_DeltaBD`.`PROCESS_N3`.`PROC_N3_NAME` AS `PROC_N3_NAME`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_DESC` AS `PDT_DESC`,`planhnd_DeltaBD`.`OPORTUNITY_TYPE`.`OP_TYPE_ID` AS `OP_TYPE_ID`,`planhnd_DeltaBD`.`OPORTUNITY_TYPE`.`OP_TYPE_NAME` AS `OP_TYPE_NAME`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_OPORTUNITY_DATE_ACCORDED` AS `PDT_OPORTUNITY_DATE_ACCORDED`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_OPORTUNITY_PTO_REF` AS `PDT_OPORTUNITY_PTO_REF`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_OPORTUNITY_DAYS` AS `PDT_OPORTUNITY_DAYS`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_OPORTUNITY_HOURS` AS `PDT_OPORTUNITY_HOURS`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_OPORTUNITY_MINUTES` AS `PDT_OPORTUNITY_MINUTES`,`planhnd_DeltaBD`.`PRODUCT`.`GOAL_TYPE_ID` AS `GOAL_TYPE_ID`,`planhnd_DeltaBD`.`GOAL_TYPE`.`GOAL_TYPE_NAME` AS `GOAL_TYPE_NAME`,`planhnd_DeltaBD`.`PRODUCT`.`GOAL_QUANTITY_MONTH` AS `GOAL_QUANTITY_MONTH`,`planhnd_DeltaBD`.`PRODUCT`.`GOAL_POBLATION` AS `GOAL_POBLATION`,`planhnd_DeltaBD`.`PRODUCT`.`GOAL_CONFIABILITY_INDEX` AS `GOAL_CONFIABILITY_INDEX`,`planhnd_DeltaBD`.`GOAL_CONFIABILITY_INDEX`.`INDEX_VALUE` AS `INDEX_VALUE`,`planhnd_DeltaBD`.`PRODUCT`.`GOAL_SAMPLES` AS `GOAL_SAMPLES` from (((((((`planhnd_DeltaBD`.`PRODUCT` left join `planhnd_DeltaBD`.`PROCESS_N0` on((`planhnd_DeltaBD`.`PRODUCT`.`PROC_N0_ID` = `planhnd_DeltaBD`.`PROCESS_N0`.`PROC_N0_ID`))) left join `planhnd_DeltaBD`.`PROCESS_N1` on((`planhnd_DeltaBD`.`PRODUCT`.`PROC_N1_ID` = `planhnd_DeltaBD`.`PROCESS_N1`.`PROC_N1_ID`))) left join `planhnd_DeltaBD`.`PROCESS_N2` on((`planhnd_DeltaBD`.`PRODUCT`.`PROC_N2_ID` = `planhnd_DeltaBD`.`PROCESS_N2`.`PROC_N2_ID`))) left join `planhnd_DeltaBD`.`PROCESS_N3` on((`planhnd_DeltaBD`.`PRODUCT`.`PROC_N3_ID` = `planhnd_DeltaBD`.`PROCESS_N3`.`PROC_N3_ID`))) left join `planhnd_DeltaBD`.`OPORTUNITY_TYPE` on((`planhnd_DeltaBD`.`PRODUCT`.`PDT_OPORTUNITY_TYPE` = `planhnd_DeltaBD`.`OPORTUNITY_TYPE`.`OP_TYPE_ID`))) left join `planhnd_DeltaBD`.`GOAL_TYPE` on((`planhnd_DeltaBD`.`PRODUCT`.`GOAL_TYPE_ID` = `planhnd_DeltaBD`.`GOAL_TYPE`.`GOAL_TYPE_ID`))) left join `planhnd_DeltaBD`.`GOAL_CONFIABILITY_INDEX` on((`planhnd_DeltaBD`.`PRODUCT`.`GOAL_CONFIABILITY_INDEX` = `planhnd_DeltaBD`.`GOAL_CONFIABILITY_INDEX`.`ID_INDEX`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`ROL_RELATION_MEASURE_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`ROL_RELATION_MEASURE_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`ROL_RELATION_MEASURE_VIEW` AS select `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_ID` AS `MSR_ID`,`planhnd_DeltaBD`.`ROL`.`ROL_NAME` AS `ROL_NAME`,(select count(0) from `planhnd_DeltaBD`.`MEASURE_PRODUCT` where (`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`USR_ID` = `planhnd_DeltaBD`.`USER`.`USR_ID`)) AS `TOTAL_MEASURES` from ((`planhnd_DeltaBD`.`MEASURE_PRODUCT` left join `planhnd_DeltaBD`.`USER` on((`planhnd_DeltaBD`.`USER`.`USR_ID` = `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`USR_ID`))) left join `planhnd_DeltaBD`.`ROL` on((`planhnd_DeltaBD`.`ROL`.`ROL_ID` = `planhnd_DeltaBD`.`USER`.`ROL_ID`))) group by `planhnd_DeltaBD`.`USER`.`USR_PU`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`ROL_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`ROL_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`ROL_VIEW` AS select `planhnd_DeltaBD`.`ROL`.`ROL_ID` AS `ROL_ID`,`planhnd_DeltaBD`.`ROL`.`ROL_NAME` AS `ROL_NAME` from `planhnd_DeltaBD`.`ROL`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`USERS_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`USERS_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`USERS_VIEW` AS select `planhnd_DeltaBD`.`USER`.`USR_ID` AS `USR_ID`,`planhnd_DeltaBD`.`USER`.`ROL_ID` AS `ROL_ID`,`planhnd_DeltaBD`.`USER`.`USR_DOCUMENT` AS `USR_DOCUMENT`,`planhnd_DeltaBD`.`USER`.`USR_NAME` AS `USR_NAME`,`planhnd_DeltaBD`.`USER`.`USR_PU` AS `USR_PU`,`planhnd_DeltaBD`.`USER`.`USR_MAIL` AS `USR_MAIL`,`planhnd_DeltaBD`.`USER`.`USR_NICK` AS `USR_NICK`,`planhnd_DeltaBD`.`USER`.`USR_PASS` AS `USR_PASS`,`planhnd_DeltaBD`.`USER`.`USR_ACTIVE` AS `USR_ACTIVE`,`planhnd_DeltaBD`.`USER`.`USR_TYPE` AS `USR_TYPE` from `planhnd_DeltaBD`.`USER`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`USER_PU_RELATION_MEASURE_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`USER_PU_RELATION_MEASURE_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`USER_PU_RELATION_MEASURE_VIEW` AS select `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_ID` AS `MSR_ID`,`planhnd_DeltaBD`.`USER`.`USR_PU` AS `USR_PU`,(select count(0) from `planhnd_DeltaBD`.`MEASURE_PRODUCT` where (`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`USR_ID` = `planhnd_DeltaBD`.`USER`.`USR_ID`)) AS `TOTAL_MEASURES` from (`planhnd_DeltaBD`.`MEASURE_PRODUCT` left join `planhnd_DeltaBD`.`USER` on((`planhnd_DeltaBD`.`USER`.`USR_ID` = `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`USR_ID`))) group by `planhnd_DeltaBD`.`USER`.`USR_PU`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`USER_TYPE_MODULES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`USER_TYPE_MODULES`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`planhnd_deltaUse`@`%` SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`USER_TYPE_MODULES` AS select `planhnd_DeltaBD`.`USR_TYPES`.`TYPE_ID` AS `TYPE_ID`,`planhnd_DeltaBD`.`USR_TYPES`.`TYPE_NAME` AS `TYPE_NAME`,`planhnd_DeltaBD`.`USR_MODULES_DETAIL`.`MODULES_MODULE_ID` AS `MODULES_MODULE_ID`,`planhnd_DeltaBD`.`MODULES`.`MODULE_NAME` AS `MODULE_NAME`,`planhnd_DeltaBD`.`MODULES`.`MODULE_ID` AS `MODULE_ID`,`planhnd_DeltaBD`.`MODULES`.`MODULES_ALIAS` AS `MODULES_ALIAS` from ((`planhnd_DeltaBD`.`USR_MODULES_DETAIL` left join `planhnd_DeltaBD`.`USR_TYPES` on((`planhnd_DeltaBD`.`USR_TYPES`.`TYPE_ID` = `planhnd_DeltaBD`.`USR_MODULES_DETAIL`.`USR_TYPES_TYPE_ID`))) left join `planhnd_DeltaBD`.`MODULES` on((`planhnd_DeltaBD`.`USR_MODULES_DETAIL`.`MODULES_MODULE_ID` = `planhnd_DeltaBD`.`MODULES`.`MODULE_ID`)));

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `DELETE_AREA`(
	in areaID int(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from AREA where (AREA_ID = areaID)) THEN
    
		IF EXISTS (SELECT * from DIVISION_N1 where (AREA_ID = areaID)) THEN
			
            set resultMessage = 'No es posible borrar el registro, 
								 Existen Divisiones Asociados a este';
        
        ELSEIF EXISTS (SELECT * from MEASURE_PRODUCT where (AREA_ID = areaID)) THEN
			
            set resultMessage = 'No es posible borrar el registro, 
								 Mediciones Asociadas a este';
			
            DELETE FROM AREA WHERE (AREA_ID = areaId);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `DELETE_DIVISION_N1`(
	in divN1_ID int(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from DIVISION_N1 where (DIV_N1_ID = divN1_ID)) THEN
    
		IF EXISTS (SELECT * from DIVISION_N2 where (DIV_N1_ID = divN1_ID)) THEN
			
            set resultMessage = 'No es posible borrar el registro, 
								 Existen Divisiones N2_Asociadas Asociados a este';
        
        ELSEIF EXISTS (SELECT * from MEASURE_PRODUCT where (DIV_N1_ID = divN1_ID)) THEN
        
			set resultMessage = 'No es posible borrar el registro, 
								 Existen Mediciones Asociados a este';
		else
			
            DELETE FROM DIVISION_N1 WHERE (DIV_N1_ID = divN1_ID);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `DELETE_DIVISION_N2`(
	in divN2_ID int(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from DIVISION_N2 where (DIV_N2_ID = divN2_ID)) THEN
    
		IF EXISTS (SELECT * from DIVISION_N3 where (DIV_N2_ID = divN2_ID)) THEN
			
            set resultMessage = 'No es posible borrar el registro, 
								 Existen Divisiones N2_Asociadas Asociados a este';
        
        ELSEIF EXISTS (SELECT * from MEASURE_PRODUCT where (DIV_N2_ID = divN2_ID)) THEN
        
			set resultMessage = 'No es posible borrar el registro, 
								 Existen Mediciones Asociados a este';
		else
			
            DELETE FROM DIVISION_N2 WHERE (DIV_N2_ID = divN2_ID);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `DELETE_DIVISION_N3`(
	in divN3_ID int(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from DIVISION_N3 where (DIV_N3_ID = divN3_ID)) THEN
    
		IF EXISTS (SELECT * from MEASURE_PRODUCT where (DIV_N3_ID = divN3_ID)) THEN
        
			set resultMessage = 'No es posible borrar el registro, 
								 Existen Mediciones Asociados a este';
		else
			
            DELETE FROM DIVISION_N3 WHERE (DIV_N3_ID = divN3_ID);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `DELETE_MEASURE`(
	in msrID			int,
    out resultMessage	varchar(200)
)
BEGIN

IF NOT EXISTS (SELECT * FROM MEASURE_PRODUCT WHERE MSR_ID = msrID) THEN
	SET resultMessage = 'El Registro de Medicion no Existe';
ELSE
	DELETE FROM MEASURE_PRODUCT
	WHERE MSR_ID = msrID;
END IF;

END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `DELETE_PERTINENCE`(
	in pertID int(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PERTINENCES where (PERT_ID = pertID)) THEN
    
		IF EXISTS (SELECT * from DETAIL_PERT_PRODUCT where ( ID_PERTINENCE = pertID)) THEN
			
            set resultMessage = 'No es posible borrar el registro, 
								 Existen Registros Asociados a este';
        
        ELSE
			
            DELETE FROM PERTINENCES WHERE (PERT_ID = pertID);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `DELETE_PROCESS_N0`(
	in procN0_ID int(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N0 where (PROC_N0_ID = procN0_ID)) THEN
    
		IF EXISTS (SELECT * from PROCESS_N1 where (PROC_N0_ID = procN0_ID)) THEN
			
            set resultMessage = 'No es posible borrar el registro, 
								 Existen Procesos N1_Asociados Asociados a este';
        
        ELSEIF EXISTS (SELECT * from PRODUCT where (PROC_N0_ID = procN0_ID)) THEN
        
			set resultMessage = 'No es posible borrar el registro, 
								 Existen Productos Asociados a este';
		else
			
            DELETE FROM PROCESS_N0 WHERE (PROC_N0_ID = procN0_ID);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `DELETE_PROCESS_N1`(
	in procN1_ID int(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N1 where (PROC_N1_ID = procN1_ID)) THEN
    
		IF EXISTS (SELECT * from PROCESS_N2 where (PROC_N1_ID = procN1_ID)) THEN
			
            set resultMessage = 'No es posible borrar el registro, 
								 Existen Procesos N2_Asociados Asociados a este';
        
         ELSEIF EXISTS (SELECT * from PRODUCT where (PROC_N1_ID = procN1_ID)) THEN
        
			set resultMessage = 'No es posible borrar el registro, 
								 Existen Productos Asociados a este';
		else
			
            DELETE FROM PROCESS_N1 WHERE (PROC_N1_ID = procN1_ID);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `DELETE_PROCESS_N2`(
	in procN2_ID int(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N2 where (PROC_N2_ID = procN2_ID)) THEN
    
		IF EXISTS (SELECT * from PROCESS_N3 where (PROC_N2_ID = procN2_ID)) THEN
			
            set resultMessage = 'No es posible borrar el registro, 
								 Existen Procesos N3_Asociados Asociados a este';
        
        ELSEIF EXISTS (SELECT * from PRODUCT where (PROC_N2_ID = procN2_ID)) THEN
        
			set resultMessage = 'No es posible borrar el registro, 
								 Existen Productos Asociados a este';
		else
			
            DELETE FROM PROCESS_N2 WHERE (PROC_N2_ID = procN2_ID);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `DELETE_PROCESS_N3`(
	in procN3_ID int(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N3 where (PROC_N3_ID = procN3_ID)) THEN
    
		IF EXISTS (SELECT * from PRODUCT where (PROC_N3_ID = procN3_ID)) THEN
        
			set resultMessage = 'No es posible borrar el registro, 
								 Existen Productos Asociados a este';
		else
			
            DELETE FROM PROCESS_N3 WHERE (PROC_N3_ID = procN3_ID);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `DELETE_PRODUCT`(
	in pdt_ID int(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PRODUCT where (PDT_ID = pdt_ID)) THEN
    
		IF EXISTS (SELECT * from MEASURE_PRODUCT where (PDT_ID = pdt_ID)) THEN
        
			set resultMessage = 'No es posible borrar el registro, 
								 Existen Mediciones Asociados a este';
		else
        
        
			DELETE FROM DETAIL_PERT_PRODUCT WHERE PRODUCT_PDT_ID = pdt_Id;
            DELETE FROM PRODUCT WHERE (PDT_ID = pdt_ID);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `DELETE_ROL`(
	in rolID varchar(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from ROL where (ROL_ID = rolID)) THEN
    
		IF EXISTS (SELECT * from USER where (ROL_ID = rolID)) THEN
			
            set resultMessage = 'No es posible borrar el registro, 
								 Existen Usuarios Asociados a este';
        
        ELSE
			
            DELETE FROM ROL WHERE (ROL_ID = rolId);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `DELETE_USER`(
	in userID int(15),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from USER where (USR_ID = userID)) THEN
    
		IF EXISTS (SELECT * from MEASURE_PRODUCT where (USR_ID = userID)) THEN
			
            set resultMessage = 'No es posible borrar el Usuario, 
								 Existen Registros Asociados a este';
        
        ELSE
			
            DELETE FROM USER WHERE (USR_ID = userId);
			            
        END IF;
        		
    ELSE
    
		set resultMessage = 'Registro No Existe en el Sistema';
        
    END IF;
	
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_AREA_VIEW`(
	
)
BEGIN
	SELECT * FROM AREA_VIEW;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_DIVISION_N1_VIEW`(
	
)
BEGIN
	SELECT * FROM DIVISION_N1_VIEW;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_DIVISION_N2_VIEW`(
	
)
BEGIN
	SELECT * FROM DIVISION_N2_VIEW;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_DIVISION_N3_VIEW`(
	
)
BEGIN
	SELECT * FROM DIVISION_N3_VIEW;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_EFECTIVITY_OK_VIEW`(
	IN dateFrom TIMESTAMP,
    IN dateTo	TIMESTAMP
)
BEGIN
	
   SELECT * FROM EFECTIVITY_OK_VIEW
   WHERE MSR_DATE >= dateFrom AND  MSR_DATE <= dateTo;

END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_EFECTIVITY_VIEW`(
	IN dateFrom TIMESTAMP,
    IN dateTo	TIMESTAMP
)
BEGIN
	
   SELECT * FROM EFECTIVITY_VIEW 
   WHERE DEFECTS > 0
		AND MSR_DATE >= dateFrom AND  MSR_DATE <= dateTo;

END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_GENERAL_RESUME_VIEW`(

)
BEGIN
	SELECT * FROM GENERAL_RESUME_VIEW;
 
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_MEASURE_CODES_VIEW`(
	IN pdtID int
)
BEGIN
	SELECT * FROM MEASURE_VIEW
    WHERE PDT_ID = pdtID;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_MEASURE_PERTINENCES_VIEW`(
	
)
BEGIN
	SELECT * FROM MEASURE_PERTINENCES_VIEW;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_MEASURE_VIEW`(
	
)
BEGIN
	SELECT * FROM MEASURE_VIEW;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_PERTINENCES_DEFECTS`(
	IN dateFrom TIMESTAMP,
    IN dateTo	TIMESTAMP
)
BEGIN
	
    select MEASURE_PERTINENCES_VIEW.PERT_DETAIL, 
		MEASURE_PERTINENCES_VIEW.PERT_ID,
        PRODUCT_VIEW.PROC_N0_NAME,
        PRODUCT_VIEW.PDT_NAME,
        ( COUNT(*) - SUM(MEASURE_PERTINENCES_VIEW.PERT_VALUE)) AS TOTAL_NO_OK,
        ( COUNT(*)) AS 'TOTAL_MEDICIONES'
        FROM MEASURE_PERTINENCES_VIEW
        LEFT JOIN PRODUCT_VIEW ON PRODUCT_VIEW.PDT_ID = MEASURE_PERTINENCES_VIEW.PDT_ID
        LEFT JOIN MEASURE_VIEW ON MEASURE_VIEW.MSR_ID = MEASURE_PERTINENCES_VIEW.MSR_ID
        WHERE MEASURE_VIEW.MSR_DATE >= dateFrom AND MEASURE_VIEW.MSR_DATE <= dateTo
        GROUP BY MEASURE_PERTINENCES_VIEW.PERT_DETAIL
        ORDER BY TOTAL_NO_OK DESC;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_PERTINENCES_VIEW`(
	
)
BEGIN
	SELECT * FROM PERTINENCES_VIEW;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_PERTINENECES_MEASURE_VIEW`(
	
)
BEGIN
	SELECT * FROM PERTINENCES_BY_MEASURE_VIEW;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_PROCESS_N0_VIEW`(
	
)
BEGIN
	SELECT * FROM PROCESS_N0_VIEW;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_PROCESS_N1_VIEW`(
	
)
BEGIN
	SELECT * FROM PROCESS_N1_VIEW;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_PROCESS_N2_VIEW`(
	
)
BEGIN
	SELECT * FROM PROCESS_N2_VIEW;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_PROCESS_N3_VIEW`(
	
)
BEGIN
	SELECT * FROM PROCESS_N3_VIEW;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_PRODUCT_DEFECTS_DETAIL`(
	IN dateFrom TIMESTAMP,
    IN dateTo	TIMESTAMP
)
BEGIN
	   
    SELECT PRODUCT_VIEW.PDT_ID,
		PRODUCT_VIEW.PROC_N0_ID,
		PRODUCT_VIEW.PROC_N0_NAME,
		PRODUCT_VIEW.PDT_NAME,
	   COUNT(*) as 'TOTAL_MEASURES',
	   (COUNT(*) -SUM(PDT_DELIVERY_OPT)) AS 'OP_DEFECTS',
       (COUNT(*) -SUM(MSR_PERTINENCES_OK)) AS 'PERT_DEFECTS',
        ((COUNT(*) -SUM(PDT_DELIVERY_OPT)) + (COUNT(*) -SUM(MSR_PERTINENCES_OK))) AS 'TOTAL_DEFECTS'
       FROM MEASURE_VIEW
       left join PRODUCT_VIEW on PRODUCT_VIEW.PDT_ID = MEASURE_VIEW.PDT_ID
       WHERE MSR_DATE >= dateFrom AND MSR_DATE <= dateTo 
       group by PDT_NAME;
      
  
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_PRODUCT_NO_MEASURE_VIEW`(
)
BEGIN
	
   select 
		PRODUCT_VIEW.PDT_ID,
        PRODUCT_VIEW.PROC_N0_NAME, 
		PRODUCT_VIEW.PDT_NAME, 
		(CASE
        WHEN PRODUCT_VIEW.GOAL_QUANTITY_MONTH IS NULL THEN
            PRODUCT_VIEW.GOAL_SAMPLES
        ELSE
            PRODUCT_VIEW.GOAL_QUANTITY_MONTH
        END) as 'MEASURE_GOAL'
        
        from PRODUCT_VIEW
		left join MEASURE_VIEW 
		ON PRODUCT_VIEW.PDT_ID  = MEASURE_VIEW.PDT_ID
		WHERE MEASURE_VIEW.MSR_ID IS NULL
        ;


END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_PRODUCT_PERTINECES_VIEW`(
	in pdtID int
)
BEGIN
	SELECT * FROM PRODUCT_PERTINENCES_VIEW WHERE PDT_ID = pdtID;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_PRODUCT_ROL_QUERY_VIEW`(
	IN 	rolID	INT
)
BEGIN

	SELECT 	PRODUCT_VIEW.PDT_ID,
		PRODUCT_VIEW.PDT_NAME,
        (CASE
        WHEN ROL_PRODUCT.ROL_ID = rolID THEN
            TRUE
        ELSE
            FALSE
        END) as 'IS_RELATIONED',
                NOW() as 'TIME_COLUMN'
         FROM PRODUCT_VIEW
        LEFT JOIN ROL_PRODUCT ON PRODUCT_VIEW.PDT_ID = ROL_PRODUCT.PDT_ID
        LEFT JOIN ROL_VIEW ON ROL_VIEW.ROL_ID = ROL_PRODUCT.ROL_ID
        group by PRODUCT_VIEW.PDT_NAME;

END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_PRODUCT_ROL_VIEW`(
	
)
BEGIN
	SELECT * FROM PRODUCT_ROL_VIEW;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_PRODUCT_ROL_VIEW_USER`(
	in usrID int
)
BEGIN


	SELECT *
            FROM
            planhnd_DeltaBD.PRODUCT_ROL_VIEW
            WHERE PRODUCT_ROL_VIEW.ROL_ID = 
					(SELECT USERS_VIEW.ROL_ID FROM USERS_VIEW
							WHERE USERS_VIEW.USR_ID = usrID);
         
    
    
    
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_PRODUCT_VIEW`(
	
)
BEGIN
	SELECT * FROM PRODUCT_VIEW;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_ROL_RELATION_MEASURE_VIEW`(
	IN dateFrom TIMESTAMP,
    IN dateTo	TIMESTAMP
)
BEGIN
	
   SELECT 
		MEASURE_PRODUCT.MSR_ID,
        ROL.ROL_NAME,
	   (SELECT COUNT(*) FROM MEASURE_PRODUCT WHERE MEASURE_PRODUCT.USR_ID = USER.USR_ID 
       AND MSR_DATE >= dateFrom AND MSR_DATE <= dateTo ) AS 'TOTAL_MEASURES'
       FROM MEASURE_PRODUCT
       LEFT JOIN USER ON USER.USR_ID = MEASURE_PRODUCT.USR_ID
       LEFT JOIN ROL ON ROL.ROL_ID = USER.ROL_ID
       GROUP BY USER.USR_PU;

END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_ROL_VIEW`(
	
)
BEGIN
	SELECT * FROM ROL_VIEW;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_USERS_VIEW`(
	
)
BEGIN
	SELECT * FROM USERS_VIEW;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_USER_PU_RELATION_MEASURE_VIEW`(
	IN dateFrom TIMESTAMP,
    IN dateTo	TIMESTAMP
)
BEGIN
	
   SELECT 
		MEASURE_PRODUCT.MSR_ID,
		USER.USR_PU,
		(SELECT COUNT(*) FROM MEASURE_PRODUCT WHERE MEASURE_PRODUCT.USR_ID = USER.USR_ID 
			AND MSR_DATE >= dateFrom AND MSR_DATE <= dateTo ) AS 'TOTAL_MEASURES'
        FROM MEASURE_PRODUCT
		LEFT JOIN USER ON USER.USR_ID = MEASURE_PRODUCT.USR_ID
        GROUP BY USER.USR_PU;

END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `GET_USER_TYPE_MODULES`(
	in userTypeID INT
)
BEGIN
	SELECT * FROM USER_TYPE_MODULES
	WHERE TYPE_ID = userTypeID;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `INSERT_AREA`(
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
	
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `INSERT_DIVISION_N1`(
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
	
   
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `INSERT_DIVISION_N2`(
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
	
   
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `INSERT_DIVISION_N3`(
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
	
   
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `INSERT_MEASURE`(
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
    in inputText VARCHAR (2000),
    out resultMessage	VARCHAR(100)
    
    
)
BEGIN
DECLARE repCount INT;
DECLARE succesValidation BOOL;
DECLARE msrOK	BOOL;
DECLARE delChar VARCHAR (1);
DECLARE item VARCHAR(2000);
DECLARE item_name	VARCHAR(50);
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
			
			IF length(item) > 0 THEN
				SET item_name = (SELECT SPLIT_STR(item, '/', 1));
                SET item_value = (SELECT SPLIT_STR(item, '/', 2));
				SET pertID = (SELECT PERT_ID FROM MEASURE_PERTINENCES_VIEW WHERE MSR_ID = msrID AND PDT_RAST_CODE = msrRastCode  AND PERT_DETAIL = item_name);
				SET SQL_SAFE_UPDATES=0;
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

END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `INSERT_PERTINENCE`(
	in pertDETAIL varchar(45),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PERTINENCES where (PERT_DETAIL = pertDETAIL)) THEN
		set resultMessage = 'El Nombre de la pertinencia  Seleccionado ya existe en el sistema';
    ELSE
		insert	into PERTINENCES (PERT_DETAIL) values(pertDETAIL);
	END IF;
	
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `INSERT_PROCESS_N0`(
	in procN0_name varchar(45),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N0 where (PROC_N0_NAME = procN0_name)) THEN
		set resultMessage = 'El Nombre del Proceso Ingresado ya existe en el sistema';
    ELSEIF EXISTS (SELECT * from PROCESS_N1 where (PROC_N1_NAME = procN0_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N1';
    ELSEIF EXISTS (SELECT * from PROCESS_N2 where (PROC_N2_NAME = procN0_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N2';
    ELSEIF EXISTS (SELECT * from PROCESS_N3 where (PROC_N3_NAME = procN0_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N3';
    ELSE
		insert	into PROCESS_N0 (PROC_N0_NAME) values(procN0_name);
	END IF;
	
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `INSERT_PROCESS_N1`(
	in procN1_name varchar(45),
    in procN0_ID INT,
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N0 where (PROC_N0_NAME = procN1_name)) THEN
		set resultMessage = 'El Nombre del Proceso ya esta Asociado a un Proceso';
    ELSEIF EXISTS (SELECT * from PROCESS_N1 where (PROC_N1_NAME = procN1_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N1';
    ELSEIF EXISTS (SELECT * from PROCESS_N2 where (PROC_N2_NAME = procN1_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N2';
    ELSEIF EXISTS (SELECT * from PROCESS_N3 where (PROC_N3_NAME = procN1_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N3';
    ELSEIF NOT EXISTS (SELECT * from PROCESS_N0 where (PROC_N0_ID = procN0_ID)) THEN
		set resultMessage = 'El Proceso no existe';
    ELSE
		insert	into PROCESS_N1 (PROC_N1_NAME,PROC_N0_ID) values(procN1_name,procN0_ID);
	END IF;
	
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `INSERT_PROCESS_N2`(
	in procN2_name varchar(45),
    in procN1_ID int,
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N0 where (PROC_N0_NAME = procN2_name)) THEN
		set resultMessage = 'El Nombre del Proceso ya esta Asociado a un Proceso';
    ELSEIF EXISTS (SELECT * from PROCESS_N1 where (PROC_N1_NAME = procN2_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N1';
    ELSEIF EXISTS (SELECT * from PROCESS_N2 where (PROC_N2_NAME = procN2_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N2';
    ELSEIF EXISTS (SELECT * from PROCESS_N3 where (PROC_N3_NAME = procN2_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N3';
	ELSEIF NOT EXISTS (SELECT * from PROCESS_N1 where (PROC_N1_ID = procN1_ID)) THEN
		set resultMessage = 'El Proceso N1 no existe';
    ELSE
		insert	into PROCESS_N2 (PROC_N2_NAME,PROC_N1_ID) values(procN2_name,procN1_ID);
	END IF;
	
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `INSERT_PROCESS_N3`(
	in procN3_name varchar(45),
    in procN2_ID int,
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N0 where (PROC_N0_NAME = procN3_name)) THEN
		set resultMessage = 'El Nombre del Proceso Ingresado ya existe en el sistema';
    ELSEIF EXISTS (SELECT * from PROCESS_N1 where (PROC_N1_NAME = procN3_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N1';
    ELSEIF EXISTS (SELECT * from PROCESS_N2 where (PROC_N2_NAME = procN3_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N2';
    ELSEIF EXISTS (SELECT * from PROCESS_N3 where (PROC_N3_NAME = procN3_name)) THEN
		set resultMessage = 'El Nombre ya esta Asociado a un Procedimiento N3';
    ELSEIF NOT EXISTS (SELECT * from PROCESS_N2 where (PROC_N2_ID = procN2_ID)) THEN
		set resultMessage = 'El Proceso N2 no existe';
    ELSE
		insert	into PROCESS_N3 (PROC_N3_NAME,PROC_N2_ID) values(procN3_name,procN2_ID);
	END IF;
	
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `INSERT_PRODUCT`(

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
    in pdtPoint_Ref		VARCHAR(10),
    in pdtDays			INT,
    in pdtHours			INT,
    in pdtMinutes		INT,
    in pdtGoal_type		INT,
    in pdtQuant_Mont	INT,
    in pdtGoal_Pob		VARCHAR(50),
    in pdtGoal_index	INT,
    in pdtGoal_Samples	INT,
    in inputText		VARCHAR(2000),
    
	out ResultMessage 	VARCHAR (200)
)
BEGIN

DECLARE delChar VARCHAR (1);

DECLARE item VARCHAR(2000);

IF EXISTS (SELECT * FROM PRODUCT WHERE PDT_NAME = pdtName) THEN
	SET ResultMessage = 'Ya Existe in Registro con este nombre';
ELSEIF EXISTS (SELECT * FROM PRODUCT WHERE PDT_SIGLA = pdtSigla) THEN
	SET ResultMessage = 'Ya Existe in Registro con esta Sigla';
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

INSERT INTO `planhnd_DeltaBD`.`PRODUCT` (`PDT_NAME`,  `PDT_HASCODE`, PDT_SIGLA,
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
										WHERE ID_PERTINENCE = (SELECT PERT_ID FROM PERTINENCES WHERE PERT_DETAIL = item) 
										AND PDT_ID = (SELECT PDT_ID FROM PRODUCT WHERE PDT_NAME = pdtName))THEN
							
							insert Into DETAIL_PERT_PRODUCT (ID_PERTINENCE,PDT_ID) 
								values ((select PERT_ID from PERTINENCES where PERT_DETAIL = item),
										(SELECT PDT_ID FROM PRODUCT WHERE PDT_NAME = pdtName)) ;
					END IF;
					
			ELSE
               
			INSERT INTO PERTINENCES (PERT_DETAIL) SELECT item;
            insert Into DETAIL_PERT_PRODUCT (ID_PERTINENCE,PDT_ID) 
				values ((select PERT_ID from PERTINENCES where PERT_DETAIL = item) ,
						(SELECT PDT_ID FROM PRODUCT WHERE PDT_NAME = pdtName));
			end if;
        end if;
        
	END WHILE;
    
    IF length(inputText) > 0 then
		IF EXISTS(SELECT * FROM PERTINENCES WHERE PERT_DETAIL = inputText) then
			 
					  IF NOT EXISTS(SELECT * FROM DETAIL_PERT_PRODUCT 
										WHERE ID_PERTINENCE = (SELECT PERT_ID FROM PERTINENCES WHERE PERT_DETAIL = inputText) 
										AND PDT_ID = (SELECT PDT_ID FROM PRODUCT WHERE PDT_NAME = pdtName))THEN
							
							insert Into DETAIL_PERT_PRODUCT (ID_PERTINENCE,PDT_ID) 
								values ((select PERT_ID from PERTINENCES where PERT_DETAIL = inputText),
										(SELECT PDT_ID FROM PRODUCT WHERE PDT_NAME = pdtName)) ;
					END IF;
					
			ELSE
               
			INSERT INTO PERTINENCES (PERT_DETAIL) SELECT inputText;
            insert Into DETAIL_PERT_PRODUCT (ID_PERTINENCE,PDT_ID) 
				values ((select PERT_ID from PERTINENCES where PERT_DETAIL = inputText) ,
						(SELECT PDT_ID FROM PRODUCT WHERE PDT_NAME = pdtName));
			end if;
	end if;
    
ELSE
   
	   IF EXISTS (SELECT * FROM PRODUCT WHERE PDT_NAME = pdtName) THEN
		SET ResultMessage = 'Ya Existe in Registro con este nombre';
	ELSEIF EXISTS (SELECT * FROM PRODUCT WHERE PDT_SIGLA = pdtSigla) THEN
		SET ResultMessage = 'Ya Existe in Registro con esta Sigla';
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

END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `INSERT_ROL`(
	in rolNAME varchar(45),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from ROL where (ROL_NAME = rolName)) THEN
		set resultMessage = 'El Nombre del Rol Seleccionado ya existe en el sistema';
    ELSE
		insert	into ROL (ROL_NAME) values(rolNAME);
	END IF;
	
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `INSERT_ROL_PRODUCT`(

	in rolID	 		INT,
    in inputText		VARCHAR (2000),
    out resultMessage 	VARCHAR (200)
)
BEGIN

DECLARE delChar VARCHAR (1);
DECLARE item VARCHAR(2000);

IF EXISTS (SELECT * FROM ROL WHERE ROL_ID = rolID) THEN
SET delChar = ',';

WHILE LOCATE(delChar,inputText) != 0 DO
 
    	SET item = RTRIM(LTRIM(SUBSTRING(inputText,1, LOCATE(delChar,inputText) - 1)));
    	SET inputText = RTRIM(LTRIM(SUBSTRING(inputText, LOCATE(delChar, inputText) + LENGTH(delChar), LENGTH(inputText))));
    	
    	IF length(item) > 0 THEN
       
				IF EXISTS(SELECT * FROM PRODUCT WHERE PDT_ID = item) then
						 
						IF NOT EXISTS(SELECT * FROM ROL_PRODUCT WHERE PDT_ID = item AND ROL_ID = rolID)THEN
							 insert Into ROL_PRODUCT (ROL_ID,PDT_ID) 
							values 	(rolID,item);
						END IF;
					
				ELSE
					
                    set resultMessage = CONCAT('El Producto ',item,' No Existe');
				
				END IF;
        END IF;
        
	END WHILE;
    
    IF length(inputText) > 0 then
		IF EXISTS(SELECT * FROM PRODUCT WHERE PDT_ID = inputText) then
			 
						IF NOT EXISTS(SELECT * FROM ROL_PRODUCT WHERE PDT_ID = inputText AND ROL_ID = rolID )THEN
							
							insert Into ROL_PRODUCT (ROL_ID,PDT_ID) 
								values 	(rolID,inputText);
						END IF;
					
				ELSE
					
                    set resultMessage = CONCAT('El Producto ',inputText,' No Existe');
				
				END IF;
	end if;
ELSE
SET resultMessage = 'El Rol No Existe';
END IF;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `INSERT_USER`(
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
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE DEFINER=`planhnd_deltaUse`@`%` FUNCTION `SPLIT_STR`(
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

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `TEST`(
OUT ABV VARCHAR (500)
)
BEGIN
	IF  1 < 2  and (2 < 1 or 1 > 2) THEN
		set ABV = 'true';
    end if;
    
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `UPDATE_AREA`(
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
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `UPDATE_DIVISION_N1`(
	in divID int,
    in newDivDetail  varchar(45),
    in newAreaID    int,
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from DIVISION_N1 where (DIV_N1_ID = divID)) THEN
		
        
        
         IF EXISTS (SELECT * from AREA where (AREA_NAME = newDivDetail)) THEN
			
            set resultMessage = 'Ya existe, una Area con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from DIVISION_N1 where (DIV_N1_NAME = newDivDetail AND AREA_ID = 
									(SELECT AREA_ID FROM DIVISION_N1 WHERE DIV_N1_ID = divID ) AND AREA_ID = newAreaID)) THEN
			
            set resultMessage = 'Ya existe, una Division N1 con Este Nombre';
            
			
            
		ELSEIF NOT EXISTS (SELECT * from AREA where (AREA_ID = newAreaID)) THEN
			
            set resultMessage = 'El Area Asociada no Existe';
            
		ELSE
			UPDATE DIVISION_N1 SET DIV_N1_NAME = newDivDetail, AREA_ID = newAreaID WHERE DIV_N1_ID = divID;
        END IF;
    ELSE
		set resultMessage = 'Registro No Existe en el Sistema';
    END IF;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `UPDATE_DIVISION_N2`(
	in divID int,
    in newDivDetail  varchar(45),
    in newDIVFatherID    int,
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from DIVISION_N2 where (DIV_N2_ID = divID)) THEN
		
        
        
         IF EXISTS (SELECT * from AREA where (AREA_NAME = newDivDetail)) THEN
			
            set resultMessage = 'Ya existe, una Area con Este Nombre';
            
		ELSEIF EXISTS (SELECT * from DIVISION_N1 where (DIV_N1_NAME = newDivDetail)) THEN
			
            set resultMessage = 'Ya existe, una dIVISION N1 con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from DIVISION_N2 where (DIV_N2_NAME = newDivDetail AND DIV_N1_ID = 
									(SELECT DIV_N1_ID FROM DIVISION_N2 WHERE DIV_N2_ID = divID) AND DIV_N1_ID = newDIVFatherID)) THEN
			
            set resultMessage = 'Ya existe, una Division N2 con Este Nombre';
            
		ELSEIF NOT EXISTS (SELECT * from DIVISION_N1 where (DIV_N1_ID = newDIVFatherID)) THEN
			
            set resultMessage = 'la Division N1 Asociada no Existe';
            
		ELSE
			UPDATE DIVISION_N2 SET DIV_N2_NAME = newDivDetail, DIV_N1_ID = newDIVFatherID WHERE DIV_N2_ID = divID;
        END IF;
    ELSE
		set resultMessage = 'Registro No Existe en el Sistema';
    END IF;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `UPDATE_DIVISION_N3`(
	in divID int,
    in newDivDetail  varchar(45),
    in newDIVFatherID    int,
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from DIVISION_N3 where (DIV_N3_ID = divID)) THEN
		
        
        
         IF EXISTS (SELECT * from AREA where (AREA_NAME = newDivDetail)) THEN
			
            set resultMessage = 'Ya existe, una Area con Este Nombre';
            
		ELSEIF EXISTS (SELECT * from DIVISION_N1 where (DIV_N1_NAME = newDivDetail)) THEN
			
            set resultMessage = 'Ya existe, una dIVISION N1 con Este Nombre';
            
		ELSEIF EXISTS (SELECT * from DIVISION_N2 where (DIV_N2_NAME = newDivDetail)) THEN
			
            set resultMessage = 'Ya existe, una dIVISION N2 con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from DIVISION_N3 where (DIV_N3_NAME = newDivDetail AND DIV_N2_ID = 
									(SELECT DIV_N2_ID FROM DIVISION_N3 WHERE DIV_N3_ID = divID) AND DIV_N2_ID = newDIVFatherID)) THEN
			
            set resultMessage = 'Ya existe, una Division N3con Este Nombre';
            
		ELSEIF NOT EXISTS (SELECT * from DIVISION_N2 where (DIV_N2_ID = newDIVFatherID)) THEN
			
            set resultMessage = 'la Division N1 Asociada no Existe';
            
		ELSE
			UPDATE DIVISION_N3 SET DIV_N3_NAME = newDivDetail, DIV_N2_ID = newDIVFatherID WHERE DIV_N3_ID = divID;
        END IF;
    ELSE
		set resultMessage = 'Registro No Existe en el Sistema';
    END IF;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `UPDATE_PERTINENCE`(
	in pertID int,
    in newPertDetail varchar(45),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PERTINENCES where (PERT_ID = pertID)) THEN
		
        IF EXISTS (SELECT * from PERTINENCES where (PERT_DETAIL = newPertDetail)) THEN
			
            set resultMessage = 'Ya existe, una Pertinencia con Este Nombre';
            
        ELSE
        
			update PERTINENCES SET PERT_DETAIL = newPertDetail WHERE PERT_ID = pertID;
        
        END IF;
    ELSE
		set resultMessage = 'Registro No Existe en el Sistema';
    END IF;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `UPDATE_PROCESS_N0`(
	in procID int,
    in newProcDetail varchar(45),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N0 where (PROC_N0_ID = procID)) THEN
		
        IF EXISTS (SELECT * from PROCESS_N0 where (PROC_N0_NAME = procID)) THEN
			
            set resultMessage = 'Ya existe, una Proceso con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from PROCESS_N1 where (PROC_N1_NAME = procID)) THEN
			
            set resultMessage = 'Ya existe, una Procedimiento N1 con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from PROCESS_N2 where (PROC_N2_NAME = procID)) THEN
			
            set resultMessage = 'Ya existe, una Procedimiento N2 con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from PROCESS_N3 where (PROC_N3_NAME = procID)) THEN
			
            set resultMessage = 'Ya existe, una Procedimiento N3 con Este Nombre';
            
        ELSE        
			update PROCESS_N0 SET PROC_N0_NAME = newProcDetail WHERE PROC_N0_ID = procID;
        
        END IF;
    ELSE
		set resultMessage = 'Registro No Existe en el Sistema';
    END IF;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `UPDATE_PROCESS_N1`(
	in procID int,
    in newProcDetail  varchar(45),
    in newProcN0ID    int,
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N1 where (PROC_N1_ID = procID)) THEN
		
        IF EXISTS (SELECT * from PROCESS_N0 where (PROC_N0_NAME = procID)) THEN
			
            set resultMessage = 'Ya existe, una Proceso con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from PROCESS_N1 where (PROC_N1_NAME = procID)) THEN
			
            set resultMessage = 'Ya existe, una Procedimiento N1 con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from PROCESS_N2 where (PROC_N2_NAME = procID)) THEN
			
            set resultMessage = 'Ya existe, una Procedimiento N2 con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from PROCESS_N3 where (PROC_N3_NAME = procID)) THEN
			
            set resultMessage = 'Ya existe, una Procedimiento N3 con Este Nombre';
            
        ELSEIF EXISTS (SELECT * FROM PROCESS_N0 WHERE (PROC_N0_ID = newProcN0ID)) THEN       
			update PROCESS_N1 SET PROC_N1_NAME = newProcDetail,PROC_N0_ID = newProcN0ID  WHERE PROC_N1_ID = procID;
		ELSE
			set resultMessage = 'El Proceso no Existe';
        END IF;
    ELSE
		set resultMessage = 'Registro No Existe en el Sistema';
    END IF;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `UPDATE_PROCESS_N2`(
	in procID int,
    in newProcDetail varchar(15),
    in newProcFatherid int,
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N2 where (PROC_N2_ID = procID)) THEN
		
        IF EXISTS (SELECT * from PROCESS_N0 where (PROC_N0_NAME = newProcDetail)) THEN
			
            set resultMessage = 'Ya existe, una Proceso con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from PROCESS_N1 where (PROC_N1_NAME = newProcDetail)) THEN
			
            set resultMessage = 'Ya existe, una Procedimiento N1 con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from PROCESS_N2 where (PROC_N2_NAME = newProcDetail)) THEN
			
            set resultMessage = 'Ya existe, una Procedimiento N2 con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from PROCESS_N3 where (PROC_N3_NAME = newProcDetail)) THEN
			
            set resultMessage = 'Ya existe, una Procedimiento N3 con Este Nombre';
            
		ELSEIF exists (SELECT * FROM PROCESS_N1 WHERE (PROC_N1_ID = newProcFatherid)) THEN        
        
			update PROCESS_N2 SET PROC_N2_NAME= newProcDetail, PROC_N1_ID =newProcFatherid  WHERE PROC_N2_ID = procID;
            
		ELSE   
			set resultMessage = 'el Procedimiento N1 no existe';
        END IF;
    ELSE
		set resultMessage = 'Registro No Existe en el Sistema';
    END IF;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `UPDATE_PROCESS_N3`(
	in procID int,
    in newProcFatherid int,
    in newProcDetail varchar(45),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from PROCESS_N3 where (PROC_N0_ID = procID)) THEN
		
        IF EXISTS (SELECT * from PROCESS_N0 where (PROC_N0_NAME = procID)) THEN
			
            set resultMessage = 'Ya existe, una Proceso con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from PROCESS_N1 where (PROC_N1_NAME = procID)) THEN
			
            set resultMessage = 'Ya existe, una Procedimiento N1 con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from PROCESS_N2 where (PROC_N2_NAME = procID)) THEN
			
            set resultMessage = 'Ya existe, una Procedimiento N2 con Este Nombre';
            
        ELSEIF EXISTS (SELECT * from PROCESS_N3 where (PROC_N3_NAME = procID)) THEN
			
            set resultMessage = 'Ya existe, una Procedimiento N3 con Este Nombre';
            
        ELSEIF exists (SELECT * FROM PROCESS_N2 WHERE (PROC_N2_ID = newProcFatherid)) THEN        
			update PROCESS_N3 SET PROC_N3_NAME= newProcDetail, PROC_N2_ID =newProcFatherid  WHERE PROC_N3_ID = procID;
		ELSE   
			set resultMessage = 'el Procedimiento N2 no existe';
        END IF;
    ELSE
		set resultMessage = 'Registro No Existe en el Sistema';
    END IF;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `UPDATE_PRODUCT`(
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
        
        
        DELETE FROM planhnd_DeltaBD.DETAIL_PERT_PRODUCT WHERE DETAIL_PERT_PRODUCT.PDT_ID = pdtId;

        
        
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
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `UPDATE_ROL`(
	in rolID int,
    in newRolName varchar(45),
    out resultMessage varchar(200)
)
BEGIN
	IF EXISTS (SELECT * from ROL where (ROL_ID = rolID)) THEN
		
        IF EXISTS (SELECT * from ROL where (ROL_NAME = newRolName)) THEN
			
            set resultMessage = 'Ya existe, un rol con Este Nombre';
            
        ELSE
        
			update ROL SET ROL_NAME = newRolName WHERE ROL_ID = rolID;
        
        END IF;
    ELSE
		set resultMessage = 'Registro No Existe en el Sistema';
    END IF;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `UPDATE_ROL_PRODUCT`(

	in rolID	 		INT,
    in inputText		VARCHAR (2000),
    out resultMessage 	VARCHAR (200)
)
BEGIN

DECLARE delChar VARCHAR (1);
DECLARE item VARCHAR(2000);

IF EXISTS (SELECT * FROM ROL WHERE ROL_ID = rolID) THEN
SET delChar = ',';

DELETE FROM ROL_PRODUCT WHERE ROL_PRODUCT.ROL_ID = rolID;

/**
Insertar nuevos productos al rol
**/
WHILE LOCATE(delChar,inputText) != 0 DO
 
    	SET item = RTRIM(LTRIM(SUBSTRING(inputText,1, LOCATE(delChar,inputText) - 1)));
    	SET inputText = RTRIM(LTRIM(SUBSTRING(inputText, LOCATE(delChar, inputText) + LENGTH(delChar), LENGTH(inputText))));
    	
    	IF length(item) > 0 THEN
       
				IF EXISTS(SELECT * FROM PRODUCT WHERE PDT_ID = item) then
						 
						IF NOT EXISTS(SELECT * FROM ROL_PRODUCT WHERE PDT_ID = item AND ROL_ID = rolID)THEN
							 insert Into ROL_PRODUCT (ROL_ID,PDT_ID) 
							values 	(rolID,item);
						END IF;
					
				ELSE
					
                    set resultMessage = CONCAT('El Producto ',item,' No Existe');
				
				END IF;
        END IF;
        
	END WHILE;
    
    IF length(inputText) > 0 then
		IF EXISTS(SELECT * FROM PRODUCT WHERE PDT_ID = inputText) then
			 
						IF NOT EXISTS(SELECT * FROM ROL_PRODUCT WHERE PDT_ID = inputText AND ROL_ID = rolID )THEN
							
							insert Into ROL_PRODUCT (ROL_ID,PDT_ID) 
								values 	(rolID,inputText);
						END IF;
					
				ELSE
					
                    set resultMessage = CONCAT('El Producto ',inputText,' No Existe');
				
				END IF;
	end if;
ELSE
SET resultMessage = 'El Rol No Existe';
END IF;
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `UPDATE_USER`(
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
END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `mejor_vendedor`(fecha_inicio DATE, fecha_final DATE)
BEGIN

-- Declaración de variables
DECLARE ID_VENDEDOR INT;
DECLARE ACUMULADO_VENTAS INT;
DECLARE TEMPV INT DEFAULT 0;
DECLARE TEMPID INT DEFAULT 0;

-- Definición de la consulta
DECLARE mejor_vendedor_cursor CURSOR FOR
SELECT V.IDVENDEDOR,SUM(DF.UNIDADES*DF.PRECIO)
FROM VENDEDOR AS V INNER JOIN FACTURA AS F
ON V.IDVENDEDOR = F.IDVENDEDOR  AND (F.FECHA BETWEEN fecha_inicio AND fecha_final)
INNER JOIN DETALLEFACTURA AS DF
ON F.IDFACTURA = DF.IDFACTURA
GROUP BY V.IDVENDEDOR;

-- Declaración de un manejador de error tipo NOT FOUND
DECLARE CONTINUE HANDLER FOR NOT FOUND SET @hecho = TRUE;

-- Abrimos el cursor
OPEN mejor_vendedor_cursor;

-- Comenzamos nuestro bucle de lectura
loop1: LOOP

-- Obtenemos la primera fila en la variables correspondientes
FETCH mejor_vendedor_cursor INTO ID_VENDEDOR, ACUMULADO_VENTAS;

-- Si el cursor se quedó sin elementos,
-- entonces nos salimos del bucle
IF @hecho THEN
LEAVE loop1;
END IF;

-- Guardamos el acumulado de ventas y el código
-- si el vendedor actual tiene mejores resultados
IF ACUMULADO_VENTAS>=TEMPV THEN
SET TEMPV = ACUMULADO_VENTAS;
SET TEMPID = ID_VENDEDOR;
END IF;

END LOOP loop1;

-- Cerramos el cursor
CLOSE mejor_vendedor_cursor;

-- Imprimimos el código y total acumulado de ventas del vendedor
SELECT  TEMPID AS CODIGO_VENDEDOR, TEMPV AS TOTAL_VENTAS;

END$$

DELIMITER ;

DELIMITER $$
USE `planhnd_DeltaBD`$$
CREATE PROCEDURE `spSplitData`(
	in inputText VARCHAR (2000),
    in delChar   VARCHAR (1)
   
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

END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
