<%@ Page Title="Admin" Language="C#" MasterPageFile="~/LayoutPages/AdminSite.Master" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="Connet.AdminAccess.AdminLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Css/AdminLogin.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <%-- Login Page --%>
    <asp:Panel ID="AuthPanel" runat="server" CssClass="container_wrapper">
        <h5 class="text-center p-3">Administration Authentication</h5>

        <hr class="mx-5 my-0" />

        <div class="mx-5 px-5 py-2">
            <label for="body_Username">Username: </label>
            <asp:TextBox ID="Username" runat="server" CssClass="form-control" placeholder="Username" CausesValidation="True" MaxLength="50"></asp:TextBox>
            <small>
                <asp:CustomValidator ID="UsernameValidator" runat="server" CssClass="error" Display="Dynamic" ControlToValidate="Username" EnableClientScript="False" ValidateEmptyText="True" OnServerValidate="UsernameValidator_ServerValidate"></asp:CustomValidator>
            </small>
            <br />
            <label for="body_Password">Password: </label>
            <asp:TextBox ID="Password" runat="server" CssClass="form-control" placeholder="Password" MaxLength="50" CausesValidation="True" TextMode="Password"></asp:TextBox>
            <small>
                <asp:CustomValidator ID="PasswordValidator" runat="server" ValidateEmptyText="True" EnableClientScript="False" ControlToValidate="Password" Display="Dynamic" CssClass="error" OnServerValidate="PasswordValidator_ServerValidate"></asp:CustomValidator>
            </small>
            <br />
        </div>

        <div class="bg-dark p-3 text-center mt-3">
            <asp:Button ID="BackBtn" runat="server" Text="Back" CausesValidation="False" UseSubmitBehavior="False" CssClass="btn btn-link text-white" />
            <asp:Button ID="Login" runat="server" Text="Login" CssClass="btn btn-outline-warning" OnClick="Login_Click" />
        </div>
    </asp:Panel>

    <%-- Menu Page --%>
    <asp:Panel ID="MenuPanel" runat="server" CssClass="container_wrapper p-3" Visible="False">
        <h5>Welcome,
            <asp:Literal ID="AdminName" runat="server"></asp:Literal></h5>
        <hr class="w-100" />
        <a href="/AdminAccess/ManagementReport.aspx?type=summary">
            <i class="fas fa-file-alt fa-5x"></i>
            <p>Management Report - Summary</p>
        </a>
        <a href="/AdminAccess/ManagementReport.aspx?type=exception">
            <i class="fas fa-file-alt fa-5x"></i>
            <p>Management Report - Exception</p>
        </a>
        <a href="/AdminAccess/ManagementReport.aspx?type=detail">
            <i class="fas fa-file-alt fa-5x"></i>
            <p>Management Report - Detail</p>
        </a>
    </asp:Panel>
</asp:Content>
