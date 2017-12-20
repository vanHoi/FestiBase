CREATE TABLE [dbo].[ARTIST] (
    [artist_number] INT          IDENTITY (1, 1) NOT NULL,
    [artist_name]   VARCHAR (50) NOT NULL
);

GO
CREATE TABLE [dbo].[ARTIST_FILE] (
    [file_number]     INT          IDENTITY (1, 1) NOT NULL,
    [artist_number]   INT          NOT NULL,
    [festival_number] INT          NOT NULL,
    [branch_number]   INT          NOT NULL,
    [file]            VARCHAR (50) NOT NULL,
    [description]     TEXT         NOT NULL
);

GO
CREATE TABLE [dbo].[ATTRACTION] (
    [attraction_number] INT          IDENTITY (1, 1) NOT NULL,
    [festival_number]   INT          NOT NULL,
    [branch_number]     INT          NOT NULL,
    [name]              VARCHAR (50) NOT NULL,
    [attraction_type]   VARCHAR (50) NOT NULL
);

GO
CREATE TABLE [dbo].[BOUGHT_TICKET] (
    [ticket_number]   INT          IDENTITY (1, 1) NOT NULL,
    [festival_number] INT          NOT NULL,
    [branch_number]   INT          NOT NULL,
    [ticket_type]     VARCHAR (50) NOT NULL,
    [visitor_number]  INT          NOT NULL,
    [scan_date]       DATETIME     NULL
);

GO
CREATE TABLE [dbo].[CATERING] (
    [catering_number] INT          IDENTITY (1, 1) NOT NULL,
    [festival_number] INT          NOT NULL,
    [branch_number]   INT          NOT NULL,
    [name]            VARCHAR (50) NOT NULL,
    [electricity]     BIT          NOT NULL
);

GO
CREATE TABLE [dbo].[COMPANY] (
    [coc_number] VARCHAR (8)  NOT NULL,
    [name]       VARCHAR (50) NOT NULL
);

GO
CREATE TABLE [dbo].[COMPANY_BRANCH] (
    [branch_number] INT          IDENTITY (1, 1) NOT NULL,
    [coc_number]    VARCHAR (8)  NOT NULL,
    [town_number]   INT          NOT NULL,
    [street]        VARCHAR (50) NOT NULL,
    [house_number]  VARCHAR (20) NOT NULL
);

GO
CREATE TABLE [dbo].[COUNTRY] (
    [country_number] INT          IDENTITY (1, 1) NOT NULL,
    [country_name]   VARCHAR (50) NOT NULL
);

GO
CREATE TABLE [dbo].[FESTIVAL] (
    [festival_number]     INT          IDENTITY (1, 1) NOT NULL,
    [organisation_number] INT          NOT NULL,
    [name]                VARCHAR (50) NOT NULL,
    [start_date]          DATETIME     NOT NULL,
    [end_date]            DATETIME     NOT NULL,
    [location]            VARCHAR (50) NOT NULL,
    [token_price]         MONEY        NOT NULL
);

GO
CREATE TABLE [dbo].[FESTIVAL_COMPANY] (
    [festival_number]  INT          NOT NULL,
    [branch_number]    INT          NOT NULL,
    [contact_person]   VARCHAR (50) NOT NULL,
    [description]      TEXT         NOT NULL,
    [telephone_number] VARCHAR (10) NOT NULL
);

GO
CREATE TABLE [dbo].[FESTIVAL_COMPANY_FILE] (
    [file_number]     INT          IDENTITY (1, 1) NOT NULL,
    [festival_number] INT          NOT NULL,
    [branch_number]   INT          NOT NULL,
    [file]            VARCHAR (50) NOT NULL,
    [description]     TEXT         NOT NULL
);

GO
CREATE TABLE [dbo].[GENRE] (
    [genre_number] INT          IDENTITY (1, 1) NOT NULL,
    [genre]        VARCHAR (50) NOT NULL
);

