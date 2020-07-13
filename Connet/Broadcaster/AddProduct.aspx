<%@ Page Title="Add Product" Language="C#" MasterPageFile="~/LayoutPages/Layout.Master" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="Connet.Broadcaster.AddProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Css/AddProduct.css" rel="stylesheet" />
    <script src="../Js/AddProduct.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:Panel ID="Wrapper" runat="server">
        <div class="title">
            <h5>Add Product</h5>
        </div>

        <div id="container_wrapper">
            <div id="previewImg">
                <h6>Product Image</h6>
                <asp:Image ID="Prod_Img" runat="server" ImageUrl="~/Images/empty_picture.png" />
                <small class="text-left">*.png, *.jpeg, *.jpg</small>
                <div class="custom-file">
                    <asp:FileUpload ID="Img_File" runat="server" CssClass="custom-file-input" accept="image/*" />
                    <label class="custom-file-label text-left" for="body_Img_File">Choose file</label>
                </div>
                <small class="text-left m-2">
                    <asp:CustomValidator ID="Prod_ImgValidation" runat="server" ControlToValidate="Img_File" CssClass="error" Display="Dynamic" OnServerValidate="Prod_ImgValidation_ServerValidate" ValidateEmptyText="True" EnableClientScript="False"></asp:CustomValidator>
                </small>
            </div>

            <div id="info">
                <label for="body_Name">Name: </label>
                <asp:TextBox ID="Name" runat="server" CssClass="form-control" placeholder="Name" CausesValidation="True" MaxLength="100"></asp:TextBox>
                <small>
                    <asp:RequiredFieldValidator ID="NameValidator" runat="server" ErrorMessage="Product name is empty" CssClass="error" ControlToValidate="Name" Display="Dynamic" SetFocusOnError="True" EnableClientScript="False"></asp:RequiredFieldValidator></small>

                <br />
                <label for="body_Description">Description: </label>
                <asp:TextBox ID="Description" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder="Description" Rows="6" CausesValidation="True"></asp:TextBox>
                <small>
                    <asp:RequiredFieldValidator ID="DescValidator" runat="server" ErrorMessage="Product description is empty" CssClass="error" ControlToValidate="Description" Display="Dynamic" EnableClientScript="False"></asp:RequiredFieldValidator></small>

                <br />
                <div class="d-flex">
                    <div class="flex-fill">
                        <label for="body_Qty">Quantity: </label>
                        <asp:TextBox ID="Qty" runat="server" CssClass="form-control col-11" TextMode="Number" placeholder="Quantity" step="0.01" min="0" max="999999"></asp:TextBox>
                        <small>
                            <asp:RequiredFieldValidator ID="QtyEmptyValidator" runat="server" ErrorMessage="Quantity is empty" CssClass="error" Display="Dynamic" EnableClientScript="False" ControlToValidate="Qty"></asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="QtyValidator" runat="server" ErrorMessage="Invalid quantity value" Display="Dynamic" CssClass="error" MinimumValue="0" MaximumValue="999999" ControlToValidate="Qty" EnableClientScript="False"></asp:RangeValidator>
                        </small>

                    </div>
                    <div class="flex-fill">
                        <label for="body_Price">Price: </label>
                        <asp:TextBox ID="Price" runat="server" CssClass="form-control col-11" TextMode="Number" placeholder="Price (RM)" min="1" max="999999"></asp:TextBox>
                        <small>
                            <asp:RequiredFieldValidator ID="PriceEmptyValidator" runat="server" ErrorMessage="Price is empty" CssClass="error" Display="Dynamic" EnableClientScript="False" ControlToValidate="Price"></asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="PriceValidator" runat="server" ErrorMessage="Invalid price value" Display="Dynamic" CssClass="error" MinimumValue="0" MaximumValue="999999" ControlToValidate="Price" EnableClientScript="False"></asp:RangeValidator>
                        </small>
                    </div>
                </div>
            </div>
        </div>

        <div id="button">
            <asp:LinkButton ID="BackBtn" runat="server" CssClass="btn btn-link text-white">Back</asp:LinkButton>
            <asp:Button ID="AddBtn" runat="server" Text="Add Product" UseSubmitBehavior="False" CssClass="btn btn-outline-warning" OnClick="AddBtn_Click" />
        </div>
    </asp:Panel>
</asp:Content>
