using DeltaApp.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Globalization;
using System.Linq;
using System.Web;

namespace DeltaApp.DAL
{
    public class DataContext : DbContext
    {
        public DataContext()
            : base("name=DeltaBDEntities")
        {

        }

        public DbSet<USER> User { get; set; }
        public DbSet<ROL> Rol { get; set; }
        public DbSet<ROL_VIEW> ViewRol { get; set; }
        public DbSet<AREA_VIEW> ViewArea { get; set; }
        public DbSet<GOAL_CONFIABILITY_INDEX> GoalConfiability { get; set; }

        /// <summary>
        /// Permite obtener los permisos asociados al tipo de usuario.
        /// </summary>
        /// <param name="userType"></param>
        /// <returns></returns>
        public List<USER_TYPE_MODULES> spGetUserTypeModules(int userType)
        {
            using (var context = new DeltaBDEntities())
            {
                return context.GET_USER_TYPE_MODULES(userType).ToList();
            }
        }

        #region Rol
        public List<ROL_VIEW> spGetRols()
        {
            using (var context = new DeltaBDEntities())
            {
                return context.GET_ROL_VIEW().ToList();
            }
        }

        public string spCreateRol(ROL_VIEW rolInfo)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.INSERT_ROL(rolInfo.ROL_NAME, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spUpdateRol(ROL_VIEW rolInfo)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.UPDATE_ROL(rolInfo.ROL_ID, rolInfo.ROL_NAME, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spDeleteRol(int rolId)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.DELETE_ROL(rolId.ToString(), outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public List<PRODUCT_ROL_QUERY_VIEW> GetProduct(int userRoleId)
        {
            using (var context = new DeltaBDEntities())
            {
                return context.GET_PRODUCT_ROL_QUERY_VIEW(userRoleId).ToList();
            }
        }

        public string spInsertRolProducts(int rolId, string productsId)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.INSERT_ROL_PRODUCT(rolId, productsId, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }
        #endregion Rol

        #region Area
        public List<AREA_VIEW> spGetAreas()
        {
            using (var context = new DeltaBDEntities())
            {
                return context.GET_AREA_VIEW().ToList();
            }
        }

        public string spCreateArea(AREA_VIEW areaInfo)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.INSERT_AREA(areaInfo.AREA_NAME, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spUpdateArea(AREA_VIEW areaInfo)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.UPDATE_AREA(areaInfo.AREA_ID, areaInfo.AREA_NAME, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spDeleteArea(int areaId)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.DELETE_AREA(areaId, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }
        #endregion Area

        #region DivisionN1
        public List<DIVISION_N1_VIEW> spGetDivisionN1()
        {
            using (var context = new DeltaBDEntities())
            {
                return context.GET_DIVISION_N1_VIEW().ToList();
            }
        }

        public string spCreateDivisionN1(DIVISION_N1_VIEW entity)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.INSERT_DIVISION_N1(entity.DIV_N1_NAME, entity.AREA_ID, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spUpdateDivisionN1(DIVISION_N1_VIEW entity)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.UPDATE_DIVISION_N1(entity.DIV_N1_ID, entity.DIV_N1_NAME, entity.AREA_ID, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spDeleteDivisionN1(int entityId)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.DELETE_DIVISION_N1(entityId, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }
        #endregion DivisionN1

        #region DivisionN2
        public List<DIVISION_N2_VIEW> spGetDivisionN2()
        {
            using (var context = new DeltaBDEntities())
            {
                return context.GET_DIVISION_N2_VIEW().ToList();
            }
        }

        public string spCreateDivisionN2(DIVISION_N2_VIEW entity)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.INSERT_DIVISION_N2(entity.DIV_N2_NAME, entity.DIV_N1_ID, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spUpdateDivisionN2(DIVISION_N2_VIEW entity)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.UPDATE_DIVISION_N2(entity.DIV_N2_ID, entity.DIV_N2_NAME, entity.DIV_N1_ID, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spDeleteDivisionN2(int entityId)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.DELETE_DIVISION_N2(entityId, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }
        #endregion DivisionN2

        #region DivisionN3
        public List<DIVISION_N3_VIEW> spGetDivisionN3()
        {
            using (var context = new DeltaBDEntities())
            {
                return context.GET_DIVISION_N3_VIEW().ToList();
            }
        }

        public string spCreateDivisionN3(DIVISION_N3_VIEW entity)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.INSERT_DIVISION_N3(entity.DIV_N3_NAME, entity.DIV_N2_ID, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spUpdateDivisionN3(DIVISION_N3_VIEW entity)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.UPDATE_DIVISION_N3(entity.DIV_N3_ID, entity.DIV_N3_NAME, entity.DIV_N2_ID, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spDeleteDivisionN3(int entityId)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.DELETE_DIVISION_N3(entityId, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }
        #endregion DivisionN3

        #region Proceso0
        public List<PROCESS_N0_VIEW> spGetProcess0()
        {
            using (var context = new DeltaBDEntities())
            {
                return context.GET_PROCESS_N0_VIEW().ToList();
            }
        }

        public string spCreateProcess0(PROCESS_N0_VIEW entity)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.INSERT_PROCESS_N0(entity.PROC_N0_NAME, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spUpdateProcess0(PROCESS_N0_VIEW entity)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.UPDATE_PROCESS_N0(entity.PROC_N0_ID, entity.PROC_N0_NAME, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spDeleteProcess0(int entityId)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.DELETE_PROCESS_N0(entityId, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }
        #endregion Proceso0

        #region Proceso1
        public List<PROCESS_N1_VIEW> spGetProcess1()
        {
            using (var context = new DeltaBDEntities())
            {
                return context.GET_PROCESS_N1_VIEW().ToList();
            }
        }

        public string spCreateProcess1(PROCESS_N1_VIEW entity)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.INSERT_PROCESS_N1(entity.PROC_N1_NAME, entity.PROC_N0_ID, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spUpdateProcess1(PROCESS_N1_VIEW entity)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.UPDATE_PROCESS_N1(entity.PROC_N1_ID, entity.PROC_N1_NAME, entity.PROC_N0_ID, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spDeleteProcess1(int entityId)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.DELETE_PROCESS_N1(entityId, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }
        #endregion Proceso1

        #region Proceso2
        public List<PROCESS_N2_VIEW> spGetProcess2()
        {
            using (var context = new DeltaBDEntities())
            {
                return context.GET_PROCESS_N2_VIEW().ToList();
            }
        }

        public string spCreateProcess2(PROCESS_N2_VIEW entity)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.INSERT_PROCESS_N2(entity.PROC_N2_NAME, entity.PROC_N1_ID, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spUpdateProcess2(PROCESS_N2_VIEW entity)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.UPDATE_PROCESS_N2(entity.PROC_N2_ID, entity.PROC_N2_NAME, entity.PROC_N1_ID, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spDeleteProcess2(int entityId)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.DELETE_PROCESS_N2(entityId, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }
        #endregion Proceso2

        #region Proceso3
        public List<PROCESS_N3_VIEW> spGetProcess3()
        {
            using (var context = new DeltaBDEntities())
            {
                return context.GET_PROCESS_N3_VIEW().ToList();
            }
        }

        public string spCreateProcess3(PROCESS_N3_VIEW entity)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.INSERT_PROCESS_N3(entity.PROC_N3_NAME, entity.PROC_N2_ID, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spUpdateProcess2(PROCESS_N3_VIEW entity)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.UPDATE_PROCESS_N3(entity.PROC_N3_ID, entity.PROC_N2_ID, entity.PROC_N3_NAME, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spDeleteProcess3(int entityId)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.DELETE_PROCESS_N3(entityId, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }
        #endregion Proceso2

        #region Pertinencias
        public List<PERTINENCES_VIEW> spGetPertinences()
        {
            using (var context = new DeltaBDEntities())
            {
                return context.GET_PERTINENCES_VIEW().ToList();
            }
        }

        public string spCreatePertinence(PERTINENCES_VIEW pertinenceInfo)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.INSERT_PERTINENCE(pertinenceInfo.PERT_DETAIL, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spUpdatePertinence(PERTINENCES_VIEW pertinenceInfo)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.UPDATE_PERTINENCE(pertinenceInfo.PERT_ID, pertinenceInfo.PERT_DETAIL, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spDeletePertinence(int pertinenceId)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.DELETE_PERTINENCE(pertinenceId, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }
        #endregion Pertinencias

        #region Usuario
        public List<USERS_VIEW> spGetUser()
        {
            using (var context = new DeltaBDEntities())
            {
                return context.GET_USERS_VIEW().ToList();
            }
        }

        public string spCreateUser(USERS_VIEW userInfo)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.INSERT_USER(userInfo.ROL_ID, userInfo.USR_DOCUMENT, userInfo.USR_NAME, userInfo.USR_PU, userInfo.USR_MAIL,
                    userInfo.USR_NICK, userInfo.USR_PASS, Convert.ToSByte(userInfo.USR_ACTIVE), userInfo.USR_TYPE,
                    outputResultMessageParameter);
                string output = Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
                return output;
            }
        }

        public string spUpdateUser(USERS_VIEW userInfo)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.UPDATE_USER(userInfo.USR_ID, userInfo.USR_DOCUMENT, userInfo.USR_NAME, userInfo.USR_PU, userInfo.USR_MAIL,
                    userInfo.USR_NICK, userInfo.USR_PASS, Convert.ToSByte(userInfo.USR_ACTIVE), userInfo.USR_TYPE, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spDeleteUser(int usrID)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.DELETE_USER(usrID, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }
        #endregion Usuario

        #region Producto
        public List<PRODUCT_VIEW> spGetProducts()
        {
            using (var context = new DeltaBDEntities())
            {
                return context.GET_PRODUCT_VIEW().ToList();
            }
        }

        public List<PRODUCT_PERTINENCES_VIEW> spGetProductPertinences(int pdtID)
        {
            using (var context = new DeltaBDEntities())
            {
                return context.GET_PRODUCT_PERTINECES_VIEW(pdtID).ToList();
            }
        }

        public string spCreateProduct(PRODUCT_VIEW productInfo, string checkList)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.INSERT_PRODUCT(productInfo.PDT_NAME, Convert.ToSByte(productInfo.PDT_HASCODE), productInfo.PDT_SIGLA, productInfo.PROC_N0_ID, productInfo.PROC_N1_ID,
                    productInfo.PROC_N2_ID, productInfo.PROC_N3_ID, productInfo.PDT_DESC, productInfo.OP_TYPE_ID, productInfo.PDT_OPORTUNITY_DATE_ACCORDED,
                    productInfo.PDT_OPORTUNITY_PTO_REF, productInfo.PDT_OPORTUNITY_DAYS, productInfo.PDT_OPORTUNITY_HOURS, productInfo.PDT_OPORTUNITY_MINUTES, productInfo.GOAL_TYPE_ID,
                    !string.IsNullOrWhiteSpace(productInfo.GOAL_QUANTITY_MONTH) ? Convert.ToInt32(productInfo.GOAL_QUANTITY_MONTH) : (int?)null, productInfo.GOAL_POBLATION,
                    productInfo.GOAL_CONFIABILITY_INDEX, productInfo.GOAL_SAMPLES, checkList, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spUpdateProduct(PRODUCT_VIEW productInfo, string checkList)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.UPDATE_PRODUCT(productInfo.PDT_ID, productInfo.PDT_NAME, productInfo.PDT_SIGLA, Convert.ToSByte(productInfo.PDT_HASCODE), productInfo.PROC_N0_ID,
                    productInfo.PROC_N1_ID, productInfo.PROC_N2_ID, productInfo.PROC_N3_ID, productInfo.PDT_DESC, productInfo.OP_TYPE_ID, productInfo.PDT_OPORTUNITY_DATE_ACCORDED,
                    productInfo.PDT_OPORTUNITY_PTO_REF, productInfo.PDT_OPORTUNITY_DAYS, productInfo.PDT_OPORTUNITY_HOURS, productInfo.PDT_OPORTUNITY_MINUTES, productInfo.GOAL_TYPE_ID,
                    !string.IsNullOrWhiteSpace(productInfo.GOAL_QUANTITY_MONTH) ? Convert.ToInt32(productInfo.GOAL_QUANTITY_MONTH) : (int?)null, productInfo.GOAL_POBLATION,
                    productInfo.GOAL_CONFIABILITY_INDEX, productInfo.GOAL_SAMPLES, checkList, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spDeleteProduct(int areaId)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.DELETE_PRODUCT(areaId, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        /// <summary>
        /// Obtener lista de productos asociados a un rol de usuario.
        /// </summary>
        /// <param name="userRoleId">Id de rol de usuario.</param>
        /// <returns></returns>
        public List<PRODUCT_ROL_VIEW> spGetUserRoleProducts(int userID)
        {
            using (var context = new DeltaBDEntities())
            {
                return context.GET_PRODUCT_ROL_VIEW_USER(userID).ToList();
            }
        }


        #endregion Producto

        #region Medicion
        public List<MEASURE_VIEW> spGetMeasures()
        {
            using (var context = new DeltaBDEntities())
            {
                return context.GET_MEASURE_VIEW().ToList();
            }
        }

        public string spCreateMeasure(MEASURE_VIEW measureInfo, bool? msrIsOK, string checkList)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {

                context.INSERT_MEASURE(measureInfo.PDT_ID, measureInfo.PDT_SIGLA, Convert.ToInt32(measureInfo.PDT_RAST_CODE), measureInfo.USR_ID, measureInfo.AREA_ID, measureInfo.DIV_N1_ID,
                                        measureInfo.DIV_N2_ID, measureInfo.DIV_N3_ID, (Convert.ToSByte(measureInfo.PDT_DELIVERY_OPT)), measureInfo.MSR_DAYS, measureInfo.MSR_HOUR,
                                        measureInfo.MSR_MINUTES, Convert.ToSByte(msrIsOK), measureInfo.MSR_PERTINENCES_OK, checkList, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }



        public string spUpdateMeasure(MEASURE_VIEW measureInfo)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                //context.UPDATE_AREA(productInfo.AREA_ID, productInfo.AREA_NAME, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public string spDeleteMeasure(int measureId)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                context.DELETE_MEASURE(measureId, outputResultMessageParameter);
                return Convert.ToString(outputResultMessageParameter.Value, CultureInfo.InvariantCulture);
            }
        }

        public List<PERTINENCES_BY_MEASURE_VIEW> spGetPertinencesbyCode(string code)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                return context.GET_PERTINENECES_MEASURE_VIEW().ToList();

            }
        }


        public List<MEASURE_PERTINENCES_VIEW> spGetMeasurePertinences()
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                return context.GET_MEASURE_PERTINENCES_VIEW().ToList();

            }
        }

        public List<GENERAL_RESUME_VIEW> spGetGeneralResume()
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                return context.GET_GENERAL_RESUME_VIEW().ToList();

            }
        }

        public List<USER_PU_RELATION_MEASURE_VIEW> spGetUserPuRelation(DateTime dateFrom, DateTime dateTo)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                return context.GET_USER_PU_RELATION_MEASURE_VIEW(dateFrom, dateTo).ToList();

            }
        }

        public List<ROL_RELATION_MEASURE_VIEW> spGetRolRelation(DateTime dateFrom, DateTime dateTo)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                return context.GET_ROL_RELATION_MEASURE_VIEW(dateFrom, dateTo).ToList();

            }
        }

        public List<EFECTIVITY_VIEW> spGetEfectivity(DateTime dateFrom, DateTime dateTo)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                return context.GET_EFECTIVITY_VIEW(dateFrom, dateTo).ToList();

            }
        }

        public List<EFECTIVITY_OK_VIEW> spGetEfectivityOK(DateTime dateFrom, DateTime dateTo)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                return context.GET_EFECTIVITY_OK_VIEW(dateFrom, dateTo).ToList();

            }
        }

        public List<MEASURE_NO_PRODUCTS_VIEW> spGetNoMeasureProducts()
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                return context.GET_PRODUCT_NO_MEASURE_VIEW().ToList();

            }
        }

        public List<PRODUCT_DEFECTS_DETAIL> spGetDefectProducts(DateTime dateFrom, DateTime dateTo)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                return context.GET_PRODUCT_DEFECTS_DETAIL(dateFrom, dateTo).ToList();

            }
        }

        public List<PERTINENCES_DEFECTS> spGetPertinencesDefects(DateTime dateFrom, DateTime dateTo)
        {
            ObjectParameter outputResultMessageParameter = new ObjectParameter("resultMessage", typeof(string));
            using (var context = new DeltaBDEntities())
            {
                return context.GET_PERTINENCES_DEFECTS(dateFrom, dateTo).ToList();

            }
        }

        #endregion Medicion
    }
}