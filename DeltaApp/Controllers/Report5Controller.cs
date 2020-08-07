using DeltaApp.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.Reporting.WebForms;
using DeltaApp.Repository;
using System.Drawing;
using System.IO;


namespace DeltaApp.Controllers
{
    public class Report5Controller : BaseController
    {
        ReportsRepository reportRepository = new ReportsRepository();
        [ThreadStatic]
        ProcessRepository ProcessRepository = new ProcessRepository();

        // GET: Report1
        [AllowAnonymous]
        public ActionResult Index(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ViewResult Index(GENERAL_RESUME_VIEW um)
        {
            return View(um);
        }



        public ActionResult GenerateAndDisplayReport(string QdateFrom, string QdateTo, string format)
        {

            LocalReport pertDefects = new LocalReport();

            pertDefects.ReportPath = Server.MapPath("~/Reporting/DefectPertinences.rdlc");

            List<PERTINENCES_DEFECTS> listPertinencesDefects = reportRepository.GetPertinecesDefects(QdateFrom, QdateTo).ToList();

            ReportDataSource reportDataSource = new ReportDataSource();


            reportDataSource.Name = "DefectPertinences";

            if (QdateFrom != null && QdateTo != null)
            {
                var productDefects = listPertinencesDefects;
                
                reportDataSource.Value = productDefects;

            }
            else
            {
                reportDataSource.Value = reportDataSource;

            }



            pertDefects.DataSources.Add(reportDataSource);



            ReportParameterCollection reportParameters = new ReportParameterCollection();
            reportParameters.Add(new ReportParameter("DateFrom", QdateFrom));
            reportParameters.Add(new ReportParameter("DateTo", QdateTo));
            

            pertDefects.SetParameters(reportParameters);


            string reportType = "Image";
            string mimeType;
            string encoding;
            string fileNameExtension;
            //The DeviceInfo settings should be changed based on the reportType            
            //http://msdn2.microsoft.com/en-us/library/ms155397.aspx            
            string deviceInfo = "<DeviceInfo>" +
                "  <OutputFormat>jpeg</OutputFormat>" +
                "  <PageWidth>8.5in</PageWidth>" +
                "  <PageHeight>11in</PageHeight>" +
                "  <MarginTop>0.5in</MarginTop>" +
                "  <MarginLeft>1in</MarginLeft>" +
                "  <MarginRight>1in</MarginRight>" +
                "  <MarginBottom>0.5in</MarginBottom>" +
                "</DeviceInfo>";
            Warning[] warnings;
            string[] streams;
            byte[] reportBytes;


            //Render the report            
            reportBytes = pertDefects.Render(reportType, deviceInfo, out mimeType, out encoding, out fileNameExtension, out streams, out warnings);


            //Response.AddHeader("content-disposition", "attachment; filename=NorthWindCustomers." + fileNameExtension); 
            if (format == null)
            {
                return File(reportBytes, "image/jpeg");
            }
            else if (format == "PDF")
            {
                return File(reportBytes, "pdf");
            }
            else
            {
                /*var file = File(renderedBytes, "image/jpeg");

                var fileText = ImageToBase64(file, System.Drawing.Imaging.ImageFormat.Jpeg);*/

                string dateStamp = DateTime.Now.ToString("yyyyMMddHHmmss");
                string finalReportName = dateStamp + "PertinenciasDefect.pdf";
                Report1Controller.CreatePDFfile(pertDefects, finalReportName);

                return this.Json(new { Result = "OK", Report = Convert.ToBase64String(reportBytes), base65 = Request.Url.AbsoluteUri.ToString().Replace("Report5/GenerateAndDisplayReport", "ReportPDF/" + finalReportName) });
            }

        }

        static double F(double x)
        {
            MathNet.Numerics.Distributions.Normal result = new MathNet.Numerics.Distributions.Normal();
            return result.CumulativeDistribution(x);
        }

        public ActionResult DownloadReport(string territory, string format)
        {
            LocalReport localReport = new LocalReport();
            localReport.ReportPath = Server.MapPath("~/Reporting/DefectPertinences.rdlc");
            List<GENERAL_RESUME_VIEW> reportList = reportRepository.GetAll().ToList();
            ReportDataSource reportDataSource = new ReportDataSource();
            reportDataSource.Name = "General_Resume_View";
            if (territory != null)
            {
                var customerfilterList = from c in reportList
                                         where c.PDT_NAME == territory
                                         select c;


                reportDataSource.Value = customerfilterList;
            }
            else
                reportDataSource.Value = reportList;

            localReport.DataSources.Add(reportDataSource);
            string reportType = "Image";
            string mimeType;
            string encoding;
            string fileNameExtension;
            //The DeviceInfo settings should be changed based on the reportType            
            //http://msdn2.microsoft.com/en-us/library/ms155397.aspx            
            string deviceInfo = "<DeviceInfo>" +
                "  <OutputFormat>PDF</OutputFormat>" +
                "  <PageWidth>8.5in</PageWidth>" +
                "  <PageHeight>11in</PageHeight>" +
                "  <MarginTop>0.5in</MarginTop>" +
                "  <MarginLeft>1in</MarginLeft>" +
                "  <MarginRight>1in</MarginRight>" +
                "  <MarginBottom>0.5in</MarginBottom>" +
                "</DeviceInfo>";
            Warning[] warnings;
            string[] streams;
            byte[] renderedBytes;
            //Render the report            
            renderedBytes = localReport.Render(reportType, deviceInfo, out mimeType, out encoding, out fileNameExtension, out streams, out warnings);
            //Response.AddHeader("content-disposition", "attachment; filename=NorthWindCustomers." + fileNameExtension); 
            if (format == null)
            {
                return File(renderedBytes, "image/tiff");
            }
            else if (format == "PDF")
            {
                return File(renderedBytes, mimeType);
            }
            else
            {
                return File(renderedBytes, "image/tiff");
            }
        }

        public String dateFrom;
        public String dateTo;

        public ActionResult metodoprueba(string dFrom, string dTo)
        {

            dateFrom = dFrom;
            dateTo = dTo;
            return this.Json(new { Result = "OK", Options = dFrom });
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

    }
}