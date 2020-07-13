<%@ Page Title="Profile" Language="C#" MasterPageFile="~/LayoutPages/Layout.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Connet.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Css/Profile.css" rel="stylesheet" />
    <script src="Js/Profile.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <%-- LinqDataSource --%>
    <asp:LinqDataSource ID="ProfileDataSource" runat="server" OnSelecting="ProfileDataSource_Selecting"></asp:LinqDataSource>
    <asp:LinqDataSource ID="AddressDataSource" runat="server" OnSelecting="AddressDataSource_Selecting"></asp:LinqDataSource>

    <%-- Buyer Page --%>
    <asp:UpdatePanel ID="AddressUpdatePanel" runat="server">
        <ContentTemplate>
            <asp:Panel ID="BuyerPanel" runat="server" CssClass="container bg-white p-0 profile_control d-flex">
                <div class="sideMenu">
                    <div class="text-center">
                        <asp:Image ID="Profile_Pic" runat="server" ImageUrl="Images/empty_profile.jpeg" />
                        <asp:Label ID="Current_Name" runat="server" Text="Current Name" CssClass="font-weight-bold"></asp:Label>
                    </div>
                    <hr />
                    <div class="p-3">
                        <h6>My Account</h6>
                        <ul>
                            <li><asp:Button ID="edit_p" runat="server" Text="Edit Profile" CssClass="btn btn-link text-body" OnClick="edit_p_OnClick" /></li>
                            <li><asp:Button ID="edit_a" runat="server" Text="Edit Address" CssClass="btn btn-link text-body" OnClick="edit_a_OnClick" /></li>
                        </ul>
                    </div>
                </div>
                
                <div class="profile_info">
                    <asp:Panel ID="Edit_Profile" runat="server">
                        <h6 class="text-center">Edit Profile</h6>
                        <hr />
                        <p>
                            <i class="far fa-id-card"></i>ID:
                            <asp:Label ID="ProfileID" runat="server" Text="999"></asp:Label>
                        </p>

                        <p>
                            <i class="fas fa-user-tie"></i>Name:
                                    <asp:TextBox ID="Name" runat="server" CssClass="form-control" placeholder="Enter your Name" ReadOnly="True" CausesValidation="True" MaxLength="50"></asp:TextBox>
                            <small>
                                <asp:CustomValidator ID="NameValidator" runat="server" CssClass="error" Display="Dynamic" ControlToValidate="Name" OnServerValidate="NameValidator_ServerValidate" ValidateEmptyText="True" EnableClientScript="False"></asp:CustomValidator></small>
                        </p>
                        <p>
                            <i class="far fa-envelope"></i>Email:
                                    <asp:TextBox ID="Email" runat="server" CssClass="form-control" placeholder="Enter your Email" ReadOnly="True" CausesValidation="True" MaxLength="50" TextMode="Email"></asp:TextBox>
                            <small>
                                <asp:CustomValidator ID="EmailValidator" runat="server" CssClass="error" Display="Dynamic" ControlToValidate="Email" OnServerValidate="EmailValidator_ServerValidate" ValidateEmptyText="True" EnableClientScript="False"></asp:CustomValidator></small>
                        </p>
                        <p>
                            <i class="fas fa-phone"></i>Phone Number:
                                    <asp:TextBox ID="Phone" runat="server" CssClass="form-control" placeholder="Enter your Phone Number" ReadOnly="True" CausesValidation="True" MaxLength="11" TextMode="Number"></asp:TextBox>
                            <small>
                                <asp:CustomValidator ID="PhoneValidator" runat="server" CssClass="error" Display="Dynamic" ControlToValidate="Phone" OnServerValidate="PhoneValidator_ServerValidate" ValidateEmptyText="True" EnableClientScript="False"></asp:CustomValidator></small>
                        </p>
                        <div>
                            <i class="fas fa-venus-mars"></i>Gender: 
                                    <asp:Panel ID="Gender" runat="server" CssClass="d-inline">
                                        <asp:Label ID="GenderTxt" runat="server" Text="Gender"></asp:Label>
                                    </asp:Panel>
                            <asp:Panel ID="PickGender" runat="server" Visible="False">
                                <asp:RadioButton ID="Male" runat="server" GroupName="Gender" Text="Male" />
                                <asp:RadioButton ID="Female" runat="server" GroupName="Gender" Text="Female" />
                            </asp:Panel>
                        </div>

                        <%-- Buttons --%>
                        <asp:Panel ID="Edit" runat="server" CssClass="text-center p-2">
                            <asp:Button ID="EditBtn" runat="server" Text="Edit" CssClass="btn btn-outline-info" OnClick="EditBtn_Click" />
                        </asp:Panel>
                        <asp:Panel ID="Save" runat="server" CssClass="text-center p-2" Visible="False">
                            <asp:Button ID="CancelBtn" runat="server" Text="Cancel" CssClass="btn btn-outline-danger" UseSubmitBehavior="False" CausesValidation="False" OnClick="CancelBtn_Click" />
                            <asp:Button ID="SaveBtn" runat="server" Text="Save" CssClass="btn btn-outline-success" OnClick="SaveBtn_Click" />
                        </asp:Panel>
                    </asp:Panel>

                    <%-- Address --%>
                    <asp:Panel ID="Edit_Address" runat="server" Visible="False">
                        <h6 class="text-center">My Address</h6>
                        <hr />
                        <div class="d-flex justify-content-center flex-wrap">
                            <asp:ListView ID="AddressListView" runat="server" DataSourceID="AddressDataSource">
                                <EmptyDataTemplate>
                                    No address found...
                                </EmptyDataTemplate>
                                <ItemTemplate>
                                    <div class="address_wrapper">
                                        <p><%# Eval("AddressLine") %>,</p>
                                        <p><%# Eval("City") %> <%# Eval("Zipcode") %>,</p>
                                        <p><%# Eval("State") %></p>
                                        <asp:Button ID="AddressDelBtn" runat="server" Text="Delete" CssClass="btn btn-danger w-100" CommandName='<%# Eval("Id") %>' OnClick="AddressDelBtn_Click" />
                                    </div>
                                </ItemTemplate>
                            </asp:ListView>
                        </div>

                        <hr />

                        <asp:Panel ID="NewAddressPanel" runat="server">
                            <h6>Add new address</h6>

                            <div>
                                <label for="body_Address">Address Line: </label>
                                <asp:TextBox ID="Address" runat="server" CssClass="form-control" placeholder="Your address" CausesValidation="True" MaxLength="100"></asp:TextBox>
                                <small>
                                    <asp:CustomValidator ID="AddressValidator" runat="server" EnableClientScript="False" ControlToValidate="Address" Display="Dynamic" CssClass="error" ValidateEmptyText="True" OnServerValidate="AddressValidator_ServerValidate"></asp:CustomValidator>
                                </small>
                            </div>
                            <div>
                                <label for="body_City">City: </label>
                                <asp:TextBox ID="City" runat="server" CssClass="form-control" placeholder="Your City" CausesValidation="True" MaxLength="50"></asp:TextBox>
                                <small>
                                    <asp:CustomValidator ID="CityValidator" runat="server" ValidateEmptyText="True" EnableClientScript="False" ControlToValidate="City" Display="Dynamic" CssClass="error" OnServerValidate="CityValidator_ServerValidate"></asp:CustomValidator>
                                </small>
                            </div>
                            <div>
                                <label for="body_Zipcode">Zip Code: </label>
                                <asp:TextBox ID="Zipcode" runat="server" CausesValidation="True" CssClass="form-control" MaxLength="5" placeholder="Zip Code"></asp:TextBox>
                                <small>
                                    <asp:CustomValidator ID="ZipcodeValidator" runat="server" Display="Dynamic" EnableClientScript="False" ValidateEmptyText="True" CssClass="error" ControlToValidate="Zipcode" OnServerValidate="ZipCodeValidator_ServerValidate"></asp:CustomValidator>
                                </small>
                            </div>
                            <div>
                                <label for="body_State">State: </label>
                                <asp:TextBox ID="State" CssClass="form-control" placeholder="Your State" CausesValidation="True" MaxLength="50" runat="server"></asp:TextBox>
                                <small>
                                    <asp:CustomValidator ID="StateValidator" runat="server" Display="Dynamic" EnableClientScript="False" ValidateEmptyText="True" CssClass="error" ControlToValidate="State" OnServerValidate="StateValidator_ServerValidate"></asp:CustomValidator>
                                </small>
                            </div>

                            <div class="p-2 text-center">
                                <asp:Button ID="AddAddress" runat="server" Text="Save" CssClass="btn btn-outline-success" OnClick="AddAddress_Click" />
                            </div>
                        </asp:Panel>
                    </asp:Panel>
                </div>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>

    <%-- Seller Page --%>
    <asp:Panel ID="SellerPanel" runat="server" CssClass="container bg-white p-0 profile_control d-flex">
        <div class="sideMenu">
            <div class="text-center">
                <asp:Image ID="Seller_Pic" runat="server" ImageUrl="Images/empty_profile.jpeg" />
                <asp:Label ID="Seller_Name" runat="server" Text="Current Name" CssClass="font-weight-bold"></asp:Label>
            </div>
            <hr />
            <div class="p-3">
                <h6>My Account</h6>
                <ul>
                    <li><a id="myProfile" href="#">My Profile</a></li>
                    <li><a id="myProducts" href="#">My Products</a></li>
                </ul>
            </div>
        </div>
        <div class="profile_info">
            <div id="My_Profile">
                <h5 class="text-center">< My Profile ></h5>
                <hr />
                <p>
                    <i class="far fa-id-card"></i>ID:
                    <asp:Label ID="SellerID" runat="server" Text="666"></asp:Label>
                </p>
                <p>
                    <i class="far fa-calendar-alt"></i>Date Joined:
                    <asp:Label ID="SellerDateJoined" runat="server" Text="666"></asp:Label>
                </p>
                <p>
                    <i class="fas fa-user-tie"></i>Name:
                    <asp:Label ID="SellerName" runat="server" Text="666"></asp:Label>
                </p>
                <p>
                    <i class="far fa-envelope"></i>Email:
                    <asp:Label ID="SellerEmail" runat="server" Text="666"></asp:Label>
                </p>
                <p>
                    <i class="fas fa-phone"></i>Phone Number:
                    <asp:Label ID="SellerPhone" runat="server" Text="666"></asp:Label>
                </p>
            </div>
            <div id="My_Products" style="display: none">
                <h5 class="text-center">< My Products ></h5>
                <hr />
                <div class="item_wrap">
                    <asp:ListView ID="ProductList" runat="server" DataSourceID="ProfileDataSource">
                        <EmptyDataTemplate>
                            <div>No Product Found....</div>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <a class="product_wrap" href='Broadcaster/ProductInfo.aspx?id=<%# Eval("Id") %>' title='<%# Eval("Name") %>'>
                                <div>
                                    <img src="Broadcaster/Product_Image/<%# Eval("Id") %>.jpg" />
                                </div>
                                <p class="productName"><%# Eval("Name") %></p>
                            </a>
                        </ItemTemplate>
                    </asp:ListView>
                </div>
            </div>
        </div>
    </asp:Panel>

</asp:Content>
