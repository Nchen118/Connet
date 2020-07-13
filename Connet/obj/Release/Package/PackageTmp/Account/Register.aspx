<%@ Page Title="Register" Language="C#" MasterPageFile="~/LayoutPages/Layout.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Connet.Account.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Css/Register.css" rel="stylesheet" />
    <script src="https://www.google.com/recaptcha/api.js?render=6LcfRpgUAAAAAGHUfNzRfv9v5IoUVsH84-5ZgiPQ"></script>
    <script src="../Js/reCaptcha.js"></script>
    <script src="../Js/Register.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:Panel ID="wrap" runat="server">

        <h4 class="my-0 p-3 font-weight-bold">Sign Up</h4>
        
        <%-- Recaptcha Validator --%>
        <small class="p-3">
            <asp:CustomValidator ID="RecaptchaError" runat="server" ErrorMessage="*Error, seems like bot behaviour detected " Display="Dynamic" CssClass="error"></asp:CustomValidator>
        </small>

        <div class="form-group px-3">
            <asp:UpdatePanel ID="UpdatePanel" runat="server">
                <ContentTemplate>
                    <%-- Form --%>
                    <p>
                        <asp:TextBox ID="Email" runat="server" TextMode="Email" CssClass="form-control" placeholder="Email" CausesValidation="True" MaxLength="50" ViewStateMode="Inherit"></asp:TextBox>
                        <small>
                            <asp:CustomValidator ID="EmailValidator" runat="server" ErrorMessage="*" Display="Dynamic" CssClass="error" ControlToValidate="Email" ValidateEmptyText="True" OnServerValidate="SignUpEmailValidator_ServerValidate" SetFocusOnError="True" EnableClientScript="False"></asp:CustomValidator></small>
                    </p>
                    <p>
                        <asp:TextBox ID="Username" runat="server" CssClass="form-control" placeholder="Username" CausesValidation="True" MaxLength="50"></asp:TextBox>
                        <small>
                            <asp:CustomValidator ID="UsernameValidator" runat="server" ErrorMessage="*" Display="Dynamic" CssClass="error" ControlToValidate="Username" ValidateEmptyText="True" OnServerValidate="SignUpUsernameValidator_ServerValidate" EnableClientScript="False"></asp:CustomValidator></small>
                    </p>
                    <p>
                        <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="form-control" placeholder="Password" CausesValidation="True" MaxLength="50"></asp:TextBox>
                        <small>
                            <asp:CustomValidator ID="PasswordValidator" runat="server" ErrorMessage="*" Display="Dynamic" ControlToValidate="Password" EnableClientScript="False" ValidateEmptyText="True" OnServerValidate="SignUpPasswordValidator_ServerValidate" CssClass="error"></asp:CustomValidator></small>
                    </p>
                    <p>
                        <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Confirm Password" CausesValidation="True" MaxLength="50"></asp:TextBox>
                        <small>
                            <asp:CustomValidator ID="ConfirmPasswordValidator" runat="server" ErrorMessage="*" Display="Dynamic" ControlToValidate="ConfirmPassword" ValidateEmptyText="True" OnServerValidate="SignUpConfirmPasswordValidator_ServerValidate" CssClass="error" EnableClientScript="False"></asp:CustomValidator></small>
                    </p>
                    <p>
                        <asp:TextBox ID="PhoneNumber" runat="server" TextMode="Phone" CssClass="form-control" placeholder="Phone Number" CausesValidation="True"></asp:TextBox>
                        <small>
                            <asp:CustomValidator ID="PhoneNumberValidator" runat="server" ErrorMessage="*" ValidateEmptyText="True" ControlToValidate="PhoneNumber" Display="Dynamic" OnServerValidate="SignUpPhoneNumberValidator_ServerValidate" CssClass="error" EnableClientScript="False"></asp:CustomValidator></small>
                    </p>

                    <%-- Buyer and seller selection --%>
                    <h6>Choose register type:</h6>

                    <%-- Register type validation --%>
                    <small>
                        <asp:CustomValidator ID="RegisType" runat="server" ErrorMessage="*Please choose a registration type" Display="Dynamic" CssClass="error" OnServerValidate="RegisTypeValidator_ServerValidate" EnableClientScript="False"></asp:CustomValidator>
                    </small>

                    <div class="choose_wrapper">
                        <%-- Buyer --%>
                        <div id="buyerSide">
                            <p class="font-weight-bold">Buyer</p>
                            <label>
                                <img src="../Images/buyer_icon.png" class="choose_img" alt="Buyer" id="buyerImg" />
                                <asp:RadioButton ID="buyerR" runat="server" GroupName="registerType" ValidationGroup="registerType" CausesValidation="True" CssClass="d-none" />
                            </label>
                        </div>

                        <%-- Vertical line --%>
                        <div class="line"></div>
                        <div class="wordwrapper mx-auto">
                            <div class="word">or</div>
                        </div>

                        <%-- Seller --%>
                        <div id="sellerSide">
                            <p class="font-weight-bold">Seller</p>
                            <label>
                                <img src="../Images/seller_icon.png" class="choose_img" alt="Seller" id="sellerImg" />
                                <asp:RadioButton ID="sellerR" runat="server" GroupName="registerType" ValidationGroup="registerType" CausesValidation="True" CssClass="d-none" />
                            </label>
                        </div>
                    </div>
                    
                    <%-- Terms and Policy --%>
                    <input id="condition" type="checkbox" runat="server" />
                    <span>I agree to the Connet <a href="../TermsAndConditions.aspx">Terms of Service</a> and <a href="../PrivacyPolicy.aspx">Privacy Policy</a></span>
                    <%-- Validation --%>

                    <%-- Recaptcha v3 --%>
                    <asp:HiddenField ID="recaptcha_token" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

        <%-- Submit button --%>
        <div id="bottom_wrap" class="text-right px-4">
            <asp:Button ID="Cancel" runat="server" Text="Cancel" CssClass="btn btn-link font-weight-bold text-body" UseSubmitBehavior="False" OnClick="Cancel_Click" />
            <button id="SignupBtn" type="button" runat="server" OnServerClick="Signup_Click" class="btn btn-outline-warning font-weight-bold loadingBtn">
                Sign Up
            </button>
        </div>
    </asp:Panel>
</asp:Content>
