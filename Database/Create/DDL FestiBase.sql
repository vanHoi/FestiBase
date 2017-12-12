/*==============================================================*/
/* DBMS name:      FestiBase									*/
/* PDM version 4												*/	
/* DDL script													*/
/*==============================================================*/

USE master
GO

DROP DATABASE IF EXISTS FestiBase
GO

CREATE DATABASE FestiBase
GO

USE FestiBase
GO

/*==============================================================*/
/* Table: ARTIST                                                */
/*==============================================================*/
create table ARTIST (
   artist_number        int identity (1,1)   not null,
   artist_name          varchar(50)          not null,
   constraint PK_ARTIST primary key (artist_number)
)
go

/*==============================================================*/
/* Table: VISITOR                                               */
/*==============================================================*/
create table VISITOR (
   visitor_number       int identity (1,1)   not null,
   email                varchar(30)          null,
   first_name           varchar(25)          null,
   surname              varchar(30)          null,
   constraint PK_VISITOR primary key (visitor_number)
)
go

/*==============================================================*/
/* Table: ARTIST_preferred_by_VISITOR                           */
/*==============================================================*/
create table ARTIST_preferred_by_VISITOR (
   artist_number        int                  not null,
   visitor_number       int                  not null,
   constraint PK_ARTIST_PREFERRED_BY_VISITOR primary key (artist_number, visitor_number),
   constraint FK_ARTIST_P_RELATIONS_ARTIST foreign key (artist_number)
      references ARTIST (artist_number),
   constraint FK_ARTIST_P_RELATIONS_VISITOR foreign key (visitor_number)
      references VISITOR (visitor_number)
)
go

/*==============================================================*/
/* Table: COMPANY                                               */
/*==============================================================*/
create table COMPANY (
   coc_number           varchar(8)           not null,
   name                 varchar(50)          not null,
   constraint PK_COMPANY primary key (coc_number)
)
go

/*==============================================================*/
/* Table: ORGANISATION                                          */
/*==============================================================*/
create table ORGANISATION (
   organisation_number  int identity (1,1)   not null,
   name                 varchar(40)          not null,
   constraint PK_ORGANISATION primary key (organisation_number)
)
go

/*==============================================================*/
/* Table: FESTIVAL                                              */
/*==============================================================*/
create table FESTIVAL (
   festival_number      int identity (1,1)   not null,
   organisation_number  int                  not null,
   name                 varchar(25)          not null,
   start_date           datetime             not null,
   end_date             datetime             not null,
   location             varchar(50)          not null,
   token_price          money                not null,
   constraint PK_FESTIVAL primary key (festival_number),
   constraint FK_FESTIVAL_RELATIONS_ORGANISA foreign key (organisation_number)
      references ORGANISATION (organisation_number)
)
go

/*==============================================================*/
/* Table: COUNTRY                                               */
/*==============================================================*/
create table COUNTRY (
   country_number       int identity (1,1)   not null,
   country_name         varchar(50)          not null,
   constraint PK_COUNTRY primary key (country_number)
)
go

/*==============================================================*/
/* Table: TOWN                                                  */
/*==============================================================*/
create table TOWN (
   town_number          int identity (1,1)   not null,
   country_number       int                  not null,
   town_name            varchar(25)          not null,
   constraint PK_TOWN primary key (town_number),
   constraint FK_TOWN_TOWN_IN_C_COUNTRY foreign key (country_number)
      references COUNTRY (country_number)
)
go

/*==============================================================*/
/* Table: FESTIVAL_COMPANY                                      */
/*==============================================================*/
create table FESTIVAL_COMPANY (
   coc_number           varchar(8)           not null,
   festival_number      int                  not null,
   town_number          int                  not null,
   telephone_number     varchar(10)          not null,
   street               varchar(50)          not null,
   house_number         int                  not null,
   contact_person       varchar(40)          not null,
   description          text                 not null,
   constraint PK_FESTIVAL_COMPANY primary key (coc_number, festival_number),
   constraint FK_FESTIVAL_RELATIONS_COMPANY foreign key (coc_number)
      references COMPANY (coc_number),
   constraint FK_FESTIVAL_COMPANY_RELATIONS_FESTIVAL foreign key (festival_number)
      references FESTIVAL (festival_number),
   constraint FK_FESTIVAL_RELATIONS_TOWN foreign key (town_number)
      references TOWN (town_number)
)
go

