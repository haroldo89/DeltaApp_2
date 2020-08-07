using DeltaApp.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DeltaApp.Controllers
{
    public class MeasureController : BaseController
    {
        ProductRepository       productRepository       = new ProductRepository();
        AreaRepository          areaRepository          = new AreaRepository();
        DivisionN1Repository    divisionN1Repository    = new DivisionN1Repository();
        DivisionN2Repository    divisionN2Repository    = new DivisionN2Repository();
        DivisionN3Repository    divisionN3Repository    = new DivisionN3Repository();
        MeasureRepository       measureRepository       = new MeasureRepository();


     
        public ActionResult GetProductOptions()
        {
            try
            {

                var entities = this.productRepository.GetProductsByUserID(CurrentUser.UserID)
                    .Select(c => new { DisplayText = c.PDT_NAME , Value = c.PDT_ID});
                return this.Json(new { Result = "OK", Options = entities });
            }
            catch (Exception ex)
            {
                return this.Json(new { Result = "ERROR", Message = ex.Message });
            }
        } 


        public ActionResult GetMeasureCodeOptions(string pdtID)
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(pdtID))
                {

                    var entities = this.measureRepository.GetMeasureCodes(Convert.ToInt32(pdtID));
                    return this.Json(new { Result = "OK", Options = entities });
                }
                return this.Json(new { Result = "OK" });
            }
            catch (Exception ex)
            {
                return this.Json(new { Result = "ERROR", Message = ex.Message });
            }
        }

        public ActionResult GetProductPertinences (int pdtID)
        {
            try
            {
                var entities = this.productRepository.GetProductPertineces(pdtID);
                    
                return this.Json(new { Result = "OK", Pertinences = entities });
            }
            catch (Exception ex)
            {
                return this.Json(new { Result = "ERROR", Message = ex.Message });
            }
        }

        public ActionResult GetMeasurePertinences(string msrRastCode, string pdtID)
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(msrRastCode) && !string.IsNullOrWhiteSpace(pdtID))
                {
                    var entities = this.measureRepository.GetMeasurePertinences(msrRastCode, pdtID);
                    return this.Json(new { Result = "OK", Pertinences = entities });
                }
                return this.Json(new { Result = "OK" });
            }
            catch (Exception ex)
            {
                return this.Json(new { Result = "ERROR", Message = ex.Message });
            }


        }

        public ActionResult GetProductInfo(string pdtID)
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(pdtID))
                {
                    var entities = this.productRepository.GetById(Convert.ToInt32(pdtID));
                    return this.Json(new { Result = "OK", Product = entities });
                }
                return this.Json(new { Result = "OK" });
            }
            catch (Exception ex)
            {
                return this.Json(new { Result = "ERROR", Message = ex.Message });
            }
        }

        public ActionResult GetAreaOptions()
        {
            try
            {
                var entities = this.areaRepository.GetAll()
                    .Select(c => new { DisplayText = c.AREA_NAME, Value = c.AREA_ID});
                return this.Json(new { Result = "OK", Options = entities });
            }
            catch (Exception ex)
            {
                return this.Json(new { Result = "ERROR", Message = ex.Message });
            }
        }


        public ActionResult GetDivisionN1Options( String areaID = "")
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(areaID))
                {

                    var entities = this.divisionN1Repository.GeDivisionN1Items(Convert.ToInt32(areaID));
                    return this.Json(new { Result = "OK", Options = entities });
                }
                return this.Json(new { Result = "OK" });
            }
            catch (Exception ex)
            {
                return this.Json(new { Result = "ERROR", Message = ex.Message });
            }
        }


        public ActionResult GetDivisionN2Options(String divisionN1Id = "")
        {
           try
           {
                if (!string.IsNullOrWhiteSpace(divisionN1Id))
                {
                    var entities = this.divisionN2Repository.GeDivisionN2Items(Convert.ToInt32(divisionN1Id));
                    return this.Json(new { Result = "OK", Options = entities });
                }
                return this.Json(new { Result = "OK" });
            }
            catch (Exception ex)
            {
                return this.Json(new { Result = "ERROR", Message = ex.Message });
            }
        }

        public ActionResult GetDivisionN3Options(String divisionN3Id = "")
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(divisionN3Id))
                {
                    var entities = this.divisionN3Repository.GeDivisionN3Items(Convert.ToInt32(divisionN3Id));
                    return this.Json(new { Result = "OK", Options = entities });
                }
                return this.Json(new { Result = "OK" });
            }
            catch (Exception ex)
            {
                return this.Json(new { Result = "ERROR", Message = ex.Message });
            }
        }

        public ActionResult GetMeasureInfo(String rastCode, int pdtID)
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(rastCode))
                {
                    var entities = this.measureRepository.GetByRastCode(Convert.ToInt32(rastCode),pdtID);
                    return this.Json(new { Result = "OK", Measure = entities });
                }
                return this.Json(new { Result = "OK" });
            }
            catch (Exception ex)
            {
                return this.Json(new { Result = "ERROR", Message = ex.Message });
            }
        }

 // GET: Measure
        public ActionResult Index()
        {
            return View();
        }



        public ActionResult CreateMeasure(int PDT_ID, string PDT_SIGLA, int PDT_RAST_CODE, int USR_ID, int AREA_ID, int? DIV_N1_ID = null,
                                         int? DIV_N2_ID = null, int? DIV_N3_ID = null, bool? PDT_DELIVERY_OPT = false, int? MSR_DAYS = 0, int? MSR_HOUR = 0,
                                        int? MSR_MINUTES = 0, bool? isMsrOk = false, int pertOK =  0, string checkList = "")
        {
            ActionResult result = null;
            USR_ID =  CurrentUser.UserID;
            string resultMessage = string.Empty;
            try
            {
                resultMessage = this.measureRepository.Insert(PDT_ID,PDT_SIGLA,PDT_RAST_CODE,USR_ID,AREA_ID,DIV_N1_ID,
                                                                DIV_N2_ID,DIV_N3_ID,PDT_DELIVERY_OPT,MSR_DAYS,MSR_HOUR,MSR_MINUTES,
                                                                isMsrOk,pertOK,checkList);
                if (!string.IsNullOrEmpty(resultMessage))
                {
                    throw new ApplicationException(resultMessage);
                }
                result = this.Json(new { resultMessage = "" }, JsonRequestBehavior.AllowGet);
            }
            catch (ApplicationException ex)
            {
                result = this.Json(new { errorMessage = string.Format("Error en el Guardado de la Medicion, {0}", ex.Message) }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                result = this.Json(new { errorMessage = ex.InnerException }, JsonRequestBehavior.AllowGet);
            }
            return result;
        }
    }
}