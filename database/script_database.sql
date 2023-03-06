

USE [master]
GO


/****** Object:  Database [SistemaAPPDb]    Script Date: 03/03/2023 20:11:17 ******/
if exists(select * from sysdatabases where name = 'SistemaAPPDb')
begin
	DROP DATABASE [SistemaAPPDb]
end
GO

/****** Object:  Database [SistemaAPPDb]    Script Date: 03/03/2023 20:11:17 ******/
CREATE DATABASE [SistemaAPPDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SistemaAPPDb', FILENAME = N'D:\ServerSQL\MSSQL\Data\SistemaAPPDb.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SistemaAPPDb_log', FILENAME = N'D:\ServerSQL\MSSQL\Data\SistemaAPPDb_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SistemaAPPDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [SistemaAPPDb] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [SistemaAPPDb] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [SistemaAPPDb] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [SistemaAPPDb] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [SistemaAPPDb] SET ARITHABORT OFF 
GO

ALTER DATABASE [SistemaAPPDb] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [SistemaAPPDb] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [SistemaAPPDb] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [SistemaAPPDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [SistemaAPPDb] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [SistemaAPPDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [SistemaAPPDb] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [SistemaAPPDb] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [SistemaAPPDb] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [SistemaAPPDb] SET  ENABLE_BROKER 
GO

ALTER DATABASE [SistemaAPPDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [SistemaAPPDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [SistemaAPPDb] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [SistemaAPPDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [SistemaAPPDb] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [SistemaAPPDb] SET READ_COMMITTED_SNAPSHOT ON 
GO

ALTER DATABASE [SistemaAPPDb] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [SistemaAPPDb] SET RECOVERY FULL 
GO

ALTER DATABASE [SistemaAPPDb] SET  MULTI_USER 
GO

ALTER DATABASE [SistemaAPPDb] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [SistemaAPPDb] SET DB_CHAINING OFF 
GO

ALTER DATABASE [SistemaAPPDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [SistemaAPPDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [SistemaAPPDb] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [SistemaAPPDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [SistemaAPPDb] SET QUERY_STORE = OFF
GO

ALTER DATABASE [SistemaAPPDb] SET  READ_WRITE 
GO




--=============================================================================================================
-- CRIANDO AS TABELAS
--=============================================================================================================
USE [SistemaAPPDb]
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 03/03/2023 20:16:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](100) NOT NULL,
	[ClaimType] [nvarchar](100) NULL,
	[ClaimValue] [nvarchar](100) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 03/03/2023 20:16:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](100) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](100) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 03/03/2023 20:16:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](100) NOT NULL,
	[ClaimType] [nvarchar](100) NULL,
	[ClaimValue] [nvarchar](100) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 03/03/2023 20:16:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](100) NOT NULL,
	[ProviderKey] [nvarchar](100) NOT NULL,
	[ProviderDisplayName] [nvarchar](100) NULL,
	[UserId] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 03/03/2023 20:16:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](100) NOT NULL,
	[RoleId] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 03/03/2023 20:16:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](100) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](100) NULL,
	[SecurityStamp] [nvarchar](100) NULL,
	[ConcurrencyStamp] [nvarchar](100) NULL,
	[PhoneNumber] [nvarchar](100) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 03/03/2023 20:16:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](100) NOT NULL,
	[LoginProvider] [nvarchar](100) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](100) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 03/03/2023 20:16:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Active] [bit] NOT NULL,
	[CreatedBy] [nvarchar](100) NOT NULL,
	[CreatedOn] [datetime2](7) NOT NULL,
	[EditedBy] [nvarchar](100) NOT NULL,
	[EditedOn] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogAPI]    Script Date: 03/03/2023 20:16:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogAPI](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Message] [nvarchar](max) NULL,
	[MessageTemplate] [nvarchar](max) NULL,
	[Level] [nvarchar](max) NULL,
	[TimeStamp] [datetime] NULL,
	[Exception] [nvarchar](max) NULL,
	[Properties] [nvarchar](max) NULL,
 CONSTRAINT [PK_LogAPI] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderProducts]    Script Date: 03/03/2023 20:16:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderProducts](
	[OrdersId] [uniqueidentifier] NOT NULL,
	[ProductsId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_OrderProducts] PRIMARY KEY CLUSTERED 
(
	[OrdersId] ASC,
	[ProductsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 03/03/2023 20:16:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [uniqueidentifier] NOT NULL,
	[ClientId] [nvarchar](100) NOT NULL,
	[Total] [decimal](18, 2) NOT NULL,
	[DeliveryAddress] [nvarchar](100) NOT NULL,
	[CreatedBy] [nvarchar](100) NOT NULL,
	[CreatedOn] [datetime2](7) NOT NULL,
	[EditedBy] [nvarchar](100) NOT NULL,
	[EditedOn] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 03/03/2023 20:16:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
	[CategoryId] [uniqueidentifier] NOT NULL,
	[HasStock] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
	[CreatedBy] [nvarchar](100) NOT NULL,
	[CreatedOn] [datetime2](7) NOT NULL,
	[EditedBy] [nvarchar](100) NOT NULL,
	[EditedOn] [datetime2](7) NOT NULL,
	[Price] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0.0)) FOR [Price]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[OrderProducts]  WITH CHECK ADD  CONSTRAINT [FK_OrderProducts_Orders_OrdersId] FOREIGN KEY([OrdersId])
REFERENCES [dbo].[Orders] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderProducts] CHECK CONSTRAINT [FK_OrderProducts_Orders_OrdersId]
GO
ALTER TABLE [dbo].[OrderProducts]  WITH CHECK ADD  CONSTRAINT [FK_OrderProducts_Products_ProductsId] FOREIGN KEY([ProductsId])
REFERENCES [dbo].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderProducts] CHECK CONSTRAINT [FK_OrderProducts_Products_ProductsId]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories_CategoryId]
GO




