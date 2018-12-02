SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP TABLE [dbo].[Aspects2]
CREATE TABLE [dbo].[Aspects2](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[noun] [nvarchar](max) NULL,
	[adjective] [nvarchar](max) NULL,
	[polarity] [float] NULL,
	[rule] [int] NULL,
	[cluster] nvarchar(max) NOT NULL
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO