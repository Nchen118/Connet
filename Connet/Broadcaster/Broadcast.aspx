<%@ Page Title="Broadcast" Language="C#" MasterPageFile="~/LayoutPages/Layout.Master" AutoEventWireup="true" CodeBehind="Broadcast.aspx.cs" Inherits="Connet.Broadcaster.Broadcast" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/webrtc-adapter/6.4.0/adapter.min.js"></script>
    <script src="https://rtcmulticonnection.herokuapp.com/dist/RTCMultiConnection.min.js"></script>
    <script src="https://rtcmulticonnection.herokuapp.com/socket.io/socket.io.js"></script>
    <script src="https://cdn.webrtc-experiment.com/CodecsHandler.js"></script>
    <script src="../Scripts/jquery.signalR-2.4.1.min.js"></script>
    <script src="../Js/SignalRConnection.js"></script>
    <script src="/signalr/hubs"></script>
    <link href="../Css/Broadcast.css" rel="stylesheet" />
    <script src="../Js/Broadcast.js"></script>
    <script src="../Scripts/webcamjs/webcam.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:LinqDataSource ID="ProductListDataSource" runat="server" OnSelecting="ProductListDataSource_Selecting"></asp:LinqDataSource>
    <table>
        <tr>
            <td id="video-stream">
                <p class="text-white font-weight-bold"><i class="fas fa-podcast"></i><span id="views">0</span></p>
                <video id="broadcast" autoplay="autoplay" muted="muted" preload="auto"></video>
                <canvas id="screenshot_img" class="d-none"></canvas>
            </td>
            <td id="sell-item" rowspan="2">
                <div class="header"><i class="fas fa-truck-loading"></i> Product Selling</div>
                <div id="item-list" class="scrollbar">

                    <asp:ListView ID="BroadcastProduct" runat="server" DataSourceID="ProductListDataSource">
                        <EmptyDataTemplate>
                            No Product Found....
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <a class="item-wrap text-body" href='<%= Page.ResolveClientUrl("~/Broadcaster/ProductInfo.aspx?id=") %><%# Eval("productID") %>' target="_blank">
                                <img src='/Broadcaster/Product_Image/<%# Eval("productID") %>.jpg' />
                                <p class="overflow-hidden"><%# Eval("Product.Name") %></p>
                            </a>
                        </ItemTemplate>
                    </asp:ListView>
                </div>
            </td>
            <td id="public-chat" rowspan="2">
                <div class="header"><i class="fas fa-comment-dots"></i> Chat</div>
                <div class="scrollbar" id="chatInbox">
                    <ul id="chatContent">
                        <%--Display Name and Message--%>
                    </ul>
                </div>
                <div id="send-wrap" class="input-group">
                    <input id="txtMessage" type="text" class="form-control" placeholder="Type a message..." />
                    <div class="input-group-append">
                        <input id="btnSend" type="button" value="Send" class="btn btn-outline-primary" />
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="header"><i class="fas fa-sliders-h"></i> Setting</div>
                <div id="setting" class="scrollbar">
                    <label>Microphone </label>
                </div>
            </td>
        </tr>
    </table>
    
    <%-- Hidden Value --%>
    <asp:HiddenField ID="sellerField" runat="server" />
    <asp:HiddenField ID="roomid" runat="server" />
</asp:Content>
