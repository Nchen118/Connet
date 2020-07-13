<%@ Page Title="Error" Language="C#" MasterPageFile="~/LayoutPages/Layout.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="Connet.Error" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="container text-center bg-white p-2">
        <h3>Oops...</h3>
        <asp:Label ID="ErrorMsg" runat="server" Text="Label"></asp:Label>
        <asp:Label ID="ErrorTrace" runat="server" Text="Label"></asp:Label><hr/>
        <div>
            <asp:Button ID="ReturnBackBtn" runat="server" Text="Return To Home" OnClick="ReturnBackBtn_Click" CssClass="btn btn-outline-primary" />
        </div>
    </div>
</asp:Content>