GO
CREATE TABLE [dbo].[GENRE_of_ARTIST] (
    [genre_number]  INT NOT NULL,
    [artist_number] INT NOT NULL
);

GO
CREATE TABLE [dbo].[GENRE_preference_VISITOR] (
    [visitor_number] INT NOT NULL,
    [genre_number]   INT NOT NULL
);

GO
CREATE TABLE [dbo].[LOCKER] (
    [locker_number]   INT IDENTITY (1, 1) NOT NULL,
    [festival_number] INT NOT NULL,
    [branch_number]   INT NOT NULL
);

GO
CREATE TABLE [dbo].[LOCKER_RENTED] (
    [locker_number]  INT      NOT NULL,
    [start_date]     DATETIME NOT NULL,
    [end_date]       DATETIME NULL,
    [visitor_number] INT      NOT NULL
);

GO
CREATE TABLE [dbo].[ORGANISATION] (
    [organisation_number] INT          IDENTITY (1, 1) NOT NULL,
    [name]                VARCHAR (50) NOT NULL
);

GO
CREATE TABLE [dbo].[PERFORMANCE] (
    [performance_number]     INT      IDENTITY (1, 1) NOT NULL,
    [artist_number]          INT      NOT NULL,
    [podium_schedule_number] DATETIME NULL,
    [festival_number]        INT      NOT NULL,
    [start_time]             DATETIME NULL,
    [play_time]              INT      NOT NULL,
    [min_prep_time]          INT      NULL
);

GO
CREATE TABLE [dbo].[PODIUM] (
    [podium_number]       INT          IDENTITY (1, 1) NOT NULL,
    [festival_number]     INT          NOT NULL,
    [tent_number]         INT          NULL,
    [name]                VARCHAR (50) NOT NULL,
    [construction_width]  INT          NOT NULL,
    [construction_length] INT          NOT NULL,
    [construction_height] INT          NULL,
    [floor_height]        INT          NULL,
    [capacity]            INT          NOT NULL,
    [floor_load]          INT          NOT NULL,
    [free_span_width]     INT          NOT NULL,
    [free_span_length]    INT          NOT NULL,
    [free_span_height]    INT          NULL,
    [environment]         TEXT         NOT NULL
);

GO
CREATE TABLE [dbo].[PODIUM_FILE] (
    [file_number]     INT          IDENTITY (1, 1) NOT NULL,
    [podium_number]   INT          NOT NULL,
    [festival_number] INT          NOT NULL,
    [branch_number]   INT          NOT NULL,
    [file]            VARCHAR (50) NOT NULL,
    [description]     TEXT         NOT NULL
);

GO
CREATE TABLE [dbo].[PODIUM_plays_GENRE] (
    [genre_number]  INT NOT NULL,
    [podium_number] INT NOT NULL
);

GO
CREATE TABLE [dbo].[PODIUM_SCHEDULE] (
    [podium_schedule_number] DATETIME NOT NULL,
    [podium_number]          INT      NOT NULL,
    [start_date]             DATETIME NOT NULL,
    [start_time]             DATETIME NULL,
    [end_date]               DATETIME NULL,
    [end_time]               DATETIME NULL,
    [break_time]             INT      NULL
);

GO
CREATE TABLE [dbo].[Relationship_40] (
    [visitor_number]     INT NOT NULL,
    [performance_number] INT NOT NULL
);

GO
CREATE TABLE [dbo].[TENT] (
    [tent_number]         INT          IDENTITY (1, 1) NOT NULL,
    [festival_number]     INT          NOT NULL,
    [name]                VARCHAR (50) NOT NULL,
    [width]               INT          NOT NULL,
    [length]              INT          NOT NULL,
    [side_height]         INT          NOT NULL,
    [ridge_height]        INT          NOT NULL,
    [construction_width]  INT          NOT NULL,
    [construction_length] INT          NOT NULL,
    [tent_type]           VARCHAR (50) NOT NULL,
    [color]               VARCHAR (50) NOT NULL,
    [floor_type]          VARCHAR (50) NULL,
    [capacity]            INT          NOT NULL
);

