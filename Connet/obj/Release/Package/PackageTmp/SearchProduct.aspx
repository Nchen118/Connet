<%@ Page Title="Search" Language="C#" MasterPageFile="~/LayoutPages/Layout.Master" AutoEventWireup="true" CodeBehind="SearchProduct.aspx.cs" Inherits="Connet.SearchProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Css/SearchProduct.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:LinqDataSource ID="SearchDataSource" runat="server" OnSelecting="SearchDataSource_Selecting"></asp:LinqDataSource>
    <div class="container">
        <h4>Search Result:</h4>
        <div class="d-flex flex-wrap justify-content-center">
            <asp:ListView ID="SearchListView" runat="server" DataSourceID="SearchDataSource">
                <EmptyDataTemplate>
                    <div class="text-center">No search result...</div>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <div class="item_wrap">
                        <a href="/Broadcaster/ProductInfo.aspx?id=<%# Eval("Id") %>">
                            <div>
                                <img src="/Broadcaster/Product_Image/<%# Eval("Id") %>.jpg" />
                            </div>
                            <p><%# Eval("Name") %></p>
                        </a>
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>
</asp:Content>
