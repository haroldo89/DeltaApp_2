
-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`AREA_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`AREA_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`AREA_VIEW` AS select `planhnd_DeltaBD`.`AREA`.`AREA_ID` AS `AREA_ID`,`planhnd_DeltaBD`.`AREA`.`AREA_NAME` AS `AREA_NAME` from `planhnd_DeltaBD`.`AREA`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`DIVISION_N1_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`DIVISION_N1_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`DIVISION_N1_VIEW` AS select `planhnd_DeltaBD`.`DIVISION_N1`.`DIV_N1_ID` AS `DIV_N1_ID`,`planhnd_DeltaBD`.`DIVISION_N1`.`DIV_N1_NAME` AS `DIV_N1_NAME`,`planhnd_DeltaBD`.`DIVISION_N1`.`AREA_ID` AS `AREA_ID`,`planhnd_DeltaBD`.`AREA`.`AREA_NAME` AS `AREA_NAME` from (`planhnd_DeltaBD`.`DIVISION_N1` left join `planhnd_DeltaBD`.`AREA` on((`planhnd_DeltaBD`.`DIVISION_N1`.`AREA_ID` = `planhnd_DeltaBD`.`AREA`.`AREA_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`DIVISION_N2_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`DIVISION_N2_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`DIVISION_N2_VIEW` AS select `planhnd_DeltaBD`.`DIVISION_N2`.`DIV_N2_ID` AS `DIV_N2_ID`,`planhnd_DeltaBD`.`DIVISION_N2`.`DIV_N2_NAME` AS `DIV_N2_NAME`,`planhnd_DeltaBD`.`DIVISION_N2`.`DIV_N1_ID` AS `DIV_N1_ID`,`planhnd_DeltaBD`.`DIVISION_N1`.`DIV_N1_NAME` AS `DIV_N1_NAME` from (`planhnd_DeltaBD`.`DIVISION_N2` left join `planhnd_DeltaBD`.`DIVISION_N1` on((`planhnd_DeltaBD`.`DIVISION_N2`.`DIV_N1_ID` = `planhnd_DeltaBD`.`DIVISION_N1`.`DIV_N1_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`DIVISION_N3_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`DIVISION_N3_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`DIVISION_N3_VIEW` AS select `planhnd_DeltaBD`.`DIVISION_N3`.`DIV_N3_ID` AS `DIV_N3_ID`,`planhnd_DeltaBD`.`DIVISION_N3`.`DIV_N3_NAME` AS `DIV_N3_NAME`,`planhnd_DeltaBD`.`DIVISION_N3`.`DIV_N2_ID` AS `DIV_N2_ID`,`planhnd_DeltaBD`.`DIVISION_N2`.`DIV_N2_NAME` AS `DIV_N2_NAME` from (`planhnd_DeltaBD`.`DIVISION_N3` left join `planhnd_DeltaBD`.`DIVISION_N2` on((`planhnd_DeltaBD`.`DIVISION_N3`.`DIV_N2_ID` = `planhnd_DeltaBD`.`DIVISION_N2`.`DIV_N2_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`EFECTIVITY_OK_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`EFECTIVITY_OK_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`EFECTIVITY_OK_VIEW` AS select `PERTINENCES_BY_MEASURE_VIEW`.`MSR_ID` AS `MSR_ID`,`MEASURE_VIEW`.`MSR_DATE` AS `MSR_DATE`,`MEASURE_VIEW`.`AREA_NAME` AS `AREA_NAME`,`MEASURE_VIEW`.`PDT_NAME` AS `PDT_NAME`,sum(`PERTINENCES_BY_MEASURE_VIEW`.`PERT_VALUE`) AS `OK`,count(0) AS `TOTAL` from (`planhnd_DeltaBD`.`PERTINENCES_BY_MEASURE_VIEW` left join `planhnd_DeltaBD`.`MEASURE_VIEW` on((`MEASURE_VIEW`.`MSR_ID` = `PERTINENCES_BY_MEASURE_VIEW`.`MSR_ID`))) group by `PERTINENCES_BY_MEASURE_VIEW`.`MSR_ID`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`EFECTIVITY_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`EFECTIVITY_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`EFECTIVITY_VIEW` AS select `PERTINENCES_BY_MEASURE_VIEW`.`MSR_ID` AS `MSR_ID`,`MEASURE_VIEW`.`MSR_DATE` AS `MSR_DATE`,`MEASURE_VIEW`.`AREA_NAME` AS `AREA_NAME`,`MEASURE_VIEW`.`PDT_NAME` AS `PDT_NAME`,(count(0) - sum(`PERTINENCES_BY_MEASURE_VIEW`.`PERT_VALUE`)) AS `DEFECTS`,count(0) AS `TOTAL` from (`planhnd_DeltaBD`.`PERTINENCES_BY_MEASURE_VIEW` left join `planhnd_DeltaBD`.`MEASURE_VIEW` on((`MEASURE_VIEW`.`MSR_ID` = `PERTINENCES_BY_MEASURE_VIEW`.`MSR_ID`))) group by `PERTINENCES_BY_MEASURE_VIEW`.`MSR_ID`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`GENERAL_RESUME_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`GENERAL_RESUME_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`GENERAL_RESUME_VIEW` AS select `planhnd_DeltaBD`.`PROCESS_N0`.`PROC_N0_NAME` AS `PROC_N0_NAME`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_ID` AS `PDT_ID`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_NAME` AS `PDT_NAME`,sum(`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`REPROCES_COUNT`) AS `REPROCES_COUNT`,(select count(0) from `planhnd_DeltaBD`.`MEASURE_PRODUCT` where (`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_ID` = `planhnd_DeltaBD`.`PRODUCT`.`PDT_ID`)) AS `MEASURES_COUNT`,(select count(0) from `planhnd_DeltaBD`.`MEASURE_PRODUCT` where ((`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_ID` = `planhnd_DeltaBD`.`PRODUCT`.`PDT_ID`) and (`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_OK` = 0))) AS `MEASURES_DEFECTS`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_DATE` AS `MSR_DATE` from ((`planhnd_DeltaBD`.`PRODUCT` left join `planhnd_DeltaBD`.`PROCESS_N0` on((`planhnd_DeltaBD`.`PROCESS_N0`.`PROC_N0_ID` = `planhnd_DeltaBD`.`PRODUCT`.`PROC_N0_ID`))) left join `planhnd_DeltaBD`.`MEASURE_PRODUCT` on((`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_ID` = `planhnd_DeltaBD`.`PRODUCT`.`PDT_ID`))) where ((select count(0) from `planhnd_DeltaBD`.`MEASURE_PRODUCT` where (`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_ID` = `planhnd_DeltaBD`.`PRODUCT`.`PDT_ID`)) > 0) group by `planhnd_DeltaBD`.`PRODUCT`.`PDT_NAME`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`MEASURE_CODE_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`MEASURE_CODE_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`MEASURE_CODE_VIEW` AS select `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_RAST_CODE` AS `PDT_RAST_CODE` from `planhnd_DeltaBD`.`MEASURE_PRODUCT`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`MEASURE_NO_PRODUCTS_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`MEASURE_NO_PRODUCTS_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`MEASURE_NO_PRODUCTS_VIEW` AS select `PRODUCT_VIEW`.`PDT_ID` AS `PDT_ID`,`PRODUCT_VIEW`.`PROC_N0_NAME` AS `PROC_N0_NAME`,`PRODUCT_VIEW`.`PDT_NAME` AS `PDT_NAME`,(case when isnull(`PRODUCT_VIEW`.`GOAL_QUANTITY_MONTH`) then `PRODUCT_VIEW`.`GOAL_SAMPLES` else `PRODUCT_VIEW`.`GOAL_QUANTITY_MONTH` end) AS `MEASURE_GOAL` from (`planhnd_DeltaBD`.`PRODUCT_VIEW` left join `planhnd_DeltaBD`.`MEASURE_VIEW` on((`PRODUCT_VIEW`.`PDT_ID` = `MEASURE_VIEW`.`PDT_ID`))) where isnull(`MEASURE_VIEW`.`MSR_ID`);


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`MEASURE_PERTINENCES_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`MEASURE_PERTINENCES_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`MEASURE_PERTINENCES_VIEW` AS select `planhnd_DeltaBD`.`PERT_MEASURE`.`MSR_ID` AS `MSR_ID`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_ID` AS `PDT_ID`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_SIGLA` AS `PDT_SIGLA`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_RAST_CODE` AS `PDT_RAST_CODE`,`planhnd_DeltaBD`.`PERT_MEASURE`.`PERT_ID` AS `PERT_ID`,`planhnd_DeltaBD`.`PERTINENCES`.`PERT_DETAIL` AS `PERT_DETAIL`,`planhnd_DeltaBD`.`PERT_MEASURE`.`PERT_VALUE` AS `PERT_VALUE`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`AREA_ID` AS `AREA_ID`,`planhnd_DeltaBD`.`AREA`.`AREA_NAME` AS `AREA_NAME`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N1_ID` AS `DIV_N1_ID`,`planhnd_DeltaBD`.`DIVISION_N1`.`DIV_N1_NAME` AS `DIV_N1_NAME`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N2_ID` AS `DIV_N2_ID`,`planhnd_DeltaBD`.`DIVISION_N2`.`DIV_N2_NAME` AS `DIV_N2_NAME`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N3_ID` AS `DIV_N3_ID`,`planhnd_DeltaBD`.`DIVISION_N3`.`DIV_N3_NAME` AS `DIV_N3_NAME` from (((((((`planhnd_DeltaBD`.`PERT_MEASURE` left join `planhnd_DeltaBD`.`PERTINENCES` on((`planhnd_DeltaBD`.`PERTINENCES`.`PERT_ID` = `planhnd_DeltaBD`.`PERT_MEASURE`.`PERT_ID`))) left join `planhnd_DeltaBD`.`MEASURE_PRODUCT` on((`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_ID` = `planhnd_DeltaBD`.`PERT_MEASURE`.`MSR_ID`))) left join `planhnd_DeltaBD`.`PRODUCT` on((`planhnd_DeltaBD`.`PRODUCT`.`PDT_ID` = `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_ID`))) left join `planhnd_DeltaBD`.`AREA` on((`planhnd_DeltaBD`.`AREA`.`AREA_ID` = `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`AREA_ID`))) left join `planhnd_DeltaBD`.`DIVISION_N1` on((`planhnd_DeltaBD`.`DIVISION_N1`.`DIV_N1_ID` = `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N1_ID`))) left join `planhnd_DeltaBD`.`DIVISION_N2` on((`planhnd_DeltaBD`.`DIVISION_N2`.`DIV_N2_ID` = `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N2_ID`))) left join `planhnd_DeltaBD`.`DIVISION_N3` on((`planhnd_DeltaBD`.`DIVISION_N3`.`DIV_N3_ID` = `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N3_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`MEASURE_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`MEASURE_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`MEASURE_VIEW` AS select `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_ID` AS `MSR_ID`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_ID` AS `PDT_ID`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_NAME` AS `PDT_NAME`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_SIGLA` AS `PDT_SIGLA`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_RAST_CODE` AS `PDT_RAST_CODE`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`USR_ID` AS `USR_ID`,`planhnd_DeltaBD`.`USER`.`USR_NAME` AS `USR_NAME`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`REPROCES_COUNT` AS `REPROCES_COUNT`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`AREA_ID` AS `AREA_ID`,`planhnd_DeltaBD`.`AREA`.`AREA_NAME` AS `AREA_NAME`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N1_ID` AS `DIV_N1_ID`,`planhnd_DeltaBD`.`DIVISION_N1`.`DIV_N1_NAME` AS `DIV_N1_NAME`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N2_ID` AS `DIV_N2_ID`,`planhnd_DeltaBD`.`DIVISION_N2`.`DIV_N2_NAME` AS `DIV_N2_NAME`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N3_ID` AS `DIV_N3_ID`,`planhnd_DeltaBD`.`DIVISION_N3`.`DIV_N3_NAME` AS `DIV_N3_NAME`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_DELIVERY_OPT` AS `PDT_DELIVERY_OPT`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_DAYS` AS `MSR_DAYS`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_HOUR` AS `MSR_HOUR`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_MINUTES` AS `MSR_MINUTES`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_OK` AS `MSR_OK`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_PERTINENCES_OK` AS `MSR_PERTINENCES_OK`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_DATE` AS `MSR_DATE` from ((((((`planhnd_DeltaBD`.`MEASURE_PRODUCT` left join `planhnd_DeltaBD`.`PRODUCT` on((`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_ID` = `planhnd_DeltaBD`.`PRODUCT`.`PDT_ID`))) left join `planhnd_DeltaBD`.`USER` on((`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`USR_ID` = `planhnd_DeltaBD`.`USER`.`USR_ID`))) left join `planhnd_DeltaBD`.`AREA` on((`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`AREA_ID` = `planhnd_DeltaBD`.`AREA`.`AREA_ID`))) left join `planhnd_DeltaBD`.`DIVISION_N1` on((`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N1_ID` = `planhnd_DeltaBD`.`DIVISION_N1`.`DIV_N1_ID`))) left join `planhnd_DeltaBD`.`DIVISION_N2` on((`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N2_ID` = `planhnd_DeltaBD`.`DIVISION_N2`.`DIV_N2_ID`))) left join `planhnd_DeltaBD`.`DIVISION_N3` on((`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`DIV_N3_ID` = `planhnd_DeltaBD`.`DIVISION_N3`.`DIV_N3_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PERTINENCES_BY_MEASURE_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PERTINENCES_BY_MEASURE_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PERTINENCES_BY_MEASURE_VIEW` AS select `planhnd_DeltaBD`.`PERT_MEASURE`.`MSR_ID` AS `MSR_ID`,`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`PDT_RAST_CODE` AS `PDT_RAST_CODE`,`planhnd_DeltaBD`.`PERT_MEASURE`.`PERT_ID` AS `PERT_ID`,`planhnd_DeltaBD`.`PERTINENCES`.`PERT_DETAIL` AS `PERT_DETAIL`,`planhnd_DeltaBD`.`PERT_MEASURE`.`PERT_VALUE` AS `PERT_VALUE` from ((`planhnd_DeltaBD`.`PERT_MEASURE` left join `planhnd_DeltaBD`.`PERTINENCES` on((`planhnd_DeltaBD`.`PERTINENCES`.`PERT_ID` = `planhnd_DeltaBD`.`PERT_MEASURE`.`PERT_ID`))) left join `planhnd_DeltaBD`.`MEASURE_PRODUCT` on((`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_ID` = `planhnd_DeltaBD`.`PERT_MEASURE`.`MSR_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PERTINENCES_DEFECTS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PERTINENCES_DEFECTS`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PERTINENCES_DEFECTS` AS select `MEASURE_PERTINENCES_VIEW`.`PERT_DETAIL` AS `PERT_DETAIL`,`MEASURE_PERTINENCES_VIEW`.`PERT_ID` AS `PERT_ID`,`PRODUCT_VIEW`.`PROC_N0_NAME` AS `PROC_N0_NAME`,`PRODUCT_VIEW`.`PDT_NAME` AS `PDT_NAME`,(count(0) - sum(`MEASURE_PERTINENCES_VIEW`.`PERT_VALUE`)) AS `TOTAL_NO_OK`,count(0) AS `TOTAL_MEDICIONES` from (`planhnd_DeltaBD`.`MEASURE_PERTINENCES_VIEW` left join `planhnd_DeltaBD`.`PRODUCT_VIEW` on((`PRODUCT_VIEW`.`PDT_ID` = `MEASURE_PERTINENCES_VIEW`.`PDT_ID`))) group by `MEASURE_PERTINENCES_VIEW`.`PERT_DETAIL` order by `TOTAL_NO_OK` desc;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PERTINENCES_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PERTINENCES_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PERTINENCES_VIEW` AS select `planhnd_DeltaBD`.`PERTINENCES`.`PERT_ID` AS `PERT_ID`,`planhnd_DeltaBD`.`PERTINENCES`.`PERT_DETAIL` AS `PERT_DETAIL` from `planhnd_DeltaBD`.`PERTINENCES`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PROCESS_N0_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PROCESS_N0_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PROCESS_N0_VIEW` AS select `COMMIT`.`PROC_N0_ID` AS `PROC_N0_ID`,`COMMIT`.`PROC_N0_NAME` AS `PROC_N0_NAME` from `planhnd_DeltaBD`.`PROCESS_N0` `COMMIT`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PROCESS_N1_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PROCESS_N1_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PROCESS_N1_VIEW` AS select `planhnd_DeltaBD`.`PROCESS_N1`.`PROC_N1_ID` AS `PROC_N1_ID`,`planhnd_DeltaBD`.`PROCESS_N1`.`PROC_N1_NAME` AS `PROC_N1_NAME`,`planhnd_DeltaBD`.`PROCESS_N1`.`PROC_N0_ID` AS `PROC_N0_ID`,`planhnd_DeltaBD`.`PROCESS_N0`.`PROC_N0_NAME` AS `PROC_N0_NAME` from (`planhnd_DeltaBD`.`PROCESS_N1` left join `planhnd_DeltaBD`.`PROCESS_N0` on((`planhnd_DeltaBD`.`PROCESS_N1`.`PROC_N0_ID` = `planhnd_DeltaBD`.`PROCESS_N0`.`PROC_N0_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PROCESS_N2_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PROCESS_N2_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PROCESS_N2_VIEW` AS select `planhnd_DeltaBD`.`PROCESS_N2`.`PROC_N2_ID` AS `PROC_N2_ID`,`planhnd_DeltaBD`.`PROCESS_N2`.`PROC_N2_NAME` AS `PROC_N2_NAME`,`planhnd_DeltaBD`.`PROCESS_N2`.`PROC_N1_ID` AS `PROC_N1_ID`,`planhnd_DeltaBD`.`PROCESS_N1`.`PROC_N1_NAME` AS `PROC_N1_NAME` from (`planhnd_DeltaBD`.`PROCESS_N2` left join `planhnd_DeltaBD`.`PROCESS_N1` on((`planhnd_DeltaBD`.`PROCESS_N2`.`PROC_N1_ID` = `planhnd_DeltaBD`.`PROCESS_N1`.`PROC_N1_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PROCESS_N3_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PROCESS_N3_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PROCESS_N3_VIEW` AS select `planhnd_DeltaBD`.`PROCESS_N3`.`PROC_N3_ID` AS `PROC_N3_ID`,`planhnd_DeltaBD`.`PROCESS_N3`.`PROC_N3_NAME` AS `PROC_N3_NAME`,`planhnd_DeltaBD`.`PROCESS_N3`.`PROC_N2_ID` AS `PROC_N2_ID`,`planhnd_DeltaBD`.`PROCESS_N2`.`PROC_N2_NAME` AS `PROC_N2_NAME` from (`planhnd_DeltaBD`.`PROCESS_N3` left join `planhnd_DeltaBD`.`PROCESS_N2` on((`planhnd_DeltaBD`.`PROCESS_N3`.`PROC_N2_ID` = `planhnd_DeltaBD`.`PROCESS_N2`.`PROC_N2_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PRODUCT_DEFECTS_DETAIL`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PRODUCT_DEFECTS_DETAIL`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PRODUCT_DEFECTS_DETAIL` AS select `PRODUCT_VIEW`.`PDT_ID` AS `PDT_ID`,`PRODUCT_VIEW`.`PROC_N0_ID` AS `PROC_N0_ID`,`PRODUCT_VIEW`.`PROC_N0_NAME` AS `PROC_N0_NAME`,`PRODUCT_VIEW`.`PDT_NAME` AS `PDT_NAME`,count(0) AS `TOTAL_MEASURES`,(count(0) - sum(`MEASURE_VIEW`.`PDT_DELIVERY_OPT`)) AS `OP_DEFECTS`,(count(0) - sum(`MEASURE_VIEW`.`MSR_PERTINENCES_OK`)) AS `PERT_DEFECTS`,((count(0) - sum(`MEASURE_VIEW`.`PDT_DELIVERY_OPT`)) + (count(0) - sum(`MEASURE_VIEW`.`MSR_PERTINENCES_OK`))) AS `TOTAL_DEFECTS` from (`planhnd_DeltaBD`.`MEASURE_VIEW` left join `planhnd_DeltaBD`.`PRODUCT_VIEW` on((`PRODUCT_VIEW`.`PDT_ID` = `MEASURE_VIEW`.`PDT_ID`))) group by `PRODUCT_VIEW`.`PDT_NAME`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PRODUCT_PERTINENCES_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PRODUCT_PERTINENCES_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PRODUCT_PERTINENCES_VIEW` AS select `planhnd_DeltaBD`.`DETAIL_PERT_PRODUCT`.`ID_PERTINENCE` AS `ID_PERTINENCE`,`planhnd_DeltaBD`.`PERTINENCES`.`PERT_DETAIL` AS `PERT_DETAIL`,`planhnd_DeltaBD`.`DETAIL_PERT_PRODUCT`.`PDT_ID` AS `PDT_ID`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_NAME` AS `PDT_NAME` from ((`planhnd_DeltaBD`.`DETAIL_PERT_PRODUCT` left join `planhnd_DeltaBD`.`PERTINENCES` on((`planhnd_DeltaBD`.`PERTINENCES`.`PERT_ID` = `planhnd_DeltaBD`.`DETAIL_PERT_PRODUCT`.`ID_PERTINENCE`))) left join `planhnd_DeltaBD`.`PRODUCT` on((`planhnd_DeltaBD`.`PRODUCT`.`PDT_ID` = `planhnd_DeltaBD`.`DETAIL_PERT_PRODUCT`.`PDT_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PRODUCT_ROL_QUERY_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PRODUCT_ROL_QUERY_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PRODUCT_ROL_QUERY_VIEW` AS select `PRODUCT_VIEW`.`PDT_ID` AS `PDT_ID`,`PRODUCT_VIEW`.`PDT_NAME` AS `PDT_NAME`,(case when (`planhnd_DeltaBD`.`ROL_PRODUCT`.`ROL_ID` = 1) then 1 else 0 end) AS `IS_RELATIONED`,now() AS `TIME_COLUMN` from ((`planhnd_DeltaBD`.`PRODUCT_VIEW` left join `planhnd_DeltaBD`.`ROL_PRODUCT` on((`PRODUCT_VIEW`.`PDT_ID` = `planhnd_DeltaBD`.`ROL_PRODUCT`.`PDT_ID`))) left join `planhnd_DeltaBD`.`ROL_VIEW` on((`ROL_VIEW`.`ROL_ID` = `planhnd_DeltaBD`.`ROL_PRODUCT`.`ROL_ID`))) group by `PRODUCT_VIEW`.`PDT_NAME`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PRODUCT_ROL_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PRODUCT_ROL_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PRODUCT_ROL_VIEW` AS select `PRODUCT_VIEW`.`PDT_ID` AS `PDT_ID`,`PRODUCT_VIEW`.`PDT_NAME` AS `PDT_NAME`,`planhnd_DeltaBD`.`ROL_PRODUCT`.`ROL_ID` AS `ROL_ID`,`ROL_VIEW`.`ROL_NAME` AS `ROL_NAME` from ((`planhnd_DeltaBD`.`PRODUCT_VIEW` left join `planhnd_DeltaBD`.`ROL_PRODUCT` on((`PRODUCT_VIEW`.`PDT_ID` = `planhnd_DeltaBD`.`ROL_PRODUCT`.`PDT_ID`))) left join `planhnd_DeltaBD`.`ROL_VIEW` on((`planhnd_DeltaBD`.`ROL_PRODUCT`.`ROL_ID` = `ROL_VIEW`.`ROL_ID`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`PRODUCT_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`PRODUCT_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`PRODUCT_VIEW` AS select `planhnd_DeltaBD`.`PRODUCT`.`PDT_ID` AS `PDT_ID`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_NAME` AS `PDT_NAME`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_HASCODE` AS `PDT_HASCODE`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_SIGLA` AS `PDT_SIGLA`,`planhnd_DeltaBD`.`PROCESS_N0`.`PROC_N0_ID` AS `PROC_N0_ID`,`planhnd_DeltaBD`.`PROCESS_N0`.`PROC_N0_NAME` AS `PROC_N0_NAME`,`planhnd_DeltaBD`.`PROCESS_N1`.`PROC_N1_ID` AS `PROC_N1_ID`,`planhnd_DeltaBD`.`PROCESS_N1`.`PROC_N1_NAME` AS `PROC_N1_NAME`,`planhnd_DeltaBD`.`PROCESS_N2`.`PROC_N2_ID` AS `PROC_N2_ID`,`planhnd_DeltaBD`.`PROCESS_N2`.`PROC_N2_NAME` AS `PROC_N2_NAME`,`planhnd_DeltaBD`.`PROCESS_N3`.`PROC_N3_ID` AS `PROC_N3_ID`,`planhnd_DeltaBD`.`PROCESS_N3`.`PROC_N3_NAME` AS `PROC_N3_NAME`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_DESC` AS `PDT_DESC`,`planhnd_DeltaBD`.`OPORTUNITY_TYPE`.`OP_TYPE_ID` AS `OP_TYPE_ID`,`planhnd_DeltaBD`.`OPORTUNITY_TYPE`.`OP_TYPE_NAME` AS `OP_TYPE_NAME`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_OPORTUNITY_DATE_ACCORDED` AS `PDT_OPORTUNITY_DATE_ACCORDED`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_OPORTUNITY_PTO_REF` AS `PDT_OPORTUNITY_PTO_REF`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_OPORTUNITY_DAYS` AS `PDT_OPORTUNITY_DAYS`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_OPORTUNITY_HOURS` AS `PDT_OPORTUNITY_HOURS`,`planhnd_DeltaBD`.`PRODUCT`.`PDT_OPORTUNITY_MINUTES` AS `PDT_OPORTUNITY_MINUTES`,`planhnd_DeltaBD`.`PRODUCT`.`GOAL_TYPE_ID` AS `GOAL_TYPE_ID`,`planhnd_DeltaBD`.`GOAL_TYPE`.`GOAL_TYPE_NAME` AS `GOAL_TYPE_NAME`,`planhnd_DeltaBD`.`PRODUCT`.`GOAL_QUANTITY_MONTH` AS `GOAL_QUANTITY_MONTH`,`planhnd_DeltaBD`.`PRODUCT`.`GOAL_POBLATION` AS `GOAL_POBLATION`,`planhnd_DeltaBD`.`PRODUCT`.`GOAL_CONFIABILITY_INDEX` AS `GOAL_CONFIABILITY_INDEX`,`planhnd_DeltaBD`.`GOAL_CONFIABILITY_INDEX`.`INDEX_VALUE` AS `INDEX_VALUE`,`planhnd_DeltaBD`.`PRODUCT`.`GOAL_SAMPLES` AS `GOAL_SAMPLES` from (((((((`planhnd_DeltaBD`.`PRODUCT` left join `planhnd_DeltaBD`.`PROCESS_N0` on((`planhnd_DeltaBD`.`PRODUCT`.`PROC_N0_ID` = `planhnd_DeltaBD`.`PROCESS_N0`.`PROC_N0_ID`))) left join `planhnd_DeltaBD`.`PROCESS_N1` on((`planhnd_DeltaBD`.`PRODUCT`.`PROC_N1_ID` = `planhnd_DeltaBD`.`PROCESS_N1`.`PROC_N1_ID`))) left join `planhnd_DeltaBD`.`PROCESS_N2` on((`planhnd_DeltaBD`.`PRODUCT`.`PROC_N2_ID` = `planhnd_DeltaBD`.`PROCESS_N2`.`PROC_N2_ID`))) left join `planhnd_DeltaBD`.`PROCESS_N3` on((`planhnd_DeltaBD`.`PRODUCT`.`PROC_N3_ID` = `planhnd_DeltaBD`.`PROCESS_N3`.`PROC_N3_ID`))) left join `planhnd_DeltaBD`.`OPORTUNITY_TYPE` on((`planhnd_DeltaBD`.`PRODUCT`.`PDT_OPORTUNITY_TYPE` = `planhnd_DeltaBD`.`OPORTUNITY_TYPE`.`OP_TYPE_ID`))) left join `planhnd_DeltaBD`.`GOAL_TYPE` on((`planhnd_DeltaBD`.`PRODUCT`.`GOAL_TYPE_ID` = `planhnd_DeltaBD`.`GOAL_TYPE`.`GOAL_TYPE_ID`))) left join `planhnd_DeltaBD`.`GOAL_CONFIABILITY_INDEX` on((`planhnd_DeltaBD`.`PRODUCT`.`GOAL_CONFIABILITY_INDEX` = `planhnd_DeltaBD`.`GOAL_CONFIABILITY_INDEX`.`ID_INDEX`)));


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`ROL_RELATION_MEASURE_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`ROL_RELATION_MEASURE_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`ROL_RELATION_MEASURE_VIEW` AS select `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_ID` AS `MSR_ID`,`planhnd_DeltaBD`.`ROL`.`ROL_NAME` AS `ROL_NAME`,(select count(0) from `planhnd_DeltaBD`.`MEASURE_PRODUCT` where (`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`USR_ID` = `planhnd_DeltaBD`.`USER`.`USR_ID`)) AS `TOTAL_MEASURES` from ((`planhnd_DeltaBD`.`MEASURE_PRODUCT` left join `planhnd_DeltaBD`.`USER` on((`planhnd_DeltaBD`.`USER`.`USR_ID` = `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`USR_ID`))) left join `planhnd_DeltaBD`.`ROL` on((`planhnd_DeltaBD`.`ROL`.`ROL_ID` = `planhnd_DeltaBD`.`USER`.`ROL_ID`))) group by `planhnd_DeltaBD`.`USER`.`USR_PU`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`ROL_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`ROL_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`ROL_VIEW` AS select `planhnd_DeltaBD`.`ROL`.`ROL_ID` AS `ROL_ID`,`planhnd_DeltaBD`.`ROL`.`ROL_NAME` AS `ROL_NAME` from `planhnd_DeltaBD`.`ROL`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`USERS_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`USERS_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`USERS_VIEW` AS select `planhnd_DeltaBD`.`USER`.`USR_ID` AS `USR_ID`,`planhnd_DeltaBD`.`USER`.`ROL_ID` AS `ROL_ID`,`planhnd_DeltaBD`.`USER`.`USR_DOCUMENT` AS `USR_DOCUMENT`,`planhnd_DeltaBD`.`USER`.`USR_NAME` AS `USR_NAME`,`planhnd_DeltaBD`.`USER`.`USR_PU` AS `USR_PU`,`planhnd_DeltaBD`.`USER`.`USR_MAIL` AS `USR_MAIL`,`planhnd_DeltaBD`.`USER`.`USR_NICK` AS `USR_NICK`,`planhnd_DeltaBD`.`USER`.`USR_PASS` AS `USR_PASS`,`planhnd_DeltaBD`.`USER`.`USR_ACTIVE` AS `USR_ACTIVE`,`planhnd_DeltaBD`.`USER`.`USR_TYPE` AS `USR_TYPE` from `planhnd_DeltaBD`.`USER`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`USER_PU_RELATION_MEASURE_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`USER_PU_RELATION_MEASURE_VIEW`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`USER_PU_RELATION_MEASURE_VIEW` AS select `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`MSR_ID` AS `MSR_ID`,`planhnd_DeltaBD`.`USER`.`USR_PU` AS `USR_PU`,(select count(0) from `planhnd_DeltaBD`.`MEASURE_PRODUCT` where (`planhnd_DeltaBD`.`MEASURE_PRODUCT`.`USR_ID` = `planhnd_DeltaBD`.`USER`.`USR_ID`)) AS `TOTAL_MEASURES` from (`planhnd_DeltaBD`.`MEASURE_PRODUCT` left join `planhnd_DeltaBD`.`USER` on((`planhnd_DeltaBD`.`USER`.`USR_ID` = `planhnd_DeltaBD`.`MEASURE_PRODUCT`.`USR_ID`))) group by `planhnd_DeltaBD`.`USER`.`USR_PU`;


USE `planhnd_DeltaBD`;

-- -----------------------------------------------------
-- View `planhnd_DeltaBD`.`USER_TYPE_MODULES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planhnd_DeltaBD`.`USER_TYPE_MODULES`;
USE `planhnd_DeltaBD`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `planhnd_DeltaBD`.`USER_TYPE_MODULES` AS select `planhnd_DeltaBD`.`USR_TYPES`.`TYPE_ID` AS `TYPE_ID`,`planhnd_DeltaBD`.`USR_TYPES`.`TYPE_NAME` AS `TYPE_NAME`,`planhnd_DeltaBD`.`USR_MODULES_DETAIL`.`MODULES_MODULE_ID` AS `MODULES_MODULE_ID`,`planhnd_DeltaBD`.`MODULES`.`MODULE_NAME` AS `MODULE_NAME`,`planhnd_DeltaBD`.`MODULES`.`MODULE_ID` AS `MODULE_ID`,`planhnd_DeltaBD`.`MODULES`.`MODULES_ALIAS` AS `MODULES_ALIAS` from ((`planhnd_DeltaBD`.`USR_MODULES_DETAIL` left join `planhnd_DeltaBD`.`USR_TYPES` on((`planhnd_DeltaBD`.`USR_TYPES`.`TYPE_ID` = `planhnd_DeltaBD`.`USR_MODULES_DETAIL`.`USR_TYPES_TYPE_ID`))) left join `planhnd_DeltaBD`.`MODULES` on((`planhnd_DeltaBD`.`USR_MODULES_DETAIL`.`MODULES_MODULE_ID` = `planhnd_DeltaBD`.`MODULES`.`MODULE_ID`)));