GO
CREATE TABLE [dbo].[TENT_FILE] (
    [file_number]     INT          IDENTITY (1, 1) NOT NULL,
    [tent_number]     INT          NOT NULL,
    [festival_number] INT          NOT NULL,
    [branch_number]   INT          NOT NULL,
    [file]            VARCHAR (50) NOT NULL,
    [description]     TEXT         NOT NULL
);

GO
CREATE TABLE [dbo].[TICKET_TYPE] (
    [festival_number] INT          NOT NULL,
    [branch_number]   INT          NOT NULL,
    [ticket_type]     VARCHAR (50) NOT NULL,
    [price]           MONEY        NOT NULL,
    [date_valid_from] DATETIME     NOT NULL,
    [date_valid_to]   DATETIME     NULL
);

GO
CREATE TABLE [dbo].[TOILET] (
    [toilet_number]   INT          IDENTITY (1, 1) NOT NULL,
    [festival_number] INT          NOT NULL,
    [branch_number]   INT          NOT NULL,
    [name]            VARCHAR (50) NOT NULL,
    [capacity]        INT          NOT NULL
);

GO
CREATE TABLE [dbo].[TOWN] (
    [town_number]    INT          IDENTITY (1, 1) NOT NULL,
    [country_number] INT          NOT NULL,
    [town_name]      VARCHAR (50) NOT NULL
);

GO
CREATE TABLE [dbo].[VISITOR] (
    [visitor_number]    INT          IDENTITY (1, 1) NOT NULL,
    [town_number]       INT          NULL,
    [email]             VARCHAR (50) NULL,
    [first_name]        VARCHAR (50) NULL,
    [surname]           VARCHAR (50) NULL,
    [telephone_number]  VARCHAR (10) NULL,
    [birthdate]         DATETIME     NULL,
    [twitter_username]  VARCHAR (15) NULL,
    [facebook_username] VARCHAR (70) NULL,
    [street]            VARCHAR (50) NULL,
    [house_number]      VARCHAR (20) NULL
);

GO
CREATE TABLE [dbo].[VISITOR_visited_PERFORMANCE] (
    [visitor_number]     INT NOT NULL,
    [performance_number] INT NOT NULL
);

GO
ALTER TABLE [dbo].[ARTIST_FILE]
    ADD CONSTRAINT [FK_ARTIST_F_RELATIONS_ARTIST] FOREIGN KEY ([artist_number]) REFERENCES [dbo].[ARTIST] ([artist_number]);

GO
ALTER TABLE [dbo].[ARTIST_FILE]
    ADD CONSTRAINT [FK_ARTIST_F_RELATIONS_FESTIVAL] FOREIGN KEY ([festival_number], [branch_number]) REFERENCES [dbo].[FESTIVAL_COMPANY] ([festival_number], [branch_number]);

GO
ALTER TABLE [dbo].[ATTRACTION]
    ADD CONSTRAINT [FK_ATTRACTI_RELATIONS_FESTIVAL] FOREIGN KEY ([festival_number], [branch_number]) REFERENCES [dbo].[FESTIVAL_COMPANY] ([festival_number], [branch_number]);

GO
ALTER TABLE [dbo].[BOUGHT_TICKET]
    ADD CONSTRAINT [FK_BOUGHT_T_BOUGHT_TI_TICKET_T] FOREIGN KEY ([festival_number], [branch_number], [ticket_type]) REFERENCES [dbo].[TICKET_TYPE] ([festival_number], [branch_number], [ticket_type]);

GO
ALTER TABLE [dbo].[BOUGHT_TICKET]
    ADD CONSTRAINT [FK_BOUGHT_T_VISITOR_B_VISITOR] FOREIGN KEY ([visitor_number]) REFERENCES [dbo].[VISITOR] ([visitor_number]);

