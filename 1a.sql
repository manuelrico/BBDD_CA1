USE [Company]
GO
/****** Object:  StoredProcedure [dbo].[usp_CreateNewDepartment]    Script Date: 06/03/2018 17:35:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATEPROCEDURE [dbo].[usp_CreateNewDepartment]
	-- Add the parameters for the stored procedure here
	@DName nvarchar(50),
	@MgrSSN numeric(9,0)	


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	SET NOCOUNT ON;
	--if @MgrSSN in (select @MgrSSN from Department where MgrSSN = @MgrSSN)
	--begin
	--	PRINT N'Ha entrado en el if del SSN.';
	--	raiserror('The MgrSSN is already a Department manager', 16, 1);
	--end
	--else
	--if @DName not in (select @DName from Department where Dname = @DName)
	--begin 
	--	PRINT N'Ha entrado en el if del Nombre.';
	--	raiserror('The DName Already exists', 16, 1);
	--end
	if @DName not in (select @DName from Department where DName = @DName)
	Begin
		if @MgrSSN not in (select @MgrSSN from Department where MgrSSN = @MgrSSN)
		begin
		Declare @MgrStartDate datetime = getdate();
		Declare @DNumber int
		select @DNumber=count(DNumber)+1 from Department
		PRINT N'Ha entrado en el segundo if.';
		insert into Department (DName, DNumber, MgrSSN, MgrStartDate)
		select @DName,@DNumber,@MgrSSN, @MgrStartDate
		end
		else
			begin
				PRINT N'No tiene mismo nombre pero SSN no valido';
			end 
	end
	else if @MgrSSN in (select @MgrSSN from Department where MgrSSN = @MgrSSN)
		begin
			PRINT N'El SSN ya se esta usando.';
			raiserror('The MgrSSN is already a Department manager', 16, 1);
		end
		else
			raiserror('The DName Already exists del else', 16, 1);

END

