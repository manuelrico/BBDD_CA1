-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE usp_DeleteDepartment 
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
	DELETE Department where DNumber = @DNumber;
	DELETE Dept_Locations where DNUmber = @DNumber;
	DECLARE @PruebaPNo uniqueidentifier
	DECLARE @Pno uniqueidentifier
	DECLARE @tries int
	SET @tries = 0;
	SET @PruebaPNo = (Select Count(PNumber) from Project where DNum = @DNumber)
	WHILE @PruebaPNo > 0
	BEGIN
		SET @Pno = (Select TOP 1 percent Pnumber FROM Project where DNum = @DNumber)
		DELETE Works_on where @Pno = Pno;
		SET @PruebaPNo = (Select Count(PNumber) from Project where DNum = @DNumber)
		SET @tries = @tries + 1;
		IF @PruebaPNo = @tries
			BREAK
		ELSE	
			CONTINUE
	END
	DELETE Project where DNUm = @DNumber;
	UPDATE Employee SET Dno = NULL where Dno = @DNumber;

END
GO
