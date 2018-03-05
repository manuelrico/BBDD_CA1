USE [Company]
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateDepartmentManager]    Script Date: 05/03/2018 15:12:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_UpdateDepartmentManager] 
	-- Add the parameters for the stored procedure here
	@DNumber int,
	@MgrSSN numeric (9,0)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if @MgrSSN in (select @MgrSSN from Department where MgrSSN = @MgrSSN)
	begin
		raiserror('The MgrSSN is already a Department manager', 16, 1);
	end
	else
	begin
		UPDATE Department SET MgrSSN = @MgrSSN WHERE DNumber = @DNumber;
		UPDATE Employee SET SuperSSN = @MgrSSN WHERE Dno = @DNumber AND SSN !=@MgrSSN;
		UPDATE Department Set MgrStartDate = getdate() WHERE DNumber = @DNumber;
	end
END
