CREATE TABLE AuditLogs
    (
        id uniqueidentifier PRIMARY KEY NOT NULL,
        level nvarchar(255),
        message nvarchar(max),
        createdAt datetimeoffset NOT NULL,
        updatedAt datetimeoffset NOT NULL,
        application varchar(255),
        environment varchar(255),
        type varchar(255),
        subType varchar(255),
        userId uniqueidentifier,
        organisationid uniqueidentifier
    );
GO
CREATE INDEX level ON dbo.AuditLogs (level);
GO
CREATE INDEX userId ON dbo.AuditLogs (userId);
GO
CREATE INDEX type ON dbo.AuditLogs (type);