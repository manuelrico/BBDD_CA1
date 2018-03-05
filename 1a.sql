USE [Company]
GO
/****** Object:  StoredProcedure [dbo].[usp_CreateNewDepartment]    Script Date: 05/03/2018 15:07:20 ******/
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
	@MgrSSN numeric(9,0)	


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	SET NOCOUNT ON;
	if @MgrSSN in (select @MgrSSN from Department where MgrSSN = @MgrSSN)
	begin
		raiserror('The MgrSSN is already a Department manager', 16, 1);
	end
	else
	if @DName in (select @DName from Department where Dname = @DName)
	begin 
		raiserror('The DName Already exists', 16, 1);
	end
	if @DName not in (select @DName from Department where DName = @DName)
	Declare @MgrStartDate datetime = getdate();
	Declare @DNumber int = 8
	/*select @DNumber=count(DNumber)+1 from Department*/
	Begin
		if @MgrSSN not in (select @MgrSSN from Department where MgrSSN = @MgrSSN)
		begin
		insert into Department (DName, DNumber, MgrSSN, MgrStartDate)
		select @DName,@DNumber,@MgrSSN, @MgrStartDate
		end
	end

END

