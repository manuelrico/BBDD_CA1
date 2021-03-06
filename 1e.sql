USE [Company]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetDepartment]    Script Date: 08/03/2018 18:51:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetDepartment] 
	-- Add the parameters for the stored procedure here
	@DNumber int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DName, Count(Fname) AS 'Number Of Employees' 
	FROM Department LEFT JOIN Employee ON DNumber = Dno 
	Where DNumber = @DNumber GROUP BY DName;
END