GO
ALTER TABLE [dbo].[CATERING]
    ADD CONSTRAINT [FK_CATERING_CATERING__FESTIVAL] FOREIGN KEY ([festival_number], [branch_number]) REFERENCES [dbo].[FESTIVAL_COMPANY] ([festival_number], [branch_number]);

GO
ALTER TABLE [dbo].[COMPANY_BRANCH]
    ADD CONSTRAINT [FK_COMPANY__COMPANY_B_TOWN] FOREIGN KEY ([town_number]) REFERENCES [dbo].[TOWN] ([town_number]);

GO
ALTER TABLE [dbo].[COMPANY_BRANCH]
    ADD CONSTRAINT [FK_COMPANY__RELATIONS_COMPANY] FOREIGN KEY ([coc_number]) REFERENCES [dbo].[COMPANY] ([coc_number]);

GO
ALTER TABLE [dbo].[FESTIVAL_COMPANY_FILE]
    ADD CONSTRAINT [FK_FESTIVAL_COMPANY_HAS_FILE] FOREIGN KEY ([festival_number], [branch_number]) REFERENCES [dbo].[FESTIVAL_COMPANY] ([festival_number], [branch_number]);

GO
ALTER TABLE [dbo].[FESTIVAL_COMPANY]
    ADD CONSTRAINT [FK_FESTIVAL_RELATIONS_COMPANY_] FOREIGN KEY ([branch_number]) REFERENCES [dbo].[COMPANY_BRANCH] ([branch_number]);

GO
ALTER TABLE [dbo].[FESTIVAL_COMPANY]
    ADD CONSTRAINT [FK_FESTIVAL_RELATIONS_FESTIVAL] FOREIGN KEY ([festival_number]) REFERENCES [dbo].[FESTIVAL] ([festival_number]);

GO
ALTER TABLE [dbo].[FESTIVAL]
    ADD CONSTRAINT [FK_FESTIVAL_RELATIONS_ORGANISA] FOREIGN KEY ([organisation_number]) REFERENCES [dbo].[ORGANISATION] ([organisation_number]);

GO
ALTER TABLE [dbo].[GENRE_of_ARTIST]
    ADD CONSTRAINT [FK_GENRE_OF_GENRE_OF__ARTIST] FOREIGN KEY ([artist_number]) REFERENCES [dbo].[ARTIST] ([artist_number]);

GO
ALTER TABLE [dbo].[GENRE_of_ARTIST]
    ADD CONSTRAINT [FK_GENRE_OF_GENRE_OF__GENRE] FOREIGN KEY ([genre_number]) REFERENCES [dbo].[GENRE] ([genre_number]);

GO
ALTER TABLE [dbo].[GENRE_preference_VISITOR]
    ADD CONSTRAINT [FK_GENRE_PR_GENRE_PRE_GENRE] FOREIGN KEY ([genre_number]) REFERENCES [dbo].[GENRE] ([genre_number]);

GO
ALTER TABLE [dbo].[GENRE_preference_VISITOR]
    ADD CONSTRAINT [FK_GENRE_PR_GENRE_PRE_VISITOR] FOREIGN KEY ([visitor_number]) REFERENCES [dbo].[VISITOR] ([visitor_number]);

GO
ALTER TABLE [dbo].[LOCKER_RENTED]
    ADD CONSTRAINT [FK_LOCKER_R_LOCKER_IN_LOCKER] FOREIGN KEY ([locker_number]) REFERENCES [dbo].[LOCKER] ([locker_number]);

GO
ALTER TABLE [dbo].[LOCKER_RENTED]
    ADD CONSTRAINT [FK_LOCKER_R_VISITOR_R_VISITOR] FOREIGN KEY ([visitor_number]) REFERENCES [dbo].[VISITOR] ([visitor_number]);

