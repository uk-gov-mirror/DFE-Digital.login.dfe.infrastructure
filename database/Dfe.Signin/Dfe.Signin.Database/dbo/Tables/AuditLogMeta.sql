CREATE TABLE AuditLogMeta
    (
        id uniqueidentifier PRIMARY KEY NOT NULL,
        auditId uniqueidentifier NOT NULL,
        [key] nvarchar(125) NOT NULL,
        [value] nvarchar(max) NULL,
        CONSTRAINT [AuditLog_FK] FOREIGN KEY (auditId) REFERENCES AuditLogs(id)
    );