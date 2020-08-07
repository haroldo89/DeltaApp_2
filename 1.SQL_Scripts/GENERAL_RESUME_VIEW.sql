CREATE OR REPLACE VIEW GENERAL_RESUME_VIEW AS

SELECT
		PROCESS_N0.PROC_N0_NAME,
        PRODUCT.PDT_ID,
        PRODUCT.PDT_NAME,
        SUM( MEASURE_PRODUCT.REPROCES_COUNT) AS 'REPROCES_COUNT',
        (SELECT COUNT(*) FROM MEASURE_PRODUCT WHERE MEASURE_PRODUCT.PDT_ID = PRODUCT.PDT_ID) AS 'MEASURES_COUNT',
        (SELECT COUNT(*) FROM MEASURE_PRODUCT WHERE MEASURE_PRODUCT.PDT_ID = PRODUCT.PDT_ID AND MEASURE_PRODUCT.MSR_OK = FALSE) AS 'MEASURES_DEFECTS',
        MEASURE_PRODUCT.MSR_DATE
        FROM PRODUCT
        
        LEFT JOIN PROCESS_N0 ON PROCESS_N0.PROC_N0_ID = PRODUCT.PROC_N0_ID
        LEFT JOIN MEASURE_PRODUCT ON MEASURE_PRODUCT.PDT_ID = PRODUCT.PDT_ID 
        
		WHERE  (SELECT COUNT(*) FROM MEASURE_PRODUCT WHERE MEASURE_PRODUCT.PDT_ID = PRODUCT.PDT_ID) >0
        GROUP BY PRODUCT.PDT_NAME;        

COMMIT;

SELECT
		PROCESS_N0.PROC_N0_NAME,
        PRODUCT.PDT_ID,
        PRODUCT.PDT_NAME,
        SUM( MEASURE_PRODUCT.REPROCES_COUNT) AS 'REPROCES_COUNT',
        (SELECT COUNT(*) FROM MEASURE_PRODUCT WHERE MEASURE_PRODUCT.PDT_ID = PRODUCT.PDT_ID) AS 'MEASURES_COUNT',
        MEASURE_PRODUCT.MSR_DATE
        FROM PRODUCT
        
        LEFT JOIN PROCESS_N0 ON PROCESS_N0.PROC_N0_ID = PRODUCT.PROC_N0_ID
        LEFT JOIN MEASURE_PRODUCT ON MEASURE_PRODUCT.PDT_ID = PRODUCT.PDT_ID 
		WHERE  (SELECT COUNT(*) FROM MEASURE_PRODUCT WHERE MEASURE_PRODUCT.PDT_ID = PRODUCT.PDT_ID) >0
        GROUP BY PRODUCT.PDT_NAME;        




CREATE OR REPLACE VIEW USER_PU_RELATION_MEASURE_VIEW AS
SELECT 
		MEASURE_PRODUCT.MSR_ID,
		USER.USR_PU,
		(SELECT COUNT(*) FROM MEASURE_PRODUCT WHERE MEASURE_PRODUCT.USR_ID = USER.USR_ID) AS 'TOTAL_MEASURES'
        FROM MEASURE_PRODUCT
		LEFT JOIN USER ON USER.USR_ID = MEASURE_PRODUCT.USR_ID
        GROUP BY USER.USR_PU;
		COMMIT;
       
		
CREATE OR REPLACE VIEW ROL_RELATION_MEASURE_VIEW AS
SELECT 
		MEASURE_PRODUCT.MSR_ID,
        ROL.ROL_NAME,
	   (SELECT COUNT(*) FROM MEASURE_PRODUCT WHERE MEASURE_PRODUCT.USR_ID = USER.USR_ID) AS 'TOTAL_MEASURES'
       FROM MEASURE_PRODUCT
       LEFT JOIN USER ON USER.USR_ID = MEASURE_PRODUCT.USR_ID
       LEFT JOIN ROL ON ROL.ROL_ID = USER.ROL_ID
       GROUP BY USER.USR_PU;
       COMMIT;

SELECT * FROM EFECTIVITY_VIEW WHERE DEFECTS > 0;
CREATE OR REPLACE VIEW EFECTIVITY_VIEW AS
SELECT PERTINENCES_BY_MEASURE_VIEW.MSR_ID,
		MEASURE_VIEW.MSR_DATE, AREA_NAME,
        PDT_NAME,
        (COUNT(*)-SUM(PERT_VALUE)) AS DEFECTS,
COUNT(*) AS TOTAL
FROM PERTINENCES_BY_MEASURE_VIEW
LEFT join MEASURE_VIEW ON MEASURE_VIEW.MSR_ID = PERTINENCES_BY_MEASURE_VIEW.MSR_ID
GROUP BY PERTINENCES_BY_MEASURE_VIEW.MSR_ID;



CREATE OR REPLACE VIEW EFECTIVITY_OK_VIEW AS
SELECT PERTINENCES_BY_MEASURE_VIEW.MSR_ID,
		MEASURE_VIEW.MSR_DATE, AREA_NAME,
        PDT_NAME,
        (SUM(PERT_VALUE)) AS OK,
		COUNT(*) AS TOTAL
FROM PERTINENCES_BY_MEASURE_VIEW
LEFT join MEASURE_VIEW ON MEASURE_VIEW.MSR_ID = PERTINENCES_BY_MEASURE_VIEW.MSR_ID
GROUP BY PERTINENCES_BY_MEASURE_VIEW.MSR_ID;

CREATE OR REPLACE VIEW MEASURE_NO_PRODUCTS_VIEW AS
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
        

