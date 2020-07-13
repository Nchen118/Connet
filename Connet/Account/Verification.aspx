<%@ Page Title="Verification" Language="C#" MasterPageFile="~/LayoutPages/Layout.Master" AutoEventWireup="true" CodeBehind="Verification.aspx.cs" Inherits="Connet.Account.Verification" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Css/Verification.css" rel="stylesheet" />
    <script src="../Js/Verification.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <%-- Verify Content Page --%>
    <asp:panel ID="VerifyPage" runat="server" CssClass="text-center container bg-white">
        <h4>Account Verify</h4>
        <p>The verify link has sent to your email</p>
        <asp:Button ID="resendBtn" runat="server" Text="Resend" CssClass="btn btn-outline-primary btn-lg loadingBtn" OnClick="resendBtn_Click"></asp:Button>
        <p>Didn't receive any email? Click the button above to resend</p>
    </asp:panel>
    <%-- Page Success Verified --%>
    <asp:panel ID="SuccessPage" CssClass="text-center container bg-white" runat="server" Visible="False">
        <h3>Hooray, Account Verified!</h3>
        <asp:LinkButton CssClass="btn btn-outline-dark loadingBtn" PostBackUrl="/" runat="server">Back to home</asp:LinkButton>
    </asp:panel>
</asp:Content>
