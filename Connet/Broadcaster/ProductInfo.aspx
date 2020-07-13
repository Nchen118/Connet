<%@ Page Title="Product Info" Language="C#" MasterPageFile="~/LayoutPages/Layout.Master" AutoEventWireup="true" CodeBehind="ProductInfo.aspx.cs" Inherits="Connet.Broadcaster.ProductInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Css/ProductInfo.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <%-- Display Product Page --%>
    <asp:Panel ID="DisplayProduct" runat="server">
        <div id="Prod_Name">
            <asp:Label ID="Name" runat="server" Text="Product Name"></asp:Label>
        </div>
        
        <div id="Prod_Info">
            <div class="img_wrap">
                <asp:Image ID="Prod_Img" runat="server" ImageUrl="../Images/empty_picture.png" />
            </div>
            <div id="info">
                <div id="price">
                    <asp:Literal ID="Price" runat="server" Text="RM 0.00"></asp:Literal>
                    <asp:TextBox ID="UpdatePrice" runat="server" placeholder="Enter new product price" CssClass="form-control" CausesValidation="True" TextMode="Number" Visible="False"></asp:TextBox>
                    <small>
                        <asp:CustomValidator ID="UpdatePriceValidator" runat="server" CssClass="error" Display="Dynamic" ControlToValidate="UpdatePrice" EnableClientScript="False" SetFocusOnError="True" ValidateEmptyText="True"></asp:CustomValidator>
                    </small>
                </div>

                <div id="intro">
                    <p>
                        <i class="fas fa-boxes"></i>Stock Available: 
                                <asp:Literal ID="Qty" runat="server" Text="0"></asp:Literal>
                        <asp:TextBox ID="QtyOrder" runat="server" CssClass="form-control col-2 d-inline mx-2" TextMode="Number" Text="1" min="1"></asp:TextBox>
                        <asp:TextBox ID="UpdateQty" runat="server" TextMode="Number" CausesValidation="True" CssClass="form-control col-3 d-inline" Visible="False"></asp:TextBox>
                        <small>
                            <asp:CustomValidator ID="QtyValidator" runat="server" Display="Dynamic" CssClass="error" EnableClientScript="False" ValidateEmptyText="True" SetFocusOnError="True"></asp:CustomValidator>
                        </small>
                    </p>
                    <p>
                        <i class="far fa-id-card"></i>Seller: 
                                <asp:HyperLink ID="Seller" runat="server" NavigateUrl="#">Seller</asp:HyperLink>
                    </p>
                </div>

                <div id="button">
                    <asp:LinkButton ID="BackBtn" runat="server" CssClass="btn btn-link">Back</asp:LinkButton>
                    <asp:Panel ID="EditProductBtn" runat="server" Visible="False">
                        <asp:Button ID="EditProduct" runat="server" Text="Edit Product" CssClass="btn btn-outline-primary" OnClick="EditProduct_Click" />
                    </asp:Panel>
                    <%-- Buyer Button --%>
                    <asp:Panel ID="AddCartPanel" runat="server" CssClass="d-inline">
                        <asp:Button ID="AddCart" runat="server" Text="Add To Cart" CssClass="btn btn-outline-primary" OnClick="AddCart_Click" UseSubmitBehavior="False" />
                    </asp:Panel>
                </div>
            </div>
        </div>

        <div id="Prod_Desc">
            <h5>Product Description</h5>
            <asp:Panel runat="server" ID="Display_Desc" CssClass="desc_wrap">
                <asp:Literal ID="Desc" runat="server" Mode="Encode"></asp:Literal>
            </asp:Panel>
        </div>
    </asp:Panel>
    
    <%-- Edit Product Page --%>
    <asp:Panel ID="EditProductPanel" runat="server" Visible="False" CssClass="container">
        <div id="Prod_Name">
            <asp:Label ID="ProdName" runat="server" Text="Product Name"></asp:Label>
        </div>

        <div id="Prod_Info">
            <div class="img_wrap">
                <asp:Image ID="ProdImg" runat="server" ImageUrl="../Images/empty_picture.png" />
            </div>
            <div id="info">
                <div id="price">
                    RM 
                            <asp:TextBox ID="PriceChange" runat="server" placeholder="Enter new product price" CssClass="form-control d-inline col-3" CausesValidation="True" TextMode="Number" step="0.01" min="0" max="999999"></asp:TextBox>
                    <small>
                        <asp:CustomValidator ID="PriceChangeValidator" runat="server" CssClass="error" Display="Dynamic" ControlToValidate="PriceChange" EnableClientScript="False" SetFocusOnError="True" ValidateEmptyText="True" OnServerValidate="PriceChangeValidator_ServerValidate"></asp:CustomValidator>
                    </small>
                </div>

                <div id="intro">
                    <p>
                        <i class="fas fa-boxes"></i>Stock Available: 
                                <asp:TextBox ID="StockChange" runat="server" CssClass="form-control col-2 d-inline mx-2" TextMode="Number" Text="1" min="1" CausesValidation="True"></asp:TextBox>
                        <small>
                            <asp:CustomValidator ID="StockChangeValidator" runat="server" Display="Dynamic" ControlToValidate="StockChange" CssClass="error" EnableClientScript="False" ValidateEmptyText="True" SetFocusOnError="True" OnServerValidate="StockChangeValidator_ServerValidate"></asp:CustomValidator>
                        </small>
                    </p>
                    <p>
                        <i class="far fa-id-card"></i>Seller: 
                                <asp:HyperLink ID="SellerLink" runat="server" NavigateUrl="#">Seller</asp:HyperLink>
                    </p>
                </div>

                <div id="button">
                    <%-- Seller Update Product Button --%>
                    <div class="d-inline text-center">
                        <asp:Button ID="DeleteProd" runat="server" Text="Delete" CssClass="btn btn-outline-danger" OnClick="DeleteProd_Click" />
                        <asp:Button ID="UpdateProd" runat="server" Text="Update" CssClass="btn btn-outline-info" OnClick="UpdateProd_Click" />
                    </div>
                </div>
            </div>
        </div>

        <div id="Prod_Desc" class="bg-white">
            <h5>Product Description</h5>
            <div class="desc_wrap">
                <asp:TextBox ID="ProdDesc" runat="server" CssClass="form-control" Rows="15" TextMode="MultiLine" CausesValidation="True"></asp:TextBox>
            </div>
            <small>
                <asp:RequiredFieldValidator ID="ProdDescRequired" runat="server" ErrorMessage="*Product Description is empty" ControlToValidate="ProdDesc" CssClass="error" Display="Dynamic" EnableClientScript="False"></asp:RequiredFieldValidator>
            </small>
        </div>
    </asp:Panel>
    
    <%-- Message Pages --%>
    <asp:Panel ID="MessagePanel" runat="server" CssClass="container bg-white text-center p-5" Visible="False">
        <p><asp:Label ID="Message" runat="server" Text="Error"></asp:Label></p>
        <asp:Button ID="ReturnBack" runat="server" Text="Return back to home" PostBackUrl="/" CssClass="btn btn-outline-primary" />
    </asp:Panel>
</asp:Content>
