<%@ Page Title="View" Language="C#" MasterPageFile="~/LayoutPages/Layout.Master" AutoEventWireup="true" CodeBehind="View.aspx.cs" Inherits="Connet.Viewer.View" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/webrtc-adapter/6.4.0/adapter.min.js"></script>
    <script src="https://rtcmulticonnection.herokuapp.com/dist/RTCMultiConnection.min.js"></script>
    <script src="https://rtcmulticonnection.herokuapp.com/socket.io/socket.io.js"></script>
    <script src="https://cdn.webrtc-experiment.com/CodecsHandler.js"></script>
    <script src="../Scripts/jquery.signalR-2.4.1.min.js"></script>
    <script src="../Js/SignalRConnection.js"></script>
    <script src="/signalr/hubs"></script>
    <script src="../Js/View.js"></script>
    <link href="../Css/View.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:LinqDataSource ID="ViewDataSource" runat="server" OnSelecting="ViewDataSource_Selecting"></asp:LinqDataSource>

    <table>
        <tr>

            <%-- Video --%>
            <td id="video-stream">
                <p id="viewers" class="text-white font-weight-bold"><i class="fas fa-podcast"></i> <span id="views">0</span></p>
                <video id="view" autoplay="autoplay" muted="muted" preload="auto"></video>
            </td>

            <%-- Chat --%>
            <td id="text-area" rowspan="2">
                <div class="title header"><i class="fas fa-comment-dots"></i> Chat</div>
                <div class="scrollbar">
                    <ul id="chatContent">
                        <%--Display Name and Message--%>
                    </ul>
                </div>
                <div id="textBox" class="input-group">
                    <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" placeholder="Type a message..." AutoCompleteType="Disabled"></asp:TextBox>
                    <div class="input-group-append">
                        <button id="btnSend" type="button" class="btn btn-outline-primary">Send</button>
                    </div>
                </div>
            </td>
        </tr>
        <tr>

            <%-- Product List --%>
            <td id="productList">
                <div class="title header"><i class="fas fa-truck-loading"></i> Product Selling</div>
                <div id="products">

                    <asp:ListView ID="product" runat="server" DataSourceID="ViewDataSource">
                        <ItemTemplate>
                            <div class="item_wrap">
                                <a href='<%= Page.ResolveClientUrl("~/Broadcaster/ProductInfo.aspx?id=") %><%# Eval("productID") %>' target="_blank">
                                    <img class="item_img" src='<%= Page.ResolveClientUrl("~/Broadcaster/Product_Image/") %><%# Eval("productID") %>.jpg' />
                                    <p class="item_text"><%# Eval("Product.Name") %></p>
                                </a>
                            </div>
                        </ItemTemplate>
                    </asp:ListView>

                </div>
            </td>

        </tr>
    </table>

    <%-- Hidden Value --%>
    <asp:HiddenField ID="userField" runat="server" />
    <asp:HiddenField ID="roomID" runat="server" Value="asdasd123" />
</asp:Content>
