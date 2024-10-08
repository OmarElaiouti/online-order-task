USE [RestaurantDelivery]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 7/26/2024 10:19:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cities]    Script Date: 7/26/2024 10:19:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities](
	[CityId] [int] IDENTITY(1,1) NOT NULL,
	[CityName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED 
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MenuItems]    Script Date: 7/26/2024 10:19:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuItems](
	[MenuItemId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[MenuItemImage] [nvarchar](max) NOT NULL,
	[RestaurantId] [int] NOT NULL,
 CONSTRAINT [PK_MenuItems] PRIMARY KEY CLUSTERED 
(
	[MenuItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 7/26/2024 10:19:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItems](
	[OrderItemId] [int] IDENTITY(1,1) NOT NULL,
	[MenuItemId] [int] NOT NULL,
	[OrderId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[TotalPrice] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_OrderItems] PRIMARY KEY CLUSTERED 
(
	[OrderItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 7/26/2024 10:19:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](max) NOT NULL,
	[CustomerEmail] [nvarchar](max) NOT NULL,
	[CustomerPhone] [nvarchar](max) NOT NULL,
	[CustomerAddress] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Restaurants]    Script Date: 7/26/2024 10:19:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Restaurants](
	[RestaurantId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[RestaurantImage] [nvarchar](max) NOT NULL,
	[CityId] [int] NOT NULL,
 CONSTRAINT [PK_Restaurants] PRIMARY KEY CLUSTERED 
(
	[RestaurantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240726032356_final', N'8.0.7')
GO
SET IDENTITY_INSERT [dbo].[Cities] ON 

INSERT [dbo].[Cities] ([CityId], [CityName]) VALUES (1, N'Cairo')
INSERT [dbo].[Cities] ([CityId], [CityName]) VALUES (2, N'Alexandria')
INSERT [dbo].[Cities] ([CityId], [CityName]) VALUES (3, N'Giza')
INSERT [dbo].[Cities] ([CityId], [CityName]) VALUES (4, N'Sharm El-Sheikh')
INSERT [dbo].[Cities] ([CityId], [CityName]) VALUES (5, N'Luxor')
INSERT [dbo].[Cities] ([CityId], [CityName]) VALUES (6, N'Aswan')
INSERT [dbo].[Cities] ([CityId], [CityName]) VALUES (7, N'Hurghada')
INSERT [dbo].[Cities] ([CityId], [CityName]) VALUES (8, N'Port Said')
SET IDENTITY_INSERT [dbo].[Cities] OFF
GO
SET IDENTITY_INSERT [dbo].[MenuItems] ON 

INSERT [dbo].[MenuItems] ([MenuItemId], [Name], [Price], [MenuItemImage], [RestaurantId]) VALUES (1, N'Feteer Meshaltet', CAST(50.00 AS Decimal(18, 2)), N'assets/images/food/Feteer_Meshaltet.jpg', 1)
INSERT [dbo].[MenuItems] ([MenuItemId], [Name], [Price], [MenuItemImage], [RestaurantId]) VALUES (2, N'Hawawshi', CAST(30.00 AS Decimal(18, 2)), N'assets/images/food/Hawawshi.jpg', 2)
INSERT [dbo].[MenuItems] ([MenuItemId], [Name], [Price], [MenuItemImage], [RestaurantId]) VALUES (3, N'Falafel', CAST(10.00 AS Decimal(18, 2)), N'assets/images/food/Falafel.jpg', 3)
INSERT [dbo].[MenuItems] ([MenuItemId], [Name], [Price], [MenuItemImage], [RestaurantId]) VALUES (4, N'Koshary', CAST(20.00 AS Decimal(18, 2)), N'assets/images/food/Koshary.jpg', 4)
INSERT [dbo].[MenuItems] ([MenuItemId], [Name], [Price], [MenuItemImage], [RestaurantId]) VALUES (5, N'Grilled Fish', CAST(100.00 AS Decimal(18, 2)), N'assets/images/food/Grilled_Fish.jpg', 5)
INSERT [dbo].[MenuItems] ([MenuItemId], [Name], [Price], [MenuItemImage], [RestaurantId]) VALUES (6, N'Stuffed Pigeon', CAST(75.00 AS Decimal(18, 2)), N'assets/images/food/Stuffed_Pigeon.jpg', 6)
INSERT [dbo].[MenuItems] ([MenuItemId], [Name], [Price], [MenuItemImage], [RestaurantId]) VALUES (7, N'Mombar', CAST(40.00 AS Decimal(18, 2)), N'assets/images/food/Mombar.jpg', 7)
INSERT [dbo].[MenuItems] ([MenuItemId], [Name], [Price], [MenuItemImage], [RestaurantId]) VALUES (8, N'Seafood Soup', CAST(60.00 AS Decimal(18, 2)), N'assets/images/food/Seafood_Soup.jpg', 8)
INSERT [dbo].[MenuItems] ([MenuItemId], [Name], [Price], [MenuItemImage], [RestaurantId]) VALUES (9, N'Molokhia', CAST(25.00 AS Decimal(18, 2)), N'assets/images/food/Molokhia.jpg', 1)
INSERT [dbo].[MenuItems] ([MenuItemId], [Name], [Price], [MenuItemImage], [RestaurantId]) VALUES (10, N'Kebab', CAST(80.00 AS Decimal(18, 2)), N'assets/images/food/Kebab.jpg', 2)
INSERT [dbo].[MenuItems] ([MenuItemId], [Name], [Price], [MenuItemImage], [RestaurantId]) VALUES (11, N'Shawarma', CAST(35.00 AS Decimal(18, 2)), N'assets/images/food/Shawarma.jpg', 3)
INSERT [dbo].[MenuItems] ([MenuItemId], [Name], [Price], [MenuItemImage], [RestaurantId]) VALUES (12, N'Baklava', CAST(15.00 AS Decimal(18, 2)), N'assets/images/food/Baklava.jpg', 4)
INSERT [dbo].[MenuItems] ([MenuItemId], [Name], [Price], [MenuItemImage], [RestaurantId]) VALUES (13, N'Shrimp Cocktail', CAST(70.00 AS Decimal(18, 2)), N'assets/images/food/Shrimp_Cocktail.jpg', 5)
INSERT [dbo].[MenuItems] ([MenuItemId], [Name], [Price], [MenuItemImage], [RestaurantId]) VALUES (14, N'Camel Steak', CAST(90.00 AS Decimal(18, 2)), N'assets/images/food/Camel_Steak.jpg', 6)
INSERT [dbo].[MenuItems] ([MenuItemId], [Name], [Price], [MenuItemImage], [RestaurantId]) VALUES (15, N'Stuffed Vine Leaves', CAST(50.00 AS Decimal(18, 2)), N'assets/images/food/Stuffed_Vine_Leaves.jpg', 7)
INSERT [dbo].[MenuItems] ([MenuItemId], [Name], [Price], [MenuItemImage], [RestaurantId]) VALUES (16, N'Fried Calamari', CAST(65.00 AS Decimal(18, 2)), N'assets/images/food/Fried_Calamari.jpg', 8)
SET IDENTITY_INSERT [dbo].[MenuItems] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderItems] ON 

INSERT [dbo].[OrderItems] ([OrderItemId], [MenuItemId], [OrderId], [Quantity], [TotalPrice]) VALUES (1, 8, 1, 1, CAST(60.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [MenuItemId], [OrderId], [Quantity], [TotalPrice]) VALUES (2, 16, 1, 1, CAST(65.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [MenuItemId], [OrderId], [Quantity], [TotalPrice]) VALUES (3, 8, 2, 1, CAST(60.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [MenuItemId], [OrderId], [Quantity], [TotalPrice]) VALUES (4, 16, 2, 1, CAST(65.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [MenuItemId], [OrderId], [Quantity], [TotalPrice]) VALUES (5, 11, 3, 4, CAST(140.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[OrderItems] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderId], [CustomerName], [CustomerEmail], [CustomerPhone], [CustomerAddress]) VALUES (1, N'omar', N'dg@dfgd.com', N'01092519738', N'dgd')
INSERT [dbo].[Orders] ([OrderId], [CustomerName], [CustomerEmail], [CustomerPhone], [CustomerAddress]) VALUES (2, N'omar', N'dg@dfgd.com', N'01092519738', N'dgd')
INSERT [dbo].[Orders] ([OrderId], [CustomerName], [CustomerEmail], [CustomerPhone], [CustomerAddress]) VALUES (3, N'omar', N'dg@dfgd.com', N'01092519738', N'dgd')
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Restaurants] ON 

INSERT [dbo].[Restaurants] ([RestaurantId], [Name], [RestaurantImage], [CityId]) VALUES (1, N'El Malky', N'assets/images/restaurants/el_malky.jpg', 1)
INSERT [dbo].[Restaurants] ([RestaurantId], [Name], [RestaurantImage], [CityId]) VALUES (2, N'Abo Haidar', N'assets/images/restaurants/abo_haidar.jpg', 1)
INSERT [dbo].[Restaurants] ([RestaurantId], [Name], [RestaurantImage], [CityId]) VALUES (3, N'Gad', N'assets/images/restaurants/gad.jpg', 2)
INSERT [dbo].[Restaurants] ([RestaurantId], [Name], [RestaurantImage], [CityId]) VALUES (4, N'Koshary Tahrir', N'assets/images/restaurants/koshary_tahrir.jpg', 3)
INSERT [dbo].[Restaurants] ([RestaurantId], [Name], [RestaurantImage], [CityId]) VALUES (5, N'Fares Seafood', N'assets/images/restaurants/fares_seafood.jpg', 4)
INSERT [dbo].[Restaurants] ([RestaurantId], [Name], [RestaurantImage], [CityId]) VALUES (6, N'Sofra', N'assets/images/restaurants/sofra.png', 5)
INSERT [dbo].[Restaurants] ([RestaurantId], [Name], [RestaurantImage], [CityId]) VALUES (7, N'Al Masry', N'assets/images/restaurants/al_masry.jpg', 6)
INSERT [dbo].[Restaurants] ([RestaurantId], [Name], [RestaurantImage], [CityId]) VALUES (8, N'El Halaka', N'assets/images/restaurants/el_halaka.jpg', 7)
INSERT [dbo].[Restaurants] ([RestaurantId], [Name], [RestaurantImage], [CityId]) VALUES (9, N'El Borg', N'assets/images/restaurants/el_borg.jpg', 8)
SET IDENTITY_INSERT [dbo].[Restaurants] OFF
GO
ALTER TABLE [dbo].[MenuItems]  WITH CHECK ADD  CONSTRAINT [FK_MenuItems_Restaurants_RestaurantId] FOREIGN KEY([RestaurantId])
REFERENCES [dbo].[Restaurants] ([RestaurantId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MenuItems] CHECK CONSTRAINT [FK_MenuItems_Restaurants_RestaurantId]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_MenuItems_MenuItemId] FOREIGN KEY([MenuItemId])
REFERENCES [dbo].[MenuItems] ([MenuItemId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_MenuItems_MenuItemId]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_Orders_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([OrderId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_Orders_OrderId]
GO
ALTER TABLE [dbo].[Restaurants]  WITH CHECK ADD  CONSTRAINT [FK_Restaurants_Cities_CityId] FOREIGN KEY([CityId])
REFERENCES [dbo].[Cities] ([CityId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Restaurants] CHECK CONSTRAINT [FK_Restaurants_Cities_CityId]
GO
