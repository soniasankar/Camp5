USE [master]
GO
/****** Object:  Database [Ems_db]    Script Date: 10-09-2024 09:30:25 ******/
CREATE DATABASE [Ems_db]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Ems_db', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Ems_db.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Ems_db_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Ems_db_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Ems_db] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Ems_db].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Ems_db] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Ems_db] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Ems_db] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Ems_db] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Ems_db] SET ARITHABORT OFF 
GO
ALTER DATABASE [Ems_db] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Ems_db] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Ems_db] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Ems_db] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Ems_db] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Ems_db] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Ems_db] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Ems_db] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Ems_db] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Ems_db] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Ems_db] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Ems_db] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Ems_db] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Ems_db] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Ems_db] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Ems_db] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Ems_db] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Ems_db] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Ems_db] SET  MULTI_USER 
GO
ALTER DATABASE [Ems_db] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Ems_db] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Ems_db] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Ems_db] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Ems_db] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Ems_db] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Ems_db] SET QUERY_STORE = OFF
GO
USE [Ems_db]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 10-09-2024 09:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 10-09-2024 09:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Gender] [nvarchar](50) NOT NULL,
	[Designation] [nvarchar](266) NOT NULL,
	[Salary] [int] NOT NULL,
	[DOB] [datetime] NOT NULL,
	[DepartmentId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Department] ([DepartmentId])
GO
/****** Object:  StoredProcedure [dbo].[sp_AddEmployee]    Script Date: 10-09-2024 09:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_AddEmployee]
@Name NVARCHAR(55),
@Gender NVARCHAR(50),
@Designation NVARCHAR(55),
@Salary INT,
@DOB DATETIME,
@DepartmentId INT
AS
BEGIN
INSERT INTO Employee (Name, Gender, Designation, Salary, DOB, DepartmentId) VALUES (@Name, @Gender, @Designation, @Salary, @DOB,

@DepartmentId)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteEmployee]    Script Date: 10-09-2024 09:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteEmployee]
    @Id INT
AS
BEGIN
    DELETE FROM [Ems_db].[dbo].[Employee]
    WHERE [Id] = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_EditEmployee]    Script Date: 10-09-2024 09:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_EditEmployee]
    @Id INT,
    @Name NVARCHAR(100),
    @Gender CHAR(10),
    @Designation NVARCHAR(100),
    @Salary DECIMAL(18, 2),
    @DOB DATE,
    @DepartmentId INT
AS
BEGIN
    UPDATE [Ems_db].[dbo].[Employee]
    SET 
        [Name] = @Name,
        [Gender] = @Gender,
        [Designation] = @Designation,
        [Salary] = @Salary,
        [DOB] = @DOB,
        [DepartmentId] = @DepartmentId
    WHERE 
        [Id] = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllDepartments]    Script Date: 10-09-2024 09:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_GetAllDepartments]
as
begin
set nocount on;
select DepartmentId,DepartmentName from Department;
End;

GO
/****** Object:  StoredProcedure [dbo].[sp_GetDepartmentsById]    Script Date: 10-09-2024 09:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_GetDepartmentsById]
@DepartmentId int
as
begin
select * from Department where @DepartmentId=DepartmentId
end;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetEmployeeById]    Script Date: 10-09-2024 09:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetEmployeeById]
    @Id INT
AS
BEGIN
    SELECT 
        [Id], 
        [Name], 
        [Gender], 
        [Designation], 
        [Salary], 
        [DOB], 
        [DepartmentId]
    FROM 
        [Ems_db].[dbo].[Employee]
    WHERE 
        [Id] = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectDepartmentById]    Script Date: 10-09-2024 09:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SelectDepartmentById]
    @DepartmentId INT
AS
BEGIN
    SELECT 
        [DepartmentId], 
        [DepartmentName]
    FROM 
        [Ems_db].[dbo].[Department]
    WHERE 
        [DepartmentId] = @DepartmentId
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectEmployees]    Script Date: 10-09-2024 09:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SelectEmployees]
AS
BEGIN
SELECT * FROM Employee
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectEmployees1]    Script Date: 10-09-2024 09:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SelectEmployees1]
AS
BEGIN
    SELECT E.*, D.DepartmentName
    FROM Employee E
    INNER JOIN Department D ON E.DepartmentId = D.DepartmentId
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectEmployeewithDepartments]    Script Date: 10-09-2024 09:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SelectEmployeewithDepartments]
AS
BEGIN
    SELECT 
        e.[Id], 
        e.[Name], 
        e.[Gender], 
        e.[Designation], 
        e.[Salary], 
        e.[DOB], 
        e.[DepartmentId], 
        d.[DepartmentName]
    FROM 
        [Ems_db].[dbo].[Employee] e
    INNER JOIN 
        [Ems_db].[dbo].[Department] d ON e.[DepartmentId] = d.[DepartmentId]
END
GO
USE [master]
GO
ALTER DATABASE [Ems_db] SET  READ_WRITE 
GO
