USE [Company]
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateDepartmentName]    Script Date: 05/03/2018 15:12:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_UpdateDepartmentName] 
	-- Add the parameters for the stored procedure here
	@DName nvarchar(50),
	@DNumber int


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if @DName in (select @DName from Department where Dname = @DName)
	begin 
		raiserror('The DName Already exists', 16, 1);
	end
	else
	begin 
		update Department SET DName = @DName Where DNumber = @DNumber;
	end
END
