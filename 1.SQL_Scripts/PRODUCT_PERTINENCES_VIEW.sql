CREATE OR REPLACE VIEW PRODUCT_PERTINENCES_VIEW AS

	SELECT	DETAIL_PERT_PRODUCT.ID_PERTINENCE,
			PERTINENCES.PERT_DETAIL,
			DETAIL_PERT_PRODUCT.PDT_ID,
            PRODUCT.PDT_NAME
	FROM DETAIL_PERT_PRODUCT
    LEFT JOIN PERTINENCES ON PERTINENCES.PERT_ID = DETAIL_PERT_PRODUCT.ID_PERTINENCE
    LEFT JOIN PRODUCT ON PRODUCT.PDT_ID = DETAIL_PERT_PRODUCT.PDT_ID;

COMMIT;
