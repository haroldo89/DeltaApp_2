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
    public class Report3Controller : BaseController
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

            LocalReport NoMeasureProducts = new LocalReport();
            
            NoMeasureProducts.ReportPath = Server.MapPath("~/Reporting/NoMeasureProducts.rdlc");
            
            List<MEASURE_NO_PRODUCTS_VIEW> noMeasureList = reportRepository.GetNoMeasure().ToList();
           

            ReportDataSource dataSource = new ReportDataSource();
            

            dataSource.Name = "NoMeasureProducts";
            dataSource.Value = noMeasureList;


            if (QdateFrom != null && QdateTo != null)
            {
                dataSource.Value = noMeasureList;
               
            }
            else
            {
                //dataSource.Value = dataSource;
                
            }
                


            NoMeasureProducts.DataSources.Add(dataSource);
            
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
            byte[] renderBytes;
            

            //Render the report            
            renderBytes = NoMeasureProducts.Render(reportType, deviceInfo, out mimeType, out encoding, out fileNameExtension, out streams, out warnings);
            

            //Response.AddHeader("content-disposition", "attachment; filename=NorthWindCustomers." + fileNameExtension); 
            if (format == null)
            {
                return File(renderBytes, "image/jpeg");
            }
            else if (format == "PDF")
            {
                return File(renderBytes, "pdf");
            }
            else
            {
                /*var file = File(renderedBytes, "image/jpeg");

                var fileText = ImageToBase64(file, System.Drawing.Imaging.ImageFormat.Jpeg);*/

                string dateStamp = DateTime.Now.ToString("yyyyMMddHHmmss");
                string finalReportName = dateStamp + "ProductosNoMedidos.pdf";
                Report1Controller.CreatePDFfile(NoMeasureProducts,finalReportName);
               
                return this.Json(new { Result = "OK", Report = Convert.ToBase64String(renderBytes), base65 = Request.Url.AbsoluteUri.ToString().Replace("Report3/GenerateAndDisplayReport", "ReportPDF/" + finalReportName) });
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