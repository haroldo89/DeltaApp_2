CREATE OR REPLACE VIEW PERTINENCES_DEFECTS AS
select  MEASURE_PERTINENCES_VIEW.PERT_DETAIL,
		MEASURE_PERTINENCES_VIEW.PERT_ID, 
		PRODUCT_VIEW.PROC_N0_NAME,
        PRODUCT_VIEW.PDT_NAME,
        ( COUNT(*) - SUM(MEASURE_PERTINENCES_VIEW.PERT_VALUE)) AS TOTAL_NO_OK,
        ( COUNT(*)) AS 'TOTAL_MEDICIONES'
        
        FROM MEASURE_PERTINENCES_VIEW
        LEFT JOIN PRODUCT_VIEW ON PRODUCT_VIEW.PDT_ID = MEASURE_PERTINENCES_VIEW.PDT_ID
        GROUP BY MEASURE_PERTINENCES_VIEW.PERT_DETAIL
        ORDER BY TOTAL_NO_OK DESC;
        
        
DROP PROCEDURE GET_PERTINENCES_DEFECTS;
DELIMITER $$
CREATE PROCEDURE  GET_PERTINENCES_DEFECTS
(
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
END $$