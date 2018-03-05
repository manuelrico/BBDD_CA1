USE [Company]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetDepartment]    Script Date: 05/03/2018 15:11:21 ******/
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
	SELECT DName, Count(*) AS 'Number Of Employees' FROM Department JOIN Employee ON DNumber = Dno Where DNumber = @DNumber GROUP BY DName;
END
