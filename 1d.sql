USE [Company]
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteDepartment]    Script Date: 09/03/2018 2:36:30 ******/
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
		DELETE Dept_Locations where DNUmber = @DNumber;
		Print N'Ha borrado el DEPT Locations'
		DECLARE @NTimes int
		DECLARE @Pno int
		DECLARE @tries int
		SET @tries = 0;
		SET @NTimes = (Select Count(PNumber) from Project where DNum = @DNumber)
			WHILE @NTimes > 0
				BEGIN
				SET @Pno = (Select TOP 1 percent Pnumber FROM Project where DNum = @DNumber)
				DELETE Works_on where @Pno = Pno;
				Print N'Ha borrado un WorksOn de '
				PRINT @NTimes
				DELETE FROM Project Where PNumber = @Pno
				Print N'Ha borrado un Proyecto '
				SET @NTimes = (Select Count(PNumber) from Project where DNum = @DNumber)
				--SET @tries = @tries + 1;
				IF @NTimes = 0
					BEGIN
					UPDATE Employee SET Dno = NULL where Dno = @DNumber;
					Print N'Ha puesto a null el Employee '
					DELETE Department where DNumber = @DNumber;
					Print N'Ha borrado el departamento '
					BREAK
					END
				END
		END
	ELSE
		BEGIN
		raiserror('The Department you want to delete does not exist', 16, 1);
		END
	END