GO
ALTER TABLE [dbo].[LOCKER]
    ADD CONSTRAINT [FK_LOCKER_RELATIONS_FESTIVAL] FOREIGN KEY ([festival_number], [branch_number]) REFERENCES [dbo].[FESTIVAL_COMPANY] ([festival_number], [branch_number]);

GO
ALTER TABLE [dbo].[PERFORMANCE]
    ADD CONSTRAINT [FK_PERFORMA_PERFORMAN_ARTIST] FOREIGN KEY ([artist_number]) REFERENCES [dbo].[ARTIST] ([artist_number]);

GO
ALTER TABLE [dbo].[PERFORMANCE]
    ADD CONSTRAINT [FK_PERFORMA_RELATIONS_FESTIVAL] FOREIGN KEY ([festival_number]) REFERENCES [dbo].[FESTIVAL] ([festival_number]);

GO
ALTER TABLE [dbo].[PERFORMANCE]
    ADD CONSTRAINT [FK_PERFORMA_RELATIONS_PODIUM_S] FOREIGN KEY ([podium_schedule_number]) REFERENCES [dbo].[PODIUM_SCHEDULE] ([podium_schedule_number]);

GO
ALTER TABLE [dbo].[PODIUM_FILE]
    ADD CONSTRAINT [FK_PODIUM_F_PODIUM_FI_PODIUM] FOREIGN KEY ([podium_number]) REFERENCES [dbo].[PODIUM] ([podium_number]);

GO
ALTER TABLE [dbo].[PODIUM_FILE]
    ADD CONSTRAINT [FK_PODIUM_F_RELATIONS_FESTIVAL] FOREIGN KEY ([festival_number], [branch_number]) REFERENCES [dbo].[FESTIVAL_COMPANY] ([festival_number], [branch_number]);

GO
ALTER TABLE [dbo].[PODIUM_plays_GENRE]
    ADD CONSTRAINT [FK_PODIUM_P_RELATIONS_GENRE] FOREIGN KEY ([genre_number]) REFERENCES [dbo].[GENRE] ([genre_number]);

GO
ALTER TABLE [dbo].[PODIUM_plays_GENRE]
    ADD CONSTRAINT [FK_PODIUM_P_RELATIONS_PODIUM] FOREIGN KEY ([podium_number]) REFERENCES [dbo].[PODIUM] ([podium_number]);

GO
ALTER TABLE [dbo].[PODIUM]
    ADD CONSTRAINT [FK_PODIUM_PODIUM_IN_TENT] FOREIGN KEY ([tent_number]) REFERENCES [dbo].[TENT] ([tent_number]);

GO
ALTER TABLE [dbo].[PODIUM]
    ADD CONSTRAINT [FK_PODIUM_RELATIONS_FESTIVAL] FOREIGN KEY ([festival_number]) REFERENCES [dbo].[FESTIVAL] ([festival_number]);

GO
ALTER TABLE [dbo].[PODIUM_SCHEDULE]
    ADD CONSTRAINT [FK_PODIUM_S_PODIUM_HA_PODIUM] FOREIGN KEY ([podium_number]) REFERENCES [dbo].[PODIUM] ([podium_number]);

GO
ALTER TABLE [dbo].[Relationship_40]
    ADD CONSTRAINT [FK_RELATION_RELATIONS_PERFORMA] FOREIGN KEY ([performance_number]) REFERENCES [dbo].[PERFORMANCE] ([performance_number]);

GO
ALTER TABLE [dbo].[Relationship_40]
    ADD CONSTRAINT [FK_RELATION_RELATIONS_VISITOR] FOREIGN KEY ([visitor_number]) REFERENCES [dbo].[VISITOR] ([visitor_number]);

GO
ALTER TABLE [dbo].[TENT_FILE]
    ADD CONSTRAINT [FK_TENT_FIL_RELATIONS_FESTIVAL] FOREIGN KEY ([festival_number], [branch_number]) REFERENCES [dbo].[FESTIVAL_COMPANY] ([festival_number], [branch_number]);

