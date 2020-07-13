<%@ Page Title="Payment" Language="C#" MasterPageFile="~/LayoutPages/Layout.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="Connet.Viewer.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Css/Payment.css" rel="stylesheet" />
    <script src="../Js/Payment.js"></script>
    <script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/3/jquery.inputmask.bundle.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/3.3.4/bindings/inputmask.binding.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:LinqDataSource ID="AddressDataSource" runat="server" OnSelecting="AddressDataSource_Selecting"></asp:LinqDataSource>
    <asp:LinqDataSource ID="CartDataSource" runat="server" OnSelecting="CartDataSource_Selecting"></asp:LinqDataSource>

    <asp:Panel ID="PaymentPanel" runat="server" CssClass="container">
        <h4 class="title m-0 px-5"><i class="fas fa-credit-card"></i> Payment Info</h4>

        <div class="py-3 px-5 bg-white">
            <%-- Payment Info --%>
            <div>
                <h5>Item Info</h5>
                <table class="table table-striped">
                    <tr>
                        <th colspan="2">Name</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>SubTotal</th>
                    </tr>
                    <asp:ListView ID="CartListView" runat="server" DataSourceID="CartDataSource">
                        <ItemTemplate>
                            <tr>
                                <td class="item_img align-middle"><img src="../Broadcaster/Product_Image/<%# Eval("Product.Id") %>.jpg"/></td>
                                <td class="align-middle prod_Name"><a class="item_name" href="../Broadcaster/ProductInfo.aspx?id=<%# Eval("Product.Id") %>"><%# Eval("Product.Name") %></a></td>
                                <td class="align-middle">RM <%# Eval("Product.Price") %></td>
                                <td class="align-middle"><%# Eval("Quantity") %></td>
                                <td class="align-middle">RM <%# decimal.Parse(Eval("Quantity").ToString()) * decimal.Parse(Eval("Product.Price").ToString()) %></td>
                            </tr>
                        </ItemTemplate>
                    </asp:ListView>
                </table>

                <hr/>
                <label>Credit / Debit Card Number</label>
                <asp:TextBox ID="txtCardNum" runat="server" MaxLength="19" data-inputmask="'mask': '9999 9999 9999 9999'" placeholder="8888 8888 8888 8888" CssClass="form-control col-6" CausesValidation="True"></asp:TextBox>
                <small>
                    <asp:CustomValidator ID="cvCardNum" runat="server" ControlToValidate="txtCardNum" ErrorMessage="number" Display="Dynamic" OnServerValidate="cvCardNum_ServerValidate" ValidateEmptyText="True" CssClass="error" EnableClientScript="False"></asp:CustomValidator>
                </small>
                
                <label>Expired Date</label>
                <asp:TextBox ID="txtExpDate" runat="server" data-inputmask="'alias': '99/99'" MaxLength="5" placeholder="mm/yy" CssClass="form-control col-3"></asp:TextBox>
                <small>
                    <asp:CustomValidator ID="cvExpDate" runat="server" ErrorMessage="exp" ControlToValidate="txtExpDate" Display="Dynamic" OnServerValidate="cvCreditCardEpx_ServerValidate" ValidateEmptyText="True" CssClass="error" EnableClientScript="False"></asp:CustomValidator>
                </small>
                
                <label>CVV</label>
                <asp:TextBox ID="txtCvv" runat="server" MaxLength="3" data-inputmask="'mask': '999'" CssClass="form-control col-2" placeholder="999" CausesValidation="True"></asp:TextBox>
                <small>
                    <asp:CustomValidator ID="cvCvv" runat="server" ErrorMessage="cvv" ControlToValidate="txtCvv" Display="Dynamic" OnServerValidate="cvCreditCardCvv_ServerValidate" ValidateEmptyText="True" CssClass="error" EnableClientScript="False"></asp:CustomValidator>
                </small>
            </div>

            <hr />

            <%-- Shipping Address --%>
            <h6>Choose your shipping address</h6>
            <small>
                <asp:CustomValidator ID="ShippingValidator" runat="server" EnableClientScript="False" ValidateEmptyText="True" Display="Dynamic" CssClass="error"></asp:CustomValidator>
            </small>
            <div class="address_flex">
                <asp:ListView ID="AddressListView" runat="server" DataSourceID="AddressDataSource" DataKeyNames="Id">
                    <EmptyDataTemplate>
                        <p>No address found...</p>
                        <p>Click manage address button before process payment</p>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                            <div id="<%# Eval("Id") %>" class="address_wrapper">
                                <label>
                                    <p><%# Eval("AddressLine") %>,</p>
                                    <p><%# Eval("City") %> <%# Eval("Zipcode") %>,</p>
                                    <p><%# Eval("State") %></p>
                                    <asp:RadioButton ID="AddressRb" runat="server" CssClass="d-none" GroupName="AddressRbtnGroup" ValidationGroup="Address" value='<%# Eval("Id") %>'/>
                                </label>
                            </div>
                    </ItemTemplate>
                </asp:ListView>
            </div>
            <div class="text-center p-2">
                <asp:LinkButton ID="ManageAddressBtn" runat="server" CssClass="btn btn-outline-dark" PostBackUrl="~/Profile.aspx">Manage Address</asp:LinkButton>
            </div>
        </div>

        <%-- Buttons --%>
        <div class="p-2 text-center bg-dark">
            <asp:LinkButton ID="BackBtn" runat="server" CssClass="btn btn-link text-white">Back</asp:LinkButton>
            <asp:Button ID="Confirm" runat="server" Text="Confirm" CssClass="btn btn-outline-primary text-white" OnClick="Confirm_Click" />
        </div>
    </asp:Panel>
    
    <asp:Panel ID="MessagePanel" runat="server" CssClass="container text-center bg-white p-3" Visible="False">
        <h4>Congratulation</h4>
        <p><asp:Label ID="Message" runat="server"></asp:Label></p>
        <asp:Button ID="ReturnBtn" runat="server" Text="Return to home" CssClass="btn btn-outline-primary" PostBackUrl="/" />
    </asp:Panel>

    <%-- External JS --%>
    <script>
        $(":input").inputmask();
    </script>
</asp:Content>
