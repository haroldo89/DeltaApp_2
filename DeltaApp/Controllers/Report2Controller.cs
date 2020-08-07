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
    public class Report2Controller : BaseController
    {
        ReportsRepository reportRepository = new ReportsRepository();

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

            LocalReport localReportEfectivityBAD = new LocalReport();
            LocalReport localReportEfectivityOK = new LocalReport();

            localReportEfectivityBAD.ReportPath = Server.MapPath("~/Reporting/Efectivity1.rdlc");
            localReportEfectivityOK.ReportPath = Server.MapPath("~/Reporting/Efectivity2.rdlc");

            List<EFECTIVITY_VIEW> areaDefects = reportRepository.GetEfectivity(QdateFrom, QdateTo).ToList();
            List<EFECTIVITY_OK_VIEW> areaOK = reportRepository.GetEfectivityOK(QdateFrom, QdateTo).ToList();

            ReportDataSource reportDataEfectivityBAD = new ReportDataSource();
            ReportDataSource reportDataEfectivityOK = new ReportDataSource();

            reportDataEfectivityBAD.Name = "EfectivityDefects";
            reportDataEfectivityOK.Name = "EfectivityOk";
         
            if (QdateFrom != null && QdateTo != null)
            {
                reportDataEfectivityBAD.Value = areaDefects;
                reportDataEfectivityOK.Value = areaOK;
            }
            else
            {
                reportDataEfectivityBAD.Value = reportDataEfectivityBAD;
                reportDataEfectivityOK.Value = reportDataEfectivityOK;
            }
                


            localReportEfectivityBAD.DataSources.Add(reportDataEfectivityBAD);
            localReportEfectivityOK.DataSources.Add(reportDataEfectivityOK);


            ReportParameterCollection reportParameters = new ReportParameterCollection();
            reportParameters.Add(new ReportParameter("dataFrom", QdateFrom));
            reportParameters.Add(new ReportParameter("dataTo", QdateTo));



            localReportEfectivityBAD.SetParameters(reportParameters);
            localReportEfectivityOK.SetParameters(reportParameters);


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
            byte[] reportAreaBadBytes;
            byte[] reportAreaOkBytes;

            //Render the report            
            reportAreaBadBytes = localReportEfectivityBAD.Render(reportType, deviceInfo, out mimeType, out encoding, out fileNameExtension, out streams, out warnings);
            reportAreaOkBytes = localReportEfectivityOK.Render(reportType, deviceInfo, out mimeType, out encoding, out fileNameExtension, out streams, out warnings);

            //Response.AddHeader("content-disposition", "attachment; filename=NorthWindCustomers." + fileNameExtension); 
            if (format == null)
            {
                return File(reportAreaBadBytes, "image/jpeg");
            }
            else if (format == "PDF")
            {
                return File(reportAreaBadBytes, "pdf");
            }
            else
            {
                /*var file = File(renderedBytes, "image/jpeg");

                var fileText = ImageToBase64(file, System.Drawing.Imaging.ImageFormat.Jpeg);*/

                string finalReportName = CreateAndMergeReport(localReportEfectivityBAD, localReportEfectivityOK,2, "ReporteEfectividad.pdf");

                return this.Json(new { Result = "OK", Report = Convert.ToBase64String(reportAreaBadBytes), Report2 = Convert.ToBase64String(reportAreaOkBytes), base65 = Request.Url.AbsoluteUri.ToString().Replace("Report2/GenerateAndDisplayReport", "ReportPDF/" + finalReportName) });
            }

        }

        public static string CreateAndMergeReport(LocalReport report1, LocalReport report2, int reportNumber, string reportName)
        {
            string dateStamp = DateTime.Now.ToString("yyyyMMddHHmmss");

            Report1Controller.CreatePDFfile(report1, dateStamp + "report" + reportNumber + "1.pdf");
            Report1Controller.CreatePDFfile(report2, dateStamp + "report" + reportNumber + "2.pdf");
            string[] array = new string[2];

            array[0] = AppDomain.CurrentDomain.BaseDirectory + "\\ReportPDF\\" + dateStamp + "report21.pdf";
            array[1] = AppDomain.CurrentDomain.BaseDirectory + "\\ReportPDF\\" + dateStamp + "report22.pdf";
            string finalReportName = dateStamp + reportName;
            Report1Controller.CombineMultiplePDFs(array, AppDomain.CurrentDomain.BaseDirectory + "\\ReportPDF\\" + dateStamp + reportName);
            return finalReportName;
        }

        static double F(double x)
        {
            MathNet.Numerics.Distributions.Normal result = new MathNet.Numerics.Distributions.Normal();
            return result.CumulativeDistribution(x);
        }



        public ActionResult DownloadReport(string territory, string format)
        {
            LocalReport localReport = new LocalReport();
            localReport.ReportPath = Server.MapPath("~/Reporting/GeneralResume.rdlc");
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


    }


}