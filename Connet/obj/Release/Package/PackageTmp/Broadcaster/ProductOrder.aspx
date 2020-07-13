<%@ Page Title="Product Order" Language="C#" MasterPageFile="~/LayoutPages/Layout.Master" AutoEventWireup="true" CodeBehind="ProductOrder.aspx.cs" Inherits="Connet.Broadcaster.ProductOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Css/ProductOrder.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:LinqDataSource ID="OrderDataSource" runat="server" OnSelecting="OrderDataSource_Selecting"></asp:LinqDataSource>
    <h4 class="title container mb-0 text-center">My Product Order</h4>
    <div class="container bg-white p-3">
        <table class="table table-striped">
            <tr>
                <th>Order ID</th>
                <th>Order Date</th>
                <th>Product</th>
                <th>Buyer</th>
                <th>Order Status</th>
            </tr>
            <asp:ListView ID="OrderListView" runat="server" DataSourceID="OrderDataSource">
                <EmptyDataTemplate>
                    <tr>
                        <td colspan="5" class="text-center">No Order Found...</td>
                    </tr>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("Order.Id") %></td>
                        <td><%# DateTime.Parse(Eval("Order.Order_date").ToString()).ToString("dd/MM/yyy")  %></td>
                        <td><%# Eval("Product.Name") %></td>
                        <td><%# Eval("Order.Buyer.Name") %></td>
                        <td><%# Eval("Order.Order_Status") %></td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
        </table>
    </div>
</asp:Content>