/*==============================================================*/
/* Table: ATTRACTION                                            */
/*==============================================================*/
create table ATTRACTION (
   attraction_number    int identity (1,1)   not null,
   coc_number           varchar(8)           not null,
   festival_number      int                  not null,
   name                 varchar(30)          not null,
   attraction_type      varchar(20)          not null,
   constraint PK_ATTRACTION primary key (attraction_number),
   constraint FK_ATTRACTI_RELATIONS_FESTIVAL foreign key (coc_number, festival_number)
      references FESTIVAL_COMPANY (coc_number, festival_number)
)
go

/*==============================================================*/
/* Table: TICKET_TYPE                                           */
/*==============================================================*/
create table TICKET_TYPE (
   coc_number           varchar(8)           not null,
   festival_number      int                  not null,
   ticket_type          varchar(20)          not null,
   price                money                not null,
   date_valid_from      datetime             not null,
   date_valid_to        datetime             null,
   constraint PK_TICKET_TYPE primary key (coc_number, festival_number, ticket_type),
   constraint FK_TICKET_T_RELATIONS_FESTIVAL foreign key (coc_number, festival_number)
      references FESTIVAL_COMPANY (coc_number, festival_number)
)
go

/*==============================================================*/
/* Table: BOUGHT_TICKET                                         */
/*==============================================================*/
create table BOUGHT_TICKET (
   ticket_number        int identity (1,1)   not null,
   coc_number           varchar(8)           not null,
   festival_number      int                  not null,
   ticket_type          varchar(20)          not null,
   visitor_number       int                  not null,
   constraint PK_BOUGHT_TICKET primary key (ticket_number),
   constraint FK_BOUGHT_T_VISITOR_B_VISITOR foreign key (visitor_number)
      references VISITOR (visitor_number),
   constraint FK_BOUGHT_T_BOUGHT_TI_TICKET_T foreign key (coc_number, festival_number, ticket_type)
      references TICKET_TYPE (coc_number, festival_number, ticket_type)
)
go

/*==============================================================*/
/* Table: CATERING                                              */
/*==============================================================*/
create table CATERING (
   catering_number      int identity (1,1)   not null,
   coc_number           varchar(8)           not null,
   festival_number      int                  not null,
   name                 varchar(25)          not null,
   electricity          bit                  not null,
   constraint PK_CATERING primary key (catering_number),
   constraint FK_CATERING_CATERING__FESTIVAL foreign key (coc_number, festival_number)
      references FESTIVAL_COMPANY (coc_number, festival_number)
)
go

/*==============================================================*/
/* Table: FESTIVAL_COMPANY_FILE                                 */
/*==============================================================*/
create table FESTIVAL_COMPANY_FILE (
   file_number          int identity (1,1)   not null,
   coc_number           varchar(8)           not null,
   festival_number      int                  not null,
   "file"               varchar(50)          not null,
   description          text                 not null,
   constraint PK_FESTIVAL_COMPANY_FILE primary key (file_number),
   constraint FK_FESTIVAL_COMPANY_FILE_RELATIONS_FESTIVAL foreign key (coc_number, festival_number)
      references FESTIVAL_COMPANY (coc_number, festival_number)
)
go

/*==============================================================*/
/* Table: GENRE                                                 */
/*==============================================================*/
create table GENRE (
   genre_number			int identity (1,1)   not null,
   genre                varchar(20)          not null,
   constraint PK_GENRE primary key (genre_number)
)
go

