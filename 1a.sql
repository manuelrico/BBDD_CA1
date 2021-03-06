USE [Company]
GO
/****** Object:  StoredProcedure [dbo].[usp_CreateDepartment]    Script Date: 08/03/2018 22:43:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CreateDepartment]
	-- Add the parameters for the stored procedure here
	@DName nvarchar(50),
	@MgrSSN numeric(9,0),
	@DNumberOut int OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	SET NOCOUNT ON;
	if @DName not in (select @DName from Department where DName = @DName)
	Begin
		if @MgrSSN not in (select @MgrSSN from Department where MgrSSN = @MgrSSN)
		begin
		Declare @MgrStartDate datetime = getdate();
		Declare @DNumber int
		select TOP 1 @DNumber = DNumber + 1 from Department order by DNumber DESC
		insert into Department (DName, DNumber, MgrSSN, MgrStartDate)
		select @DName,@DNumber,@MgrSSN, @MgrStartDate
		--PRINT '#The DNuber of the new Department is: ' + STR(@DNumber);
		select @DNumberOut = DNumber from Department where MgrSSN = @MgrSSN
		end
		else
			begin
				PRINT N'It has a proper name but invalid SSN';
				raiserror('Valid Department name, but the MgrSSN is already a Department manager', 16, 1);
			end 
	end
	else if @MgrSSN in (select @MgrSSN from Department where MgrSSN = @MgrSSN)
		begin
			PRINT N'The SSN is already in use.';
			raiserror('The MgrSSN is already a Department manager', 16, 1);
		end
		else
			raiserror('The DName Already exists', 16, 1);

END

