<%@ Page Title="Home" Language="C#" MasterPageFile="~/LayoutPages/Layout.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Connet.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Css/Index.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:LinqDataSource ID="StreamDataSource" runat="server" OnSelecting="StreamDataSource_Selecting"></asp:LinqDataSource>

    <div class="container">
        <div id="news" class="carousel slide" data-ride="carousel">
            <!-- Indicators -->
            <ul class="carousel-indicators">
                <li data-target="#news" data-slide-to="0" class="active"></li>
                <li data-target="#news" data-slide-to="1"></li>
                <li data-target="#news" data-slide-to="2"></li>
            </ul>
            <!-- The slideshow -->
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="Images/example1.png" alt="e1" class="carousel-img">
                </div>
                <div class="carousel-item">
                    <img src="Images/example2.jpg" alt="e2" class="carousel-img">
                </div>
                <div class="carousel-item">
                    <img src="Images/example3.jpg" alt="e3" class="carousel-img">
                </div>
            </div>
            <!-- Left and right controls -->
            <a class="carousel-control-prev" href="#news" data-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </a>
            <a class="carousel-control-next" href="#news" data-slide="next">
                <span class="carousel-control-next-icon"></span>
            </a>
        </div>

        <%-- Menu Bar --%>
        <div id="menu_bar">
            <p class="d-inline btn font-weight-bold">Sort by :</p>
            <asp:Button ID="RecentLink" runat="server" Text="Recent" CssClass="btn btn-link text-body" OnClick="RecentLink_Click" CausesValidation="False" UseSubmitBehavior="False"></asp:Button> | 
            <asp:Button ID="MostViewLink" runat="server" Text="Most View" CssClass="btn btn-link text-body" OnClick="MostViewLink_Click" CausesValidation="False" UseSubmitBehavior="False"></asp:Button>
        </div>

        <%-- Stream list --%>
        <div class="d-flex justify-content-center flex-wrap">
            <asp:ListView ID="StreamList" runat="server" DataSourceID="StreamDataSource">
                <EmptyDataTemplate>
                    <div class="text-center font-weight-bold p-5">No Stream Found...</div>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <a href='Viewer/View.aspx?roomid=<%# Eval("Id") %>' class="stream_list">
                        <img class="stream_img" src="<%# Eval("Screenshot") %>" />
                        <p class="streamTxtWrap"><%# Eval("Name") %></p>
                    </a>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>
</asp:Content>
