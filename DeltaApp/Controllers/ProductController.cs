using AlbatrosSoft.Common;
using AlbatrosSoft.Common.Web;
using DeltaApp.Models;
using DeltaApp.Repository;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DeltaApp.Controllers
{
    public class ProductController : BaseController
    {
        [ThreadStatic]
        ProcessRepository ProcessRepository = new ProcessRepository();
        [ThreadStatic]
        Process1Repository Process1Repository = new Process1Repository();
        [ThreadStatic]
        Process2Repository Process2Repository = new Process2Repository();
        [ThreadStatic]
        Process3Repository Process3Repository = new Process3Repository();
        [ThreadStatic]
        ProductRepository ProductRepository = new ProductRepository();
        [ThreadStatic]
        GoalConfiabilityRepository GoalConfiabilityRepository = new GoalConfiabilityRepository();

        // GET: Product
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult EditIndex()
        {
            return View();
        }

        public ActionResult EditDetailIndex(int PDT_ID)
        {
            ViewBag.PDT_ID = PDT_ID;
            return View();
        }

        [HttpPost]
        public ActionResult GetProducts(string PDT_NAME = "", string PDT_SIGLA = "", string PDT_DESC = "",
            int jtStartIndex = 0, int jtPageSize = 0, string jtSorting = null)
        {
            ActionResult result = null;
            try
            {
                //Lista de usuario con filtro
                var entities = this.ProductRepository.GetProducts(PDT_NAME, PDT_SIGLA, PDT_DESC, jtStartIndex, jtPageSize, jtSorting);
                //Conteo de usuario con filtros
                var entityCount = this.ProductRepository.GetProductsCount(PDT_NAME, PDT_SIGLA, PDT_DESC);
                //Resultado para contArea de jtable.
                result = Json(new { Result = "OK", Records = entities.ToList(), TotalRecordCount = entityCount }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                result = Json(new { Result = "ERROR", Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
            return result;
        }

        /// <summary>
        /// Obtener informacion de producto seleccionado.
        /// </summary>
        /// <param name="PDT_ID">Id de producto</param>
        /// <returns></returns>
        public ActionResult GetSelectedProductInfo(int PDT_ID)
        {
            ActionResult result = null;
            try
            {
                var entity = this.ProductRepository.GetById(PDT_ID);
                if (entity == null)
                {
                    result = this.Json(new { errorMessage = "El producto seleccionado no existe en el sistema" });
                }
                result = this.Json(new { productInfo = entity }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                result = Json(new { errorMessage = ex.Message }, JsonRequestBehavior.AllowGet);
            }

            return result;
        }

        /// <summary>
        /// Obtener pertinencias de un producto seleccionado.
        /// </summary>
        /// <param name="PDT_ID">Id de producto</param>
        /// <returns></returns>
        public ActionResult GetProductPertineces(int PDT_ID)
        {
            ActionResult result = null;
            try
            {
                var entities = this.ProductRepository.GetProductPertineces(PDT_ID);
                if (entities == null)
                {
                    result = this.Json(new { resultMessage = "El producto seleccionado no tiene pertinencias asociadas." });
                }
                result = this.Json(new { pertinencesInfo = entities }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                result = Json(new { errorMessage = ex.Message }, JsonRequestBehavior.AllowGet);
            }
            return result;
        }

        /// <summary>
        /// Crear nuevo tipo de servicio.
        /// </summary>
        /// <param name="entity">Informacion de usuario</param>
        /// <returns></returns>
        public ActionResult CreateProduct(string PDT_NAME = "", string PDT_SIGLA = "", bool PDT_HASCODE = false, string PDT_CODE = "",
            int? PROC_N0_ID = null, int? PROC_N1_ID = null, int? PROC_N2_ID = null, int? PROC_N3_ID = null, string PDT_DESC = "",
            int? OP_TYPE_ID = null, DateTime? PDT_OPORTUNITY_DATE_ACCORDED = null, string PDT_OPORTUNITY_PTO_REF = "",
            int? PDT_OPORTUNITY_DAYS = null, int? PDT_OPORTUNITY_HOURS = null, int? PDT_OPORTUNITY_MINUTES = null, int GOAL_TYPE_ID = 0,
            string GOAL_QUANTITY_MONTH = "", string GOAL_POBLATION = "", int? GOAL_CONFIABILITY_INDEX = null, int? GOAL_SAMPLES = null,
            string checkList = "")
        {
            String testChain = "call INSERT_PRODUCT( '" +
            PDT_NAME + "','" +
            PDT_HASCODE + "','" +
            PDT_SIGLA + "','" +
            PROC_N0_ID + "','" +
            PROC_N1_ID + "','" +
            PROC_N2_ID + "','" +
            PROC_N3_ID + "','" +
            PDT_DESC + "','" +
            OP_TYPE_ID + "','" +
            PDT_OPORTUNITY_DATE_ACCORDED + "','" +
            PDT_OPORTUNITY_PTO_REF + "','" +
            PDT_OPORTUNITY_DAYS + "','" +
            PDT_OPORTUNITY_HOURS + "','" +
            PDT_OPORTUNITY_MINUTES + "','" +
            GOAL_TYPE_ID + "','" +
            GOAL_QUANTITY_MONTH + "','" +
            GOAL_POBLATION + "','" +
            GOAL_CONFIABILITY_INDEX + "','" +
            GOAL_SAMPLES + "','" +
            checkList + "','" +
            "@res);";

            testChain = testChain + "select @res";
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                testChain = testChain + "select @res";
                resultMessage = this.ProductRepository.Insert(PDT_NAME, PDT_SIGLA, PDT_HASCODE, PROC_N0_ID, PROC_N1_ID, PROC_N2_ID, PROC_N3_ID,
                        PDT_DESC, OP_TYPE_ID, PDT_OPORTUNITY_DATE_ACCORDED, PDT_OPORTUNITY_PTO_REF, PDT_OPORTUNITY_DAYS, PDT_OPORTUNITY_HOURS,
                        PDT_OPORTUNITY_MINUTES, GOAL_TYPE_ID, GOAL_QUANTITY_MONTH, GOAL_POBLATION, GOAL_CONFIABILITY_INDEX, GOAL_SAMPLES, checkList);
                if (!string.IsNullOrEmpty(resultMessage))
                {
                    throw new ApplicationException(resultMessage);
                }
                result = this.Json(new { resultMessage = "Se ha creado el producto correctamente." }, JsonRequestBehavior.AllowGet);
            }
            catch (ApplicationException ex)
            {
                result = this.Json(new { errorMessage = string.Format("Error en creacion de producto, {0}", ex.Message) }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                result = this.Json(new { errorMessage = ex.InnerException }, JsonRequestBehavior.AllowGet);
            }

            return result;
        }

        /// <summary>
        /// Actualizar informacion de producto seleccionado
        /// </summary>
        /// <param name="PDT_ID">Id de producto</param>
        /// <param name="PDT_NAME">Nombre de producto</param>
        /// <param name="PDT_SIGLA">Sigla de producto</param>
        /// <param name="PDT_HASCODE">Tiene codigo</param>
        /// <param name="PDT_CODE">Codigo</param>
        /// <param name="PROC_N0_ID"></param>
        /// <param name="PROC_N1_ID"></param>
        /// <param name="PROC_N2_ID"></param>
        /// <param name="PROC_N3_ID"></param>
        /// <param name="PDT_DESC"></param>
        /// <param name="OP_TYPE_ID"></param>
        /// <param name="PDT_OPORTUNITY_DATE_ACCORDED"></param>
        /// <param name="PDT_OPORTUNITY_PTO_REF"></param>
        /// <param name="PDT_OPORTUNITY_DAYS"></param>
        /// <param name="PDT_OPORTUNITY_HOURS"></param>
        /// <param name="PDT_OPORTUNITY_MINUTES"></param>
        /// <param name="GOAL_TYPE_ID"></param>
        /// <param name="GOAL_QUANTITY_MONTH"></param>
        /// <param name="GOAL_POBLATION"></param>
        /// <param name="GOAL_CONFIABILITY_INDEX"></param>
        /// <param name="GOAL_SAMPLES"></param>
        /// <param name="checkList"></param>
        /// <returns></returns>
        public ActionResult UpdateProduct(int PDT_ID = 0, string PDT_NAME = "", string PDT_SIGLA = "", bool PDT_HASCODE = false, string PDT_CODE = "",
            int? PROC_N0_ID = null, int? PROC_N1_ID = null, int? PROC_N2_ID = null, int? PROC_N3_ID = null, string PDT_DESC = "", int? OP_TYPE_ID = null,
            DateTime? PDT_OPORTUNITY_DATE_ACCORDED = null, string PDT_OPORTUNITY_PTO_REF = "", int? PDT_OPORTUNITY_DAYS = null, int? PDT_OPORTUNITY_HOURS = null,
            int? PDT_OPORTUNITY_MINUTES = null, int GOAL_TYPE_ID = 0, string GOAL_QUANTITY_MONTH = "", string GOAL_POBLATION = "", int? GOAL_CONFIABILITY_INDEX = null,
            int? GOAL_SAMPLES = null, string checkList = "")
        {
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                resultMessage = this.ProductRepository.Update(PDT_ID, PDT_NAME, PDT_SIGLA, PDT_HASCODE, PROC_N0_ID, PROC_N1_ID, PROC_N2_ID, PROC_N3_ID,
                        PDT_DESC, OP_TYPE_ID, PDT_OPORTUNITY_DATE_ACCORDED, PDT_OPORTUNITY_PTO_REF, PDT_OPORTUNITY_DAYS, PDT_OPORTUNITY_HOURS,
                        PDT_OPORTUNITY_MINUTES, GOAL_TYPE_ID, GOAL_QUANTITY_MONTH, GOAL_POBLATION, GOAL_CONFIABILITY_INDEX, GOAL_SAMPLES, checkList);
                if (!string.IsNullOrEmpty(resultMessage))
                {
                    throw new ApplicationException(resultMessage);
                }
                result = this.Json(new { resultMessage = "Se ha actualizado el producto correctamente." }, JsonRequestBehavior.AllowGet);
            }
            catch (ApplicationException ex)
            {
                result = this.Json(new { errorMessage = string.Format("Error en actualizacion de producto, {0}", ex.Message) }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                result = this.Json(new { errorMessage = ex.InnerException }, JsonRequestBehavior.AllowGet);
            }
            return result;
        }

        /// <summary>
        /// Eliminar Area de usuario
        /// </summary>
        /// <param name="PROC_N0_ID">Id de Area de usuario</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult DeleteProduct(int PDT_ID)
        {
            ActionResult result = null;
            string resultMessage = string.Empty;
            try
            {
                resultMessage = this.ProductRepository.Delete(PDT_ID);
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
                result = this.Json(new { Result = "ERROR", Message = ex.InnerException }, JsonRequestBehavior.AllowGet);
            }
            return result;
        }


        public ActionResult GetGoalConfiabilityOptions()
        {
            try
            {
                var entities = this.GoalConfiabilityRepository.GetAll()
                    .Select(c => new Models.SelectListItem(c.ID_INDEX.ToString(), c.INDEX_VALUE.ToString()));
                return this.Json(new { Result = "OK", Options = entities });
            }
            catch (Exception ex)
            {
                return this.Json(new { Result = "ERROR", Message = ex.Message });
            }
        }

        public ActionResult GetProcess0Options()
        {
            try
            {
                var entities = this.ProcessRepository.GetAll()
                    .Select(c => new Models.SelectListItem { DisplayText = c.PROC_N0_NAME, Value = c.PROC_N0_ID.ToString() });
                return this.Json(new { Result = "OK", Options = entities });
            }
            catch (Exception ex)
            {
                return this.Json(new { Result = "ERROR", Message = ex.Message });
            }
        }

        public ActionResult GetProcess1Options(string processId = "")
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(processId))
                {

                    var entities = this.Process1Repository.GetProcess1Items(Convert.ToInt32(processId));
                    return this.Json(new { Result = "OK", Options = entities });
                }
                return this.Json(new { Result = "OK" });
            }
            catch (Exception ex)
            {
                return this.Json(new { Result = "ERROR", Message = ex.Message });
            }
        }

        public ActionResult GetProcess2Options(string processId = "")
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(processId))
                {
                    var entities = this.Process2Repository.GetProcess2Items(Convert.ToInt32(processId));
                    return this.Json(new { Result = "OK", Options = entities });
                }
                return this.Json(new { Result = "OK" });
            }
            catch (Exception ex)
            {
                return this.Json(new { Result = "ERROR", Message = ex.Message });
            }
        }

        public ActionResult GetProcess3Options(string processId = "")
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(processId))
                {
                    var entities = this.Process3Repository.GetProcess3Items(Convert.ToInt32(processId));
                    return this.Json(new { Result = "OK", Options = entities });
                }
                return this.Json(new { Result = "OK" });
            }
            catch (Exception ex)
            {
                return this.Json(new { Result = "ERROR", Message = ex.Message });
            }
        }

        #region Busqueda y ordenamiento
        private IEnumerable<PRODUCT_VIEW> SearchInfo(IEnumerable<PRODUCT_VIEW> entities, string PDT_NAME = "", string PDT_SIGLA = "",
            string PDT_DESC = "")
        {
            var dataSource = entities;
            IEnumerable<PRODUCT_VIEW> searchResult = null;
            Func<PRODUCT_VIEW, bool> filterCriteria = p => true;
            var filterHelper = new FilterHelper<PRODUCT_VIEW>();
            //Nombre
            if (!string.IsNullOrWhiteSpace(PDT_NAME))
            {
                filterCriteria = filterHelper.AddFilterExpression(filterCriteria, p => p.PDT_NAME.ToUpper(CultureInfo.InvariantCulture)
                    .Contains(PDT_NAME.ToUpper(CultureInfo.InvariantCulture)));
            }
            if (!string.IsNullOrWhiteSpace(PDT_SIGLA))
            {
                filterCriteria = filterHelper.AddFilterExpression(filterCriteria, p => p.PDT_SIGLA.ToUpper(CultureInfo.InvariantCulture)
                    .Contains(PDT_SIGLA.ToUpper(CultureInfo.InvariantCulture)));
            }
            if (!string.IsNullOrWhiteSpace(PDT_DESC))
            {
                filterCriteria = filterHelper.AddFilterExpression(filterCriteria, p => p.PDT_DESC.ToUpperInvariant()
                    .Contains(PDT_DESC.ToUpperInvariant()));
            }
            if (filterCriteria != null)
            {
                searchResult = dataSource.Where(filterCriteria);
                return searchResult;
            }
            return dataSource;
        }

        /// <summary>
        /// Ordenamiento
        /// </summary>
        /// <param name="sortExpression">Tipo de ordenamiento</param>
        /// <param name="entities">Lista a ordenar</param>
        /// <returns></returns>      
        private IEnumerable<PRODUCT_VIEW> Sorting(string sortExpression, IEnumerable<PRODUCT_VIEW> entities)
        {
            if (!string.IsNullOrEmpty(sortExpression))
            {
                string[] sortProperties = sortExpression.Split(' ');
                string sortColumn = sortProperties[0];
                string sortDirection = sortProperties[1];
                IEnumerable<PRODUCT_VIEW> sortedData = null;
                if (entities != null)
                {
                    sortedData = SortingHelper<PRODUCT_VIEW>.SortBy(entities, sortColumn, sortDirection);
                }
                return sortedData;
            }
            return entities;
        }

        #endregion Busqueda y ordenamiento
    }
}