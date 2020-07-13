using Connet.CSFile;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web.UI.WebControls;

namespace Connet.AdminAccess
{
    public partial class ManagementReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string type = Request.QueryString["type"];

                try { BackBtn.PostBackUrl = Request.UrlReferrer.ToString(); }
                catch (NullReferenceException) { BackBtn.PostBackUrl = "/"; }

                if (string.IsNullOrEmpty(UserInfo.Role) || UserInfo.Role.ToLower() != "admin")
                {
                    Response.RedirectPermanent("/AdminAccess/AdminPage.aspx");
                }

                if (type.ToLower() == "summary")
                {
                    DetailReportPanel.Visible = false;
                    ExceptionReportPanel.Visible = false;
                    SummaryReportPanel.Visible = true;
                    // Summary Report Year Dropdownlist
                    var year = Global.db.Users.OrderByDescending(x => x.DateJoined);
                    if (year.Any())
                    {
                        DateTime checkYear = DateTime.Now;
                        foreach (var o in year)
                        {
                            if (o.DateJoined.Year == checkYear.Year)
                            {
                                YearDdl.Items.Add(new ListItem(o.DateJoined.Year.ToString(), o.DateJoined.Year.ToString()));
                                checkYear = checkYear.AddYears(-1);
                            }
                        }
                    }
                    ShowSummaryReport(DateTime.Now.Year.ToString());
                }
                else if (type.ToLower() == "exception")
                {
                    DetailReportPanel.Visible = false;
                    ExceptionReportPanel.Visible = true;
                    SummaryReportPanel.Visible = false;
                    ShowExceptionReport();
                }
                else if (type.ToLower() == "detail")
                {
                    DetailReportPanel.Visible = true;
                    ExceptionReportPanel.Visible = false;
                    SummaryReportPanel.Visible = false;
                    ShowDetailReport("");
                }
                else
                {
                    Response.RedirectPermanent("/AccessAdmin/AdminPage.aspx");
                }
            }
        }

        private void ShowSummaryReport(string year)
        {
            var u = Global.db.Users.AsEnumerable().Where(x => x.DateJoined.Year.ToString() == year).OrderByDescending(x => x.DateJoined);

            SummaryReportView.Reset();
            DataTable dt = u != null ? LinqToDataTable.LINQResultToDataTable(u) : new DataTable();
            ReportDataSource rds = new ReportDataSource("SummaryDataSet", dt);
            SummaryReportView.LocalReport.DataSources.Add(rds);
            SummaryReportView.LocalReport.ReportPath = Server.MapPath("~/AdminAccess/Report/SummaryReport.rdlc");
            SummaryReportView.LocalReport.SetParameters(new ReportParameter("year", year));
            SummaryReportView.LocalReport.SetParameters(new ReportParameter("totalRegistration", u.Count().ToString()));
            SummaryReportView.LocalReport.Refresh();
        }

        private void ShowExceptionReport()
        {
            int month, year;
            if (!string.IsNullOrEmpty(DateMonth.Text))
            {
                month = DateTime.ParseExact(DateMonth.Text, "yyyy-MM", CultureInfo.InvariantCulture).Month;
                year = DateTime.ParseExact(DateMonth.Text, "yyyy-MM", CultureInfo.InvariantCulture).Year;
            }
            else
            {
                month = DateTime.Now.Month;
                year = DateTime.Now.Year;
            }

            var u = Global.db.Streams.AsEnumerable().Where(x => x.CreatedDate.Year == year && x.CreatedDate.Month == month).OrderByDescending(x => x.TotalView).Take(3);

            ExceptionReportView.Reset();
            DataTable dt = u != null ? LinqToDataTable.LINQResultToDataTable(u) : new DataTable();
            ReportDataSource rds = new ReportDataSource("ExceptionDataSet", dt);
            ExceptionReportView.LocalReport.DataSources.Add(rds);
            ExceptionReportView.LocalReport.ReportPath = Server.MapPath("~/AdminAccess/Report/ExceptionReportMostView.rdlc");
            ExceptionReportView.LocalReport.SetParameters(new ReportParameter("month", CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(month)));
            ExceptionReportView.LocalReport.Refresh();
        }

        private void ShowDetailReport(string name)
        {
            var seller = Global.db.Sellers.FirstOrDefault(x => x.Name.Contains(name));
            var u = seller != null
                ? Global.db.OrderSales.Where(x => x.SellerName == seller.Name)
                : null;
            

            DetailReportView.Reset();
            DataTable dt = u != null ? LinqToDataTable.LINQResultToDataTable(u) : new DataTable();
            ReportDataSource rds = new ReportDataSource("DetailDataSet", dt);
            DetailReportView.LocalReport.DataSources.Add(rds);
            DetailReportView.LocalReport.ReportPath = Server.MapPath("~/AdminAccess/Report/DetailReport.rdlc");
            DetailReportView.LocalReport.Refresh();
        }

        protected void YearDdl_SelectedIndexChanged(object sender, EventArgs e)
        {
            ShowSummaryReport(YearDdl.SelectedValue);
        }

        protected void DateMonth_TextChanged(object sender, EventArgs e)
        {
            ShowExceptionReport();
        }

        protected void SellerName_TextChanged(object sender, EventArgs e)
        {
            ShowDetailReport(SellerName.Text);
        }
    }
}