---====================================================================================================================
-- INSERINDO DADOS INICIAIS
---====================================================================================================================

-- USUARIO ADMINISTRADOR
INSERT INTO [dbo].[AspNetUsers]
           ([Id]
           ,[UserName]
           ,[NormalizedUserName]
           ,[Email]
           ,[NormalizedEmail]
           ,[EmailConfirmed]
           ,[PasswordHash]
           ,[SecurityStamp]
           ,[ConcurrencyStamp]
           ,[PhoneNumber]
           ,[PhoneNumberConfirmed]
           ,[TwoFactorEnabled]
           ,[LockoutEnd]
           ,[LockoutEnabled]
           ,[AccessFailedCount])
     VALUES
           ('2a7832b8-75be-4004-bd08-30a1b5046d86'
           ,'administrador@email.com.br'
           ,'ADMINISTRADOR@EMAIL.COM.BR'
           ,'administrador@email.com.br'
           ,'ADMINISTRADOR@EMAIL.COM.BR'
           ,0
           ,'AQAAAAEAACcQAAAAEET90W5WmAcWXVcYwDyqdScGKgC5R03pXDw3Wi0jL50Yrpvxnv7vuqZcH/KO9A3ZFQ=='
           ,'NABNZJGXID3LYPDGEI2M62IAGJPNAQMD'
           ,'ae43ae74-d17a-4eac-ace3-10c38b8e35cb'
           ,NULL
           ,0
           ,0
           ,NULL
           ,1
           ,0);

INSERT INTO [dbo].[AspNetUserClaims]
           ([UserId]
           ,[ClaimType]
           ,[ClaimValue])
     VALUES
           ('2a7832b8-75be-4004-bd08-30a1b5046d86','EmployeeCode','123456'),
		   ('2a7832b8-75be-4004-bd08-30a1b5046d86','Name','ADMINISTRADOR'),
		   ('2a7832b8-75be-4004-bd08-30a1b5046d86','CreatedBy','8a127948-14a7-4494-80ec-1bb9309163cb')
GO


-- USUARIO CLIENTE
INSERT INTO [dbo].[AspNetUsers]
           ([Id]
           ,[UserName]
           ,[NormalizedUserName]
           ,[Email]
           ,[NormalizedEmail]
           ,[EmailConfirmed]
           ,[PasswordHash]
           ,[SecurityStamp]
           ,[ConcurrencyStamp]
           ,[PhoneNumber]
           ,[PhoneNumberConfirmed]
           ,[TwoFactorEnabled]
           ,[LockoutEnd]
           ,[LockoutEnabled]
           ,[AccessFailedCount])
     VALUES
           ('6a6ef4d8-85f7-400e-be6b-3bbfcebc43a8'
           ,'cliente@email.com'
           ,'CLIENTE@EMAIL.COM'
           ,'cliente@email.com'
           ,'CLIENTE@EMAIL.COM'
           ,0
           ,'AQAAAAEAACcQAAAAEC6P79G8LZQFPl2ijKIJU5qOoq3Ur5UD1rP6k5h+0Ohhw506tL7JPyJ/bvMPkKuNuw=='
           ,'ZXY7S4JCNEONOPWSRU6LF4IY4GKEIICB'
           ,'c702f645-13f4-45c3-b9ea-4a7862113856'
           ,NULL
           ,0
           ,0
           ,NULL
           ,1
           ,0);

INSERT INTO [dbo].[AspNetUserClaims]
           ([UserId]
           ,[ClaimType]
           ,[ClaimValue])
     VALUES
           ('6a6ef4d8-85f7-400e-be6b-3bbfcebc43a8','Cpf','09568648801'),
		   ('6a6ef4d8-85f7-400e-be6b-3bbfcebc43a8','Name','CLIENTE')
		   
GO