/*==============================================================*/
/* Table: GENRE_of_ARTIST                                       */
/*==============================================================*/
create table GENRE_of_ARTIST (
   genre_number         int                  not null,
   artist_number        int                  not null,
   constraint PK_GENRE_OF_ARTIST primary key (genre_number, artist_number),
   constraint FK_GENRE_OF_GENRE_OF__GENRE foreign key (genre_number)
      references GENRE (genre_number),
   constraint FK_GENRE_OF_GENRE_OF__ARTIST foreign key (artist_number)
      references ARTIST (artist_number)
)
go

/*==============================================================*/
/* Table: GENRE_preference_VISITOR                              */
/*==============================================================*/
create table GENRE_preference_VISITOR (
   visitor_number       int                  not null,
   genre_number         int                  not null,
   constraint PK_GENRE_PREFERENCE_VISITOR primary key (visitor_number, genre_number),
   constraint FK_GENRE_PR_GENRE_PRE_VISITOR foreign key (visitor_number)
      references VISITOR (visitor_number),
   constraint FK_GENRE_PR_GENRE_PRE_GENRE foreign key (genre_number)
      references GENRE (genre_number)
)
go

/*==============================================================*/
/* Table: LOCKER                                                */
/*==============================================================*/
create table LOCKER (
   locker_number        int identity (1,1)   not null,
   coc_number           varchar(8)           not null,
   festival_number      int                  not null,
   constraint PK_LOCKER primary key (locker_number),
   constraint FK_LOCKER_RELATIONS_FESTIVAL foreign key (coc_number, festival_number)
      references FESTIVAL_COMPANY (coc_number, festival_number)
)
go

/*==============================================================*/
/* Table: LOCKER_RENTED                                         */
/*==============================================================*/
create table LOCKER_RENTED (
   locker_number        int                  not null,
   start_date           datetime             not null,
   end_date             datetime             null,
   visitor_number       int                  not null,
   constraint PK_LOCKER_RENTED primary key (locker_number, start_date),
   constraint FK_LOCKER_R_LOCKER_IN_LOCKER foreign key (locker_number)
      references LOCKER (locker_number),
   constraint FK_LOCKER_R_VISITOR_R_VISITOR foreign key (visitor_number)
      references VISITOR (visitor_number)
)
go

/*==============================================================*/
/* Table: PODIUM                                                */
/*==============================================================*/
create table PODIUM (
   podium_number        int identity (1,1)   not null,
   festival_number      int                  not null,
   genre_number         int                  null,
   name                 varchar(25)          not null,
   podium_width         int                  not null,
   podium_depth         int                  not null,
   height               int                  null,
   capacity             int                  not null,
   floorheight          int                  not null,
   floor_load           int                  not null,
   free_span_width      int                  not null,
   free_span_depth      int                  not null,
   free_span_height     int                  not null,
   environment          text                 not null,
   constraint PK_PODIUM primary key (podium_number),
   constraint FK_PODIUM_RELATIONS_GENRE foreign key (genre_number)
      references GENRE (genre_number),
   constraint FK_PODIUM_RELATIONS_FESTIVAL foreign key (festival_number)
      references FESTIVAL (festival_number)
)
go

/*==============================================================*/
/* Table: PERFORMANCE                                           */
/*==============================================================*/
create table PERFORMANCE (
   performance_number   int identity (1,1)   not null,
   podium_number        int                  not null,
   artist_number        int                  not null,
   date                 datetime             null,
   start_time           datetime             null,
   play_time            int					 not null,
   constraint PK_PERFORMANCE primary key (performance_number),
   constraint FK_PERFORMA_PERFORMAN_PODIUM foreign key (podium_number)
      references PODIUM (podium_number),
   constraint FK_PERFORMA_PERFORMAN_ARTIST foreign key (artist_number)
      references ARTIST (artist_number)
)
go

