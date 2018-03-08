USE [Company]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAllDepartments]    Script Date: 08/03/2018 11:47:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetAllDepartments] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DName, Count(FName) AS 'Total Number Of Employees'
	FROM Department LEFT JOIN Employee ON Dnumber = Dno
	GROUP BY DName, DNumber;
END
