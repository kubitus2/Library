USE [master]
GO
/****** Object:  Database [Library]    Script Date: 26/01/2025 20:49:25 ******/
CREATE DATABASE [Library]

ALTER DATABASE [Library] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Library].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Library] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Library] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Library] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Library] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Library] SET ARITHABORT OFF 
GO
ALTER DATABASE [Library] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Library] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Library] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Library] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Library] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Library] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Library] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Library] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Library] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Library] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Library] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Library] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Library] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Library] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Library] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Library] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Library] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Library] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Library] SET  MULTI_USER 
GO
ALTER DATABASE [Library] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Library] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Library] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Library] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Library] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Library] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Library] SET QUERY_STORE = ON
GO
ALTER DATABASE [Library] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Library]
GO
/****** Object:  User [admin]    Script Date: 26/01/2025 20:49:25 ******/
CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [admin]
GO
/****** Object:  Table [dbo].[address]    Script Date: 26/01/2025 20:49:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[address](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[street] [nvarchar](255) NOT NULL,
	[buildingNumber] [nvarchar](255) NOT NULL,
	[flatNumber] [nvarchar](255) NULL,
	[postalCode] [nvarchar](255) NOT NULL,
	[city] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[author]    Script Date: 26/01/2025 20:49:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[author](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [nvarchar](255) NOT NULL,
	[lastName] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[availabilityStatus]    Script Date: 26/01/2025 20:49:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[availabilityStatus](
	[id] [int] NOT NULL,
	[type] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[book]    Script Date: 26/01/2025 20:49:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[book](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[ISBN] [nvarchar](255) NULL,
	[price] [decimal](10, 2) NULL,
	[genre] [nvarchar](255) NULL,
	[publishedYear] [int] NOT NULL,
	[isAvailableForSale] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bookAuthor]    Script Date: 26/01/2025 20:49:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bookAuthor](
	[author_id] [int] NOT NULL,
	[book_id] [int] NOT NULL,
 CONSTRAINT [PK_BookAuthor] PRIMARY KEY CLUSTERED 
(
	[author_id] ASC,
	[book_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bookCopy]    Script Date: 26/01/2025 20:49:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bookCopy](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[book_id] [int] NOT NULL,
	[availability] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[checkout]    Script Date: 26/01/2025 20:49:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[checkout](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[bookCopyId] [int] NOT NULL,
	[userId] [int] NOT NULL,
	[borrowDate] [date] NOT NULL,
	[returnedDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fee]    Script Date: 26/01/2025 20:49:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fee](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[amount] [decimal](10, 2) NULL,
	[checkoutId] [int] NOT NULL,
	[feeType] [int] NOT NULL,
	[userId] [int] NOT NULL,
	[description] [nvarchar](255) NULL,
	[paid] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[feeType]    Script Date: 26/01/2025 20:49:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[feeType](
	[id] [int] NOT NULL,
	[type] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order]    Script Date: 26/01/2025 20:49:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[orderDate] [date] NOT NULL,
	[addressId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orderDetails]    Script Date: 26/01/2025 20:49:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orderDetails](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[bookCopyId] [int] NULL,
	[orderId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user]    Script Date: 26/01/2025 20:49:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [nvarchar](255) NULL,
	[lastName] [nvarchar](255) NULL,
	[email] [nvarchar](255) NOT NULL,
	[phone] [nvarchar](255) NOT NULL,
	[isBlocked] [bit] NULL,
	[isActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[address] ON 

INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (1, N'Gąsowskiego', N'12', N'5', N'31-123', N'Kraków')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (2, N'Łąkowa', N'18A', N'2', N'01-987', N'Warszawa')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (3, N'Królowej Jadwigi', N'45', NULL, N'80-453', N'Gdańsk')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (4, N'Leśna', N'7', N'12', N'41-123', N'Katowice')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (5, N'Słoneczna', N'89', NULL, N'32-700', N'Oświęcim')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (6, N'Żwirki i Wigury', N'13B', N'8', N'02-092', N'Warszawa')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (7, N'Chopina', N'101', N'3', N'90-122', N'Łódź')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (8, N'Jana Pawła II', N'22', N'14', N'43-100', N'Tychy')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (9, N'Powstańców', N'9A', N'7', N'58-200', N'Wałbrzych')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (10, N'Mickiewicza', N'5', NULL, N'50-030', N'Wrocław')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (11, N'Pogodna', N'16', N'11', N'71-123', N'Szczecin')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (12, N'Targowa', N'30', NULL, N'03-734', N'Warszawa')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (13, N'Szkolna', N'17', NULL, N'15-640', N'Białystok')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (14, N'Wiatraczna', N'55', NULL, N'11-123', N'Olsztyn')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (15, N'Lipowa', N'8C', N'2', N'20-543', N'Lublin')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (16, N'Cicha', N'33', N'4', N'15-950', N'Białystok')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (17, N'Różana', N'77', NULL, N'27-600', N'Starachowice')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (18, N'Wiosenna', N'29', N'9', N'61-123', N'Poznań')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (19, N'Jagodowa', N'14', NULL, N'40-089', N'Katowice')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (20, N'Grunwaldzka', N'19', N'3', N'80-800', N'Gdynia')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (21, N'Szafirowa', N'66B', N'7', N'10-456', N'Olsztyn')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (22, N'Dworcowa', N'11', NULL, N'89-600', N'Chojnice')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (23, N'Łąkowa', N'23', N'2', N'34-200', N'Zakopane')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (24, N'Spacerowa', N'44', N'6', N'18-300', N'Łomża')
INSERT [dbo].[address] ([id], [street], [buildingNumber], [flatNumber], [postalCode], [city]) VALUES (25, N'Dębowa', N'100', NULL, N'43-300', N'Bielsko-Biała')
SET IDENTITY_INSERT [dbo].[address] OFF
GO
SET IDENTITY_INSERT [dbo].[author] ON 

INSERT [dbo].[author] ([id], [firstName], [lastName]) VALUES (1, N'Remigiusz', N'Mróz')
INSERT [dbo].[author] ([id], [firstName], [lastName]) VALUES (2, N'Olga', N'Tokarczuk')
INSERT [dbo].[author] ([id], [firstName], [lastName]) VALUES (3, N'Stanisław', N'Lem')
INSERT [dbo].[author] ([id], [firstName], [lastName]) VALUES (4, N'Henryk', N'Sienkiewicz')
INSERT [dbo].[author] ([id], [firstName], [lastName]) VALUES (5, N'Andrzej', N'Sapkowski')
INSERT [dbo].[author] ([id], [firstName], [lastName]) VALUES (6, N'Adam', N'Mickiewicz')
INSERT [dbo].[author] ([id], [firstName], [lastName]) VALUES (7, N'Jakub', N'Żulczyk')
INSERT [dbo].[author] ([id], [firstName], [lastName]) VALUES (8, N'George', N'Orwell')
INSERT [dbo].[author] ([id], [firstName], [lastName]) VALUES (9, N'Joanna', N'Chmielewska')
SET IDENTITY_INSERT [dbo].[author] OFF
GO
INSERT [dbo].[availabilityStatus] ([id], [type]) VALUES (1, N'Available')
INSERT [dbo].[availabilityStatus] ([id], [type]) VALUES (2, N'Borrowed')
INSERT [dbo].[availabilityStatus] ([id], [type]) VALUES (3, N'Sold')
GO
SET IDENTITY_INSERT [dbo].[book] ON 

INSERT [dbo].[book] ([id], [title], [ISBN], [price], [genre], [publishedYear], [isAvailableForSale]) VALUES (1, N'Kasacja', N'9788379768063', CAST(42.00 AS Decimal(10, 2)), N'Kryminał', 2015, 1)
INSERT [dbo].[book] ([id], [title], [ISBN], [price], [genre], [publishedYear], [isAvailableForSale]) VALUES (2, N'Zaginięcie', N'9788379768124', CAST(43.99 AS Decimal(10, 2)), N'Kryminał', 2016, 1)
INSERT [dbo].[book] ([id], [title], [ISBN], [price], [genre], [publishedYear], [isAvailableForSale]) VALUES (3, N'Bieguni', N'9788308065973', CAST(46.00 AS Decimal(10, 2)), N'Literatura piękna', 2007, 1)
INSERT [dbo].[book] ([id], [title], [ISBN], [price], [genre], [publishedYear], [isAvailableForSale]) VALUES (4, N'Księgi Jakubowe', N'9788308064983', CAST(60.00 AS Decimal(10, 2)), N'Literatura piękna', 2014, 1)
INSERT [dbo].[book] ([id], [title], [ISBN], [price], [genre], [publishedYear], [isAvailableForSale]) VALUES (5, N'Solaris', N'9788377995638', CAST(35.99 AS Decimal(10, 2)), N'Science fiction', 1961, 1)
INSERT [dbo].[book] ([id], [title], [ISBN], [price], [genre], [publishedYear], [isAvailableForSale]) VALUES (6, N'Bajki robotów', N'9788377995621', CAST(30.00 AS Decimal(10, 2)), N'Science fiction', 1964, 1)
INSERT [dbo].[book] ([id], [title], [ISBN], [price], [genre], [publishedYear], [isAvailableForSale]) VALUES (7, N'Quo Vadis', N'9788373275230', CAST(50.00 AS Decimal(10, 2)), N'Historyczna', 1896, 1)
INSERT [dbo].[book] ([id], [title], [ISBN], [price], [genre], [publishedYear], [isAvailableForSale]) VALUES (8, N'Potop', N'9788373275247', CAST(55.00 AS Decimal(10, 2)), N'Historyczna', 1886, 0)
INSERT [dbo].[book] ([id], [title], [ISBN], [price], [genre], [publishedYear], [isAvailableForSale]) VALUES (9, N'Ostatnie Życzenie', N'9788375780633', CAST(40.00 AS Decimal(10, 2)), N'Fantasy', 1993, 1)
INSERT [dbo].[book] ([id], [title], [ISBN], [price], [genre], [publishedYear], [isAvailableForSale]) VALUES (10, N'Miecz Przeznaczenia', N'9788375780626', CAST(40.00 AS Decimal(10, 2)), N'Fantasy', 1992, 1)
INSERT [dbo].[book] ([id], [title], [ISBN], [price], [genre], [publishedYear], [isAvailableForSale]) VALUES (11, N'Pan Tadeusz', N'9788373778724', CAST(30.00 AS Decimal(10, 2)), N'Epika', 1834, 0)
INSERT [dbo].[book] ([id], [title], [ISBN], [price], [genre], [publishedYear], [isAvailableForSale]) VALUES (12, N'Dziady', N'9788373778731', CAST(25.99 AS Decimal(10, 2)), N'Dramat', 1823, 1)
INSERT [dbo].[book] ([id], [title], [ISBN], [price], [genre], [publishedYear], [isAvailableForSale]) VALUES (13, N'Ślepnąc od świateł', N'9788379761263', CAST(40.00 AS Decimal(10, 2)), N'Thriller', 2014, 1)
INSERT [dbo].[book] ([id], [title], [ISBN], [price], [genre], [publishedYear], [isAvailableForSale]) VALUES (14, N'Informacja zwrotna', N'9788379761256', CAST(35.00 AS Decimal(10, 2)), N'Literatura piękna', 2021, 1)
INSERT [dbo].[book] ([id], [title], [ISBN], [price], [genre], [publishedYear], [isAvailableForSale]) VALUES (15, N'Rok 1984', N'9788378564932', CAST(30.00 AS Decimal(10, 2)), N'Dystopia', 1949, 1)
INSERT [dbo].[book] ([id], [title], [ISBN], [price], [genre], [publishedYear], [isAvailableForSale]) VALUES (16, N'Folwark zwierzęcy', N'9788378564949', CAST(25.99 AS Decimal(10, 2)), N'Dystopia', 1945, 0)
INSERT [dbo].[book] ([id], [title], [ISBN], [price], [genre], [publishedYear], [isAvailableForSale]) VALUES (17, N'Lesio', N'9788374545744', CAST(35.00 AS Decimal(10, 2)), N'Komedia kryminalna', 1973, 1)
INSERT [dbo].[book] ([id], [title], [ISBN], [price], [genre], [publishedYear], [isAvailableForSale]) VALUES (18, N'Całe zdanie nieboszczyka', N'9788374545751', CAST(37.00 AS Decimal(10, 2)), N'Kryminał', 1972, 1)
SET IDENTITY_INSERT [dbo].[book] OFF
GO
INSERT [dbo].[bookAuthor] ([author_id], [book_id]) VALUES (1, 1)
INSERT [dbo].[bookAuthor] ([author_id], [book_id]) VALUES (1, 2)
INSERT [dbo].[bookAuthor] ([author_id], [book_id]) VALUES (2, 3)
INSERT [dbo].[bookAuthor] ([author_id], [book_id]) VALUES (2, 4)
INSERT [dbo].[bookAuthor] ([author_id], [book_id]) VALUES (3, 5)
INSERT [dbo].[bookAuthor] ([author_id], [book_id]) VALUES (3, 6)
INSERT [dbo].[bookAuthor] ([author_id], [book_id]) VALUES (4, 7)
INSERT [dbo].[bookAuthor] ([author_id], [book_id]) VALUES (4, 8)
INSERT [dbo].[bookAuthor] ([author_id], [book_id]) VALUES (5, 9)
INSERT [dbo].[bookAuthor] ([author_id], [book_id]) VALUES (5, 10)
INSERT [dbo].[bookAuthor] ([author_id], [book_id]) VALUES (6, 11)
INSERT [dbo].[bookAuthor] ([author_id], [book_id]) VALUES (6, 12)
INSERT [dbo].[bookAuthor] ([author_id], [book_id]) VALUES (7, 13)
INSERT [dbo].[bookAuthor] ([author_id], [book_id]) VALUES (7, 14)
INSERT [dbo].[bookAuthor] ([author_id], [book_id]) VALUES (8, 15)
INSERT [dbo].[bookAuthor] ([author_id], [book_id]) VALUES (8, 16)
INSERT [dbo].[bookAuthor] ([author_id], [book_id]) VALUES (9, 17)
INSERT [dbo].[bookAuthor] ([author_id], [book_id]) VALUES (9, 18)
GO
SET IDENTITY_INSERT [dbo].[bookCopy] ON 

INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (1, 1, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (2, 1, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (3, 1, 3)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (4, 1, 2)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (5, 1, 3)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (6, 2, 3)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (7, 2, 3)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (8, 2, 3)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (9, 2, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (10, 3, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (11, 3, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (12, 3, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (13, 3, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (14, 3, 2)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (15, 4, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (16, 4, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (17, 4, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (18, 5, 2)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (19, 5, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (20, 5, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (21, 5, 3)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (22, 5, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (23, 6, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (24, 6, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (25, 6, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (26, 6, 3)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (27, 7, 3)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (28, 7, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (29, 7, 2)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (30, 7, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (31, 7, 2)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (32, 8, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (33, 8, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (34, 8, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (35, 9, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (36, 9, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (37, 9, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (38, 9, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (39, 9, 2)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (40, 10, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (41, 10, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (42, 10, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (43, 10, 3)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (44, 11, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (45, 11, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (46, 11, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (47, 11, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (48, 11, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (49, 12, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (50, 12, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (51, 12, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (52, 13, 2)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (53, 13, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (54, 13, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (55, 13, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (56, 13, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (57, 14, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (58, 14, 2)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (59, 14, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (60, 14, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (61, 15, 2)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (62, 15, 3)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (63, 15, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (64, 15, 3)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (65, 15, 3)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (66, 16, 3)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (67, 16, 3)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (68, 16, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (69, 17, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (70, 17, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (71, 17, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (72, 17, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (73, 17, 2)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (74, 18, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (75, 18, 3)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (76, 18, 1)
INSERT [dbo].[bookCopy] ([id], [book_id], [availability]) VALUES (77, 18, 1)
SET IDENTITY_INSERT [dbo].[bookCopy] OFF
GO
SET IDENTITY_INSERT [dbo].[checkout] ON 

INSERT [dbo].[checkout] ([id], [bookCopyId], [userId], [borrowDate], [returnedDate]) VALUES (1, 52, 8, CAST(N'2024-03-23' AS Date), CAST(N'2024-04-15' AS Date))
INSERT [dbo].[checkout] ([id], [bookCopyId], [userId], [borrowDate], [returnedDate]) VALUES (2, 58, 20, CAST(N'2024-03-24' AS Date), CAST(N'2024-04-28' AS Date))
INSERT [dbo].[checkout] ([id], [bookCopyId], [userId], [borrowDate], [returnedDate]) VALUES (3, 73, 19, CAST(N'2024-03-07' AS Date), CAST(N'2024-03-29' AS Date))
INSERT [dbo].[checkout] ([id], [bookCopyId], [userId], [borrowDate], [returnedDate]) VALUES (4, 39, 5, CAST(N'2024-12-12' AS Date), CAST(N'2024-12-28' AS Date))
INSERT [dbo].[checkout] ([id], [bookCopyId], [userId], [borrowDate], [returnedDate]) VALUES (5, 4, 7, CAST(N'2024-06-03' AS Date), CAST(N'2024-07-03' AS Date))
INSERT [dbo].[checkout] ([id], [bookCopyId], [userId], [borrowDate], [returnedDate]) VALUES (6, 61, 15, CAST(N'2024-04-22' AS Date), CAST(N'2024-05-11' AS Date))
INSERT [dbo].[checkout] ([id], [bookCopyId], [userId], [borrowDate], [returnedDate]) VALUES (7, 31, 6, CAST(N'2024-06-18' AS Date), CAST(N'2024-07-07' AS Date))
INSERT [dbo].[checkout] ([id], [bookCopyId], [userId], [borrowDate], [returnedDate]) VALUES (8, 18, 9, CAST(N'2024-12-22' AS Date), NULL)
INSERT [dbo].[checkout] ([id], [bookCopyId], [userId], [borrowDate], [returnedDate]) VALUES (9, 14, 17, CAST(N'2025-01-15' AS Date), NULL)
INSERT [dbo].[checkout] ([id], [bookCopyId], [userId], [borrowDate], [returnedDate]) VALUES (10, 29, 14, CAST(N'2025-01-02' AS Date), NULL)
SET IDENTITY_INSERT [dbo].[checkout] OFF
GO
SET IDENTITY_INSERT [dbo].[fee] ON 

INSERT [dbo].[fee] ([id], [amount], [checkoutId], [feeType], [userId], [description], [paid]) VALUES (1, CAST(10.00 AS Decimal(10, 2)), 1, 1, 8, NULL, 1)
INSERT [dbo].[fee] ([id], [amount], [checkoutId], [feeType], [userId], [description], [paid]) VALUES (2, CAST(10.00 AS Decimal(10, 2)), 2, 1, 20, NULL, 1)
INSERT [dbo].[fee] ([id], [amount], [checkoutId], [feeType], [userId], [description], [paid]) VALUES (3, CAST(10.00 AS Decimal(10, 2)), 3, 1, 19, NULL, 1)
INSERT [dbo].[fee] ([id], [amount], [checkoutId], [feeType], [userId], [description], [paid]) VALUES (4, CAST(10.00 AS Decimal(10, 2)), 4, 1, 5, NULL, 1)
INSERT [dbo].[fee] ([id], [amount], [checkoutId], [feeType], [userId], [description], [paid]) VALUES (5, CAST(10.00 AS Decimal(10, 2)), 5, 1, 7, NULL, 1)
INSERT [dbo].[fee] ([id], [amount], [checkoutId], [feeType], [userId], [description], [paid]) VALUES (6, CAST(10.00 AS Decimal(10, 2)), 6, 1, 15, NULL, 1)
INSERT [dbo].[fee] ([id], [amount], [checkoutId], [feeType], [userId], [description], [paid]) VALUES (7, CAST(10.00 AS Decimal(10, 2)), 7, 1, 6, NULL, 1)
INSERT [dbo].[fee] ([id], [amount], [checkoutId], [feeType], [userId], [description], [paid]) VALUES (8, CAST(6.00 AS Decimal(10, 2)), 8, 1, 9, NULL, 1)
INSERT [dbo].[fee] ([id], [amount], [checkoutId], [feeType], [userId], [description], [paid]) VALUES (9, CAST(10.00 AS Decimal(10, 2)), 9, 1, 17, NULL, 1)
INSERT [dbo].[fee] ([id], [amount], [checkoutId], [feeType], [userId], [description], [paid]) VALUES (10, CAST(10.00 AS Decimal(10, 2)), 10, 1, 14, NULL, 1)
INSERT [dbo].[fee] ([id], [amount], [checkoutId], [feeType], [userId], [description], [paid]) VALUES (16, CAST(6.00 AS Decimal(10, 2)), 8, 2, 9, NULL, 0)
SET IDENTITY_INSERT [dbo].[fee] OFF
GO
INSERT [dbo].[feeType] ([id], [type]) VALUES (1, N'Regular')
INSERT [dbo].[feeType] ([id], [type]) VALUES (2, N'Late')
GO
SET IDENTITY_INSERT [dbo].[order] ON 

INSERT [dbo].[order] ([id], [userId], [orderDate], [addressId]) VALUES (1, 5, CAST(N'2024-05-08' AS Date), 18)
INSERT [dbo].[order] ([id], [userId], [orderDate], [addressId]) VALUES (2, 8, CAST(N'2024-01-21' AS Date), 11)
INSERT [dbo].[order] ([id], [userId], [orderDate], [addressId]) VALUES (3, 8, CAST(N'2024-03-06' AS Date), 20)
INSERT [dbo].[order] ([id], [userId], [orderDate], [addressId]) VALUES (4, 7, CAST(N'2024-12-11' AS Date), 1)
INSERT [dbo].[order] ([id], [userId], [orderDate], [addressId]) VALUES (5, 11, CAST(N'2024-12-04' AS Date), 1)
INSERT [dbo].[order] ([id], [userId], [orderDate], [addressId]) VALUES (6, 11, CAST(N'2024-04-08' AS Date), 4)
INSERT [dbo].[order] ([id], [userId], [orderDate], [addressId]) VALUES (7, 20, CAST(N'2024-07-02' AS Date), 19)
INSERT [dbo].[order] ([id], [userId], [orderDate], [addressId]) VALUES (8, 10, CAST(N'2024-05-17' AS Date), 19)
INSERT [dbo].[order] ([id], [userId], [orderDate], [addressId]) VALUES (9, 13, CAST(N'2024-02-09' AS Date), 24)
INSERT [dbo].[order] ([id], [userId], [orderDate], [addressId]) VALUES (10, 6, CAST(N'2024-10-01' AS Date), 9)
SET IDENTITY_INSERT [dbo].[order] OFF
GO
SET IDENTITY_INSERT [dbo].[orderDetails] ON 

INSERT [dbo].[orderDetails] ([id], [bookCopyId], [orderId]) VALUES (7, 3, 4)
INSERT [dbo].[orderDetails] ([id], [bookCopyId], [orderId]) VALUES (11, 5, 7)
INSERT [dbo].[orderDetails] ([id], [bookCopyId], [orderId]) VALUES (12, 6, 8)
INSERT [dbo].[orderDetails] ([id], [bookCopyId], [orderId]) VALUES (3, 7, 2)
INSERT [dbo].[orderDetails] ([id], [bookCopyId], [orderId]) VALUES (4, 8, 2)
INSERT [dbo].[orderDetails] ([id], [bookCopyId], [orderId]) VALUES (13, 21, 9)
INSERT [dbo].[orderDetails] ([id], [bookCopyId], [orderId]) VALUES (1, 26, 1)
INSERT [dbo].[orderDetails] ([id], [bookCopyId], [orderId]) VALUES (9, 27, 6)
INSERT [dbo].[orderDetails] ([id], [bookCopyId], [orderId]) VALUES (2, 43, 1)
INSERT [dbo].[orderDetails] ([id], [bookCopyId], [orderId]) VALUES (8, 62, 5)
INSERT [dbo].[orderDetails] ([id], [bookCopyId], [orderId]) VALUES (15, 64, 10)
INSERT [dbo].[orderDetails] ([id], [bookCopyId], [orderId]) VALUES (6, 65, 3)
INSERT [dbo].[orderDetails] ([id], [bookCopyId], [orderId]) VALUES (14, 66, 9)
INSERT [dbo].[orderDetails] ([id], [bookCopyId], [orderId]) VALUES (5, 67, 3)
INSERT [dbo].[orderDetails] ([id], [bookCopyId], [orderId]) VALUES (10, 75, 7)
SET IDENTITY_INSERT [dbo].[orderDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[user] ON 

INSERT [dbo].[user] ([id], [firstName], [lastName], [email], [phone], [isBlocked], [isActive]) VALUES (1, N'Jan', N'Kowalski', N'jan.kowalski2@example.com', N'123456799', 0, 1)
INSERT [dbo].[user] ([id], [firstName], [lastName], [email], [phone], [isBlocked], [isActive]) VALUES (2, N'Anna', N'Nowak', N'anna.nowak@example.com', N'987654321', 0, 1)
INSERT [dbo].[user] ([id], [firstName], [lastName], [email], [phone], [isBlocked], [isActive]) VALUES (3, N'Piotr', N'Wiśniewski', N'piotr.wisniewski@example.com', N'123987456', 0, 1)
INSERT [dbo].[user] ([id], [firstName], [lastName], [email], [phone], [isBlocked], [isActive]) VALUES (4, N'Maria', N'Wójcik', N'maria.wojcik@example.com', N'456789123', 0, 1)
INSERT [dbo].[user] ([id], [firstName], [lastName], [email], [phone], [isBlocked], [isActive]) VALUES (5, N'Krzysztof', N'Kowalczyk', N'krzysztof.kowalczyk@example.com', N'789123456', 0, 1)
INSERT [dbo].[user] ([id], [firstName], [lastName], [email], [phone], [isBlocked], [isActive]) VALUES (6, N'Katarzyna', N'Kamińska', N'katarzyna.kaminska@example.com', N'654321987', 0, 1)
INSERT [dbo].[user] ([id], [firstName], [lastName], [email], [phone], [isBlocked], [isActive]) VALUES (7, N'Tomasz', N'Lewandowski', N'tomasz.lewandowski@example.com', N'321654987', 0, 1)
INSERT [dbo].[user] ([id], [firstName], [lastName], [email], [phone], [isBlocked], [isActive]) VALUES (8, N'Magdalena', N'Zielińska', N'magdalena.zielinska2@example.com', N'987123754', 0, 1)
INSERT [dbo].[user] ([id], [firstName], [lastName], [email], [phone], [isBlocked], [isActive]) VALUES (9, N'Paweł', N'Szymański', N'pawel.szymanski@example.com', N'456123789', 1, 1)
INSERT [dbo].[user] ([id], [firstName], [lastName], [email], [phone], [isBlocked], [isActive]) VALUES (10, N'Agnieszka', N'Woźniak', N'agnieszka.wozniak2@example.com', N'321087654', 0, 1)
INSERT [dbo].[user] ([id], [firstName], [lastName], [email], [phone], [isBlocked], [isActive]) VALUES (11, N'Marek', N'Dąbrowski', N'marek.dabrowski@example.com', N'789456123', 0, 1)
INSERT [dbo].[user] ([id], [firstName], [lastName], [email], [phone], [isBlocked], [isActive]) VALUES (12, N'Joanna', N'Kozłowska', N'joanna.kozlowska2@example.com', N'654987331', 0, 1)
INSERT [dbo].[user] ([id], [firstName], [lastName], [email], [phone], [isBlocked], [isActive]) VALUES (13, N'Rafał', N'Jankowski', N'rafal.jankowski@example.com', N'123654789', 0, 1)
INSERT [dbo].[user] ([id], [firstName], [lastName], [email], [phone], [isBlocked], [isActive]) VALUES (14, N'Ewa', N'Mazur', N'ewa.mazur@example.com', N'987456321', 0, 1)
INSERT [dbo].[user] ([id], [firstName], [lastName], [email], [phone], [isBlocked], [isActive]) VALUES (15, N'Grzegorz', N'Krawczyk', N'grzegorz.krawczyk@example.com', N'456789654', 0, 1)
INSERT [dbo].[user] ([id], [firstName], [lastName], [email], [phone], [isBlocked], [isActive]) VALUES (16, N'Monika', N'Grabowska', N'monika.grabowska@example.com', N'321123456', 0, 1)
INSERT [dbo].[user] ([id], [firstName], [lastName], [email], [phone], [isBlocked], [isActive]) VALUES (17, N'Michał', N'Zając', N'michal.zajac2@example.com', N'654759987', 0, 1)
INSERT [dbo].[user] ([id], [firstName], [lastName], [email], [phone], [isBlocked], [isActive]) VALUES (18, N'Zofia', N'Król', N'zofia.krol@example.com', N'789321456', 0, 1)
INSERT [dbo].[user] ([id], [firstName], [lastName], [email], [phone], [isBlocked], [isActive]) VALUES (19, N'Łukasz', N'Wieczorek', N'lukasz.wieczorek@example.com', N'123987654', 0, 1)
INSERT [dbo].[user] ([id], [firstName], [lastName], [email], [phone], [isBlocked], [isActive]) VALUES (20, N'Justyna', N'Stępień', N'justyna.stepien@example.com', N'987654123', 0, 1)
SET IDENTITY_INSERT [dbo].[user] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__book__447D36EA52EC7A4D]    Script Date: 26/01/2025 20:49:25 ******/
ALTER TABLE [dbo].[book] ADD UNIQUE NONCLUSTERED 
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_OrderDetails]    Script Date: 26/01/2025 20:49:25 ******/
ALTER TABLE [dbo].[orderDetails] ADD  CONSTRAINT [UQ_OrderDetails] UNIQUE NONCLUSTERED 
(
	[bookCopyId] ASC,
	[orderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__user__AB6E6164FDD0914C]    Script Date: 26/01/2025 20:49:25 ******/
ALTER TABLE [dbo].[user] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__user__B43B145FD8339BD3]    Script Date: 26/01/2025 20:49:25 ******/
ALTER TABLE [dbo].[user] ADD UNIQUE NONCLUSTERED 
(
	[phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[book] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[book] ADD  DEFAULT ((0)) FOR [isAvailableForSale]
GO
ALTER TABLE [dbo].[checkout] ADD  DEFAULT (NULL) FOR [returnedDate]
GO
ALTER TABLE [dbo].[fee] ADD  DEFAULT ((0)) FOR [paid]
GO
ALTER TABLE [dbo].[user] ADD  DEFAULT ((0)) FOR [isBlocked]
GO
ALTER TABLE [dbo].[user] ADD  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[bookAuthor]  WITH CHECK ADD  CONSTRAINT [FK_BookAuthor_Author] FOREIGN KEY([author_id])
REFERENCES [dbo].[author] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[bookAuthor] CHECK CONSTRAINT [FK_BookAuthor_Author]
GO
ALTER TABLE [dbo].[bookAuthor]  WITH CHECK ADD  CONSTRAINT [FK_BookAuthor_Book] FOREIGN KEY([book_id])
REFERENCES [dbo].[book] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[bookAuthor] CHECK CONSTRAINT [FK_BookAuthor_Book]
GO
ALTER TABLE [dbo].[bookCopy]  WITH CHECK ADD FOREIGN KEY([availability])
REFERENCES [dbo].[availabilityStatus] ([id])
GO
ALTER TABLE [dbo].[bookCopy]  WITH CHECK ADD FOREIGN KEY([book_id])
REFERENCES [dbo].[book] ([id])
GO
ALTER TABLE [dbo].[checkout]  WITH CHECK ADD FOREIGN KEY([bookCopyId])
REFERENCES [dbo].[bookCopy] ([id])
GO
ALTER TABLE [dbo].[checkout]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[user] ([id])
GO
ALTER TABLE [dbo].[fee]  WITH CHECK ADD FOREIGN KEY([checkoutId])
REFERENCES [dbo].[checkout] ([id])
GO
ALTER TABLE [dbo].[fee]  WITH CHECK ADD FOREIGN KEY([feeType])
REFERENCES [dbo].[feeType] ([id])
GO
ALTER TABLE [dbo].[fee]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[user] ([id])
GO
ALTER TABLE [dbo].[order]  WITH CHECK ADD FOREIGN KEY([addressId])
REFERENCES [dbo].[address] ([id])
GO
ALTER TABLE [dbo].[order]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[user] ([id])
GO
ALTER TABLE [dbo].[orderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_BookCopy] FOREIGN KEY([bookCopyId])
REFERENCES [dbo].[bookCopy] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[orderDetails] CHECK CONSTRAINT [FK_OrderDetails_BookCopy]
GO
ALTER TABLE [dbo].[orderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Order] FOREIGN KEY([orderId])
REFERENCES [dbo].[order] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[orderDetails] CHECK CONSTRAINT [FK_OrderDetails_Order]
GO
ALTER TABLE [dbo].[checkout]  WITH CHECK ADD  CONSTRAINT [CK_ReturnedDate_Valid] CHECK  (([returnedDate]>=[borrowDate] OR [returnedDate] IS NULL))
GO
ALTER TABLE [dbo].[checkout] CHECK CONSTRAINT [CK_ReturnedDate_Valid]
GO
/****** Object:  StoredProcedure [dbo].[AddBookWithAuthor]    Script Date: 26/01/2025 20:49:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddBookWithAuthor]
    @AuthorId INT,
    @Title NVARCHAR(255),
    @ISBN NVARCHAR(255),
    @Price DECIMAL(10, 2),
    @Genre NVARCHAR(255),
    @PublishedYear INT,
    @IsAvailableForSale BIT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Dodanie nowej książki
        INSERT INTO [book] (title, ISBN, price, genre, publishedYear, isAvailableForSale)
        VALUES (@Title, @ISBN, @Price, @Genre, @PublishedYear, @IsAvailableForSale);

        -- Pobranie ID ostatnio dodanej książki
        DECLARE @BookId INT = SCOPE_IDENTITY();

        -- Przypisanie książki do autora
        INSERT INTO [bookAuthor] (author_id, book_id)
        VALUES (@AuthorId, @BookId);

        -- Zatwierdzenie transakcji
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Wycofanie transakcji w przypadku błędu
        ROLLBACK TRANSACTION;

        -- Rzucenie błędu dalej
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[ChargeLateFee]    Script Date: 26/01/2025 20:49:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ChargeLateFee]
AS
BEGIN
	BEGIN TRANSACTION;

	BEGIN TRY
		DECLARE @checkoutId INT, @userId INT, @borrowDate DATE, @currentDate DATE, @lateDays INT, @lateFee DECIMAL
		SET @currentDate = GETDATE();

		DECLARE checkout_cursor CURSOR FOR
		SELECT id, userId, borrowDate
		FROM checkout
		WHERE returnedDate IS NULL AND DATEDIFF(DAY, borrowDate, @currentDate) > 30;

		OPEN checkout_cursor;
		FETCH NEXT FROM checkout_cursor INTO @checkoutId, @userId, @borrowDate;

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @lateDays = DATEDIFF(DAY, DATEADD(MONTH, 1, @borrowDate), @currentDate);
			SET @lateFee = 1.5 * @lateDays;

			IF NOT EXISTS (SELECT 1 FROM fee WHERE checkoutId = @checkoutId AND feeType = 2)
			BEGIN
				INSERT INTO fee (amount, checkoutId, feeType, userId, paid)
				SELECT @lateFee, @checkoutId, 2, @userId, 0;
			END
			ELSE
			BEGIN
				UPDATE fee
				SET amount = @lateFee
				WHERE checkoutId = @checkoutId;
			END

			UPDATE [user]
			SET isBlocked = 1
			WHERE id = @userId;


			FETCH NEXT FROM checkout_cursor INTO @checkoutId, @userId, @borrowDate;
		END

		CLOSE checkout_cursor;
		DEALLOCATE checkout_cursor;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[GetBookInventoryReport]    Script Date: 26/01/2025 20:49:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBookInventoryReport]
AS
BEGIN
    SELECT 
        UPPER(a.lastName) + ', ' + a.firstName AS author, 
        b.title, 
        b.ISBN,
        b.genre,
        b.publishedYear,
        (SELECT COUNT(*) FROM bookCopy bc WHERE bc.book_id = b.id) AS total,
        (SELECT COUNT(*) FROM bookCopy bc WHERE bc.book_id = b.id AND bc.availability = 1) AS totalAvailable,
        (SELECT COUNT(*) FROM bookCopy bc WHERE bc.book_id = b.id AND bc.availability = 2) AS totalBorrowed,
        (SELECT COUNT(*) FROM bookCopy bc WHERE bc.book_id = b.id AND bc.availability = 3) AS totalSold
    FROM [book] b 
    JOIN [bookAuthor] ba 
        ON ba.book_id = b.id 
    JOIN [author] a 
        ON ba.author_id = a.id
    ORDER BY totalAvailable DESC;
END;

GO
/****** Object:  StoredProcedure [dbo].[GetGenreSalesSummary]    Script Date: 26/01/2025 20:49:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetGenreSalesSummary]
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    BEGIN TRY
        SELECT 
            b.genre,
            COUNT(bc.id) AS soldCopies,
            SUM(b.price) AS totalRevenue
        FROM bookCopy bc
        JOIN orderDetails od 
            ON bc.id = od.bookCopyId
        JOIN book b 
            ON b.id = bc.book_id
        JOIN [order] o
            ON od.orderId = o.id
        WHERE o.orderDate BETWEEN @StartDate AND @EndDate
        GROUP BY b.genre
        ORDER BY totalRevenue DESC;
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Raise the error to the caller
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[GetOverdueBookInfo]    Script Date: 26/01/2025 20:49:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetOverdueBookInfo]
AS
BEGIN
    SELECT 	
        c.id, 
        b.title,
		bc.id AS bookCopyID,
        c.borrowDate,
        UPPER(u.lastName) + ', ' + u.firstName AS userName,
        u.email,
        u.phone,
		c.borrowDate,
        DATEDIFF(DAY, c.borrowDate, GETDATE()) AS daysSinceBorrowed,
		DATEDIFF(DAY, DATEADD(MONTH, 1, c.borrowDate), GETDATE()) AS daysLate,
        DATEDIFF(DAY, DATEADD(MONTH, 1, c.borrowDate), GETDATE()) * 1.5 AS overdueFee
    FROM checkout c
    JOIN bookCopy bc 
        ON bc.id = c.bookCopyId
    JOIN book b 
        ON bc.book_id = b.id
    JOIN [user] u 
        ON u.id = c.userId
    WHERE c.returnedDate IS NULL
    AND DATEDIFF(DAY, c.borrowDate, GETDATE()) > 30
    ORDER BY daysSinceBorrowed DESC;
END;
GO
USE [master]
GO
ALTER DATABASE [Library] SET  READ_WRITE 
GO