GO
ALTER TABLE [dbo].[TENT_FILE]
    ADD CONSTRAINT [FK_TENT_FIL_RELATIONS_TENT] FOREIGN KEY ([tent_number]) REFERENCES [dbo].[TENT] ([tent_number]);

GO
ALTER TABLE [dbo].[TENT]
    ADD CONSTRAINT [FK_TENT_RELATIONS_FESTIVAL] FOREIGN KEY ([festival_number]) REFERENCES [dbo].[FESTIVAL] ([festival_number]);

GO
ALTER TABLE [dbo].[TICKET_TYPE]
    ADD CONSTRAINT [FK_TICKET_T_RELATIONS_FESTIVAL] FOREIGN KEY ([festival_number], [branch_number]) REFERENCES [dbo].[FESTIVAL_COMPANY] ([festival_number], [branch_number]);

GO
ALTER TABLE [dbo].[TOILET]
    ADD CONSTRAINT [FK_TOILET_TOILET_BY_FESTIVAL] FOREIGN KEY ([festival_number], [branch_number]) REFERENCES [dbo].[FESTIVAL_COMPANY] ([festival_number], [branch_number]);

GO
ALTER TABLE [dbo].[TOWN]
    ADD CONSTRAINT [FK_TOWN_TOWN_IN_C_COUNTRY] FOREIGN KEY ([country_number]) REFERENCES [dbo].[COUNTRY] ([country_number]);

GO
ALTER TABLE [dbo].[VISITOR_visited_PERFORMANCE]
    ADD CONSTRAINT [FK_VISITOR__RELATIONS_PERFORMA] FOREIGN KEY ([performance_number]) REFERENCES [dbo].[PERFORMANCE] ([performance_number]);

GO
ALTER TABLE [dbo].[VISITOR_visited_PERFORMANCE]
    ADD CONSTRAINT [FK_VISITOR__RELATIONS_VISITOR] FOREIGN KEY ([visitor_number]) REFERENCES [dbo].[VISITOR] ([visitor_number]);

GO
ALTER TABLE [dbo].[VISITOR]
    ADD CONSTRAINT [FK_VISITOR_RELATIONS_TOWN] FOREIGN KEY ([town_number]) REFERENCES [dbo].[TOWN] ([town_number]);

GO
ALTER TABLE [dbo].[ARTIST]
    ADD CONSTRAINT [PK_ARTIST] PRIMARY KEY CLUSTERED ([artist_number] ASC);

GO
ALTER TABLE [dbo].[ARTIST_FILE]
    ADD CONSTRAINT [PK_ARTIST_FILE] PRIMARY KEY CLUSTERED ([file_number] ASC);

GO
ALTER TABLE [dbo].[ATTRACTION]
    ADD CONSTRAINT [PK_ATTRACTION] PRIMARY KEY CLUSTERED ([attraction_number] ASC);

GO
ALTER TABLE [dbo].[BOUGHT_TICKET]
    ADD CONSTRAINT [PK_BOUGHT_TICKET] PRIMARY KEY CLUSTERED ([ticket_number] ASC);

GO
ALTER TABLE [dbo].[CATERING]
    ADD CONSTRAINT [PK_CATERING] PRIMARY KEY CLUSTERED ([catering_number] ASC);

GO
ALTER TABLE [dbo].[COMPANY]
    ADD CONSTRAINT [PK_COMPANY] PRIMARY KEY CLUSTERED ([coc_number] ASC);

GO
ALTER TABLE [dbo].[COMPANY_BRANCH]
    ADD CONSTRAINT [PK_COMPANY_BRANCH] PRIMARY KEY CLUSTERED ([branch_number] ASC);

