using DeltaApp.Models;
using DeltaApp.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DeltaApp.Controllers
{
    public class DivisionN2Controller : BaseController
    {
        DivisionN1Repository DivisionN1Repository = new DivisionN1Repository();
        DivisionN2Repository DivisionN2Repository = new DivisionN2Repository();

        // GET: DivisionN2
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
        public ActionResult GetDivisionN2s(string name = "", int jtStartIndex = 0, int jtPageSize = 0, string jtSorting = null)
        {
            ActionResult result = null;
            try
            {
                //Lista de usuario con filtro
                var entities = this.DivisionN2Repository.GetDivisions2(name, jtStartIndex, jtPageSize, jtSorting);
                //Conteo de usuario con filtros
                var entitiesCount = this.DivisionN2Repository.GetDivisions2Count(name);
                //Resultado para contArea de jtable.
                result = Json(new { Result = "OK", Records = entities.ToList(), TotalRecordCount = entitiesCount }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                result = Json(new { Result = "ERROR", Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
            return result;
        }

        [HttpPost]
        public ActionResult GetDivisionN2sByDivisionN1(int divisionN1Id = 0, int jtStartIndex = 0, int jtPageSize = 0, string jtSorting = null)
        {
            ActionResult result = null;
            try
            {
                //Lista de usuario con filtro
                var entities = this.DivisionN2Repository.GetDivisions2(divisionN1Id, jtStartIndex, jtPageSize, jtSorting);
                //Conteo de usuario con filtros
                var entitiesCount = this.DivisionN2Repository.GetDivisions2Count(divisionN1Id);
                //Resultado para contArea de jtable.
                result = Json(new { Result = "OK", Records = entities.ToList(), TotalRecordCount = entitiesCount }, JsonRequestBehavior.AllowGet);
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
        public ActionResult CreateDivisionN2(DIVISION_N2_VIEW entity)
        {
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                if (!this.ModelState.IsValid)
                {
                    throw new Exception("Form is not valid! Please correct it and try again.");
                }
                resultMessage = this.DivisionN2Repository.Insert(entity);
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
        public ActionResult UpdateDivisionN2(DIVISION_N2_VIEW entity)
        {
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                if (!this.ModelState.IsValid)
                {
                    throw new Exception("Form is not valid! Please correct it and try again.");
                }
                resultMessage = this.DivisionN2Repository.Update(entity);
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
        /// <param name="DIV_N2_ID">Id de Area de usuario</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult DeleteDivisionN2(int DIV_N2_ID)
        {
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                resultMessage = this.DivisionN2Repository.Delete(DIV_N2_ID);
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
        public JsonResult GetDivisionN1Options()
        {
            try
            {
                var entities = DivisionN1Repository.GetAll()
                    .Select(c => new { DisplayText = c.DIV_N1_NAME, Value = c.DIV_N1_ID });
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