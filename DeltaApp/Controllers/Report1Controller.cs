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
using System.Text;
using iTextSharp.text;
using iTextSharp.text.pdf;

namespace DeltaApp.Controllers
{
    public class Report1Controller : BaseController
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

            LocalReport localReportGR = new LocalReport();
            LocalReport localReportUP = new LocalReport();

            localReportGR.ReportPath = Server.MapPath("~/Reporting/GeneralResume.rdlc");
            localReportUP.ReportPath = Server.MapPath("~/Reporting/UserPuRelation.rdlc");


            List<GENERAL_RESUME_VIEW> generalResumeList = reportRepository.GetAll_GENERAL_RESUME().ToList();
            List<USER_PU_RELATION_MEASURE_VIEW> userPURelation = reportRepository.GetAll_USER_PU_RELATION(QdateFrom, QdateTo).ToList();
            List<ROL_RELATION_MEASURE_VIEW> rolRelation = reportRepository.GetRolRelation(QdateFrom, QdateTo).ToList();


            ReportDataSource reportDataSourceGN = new ReportDataSource();
            ReportDataSource reportDataSourceUPU = new ReportDataSource();
            ReportDataSource reportDataSourceROL = new ReportDataSource();

            reportDataSourceGN.Name = "General_Resume_View";
            reportDataSourceUPU.Name = "USER_PU_RELATION_MEASURE_VIEW";
            reportDataSourceROL.Name = "ROL_RELATION_VIEW";

            var totalMeasure = 0;
            var totalDefects = 0;
            if (QdateFrom != null && QdateTo != null)
            {
                var dfrom = Convert.ToDateTime(QdateFrom);
                var dto = Convert.ToDateTime(QdateTo);

                var generalResumeFilterList = from c in generalResumeList
                                              where c.MSR_DATE >= dfrom.Date &&
                                              c.MSR_DATE <= dto.Date
                                              select c;

                totalDefects = Convert.ToInt32(generalResumeFilterList.Sum(x => x.MEASURES_DEFECTS));

                var userPuRelationFilterList = userPURelation;
                var rolRelationFilterList = rolRelation;

                totalMeasure = generalResumeFilterList.Count();

                reportDataSourceGN.Value = generalResumeFilterList;
                reportDataSourceUPU.Value = userPuRelationFilterList;
                reportDataSourceROL.Value = rolRelationFilterList;
            }
            else
                reportDataSourceGN.Value = generalResumeList;


            localReportGR.DataSources.Add(reportDataSourceGN);
            localReportGR.DataSources.Add(reportDataSourceUPU);

            localReportUP.DataSources.Add(reportDataSourceGN);
            localReportUP.DataSources.Add(reportDataSourceUPU);
            localReportUP.DataSources.Add(reportDataSourceROL);

            ReportParameterCollection reportParameters = new ReportParameterCollection();
            reportParameters.Add(new ReportParameter("DateFrom", QdateFrom));
            reportParameters.Add(new ReportParameter("DateTo", QdateTo));
            reportParameters.Add(new ReportParameter("TotalMeasure", totalMeasure.ToString()));

            double defectPercent = totalMeasure / (totalDefects + 0.00001f);
            double sigma = F(defectPercent) + 1.5f;
            reportParameters.Add(new ReportParameter("SigmaLevel", sigma.ToString("#.##")));

            localReportGR.SetParameters(reportParameters);

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
            byte[] generalResumBytes;
            byte[] rolRelationBytes;
            //Render the report            
            generalResumBytes = localReportGR.Render(reportType, deviceInfo, out mimeType, out encoding, out fileNameExtension, out streams, out warnings);
            rolRelationBytes = localReportUP.Render(reportType, deviceInfo, out mimeType, out encoding, out fileNameExtension, out streams, out warnings);

            //Response.AddHeader("content-disposition", "attachment; filename=NorthWindCustomers." + fileNameExtension); 
            if (format == null)
            {
                return File(generalResumBytes, "image/jpeg");
            }
            else if (format == "PDF")
            {
                return File(generalResumBytes, "pdf");
            }
            else
            {
                string dateStamp = DateTime.Now.ToString("yyyyMMddHHmmss");
             
                CreatePDFfile(localReportGR, dateStamp + "report11.pdf");
                CreatePDFfile(localReportUP, dateStamp + "report12.pdf");
                string[] array = new string[2];

                array[0] = AppDomain.CurrentDomain.BaseDirectory + "\\ReportPDF\\" + dateStamp + "report11.pdf";
                array[1] = AppDomain.CurrentDomain.BaseDirectory + "\\ReportPDF\\" + dateStamp + "report12.pdf";
                string finalReportName = dateStamp + "ResumenGeneral.pdf";
                CombineMultiplePDFs(array, AppDomain.CurrentDomain.BaseDirectory + "\\ReportPDF\\" + dateStamp + "ResumenGeneral.pdf");
                return this.Json(new { Result = "OK", Report = Convert.ToBase64String(generalResumBytes), Report2 = Convert.ToBase64String(rolRelationBytes), base65 = Request.Url.AbsoluteUri.ToString().Replace("Report1/GenerateAndDisplayReport", "ReportPDF/" + finalReportName ) });
            }

        }


        public static void CreatePDFfile(LocalReport report,string label)
        {
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

            byte[] file1byte = report.Render("PDF", deviceInfo, out mimeType, out encoding, out fileNameExtension, out streams, out warnings);

            using (FileStream fs = new FileStream(AppDomain.CurrentDomain.BaseDirectory + "\\ReportPDF\\" + label, FileMode.Create))
            {
                fs.Write(file1byte, 0, file1byte.Length);
            }
        }
        public static void CombineMultiplePDFs(string[] fileNames, string outFile)
        {
            // step 1: creation of a document-object
            Document document = new Document();

            // step 2: we create a writer that listens to the document
            PdfCopy writer = new PdfCopy(document, new FileStream(outFile, FileMode.Create));
            if (writer == null)
            {
                return;
            }

            // step 3: we open the document
            document.Open();

            foreach (string fileName in fileNames)
            {
                // we create a reader for a certain document
                PdfReader reader = new PdfReader(fileName);
                reader.ConsolidateNamedDestinations();

                // step 4: we add content
                for (int i = 1; i <= reader.NumberOfPages; i++)
                {
                    PdfImportedPage page = writer.GetImportedPage(reader, i);
                    writer.AddPage(page);
                }

                PRAcroForm form = reader.AcroForm;
                if (form != null)
                {
                    writer.AddDocument(reader);
                }

                reader.Close();
            }
            // step 5: we close the document and writer
            writer.Close();
            document.Close();
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