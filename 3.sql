use Company;

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*WARNING!!!!!*/
/*When creating the function, comment the ALTER TABLE*/

CREATE FUNCTION udf_getEmpCount(@DepartmentNumber INT)
RETURNS int
AS
BEGIN
	DECLARE @Emp INT = (Select Count(*) from Department JOIN Employee ON DNumber = Dno where DNumber = @DepartmentNumber);
	
	RETURN @Emp
END

ALTER TABLE Department ADD EmpCount AS dbo.udf_GetEmpCount(DNumber)