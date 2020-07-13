SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Buyer](
	[Id] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Email] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Password] [char](44) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PhoneNumber] [varchar](11) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Gender] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Verified] [bit] NOT NULL,
	[DateJoined] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seller](
	[Id] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Email] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Password] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PhoneNumber] [varchar](11) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Verified] [bit] NOT NULL,
	[DateJoined] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[User]
AS 
SELECT [Id], [Name], [Email], [Password], [PhoneNumber], [Verified], [DateJoined], 'Buyer' AS [role] FROM [Buyer]
Union
SELECT [Id], [Name], [Email], [Password], [PhoneNumber], [Verified], [DateJoined], 'Seller' AS [role] FROM [Seller]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[Id] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Order_date] [datetime] NOT NULL,
	[Order_Status] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Quantity] [int] NOT NULL,
	[TotalPrice] [decimal](12, 2) NOT NULL,
	[Buyer_Id] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Address_Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_Detail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Product_Id] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Order_Id] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Name] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Description] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Quantity] [int] NOT NULL,
	[Price] [decimal](6, 2) NOT NULL,
	[Active] [bit] NOT NULL,
	[Seller_Id] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OrderSales]
	AS SELECT o.[Id], p.[Name] AS [ProductName], o.[Quantity], o.[TotalPrice], s.[Name] AS [SellerName] 
	FROM [Order] o, [Order_Detail] od, [Product] p ,[Seller] s
	WHERE o.[Id] = od.[Order_Id] and od.[Product_Id] = p.[Id] and p.[Seller_Id] = s.[Id]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AddressLine] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[City] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[State] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Zipcode] [char](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[User_Id] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[Id] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Email] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Password] [char](44) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Buyer_Id] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Product_Id] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stream](
	[Id] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TotalView] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Seller_Id] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Active] [bit] NOT NULL,
	[Screenshot] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stream_Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoomID] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ProductID] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
ALTER TABLE [dbo].[Address] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Buyer] ADD  DEFAULT ((0)) FOR [Verified]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT ('Pending') FOR [Order_Status]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0.00)) FOR [Price]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Seller] ADD  DEFAULT ((0)) FOR [Verified]
GO
ALTER TABLE [dbo].[Stream] ADD  DEFAULT ((0)) FOR [TotalView]
GO
ALTER TABLE [dbo].[Stream] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_CartToBuyer] FOREIGN KEY([Buyer_Id])
REFERENCES [dbo].[Buyer] ([Id])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_CartToBuyer]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_CartToProduct] FOREIGN KEY([Product_Id])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_CartToProduct]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Address] FOREIGN KEY([Address_Id])
REFERENCES [dbo].[Address] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Address]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Buyer] FOREIGN KEY([Buyer_Id])
REFERENCES [dbo].[Buyer] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Buyer]
GO
ALTER TABLE [dbo].[Order_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Order_DetailToOrder] FOREIGN KEY([Order_Id])
REFERENCES [dbo].[Order] ([Id])
GO
ALTER TABLE [dbo].[Order_Detail] CHECK CONSTRAINT [FK_Order_DetailToOrder]
GO
ALTER TABLE [dbo].[Order_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Order_DetailToProduct] FOREIGN KEY([Product_Id])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[Order_Detail] CHECK CONSTRAINT [FK_Order_DetailToProduct]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_ProducToSeller] FOREIGN KEY([Seller_Id])
REFERENCES [dbo].[Seller] ([Id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_ProducToSeller]
GO
ALTER TABLE [dbo].[Stream]  WITH CHECK ADD  CONSTRAINT [FK_StreamToSeller] FOREIGN KEY([Seller_Id])
REFERENCES [dbo].[Seller] ([Id])
GO
ALTER TABLE [dbo].[Stream] CHECK CONSTRAINT [FK_StreamToSeller]
GO
ALTER TABLE [dbo].[Stream_Product]  WITH CHECK ADD  CONSTRAINT [FK_Stream_Product_ToProduct] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[Stream_Product] CHECK CONSTRAINT [FK_Stream_Product_ToProduct]
GO
ALTER TABLE [dbo].[Stream_Product]  WITH CHECK ADD  CONSTRAINT [FK_Stream_Product_ToStream] FOREIGN KEY([RoomID])
REFERENCES [dbo].[Stream] ([Id])
GO
ALTER TABLE [dbo].[Stream_Product] CHECK CONSTRAINT [FK_Stream_Product_ToStream]
GO
