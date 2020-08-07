using DeltaApp.DAL;
using DeltaApp.Models;
using DeltaApp.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DeltaApp.Controllers
{
    public class DivisionN1Controller : BaseController
    {
        AreaRepository AreaRepository = new AreaRepository();
        DivisionN1Repository DivisionN1Repository = new DivisionN1Repository();

        // GET: DivisionN1
        public ActionResult Index()
        {
            return View();
        }

        #region Metodos jTable
        /// <summary>
        /// Obtener usuarios.
        /// </summary>
        /// <param name="name">Nombre de usuario</param>
        /// <param name="jtStartIndex"></param>
        /// <param name="jtPageSize"></param>
        /// <param name="jtSorting"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult GetDivisionN1s(string name = "", int jtStartIndex = 0, int jtPageSize = 0, string jtSorting = null)
        {
            ActionResult result = null;
            try
            {
                //Lista de usuario con filtro
                var Areas = this.DivisionN1Repository.GetDivisions1(name, jtStartIndex, jtPageSize, jtSorting);
                //Conteo de usuario con filtros
                var AreaCount = this.DivisionN1Repository.GetDivisions1Count(name);
                //Resultado para contArea de jtable.
                result = Json(new { Result = "OK", Records = Areas.ToList(), TotalRecordCount = AreaCount }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                result = Json(new { Result = "ERROR", Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
            return result;
        }

        [HttpPost]
        public ActionResult GetDivisionN1ByArea(int areaId = 0, int jtStartIndex = 0, int jtPageSize = 0, string jtSorting = null)
        {
            ActionResult result = null;
            try
            {
                //Lista de usuario con filtro
                var Areas = this.DivisionN1Repository.GetDivisions1(areaId, jtStartIndex, jtPageSize, jtSorting);
                //Conteo de usuario con filtros
                var AreaCount = this.DivisionN1Repository.GetDivisions1Count(areaId);
                //Resultado para contArea de jtable.
                result = Json(new { Result = "OK", Records = Areas.ToList(), TotalRecordCount = AreaCount }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                result = Json(new { Result = "ERROR", Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
            return result;
        }

        /// <summary>
        /// Crear nuevo tipo de servicio.
        /// </summary>
        /// <param name="entity">Informacion de usuario</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult CreateDivisionN1(DIVISION_N1_VIEW entity)
        {
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                if (!this.ModelState.IsValid)
                {
                    throw new Exception("Form is not valid! Please correct it and try again.");
                }
                resultMessage = this.DivisionN1Repository.Insert(entity);
                if (string.IsNullOrEmpty(resultMessage))
                {
                    result = this.Json(new { Result = "OK", Record = entity }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    result = this.Json(new { Result = "ERROR", Message = resultMessage }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                result = this.Json(new { Result = "ERROR", Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
            return result;
        }

        /// <summary>
        /// Actualizar tipo de servicio
        /// </summary>
        /// <param name="entity">Informacion de tipo de servicio</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult UpdateDivisionN1(DIVISION_N1_VIEW entity)
        {
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                if (!this.ModelState.IsValid)
                {
                    throw new Exception("Form is not valid! Please correct it and try again.");
                }
                resultMessage = this.DivisionN1Repository.Update(entity);
                if (string.IsNullOrEmpty(resultMessage))
                {
                    result = Json(new { Result = "OK" }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    result = Json(new { Result = "ERROR", Message = resultMessage }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                result = Json(new { Result = "ERROR", Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
            return result;
        }

        /// <summary>
        /// Eliminar Area de usuario
        /// </summary>
        /// <param name="DIV_N1_ID">Id de Area de usuario</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult DeleteDivisionN1(int DIV_N1_ID)
        {
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                resultMessage = this.DivisionN1Repository.Delete(DIV_N1_ID);
                if (string.IsNullOrEmpty(resultMessage))
                {
                    result = this.Json(new { Result = "OK" }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    result = this.Json(new { Result = "ERROR", Message = resultMessage }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                result = this.Json(new { Result = "ERROR", Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
            return result;
        }

        [HttpPost]
        public JsonResult GetAreaOptions()
        {
            try
            {
                var entities = AreaRepository.GetAll()
                    .Select(c => new { DisplayText = c.AREA_NAME, Value = c.AREA_ID });
                return Json(new { Result = "OK", Options = entities });
            }
            catch (Exception ex)
            {
                return Json(new { Result = "ERROR", Message = ex.Message });
            }
        }
        #endregion Metodos jTable
    }
}