<%@ Page Title="Forget Password" Language="C#" MasterPageFile="~/LayoutPages/Layout.Master" AutoEventWireup="true" CodeBehind="ForgetPassword.aspx.cs" Inherits="Connet.Viewer.ForgetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <%-- Email Recovery --%>
    <asp:Panel ID="EmailRecoveryPanel" CssClass="container bg-white p-0" runat="server">
        <h5 class="title">Password Recovery</h5>
        <div class="px-5 text-center">
            <p>Recovery account by using email address</p>
            <asp:TextBox ID="EmailRecovery" runat="server" CssClass="form-control col-5 mx-auto" AutoCompleteType="Email" TextMode="Email" placeholder="Your email address" CausesValidation="True"></asp:TextBox>
            <small>
                <asp:CustomValidator ID="EmailValidator" runat="server" ControlToValidate="EmailRecovery" EnableClientScript="False" SetFocusOnError="True" ValidateEmptyText="True" Display="Dynamic" CssClass="error" OnServerValidate="EmailValidator_ServerValidate"></asp:CustomValidator>
            </small>
        </div>
        <div class="text-center p-3">
            <asp:Button ID="Continue" runat="server" Text="Continue" CssClass="btn btn-outline-primary" OnClick="Continue_Click" />
        </div>
    </asp:Panel>
    
    <%-- Reset Password --%>
    <asp:Panel ID="ResetPasswordPanel" CssClass="container bg-white p-0" runat="server" Visible="False">
        <h5 class="title">Reset Password</h5>
        <div class="px-5">
            <p>Your email: <asp:Label ID="Email" runat="server" Text="Email"></asp:Label></p>
            <label for="body_NewPassword">New Password: </label>
            <asp:TextBox ID="NewPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="New Password" CausesValidation="True" MaxLength="50"></asp:TextBox>
            <small>
                <asp:CustomValidator ID="NewPasswordValidator" runat="server" EnableClientScript="False" ControlToValidate="NewPassword" Display="Dynamic" CssClass="error" SetFocusOnError="True" ValidateEmptyText="True" OnServerValidate="NewPasswordValidator_ServerValidate"></asp:CustomValidator>
            </small>            
            <label for="body_ConfirmNewPassword">Confirm New Password: </label>
            <asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Confirm New Password" CausesValidation="True" MaxLength="50"></asp:TextBox>
            <small>
                <asp:CustomValidator ID="ConfirmNewPasswordValidator" runat="server" SetFocusOnError="True" EnableClientScript="False" ControlToValidate="ConfirmNewPassword" ValidateEmptyText="True" Display="Dynamic" CssClass="error" OnServerValidate="ConfirmNewPasswordValidator_ServerValidate"></asp:CustomValidator>
            </small>
        </div>
        <div class="text-center p-3">
            <asp:Button ID="Confirm" runat="server" Text="Confirm" CssClass="btn btn-outline-primary" OnClick="Confirm_Click" />
        </div>
    </asp:Panel>
    
    <%-- Message Panel --%>
    <asp:Panel ID="MessagePanel" CssClass="container bg-white p-0" runat="server" Visible="False">
        <h5 class="title text-center">Account Recovery</h5>
        <div class="text-center py-5">
            <asp:Label ID="Message" runat="server" Text="Message"></asp:Label>
        </div>
    </asp:Panel>
</asp:Content>
