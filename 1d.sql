USE [Company]
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteDepartment]    Script Date: 09/03/2018 1:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_DeleteDepartment] 
	-- Add the parameters for the stored procedure here
	@DNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

/*if the department with DNumber exists, it is deleted. 
All related tuples in the Dept_Locations relation is also deleted. 
All projects in the Project relation controlled by the department is also deleted. 
All related tuples in the Works_on relations is also deleted. All employees 
in the Employee relation working in the deleted department should have the Dno attribute set to NULL.*/

    -- Insert statements for procedure here
	IF @DNumber in (select @DNumber from Department where DNumber = @DNumber)
		BEGIN
		DECLARE @Pno int
		DELETE Dept_Locations where DNUmber = @DNumber;
		select @Pno = PNumber from Project where Dnum = @DNumber;
		DELETE Works_on where Pno = @Pno;
		DELETE Project where DNum = @DNumber;
		UPDATE Employee SET Dno = NULL where Dno = @DNumber;
		DELETE Department where DNumber = @DNumber;
		END
	ELSE
		BEGIN
		raiserror('The Department you want to delete does not exist', 16, 1);
		END
	END
