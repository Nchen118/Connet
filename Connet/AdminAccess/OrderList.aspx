<%@ Page Title="Order List" Language="C#" MasterPageFile="~/LayoutPages/AdminSite.Master" AutoEventWireup="true" CodeBehind="OrderList.aspx.cs" Inherits="Connet.AdminAccess.OrderList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Css/OrderList.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:LinqDataSource ID="OrderListDataSource" runat="server" OnSelecting="OrderListDataSource_Selecting"></asp:LinqDataSource>
    <asp:Panel ID="OrderPanel" runat="server" CssClass="container_wrapper p-3 text-center">
        <h4>Order List</h4>
        <hr/>
        <div>
            Buyer: 
            <asp:TextBox ID="Filter" runat="server" CssClass="form-control col-5 d-inline" placeholder="Search"></asp:TextBox>
        </div>
        <table class="table table-striped mt-3">
            <tr>
                <th>ID</th>
                <th>Date</th>
                <th>Status</th>
                <th>Product</th>
                <th>Buyer</th>
            </tr>
            <asp:ListView ID="OrderListView" runat="server" DataSourceID="OrderListDataSource" DataKeyNames="Id">
                <EmptyDataTemplate>
                    <tr>
                        <td colspan="5">No Order Found...</td>
                    </tr>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("Order.Id") %></td>
                        <td><%# Eval("Order.Order_date") %></td>
                        <td><%# Eval("Order.Order_Status") %></td>
                        <td><%# Eval("Product.Name") %></td>
                        <td><%# Eval("Order.Buyer.Name") %></td>
                    </tr>
                </ItemTemplate>
                
            </asp:ListView>
        </table>
    </asp:Panel>
</asp:Content>