GO
ALTER TABLE [dbo].[COUNTRY]
    ADD CONSTRAINT [PK_COUNTRY] PRIMARY KEY CLUSTERED ([country_number] ASC);

GO
ALTER TABLE [dbo].[FESTIVAL]
    ADD CONSTRAINT [PK_FESTIVAL] PRIMARY KEY CLUSTERED ([festival_number] ASC);

GO
ALTER TABLE [dbo].[FESTIVAL_COMPANY]
    ADD CONSTRAINT [PK_FESTIVAL_COMPANY] PRIMARY KEY CLUSTERED ([festival_number] ASC, [branch_number] ASC);

GO
ALTER TABLE [dbo].[FESTIVAL_COMPANY_FILE]
    ADD CONSTRAINT [PK_FESTIVAL_COMPANY_FILE] PRIMARY KEY CLUSTERED ([file_number] ASC);

GO
ALTER TABLE [dbo].[GENRE]
    ADD CONSTRAINT [PK_GENRE] PRIMARY KEY CLUSTERED ([genre_number] ASC);

GO
ALTER TABLE [dbo].[GENRE_of_ARTIST]
    ADD CONSTRAINT [PK_GENRE_OF_ARTIST] PRIMARY KEY CLUSTERED ([genre_number] ASC, [artist_number] ASC);

GO
ALTER TABLE [dbo].[GENRE_preference_VISITOR]
    ADD CONSTRAINT [PK_GENRE_PREFERENCE_VISITOR] PRIMARY KEY CLUSTERED ([visitor_number] ASC, [genre_number] ASC);

GO
ALTER TABLE [dbo].[LOCKER]
    ADD CONSTRAINT [PK_LOCKER] PRIMARY KEY CLUSTERED ([locker_number] ASC);

GO
ALTER TABLE [dbo].[LOCKER_RENTED]
    ADD CONSTRAINT [PK_LOCKER_RENTED] PRIMARY KEY CLUSTERED ([locker_number] ASC, [start_date] ASC);

GO
ALTER TABLE [dbo].[ORGANISATION]
    ADD CONSTRAINT [PK_ORGANISATION] PRIMARY KEY CLUSTERED ([organisation_number] ASC);

GO
ALTER TABLE [dbo].[PERFORMANCE]
    ADD CONSTRAINT [PK_PERFORMANCE] PRIMARY KEY CLUSTERED ([performance_number] ASC);

GO
ALTER TABLE [dbo].[PODIUM]
    ADD CONSTRAINT [PK_PODIUM] PRIMARY KEY CLUSTERED ([podium_number] ASC);

GO
ALTER TABLE [dbo].[PODIUM_FILE]
    ADD CONSTRAINT [PK_PODIUM_FILE] PRIMARY KEY CLUSTERED ([file_number] ASC);

GO
ALTER TABLE [dbo].[PODIUM_plays_GENRE]
    ADD CONSTRAINT [PK_PODIUM_PLAYS_GENRE] PRIMARY KEY CLUSTERED ([genre_number] ASC, [podium_number] ASC);

GO
ALTER TABLE [dbo].[PODIUM_SCHEDULE]
    ADD CONSTRAINT [PK_PODIUM_SCHEDULE] PRIMARY KEY CLUSTERED ([podium_schedule_number] ASC);

GO
ALTER TABLE [dbo].[Relationship_40]
    ADD CONSTRAINT [PK_RELATIONSHIP_40] PRIMARY KEY CLUSTERED ([visitor_number] ASC, [performance_number] ASC);

GO
ALTER TABLE [dbo].[TENT]
    ADD CONSTRAINT [PK_TENT] PRIMARY KEY CLUSTERED ([tent_number] ASC);

GO
ALTER TABLE [dbo].[TENT_FILE]
    ADD CONSTRAINT [PK_TENT_FILE] PRIMARY KEY CLUSTERED ([file_number] ASC);