/*==============================================================*/
/* Table: PERSONAL_INFORMATION                                  */
/*==============================================================*/
create table PERSONAL_INFORMATION (
   visitor_number       int                  not null,
   town_number          int                  null,
   telephone_number     varchar(10)          null,
   birthdate            datetime             null,
   twitter_username     varchar(15)          null,
   facebook_username    varchar(70)          null,
   street               varchar(50)          null,
   house_number         int                  null,
   constraint PK_PERSONAL_INFORMATION primary key (visitor_number),
   constraint FK_PERSONAL_RELATIONS_TOWN foreign key (town_number)
      references TOWN (town_number),
   constraint FK_PERSONAL_PERSONAL__VISITOR foreign key (visitor_number)
      references VISITOR (visitor_number)
)
go

/*==============================================================*/
/* Table: PODIUM_FILE                                           */
/*==============================================================*/
create table PODIUM_FILE (
   file_number          int identity (1,1)   not null,
   podium_number        int                  not null,
   coc_number           varchar(8)           not null,
   festival_number      int                  not null,
   "file"               varchar(50)          not null,
   description          text                 not null,
   constraint PK_PODIUM_FILE primary key (file_number),
   constraint FK_PODIUM_F_PODIUM_FI_PODIUM foreign key (podium_number)
      references PODIUM (podium_number),
   constraint FK_PODIUM_F_RELATIONS_FESTIVAL foreign key (coc_number, festival_number)
      references FESTIVAL_COMPANY (coc_number, festival_number)
)
go

/*==============================================================*/
/* Table: TENT                                                  */
/*==============================================================*/
create table TENT (
   tent_number          int identity (1,1)   not null,
   podium_number        int                  null,
   length               int                  not null,
   width                int                  not null,
   side_height          int                  not null,
   ridge_height         int                  not null,
   construction_width   int                  not null,
   construction_length  int                  not null,
   tent_type            varchar(20)          not null,
   color                varchar(10)          not null,
   floor_type           varchar(20)          null,
   capacity             int                  not null
   constraint PK_TENT primary key (tent_number),
   constraint FK_TENT_PODIUM_IN_PODIUM foreign key (podium_number)
      references PODIUM (podium_number)
)
go

/*==============================================================*/
/* Table: TENT_FILE                                             */
/*==============================================================*/
create table TENT_FILE (
   file_number          int identity (1,1)   not null,
   tent_number          int                  not null,
   coc_number           varchar(8)           not null,
   festival_number      int                  not null,
   "file"               varchar(50)          not null,
   description          text                 not null,
   constraint PK_TENT_FILE primary key (file_number),
   constraint FK_TENT_FIL_RELATIONS_FESTIVAL foreign key (coc_number, festival_number)
      references FESTIVAL_COMPANY (coc_number, festival_number),
   constraint FK_TENT_FIL_RELATIONS_TENT foreign key (tent_number)
      references TENT (tent_number)
)
go

/*==============================================================*/
/* Table: TOILET                                                */
/*==============================================================*/
create table TOILET (
   toilet_number        int identity (1,1)   not null,
   coc_number           varchar(8)           not null,
   festival_number      int                  not null,
   toilet_code          varchar(50)          not null,
   toilet_capacity      int                  not null,
   constraint PK_TOILET primary key (toilet_number),
   constraint FK_TOILET_TOILET_BY_FESTIVAL foreign key (coc_number, festival_number)
      references FESTIVAL_COMPANY (coc_number, festival_number)
)
go

/*==============================================================*/
/* Table: VISITOR_visited_PERFORMANCE                           */
/*==============================================================*/
create table VISITOR_visited_PERFORMANCE (
   visitor_number       int                  not null,
   performance_number   int                  not null,
   constraint PK_VISITOR_VISITED_PERFORMANCE primary key (visitor_number, performance_number),
   constraint FK_VISITOR__RELATIONS_VISITOR foreign key (visitor_number)
      references VISITOR (visitor_number),
   constraint FK_VISITOR__RELATIONS_PERFORMA foreign key (performance_number)
      references PERFORMANCE (performance_number)
)
go
