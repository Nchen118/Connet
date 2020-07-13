<%@ Page Title="Broadcast Info" Language="C#" MasterPageFile="~/LayoutPages/Layout.Master" AutoEventWireup="true" CodeBehind="BroadcastInfo.aspx.cs" Inherits="Connet.Broadcaster.BroadcastInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Css/BroadcastInfo.css" rel="stylesheet" />
    <script src="../Js/BroadcastInfo.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:LinqDataSource ID="ProductLinqDataSource" runat="server" OnSelecting="ProductLinqDataSource_Selecting"></asp:LinqDataSource>
    <asp:LinqDataSource ID="SelectedLinqDataSource" runat="server" OnSelecting="SelectedLinqDataSource_Selecting" ContextTypeName="Connet.ConnetDataContext"></asp:LinqDataSource>
    <div class="container">
        <h5 class="title">Broadcast Info</h5>
        <div class="bg-white px-5 py-3">
            <div class="py-2">
                <label for="body_title">Title: </label>
                <asp:TextBox ID="title" runat="server" CssClass="form-control d-inline-block col-8" placeholder="Broadcast Title" MaxLength="100" CausesValidation="True"></asp:TextBox>
                <small>
                    <%-- Validator --%>
                    <asp:RequiredFieldValidator ID="bTitle" runat="server" ErrorMessage="Title is empty" Display="Dynamic" CssClass="error" ControlToValidate="title" EnableClientScript="False"></asp:RequiredFieldValidator>
                </small>
            </div>
            <div class="py-2">
                <label for="productList">Select Stream Product: </label>
                <button type="button" id="productListBtn" class="btn btn-outline-info" data-toggle="modal" data-target="#addProduct"><i class="fas fa-pallet"></i> Product List</button>
            </div>
            <hr />
            <small>
                <asp:CustomValidator ID="ProductList" runat="server" Display="Dynamic" CssClass="error"></asp:CustomValidator>
            </small>

            <%-- Product Selected --%>
            <h6>Selected Products: </h6>
            <div class="d-flex flex-wrap">
                <asp:ListView ID="ProductSelected" runat="server" DataSourceID="SelectedLinqDataSource">
                    <EmptyDataTemplate>
                        No Selected Product
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <div class="item_wrap">
                            <label>
                                <img class="item_img" src='/Broadcaster/Product_Image/<%# Eval("Id") %>.jpg' />
                                <p class="item_link"><%# Eval("Name") %></p>
                            </label>
                        </div>
                    </ItemTemplate>
                </asp:ListView>
            </div>
        </div>

        <div id="button">
            <asp:LinkButton ID="BackBtn" runat="server" CssClass="btn btn-link text-white">Back</asp:LinkButton>
            <button runat="server" type="button" id="broadcastBtn" class="btn btn-outline-primary" OnServerClick="broadcastBtn_Click"><i class="fas fa-video"></i> Broadcast Now</button>
        </div>
        
        <!-- The Modal -->
        <div class="modal fade" id="addProduct">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header bg-dark">
                        <h4 class="modal-title text-white">Add Selling Product</h4>
                        <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body d-flex flex-wrap justify-content-center">
                        <asp:ListView ID="lvProduct" runat="server" DataSourceID="ProductLinqDataSource" DataKeyNames="Id">
                            <EmptyDataTemplate>
                                No Product Found...
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <div id="<%# Eval("Id") %>" class="item_wrap">
                                    <label>
                                        <img class="item_img" src='/Broadcaster/Product_Image/<%# Eval("Id") %>.jpg' />
                                        <p class="item_link"><%# Eval("Name") %></p>
                                        <input type="checkbox" id="chkProduct" runat="server" value='<%# Eval("Id") %>' style="display: none" />
                                    </label>
                                </div>
                            </ItemTemplate>
                        </asp:ListView>
                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer bg-dark">
                        <asp:Button ID="cancel" runat="server" CssClass="btn btn-link text-white" Text="Cancel" data-dismiss="modal" UseSubmitBehavior="False" CausesValidation="False" />
                        <asp:Button ID="done" runat="server" CssClass="btn btn-outline-primary text-white" Text="Done" OnClick="done_Click" UseSubmitBehavior="False" />
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
