<%@ Page Title="My Order" Language="C#" MasterPageFile="~/LayoutPages/Layout.Master" AutoEventWireup="true" CodeBehind="MyOrder.aspx.cs" Inherits="Connet.Viewer.MyOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Css/MyOrder.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:LinqDataSource ID="MyOrderDataSource" runat="server" OnSelecting="MyOrderDataSource_Selecting"></asp:LinqDataSource>
    <div class="container bg-white p-0">
        <h4 class="title text-center">My Order</h4>
        <div class="p-4">
            <table class="table table-striped">
                <tr class="text-center">
                    <th>Order ID</th>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>Date Ordered</th>
                    <th>Order Status</th>
                </tr>
                <asp:ListView ID="OrderListView" runat="server" DataSourceID="MyOrderDataSource">
                    <EmptyDataTemplate>
                        <tr>
                            <td colspan="5" class="text-center">No Order Found...</td>
                        </tr>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <tr>
                            <td width="200px" class="text-break"><%# Eval("Order.Id") %></td>
                            <td width="500px"><a class="text-body font-weight-bold" href='../Broadcaster/ProductInfo.aspx?id=<%# Eval("Product.Id") %>'><%# Eval("Product.Name") %></a></td>
                            <td class="text-center"><%# Eval("Order.Quantity") %></td>
                            <td class="text-center"><%# DateTime.Parse(Eval("Order.Order_date").ToString()).ToString("dd/MM/yyy")  %></td>
                            <td class="text-center font-weight-bold"><%# Eval("Order.Order_Status") %></td>
                        </tr>
                    </ItemTemplate>
                    
                </asp:ListView>
            </table>
        </div>
    </div>
</asp:Content>
