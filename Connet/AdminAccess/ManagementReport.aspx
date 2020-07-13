<%@ Page Title="Management Report" Language="C#" MasterPageFile="~/LayoutPages/AdminSite.Master" AutoEventWireup="true" CodeBehind="ManagementReport.aspx.cs" Inherits="Connet.AdminAccess.ManagementReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .box_wrap {
            box-shadow: 0 0 5px #444;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:Button ID="BackBtn" runat="server" Text="Back" CssClass="btn btn-outline-primary" />
    <%-- Summary Report --%>
    <asp:Panel ID="SummaryReportPanel" runat="server" CssClass="container p-0 text-center box_wrap" Visible="false">
        <h5>Summary Report</h5>
        <label>Year: </label>
        <asp:DropDownList ID="YearDdl" runat="server" OnSelectedIndexChanged="YearDdl_SelectedIndexChanged" AutoPostBack="True">
        </asp:DropDownList>
        <rsweb:ReportViewer ID="SummaryReportView" runat="server" ClientIDMode="AutoID" InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" InternalBorderWidth="1px" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px" ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226" Width="100%" Height="500px" SizeToReportContent="False">
        </rsweb:ReportViewer>
    </asp:Panel>

    <%-- Exception Report --%>
    <asp:Panel ID="ExceptionReportPanel" runat="server" CssClass="container p-0 text-center box_wrap" Visible="false">
        <h5>Exception Report</h5>
        <label>Month: </label>
        <asp:TextBox ID="DateMonth" runat="server" TextMode="Month" AutoPostBack="True" OnTextChanged="DateMonth_TextChanged"></asp:TextBox>
        <rsweb:ReportViewer ID="ExceptionReportView" runat="server" ClientIDMode="AutoID" InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" InternalBorderWidth="1px" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px" ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226" Width="100%" Height="500px" SizeToReportContent="False">
        </rsweb:ReportViewer>
    </asp:Panel>

    <%-- Detail Report --%>
    <asp:Panel ID="DetailReportPanel" runat="server" CssClass="container p-0 text-center box_wrap" Visible="false">
        <h5>Detail Report</h5>
        <label>Seller Name: </label>
        <asp:TextBox ID="SellerName" runat="server" AutoPostBack="True" OnTextChanged="SellerName_TextChanged"></asp:TextBox>
        <rsweb:ReportViewer ID="DetailReportView" runat="server" Width="100%" Height="500px"></rsweb:ReportViewer>
    </asp:Panel>
</asp:Content>