GO
ALTER TABLE [dbo].[TICKET_TYPE]
    ADD CONSTRAINT [PK_TICKET_TYPE] PRIMARY KEY CLUSTERED ([festival_number] ASC, [branch_number] ASC, [ticket_type] ASC);

GO
ALTER TABLE [dbo].[TOILET]
    ADD CONSTRAINT [PK_TOILET] PRIMARY KEY CLUSTERED ([toilet_number] ASC);

GO
ALTER TABLE [dbo].[TOWN]
    ADD CONSTRAINT [PK_TOWN] PRIMARY KEY CLUSTERED ([town_number] ASC);

GO
ALTER TABLE [dbo].[VISITOR]
    ADD CONSTRAINT [PK_VISITOR] PRIMARY KEY CLUSTERED ([visitor_number] ASC);

GO
ALTER TABLE [dbo].[VISITOR_visited_PERFORMANCE]
    ADD CONSTRAINT [PK_VISITOR_VISITED_PERFORMANCE] PRIMARY KEY CLUSTERED ([visitor_number] ASC, [performance_number] ASC);

GO
ALTER TABLE [dbo].[ARTIST_FILE]
    ADD CONSTRAINT [AK_KEY_2_ARTIST_F] UNIQUE NONCLUSTERED ([festival_number] ASC, [file] ASC);

GO
ALTER TABLE [dbo].[COUNTRY]
    ADD CONSTRAINT [AK_KEY_2_COUNTRY] UNIQUE NONCLUSTERED ([country_name] ASC);

GO
ALTER TABLE [dbo].[FESTIVAL_COMPANY_FILE]
    ADD CONSTRAINT [AK_KEY_2_FESTIVAL] UNIQUE NONCLUSTERED ([festival_number] ASC, [file] ASC);

GO
ALTER TABLE [dbo].[GENRE]
    ADD CONSTRAINT [AK_KEY_2_GENRE] UNIQUE NONCLUSTERED ([genre] ASC);

GO
ALTER TABLE [dbo].[ORGANISATION]
    ADD CONSTRAINT [AK_KEY_2_ORGANISA] UNIQUE NONCLUSTERED ([name] ASC);

GO
ALTER TABLE [dbo].[PERFORMANCE]
    ADD CONSTRAINT [AK_KEY_2_PERFORMA] UNIQUE NONCLUSTERED ([artist_number] ASC, [festival_number] ASC, [start_time] ASC);

GO
ALTER TABLE [dbo].[PODIUM]
    ADD CONSTRAINT [AK_KEY_2_PODIUM] UNIQUE NONCLUSTERED ([festival_number] ASC, [name] ASC);

GO
ALTER TABLE [dbo].[PODIUM_FILE]
    ADD CONSTRAINT [AK_KEY_2_PODIUM_F] UNIQUE NONCLUSTERED ([festival_number] ASC, [file] ASC);

GO
ALTER TABLE [dbo].[PODIUM_SCHEDULE]
    ADD CONSTRAINT [AK_KEY_2_PODIUM_S] UNIQUE NONCLUSTERED ([podium_number] ASC, [start_date] ASC);

GO
ALTER TABLE [dbo].[TENT]
    ADD CONSTRAINT [AK_KEY_2_TENT] UNIQUE NONCLUSTERED ([festival_number] ASC, [name] ASC);

GO
ALTER TABLE [dbo].[TENT_FILE]
    ADD CONSTRAINT [AK_KEY_2_TENT_FIL] UNIQUE NONCLUSTERED ([festival_number] ASC, [file] ASC);

GO
ALTER TABLE [dbo].[TOILET]
    ADD CONSTRAINT [AK_KEY_2_TOILET] UNIQUE NONCLUSTERED ([festival_number] ASC, [name] ASC);

GO
GRANT VIEW ANY COLUMN ENCRYPTION KEY DEFINITION TO PUBLIC;

GO
GRANT VIEW ANY COLUMN MASTER KEY DEFINITION TO PUBLIC;

GO
