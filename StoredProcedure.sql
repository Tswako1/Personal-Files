USE [MIPMIS_TRAIN]
GO
/****** Object:  StoredProcedure [dbo].[ContactCreateOrUpdate]    Script Date: 2019/02/19 9:09:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ContactCreateOrUpdate]
@ContactID int,
@Organisation varchar(50),
@ContractAmount varchar(50),
@AmountPaid varchar(250),
@ProgressStatus varchar(250),
@StartDate varchar(250),
@DateOfCompletion varchar(250),
@ActualDateOfCompletion varchar(250),
@Remarks varchar(250)

AS 
BEGIN

IF(@ContactID=0)
BEGIN
INSERT INTO Contact(Organisation,ContractAmount,AmountPaid,ProgressStatus,StartDate,DateOfCompletion,ActualDateOfCompletion,Remarks) VALUES(@Organisation,@ContractAmount,@AmountPaid,@ProgressStatus,@StartDate,@DateOfCompletion,@ActualDateOfCompletion,@Remarks);
END
ELSE
BEGIN
UPDATE Contact
SET
Organisation = @Organisation,
ContractAmount = @ContractAmount,
AmountPaid = @AmountPaid,
ProgressStatus = @ProgressStatus,
StartDate = @StartDate,
DateOfCompletion = @DateOfCompletion,
ActualDateOfCompletion = @ActualDateOfCompletion,
Remarks = @Remarks
WHERE ContactID = @ContactID

END
END

GO
/****** Object:  StoredProcedure [dbo].[ContactDeleteByID]    Script Date: 2019/02/19 9:09:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ContactDeleteByID]
@ContactID int

AS 
BEGIN

DELETE FROM Contact
WHERE ContactID = @ContactID

END

GO
/****** Object:  StoredProcedure [dbo].[ContactViewAll]    Script Date: 2019/02/19 9:09:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ContactViewAll]

AS 

BEGIN
SELECT * FROM Contact;
END

GO
/****** Object:  StoredProcedure [dbo].[ContactViewByID]    Script Date: 2019/02/19 9:09:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ContactViewByID]

@ContactID int
AS 

BEGIN
SELECT * FROM
Contact 
WHERE ContactId = @ContactID
END

GO
