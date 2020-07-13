<%@ Page Title="Seller Detail" Language="C#" MasterPageFile="~/LayoutPages/Layout.Master" AutoEventWireup="true" CodeBehind="SellerDetail.aspx.cs" Inherits="Connet.Account.SellerDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Css/SellerDetail.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:LinqDataSource ID="ProductDataSource" runat="server" OnSelecting="ProductDataSource_Selecting"></asp:LinqDataSource>
    <div class="container">

        <div id="seller_header" class="d-flex justify-content-center">
            <div>
                <asp:Image ID="SellerPic" runat="server" ImageUrl="~/Images/empty_profile.jpeg"></asp:Image>
            </div>
            <div class="d-flex flex-column justify-content-center p-2">
                <p class="text-left">ID:
                    <asp:Label ID="SellerId" runat="server"></asp:Label></p>
                <p class="text-left">Name:
                    <asp:Label ID="SellerName" runat="server" CssClass="font-weight-bold"></asp:Label></p>
                <p class="text-left">Date Joined:
                    <asp:Label ID="SellerDateJoined" runat="server" CssClass="font-weight-bold"></asp:Label></p>
                <p class="text-left">Product:
                    <asp:Label ID="SellerProduct" runat="server" CssClass="font-weight-bold"></asp:Label></p>
            </div>
        </div>

        <div class="p-2 d-flex justify-content-center align-items-center">
            <asp:ListView ID="ProductView" runat="server" DataSourceID="ProductDataSource">
                <EmptyDataTemplate>
                    <p>No product found...</p>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <div class="item_wrap">
                        <a id='<%# Eval("Id") %>' href='/Broadcaster/ProductInfo.aspx?id=<%# Eval("Id") %>'>
                            <img class="item_img" src='/Broadcaster/Product_Image/<%# Eval("Id") %>.jpg' />
                            <p class="item_link" ><%# Eval("Name") %></p>
                        </a>
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>
</asp:Content>
