<%@ Page Title="Cart" Language="C#" MasterPageFile="~/LayoutPages/Layout.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Connet.Viewer.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Css/Cart.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:LinqDataSource ID="CartLinqDataSource" runat="server" OnSelecting="CartLinqDataSource_Selecting"></asp:LinqDataSource>

    <asp:UpdatePanel ID="CartUpdatePanel" runat="server">
        <ContentTemplate>
            <asp:Panel ID="CartPanel" runat="server" CssClass="container bg-white p-0">
                <h5 class="title px-5"><i class="fas fa-shopping-cart"></i> My Cart</h5>
                <div id="cart_wrap">
                    <table class="table table-striped text-center">
                        <thead>
                            <tr>
                                <th colspan="2">Name</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Subtotal</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:ListView ID="CartProductList" runat="server" DataSourceID="CartLinqDataSource">
                                <EmptyDataTemplate>
                                    <tr>
                                        <td colspan="6" class="text-center font-weight-bold">Your cart is empty...</td>
                                    </tr>
                                </EmptyDataTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td class="item_img align-middle">
                                            <img src="../Broadcaster/Product_Image/<%# Eval("Product.Id") %>.jpg" /></td>
                                        <td class="align-middle prod_Name"><a class="item_name" href="../Broadcaster/ProductInfo.aspx?id=<%# Eval("Product.Id") %>"><%# Eval("Product.Name") %></a></td>
                                        <td class="align-middle">RM <%# Eval("Product.Price") %></td>
                                        <td class="align-middle">
                                            <div class="qty_wrap">
                                                <asp:Button ID="MinQty" runat="server" Text="-" CommandName='<%# Eval("Id") %>' OnClick="MinQty_OnClick" UseSubmitBehavior="False" />
                                                <p><%# Eval("Quantity") %></p>
                                                <asp:Button ID="AddQty" runat="server" Text="+" CommandName='<%# Eval("Id") %>' OnClick="AddQty_OnClick" UseSubmitBehavior="False" />
                                            </div>
                                        </td>
                                        <td class="align-middle">RM <%# decimal.Parse(Eval("Quantity").ToString()) * decimal.Parse(Eval("Product.Price").ToString()) %></td>
                                        <td class="align-middle">
                                            <asp:Button ID="DeleteBtn" runat="server" Text="Delete" CssClass="btn btn-link text-danger" OnClick='DeleteBtn_Click' CommandName='<%# Eval("Id") %>' UseSubmitBehavior="False" /></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:ListView>
                        </tbody>
                    </table>
                </div>

                <div id="cart_footer">
                    <button runat="server" type="button" id="checkout" class="btn btn-outline-primary text-white" onserverclick="checkout_Click"><i class="fas fa-dolly"></i> Check Out</button>
                    <asp:Label ID="totalPrice" runat="server" Text="RM 0.00"></asp:Label>
                </div>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
