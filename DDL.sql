CREATE TABLE Region(
    Id INTEGER PRIMARY KEY ASC NOT NULL,
    Name VARCHAR(50) NOT NULL,
    CONSTRAINT NameUnique UNIQUE (Name)
);

CREATE TABLE Adventure(
    Id INTEGER PRIMARY KEY ASC NOT NULL,
    RegionId INTEGER NOT NULL,
    Name VARCHAR(50) NOT NULL,
    FOREIGN KEY(RegionId) REFERENCES Region(Id),
    CONSTRAINT NameUnique UNIQUE (Name)
);

CREATE TABLE Consequence(
    Id INTEGER PRIMARY KEY ASC NOT NULL,
    Name VARCHAR(50) NOT NULL,
    CONSTRAINT NameUnique UNIQUE (Name)
);

CREATE TABLE Quest(
    Id INTEGER PRIMARY KEY ASC NOT NULL,
    AdventureId INTEGER NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Bonus INTEGER,-- NOT NULL,
    LastAward INTEGER NULL,
    Objective VARCHAR(200),-- NOT NULL,
    BossChase INTEGER NULL,
    TurnLimit INTEGER NULL,
    LimitConsequenceId INTEGER NULL,
    Comment VARCHAR(1000) NULL,
    FOREIGN KEY(AdventureId) REFERENCES Adventure(Id),
    FOREIGN KEY(LimitConsequenceId) REFERENCES Consequence(Id),
    CONSTRAINT NameUnique UNIQUE (Name)
);

CREATE TABLE Monster(
    Id INTEGER PRIMARY KEY ASC NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Level INTEGER,-- NOT NULL,
    Hearts INTEGER,-- NOT NULL,
    CONSTRAINT NameUnique UNIQUE (Name)
);

CREATE TABLE MonsterQuest(
    MonsterId INTEGER NOT NULL,
    QuestId INTEGER NOT NULL,
    FOREIGN KEY(MonsterId) REFERENCES Monster(Id),
    FOREIGN KEY(QuestId) REFERENCES Quest(Id),
    CONSTRAINT MonsterQuestUnique UNIQUE (MonsterId,QuestId)
);

CREATE TABLE Dungeoneer(
    Id INTEGER PRIMARY KEY ASC NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Hearts INTEGER NOT NULL,
    UnlockCost INTEGER NULL,
    CONSTRAINT NameUnique UNIQUE (Name)
);

CREATE TABLE Discipline(
    Id INTEGER PRIMARY KEY ASC NOT NULL,
    Name VARCHAR(50) NOT NULL,
    CONSTRAINT NameUnique UNIQUE (Name)
);

CREATE TABLE Trait(
    Id INTEGER PRIMARY KEY ASC NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(200) NOT NULL,
    CONSTRAINT NameUnique UNIQUE (Name)
);

CREATE TABLE Rarity(
    Id INTEGER PRIMARY KEY ASC NOT NULL,
    Name VARCHAR(50) NOT NULL,
    CONSTRAINT NameUnique UNIQUE (Name)
);

CREATE TABLE Tier(
    Id INTEGER PRIMARY KEY ASC NOT NULL,
    Level INTEGER NOT NULL,
    Cost INTEGER NOT NULL
);

CREATE TABLE GuildUpgrade(
    Id INTEGER PRIMARY KEY ASC NOT NULL,
    Name VARCHAR(50) NOT NULL,
    TierId INTEGER NOT NULL,
    FOREIGN KEY(TierId) REFERENCES Tier(Id),
    CONSTRAINT NameUnique UNIQUE (Name)
);

CREATE TABLE Bodypart(
    Id INTEGER PRIMARY KEY ASC NOT NULL,
    Name VARCHAR(50) NOT NULL,
    CONSTRAINT NameUnique UNIQUE (Name)
);

CREATE TABLE Item(
    Id INTEGER PRIMARY KEY ASC NOT NULL,
    Name VARCHAR(50) NOT NULL,
    GuildUpgradeId INTEGER NOT NULL,
    RarityId INTEGER NOT NULL,
    Level INTEGER NOT NULL,
    Hearts INTEGER NOT NULL,
    BodypartId INTEGER NOT NULL,
    FOREIGN KEY(GuildUpgradeId) REFERENCES GuildUpgrade(Id),
    FOREIGN KEY(RarityId) REFERENCES Rarity(Id),
    FOREIGN KEY(BodypartId) REFERENCES Bodypart(Id),
    CONSTRAINT NameUnique UNIQUE (Name)
);

CREATE TABLE MonsterDiscipline(
    MonsterId INTEGER NOT NULL,
    DisciplineId INTEGER NOT NULL,
    Level INTEGER NOT NULL,
    FOREIGN KEY(MonsterId) REFERENCES Monster(Id),
    FOREIGN KEY(DisciplineId) REFERENCES Discipline(Id),
    CONSTRAINT MonsterDisciplineUnique UNIQUE (MonsterId,DisciplineId)
);

CREATE TABLE ItemTrait(
    ItemId INTEGER NOT NULL,
    TraitId INTEGER NOT NULL,
    FOREIGN KEY(ItemId) REFERENCES Item(Id),
    FOREIGN KEY(TraitId) REFERENCES Trait(Id),
    CONSTRAINT ItemTraitUnique UNIQUE (ItemId,TraitId)
);

CREATE TABLE MonsterTrait(
    MonsterId INTEGER NOT NULL,
    TraitId INTEGER NOT NULL,
    FOREIGN KEY(MonsterId) REFERENCES Monster(Id),
    FOREIGN KEY(TraitId) REFERENCES Trait(Id),
    CONSTRAINT MonsterTraitUnique UNIQUE (MonsterId,TraitId)
);

CREATE TABLE DungeoneerTrait(
    DungeoneerId INTEGER NOT NULL,
    TraitId INTEGER NOT NULL,
    FOREIGN KEY(DungeoneerId) REFERENCES Dungeoneer(Id),
    FOREIGN KEY(TraitId) REFERENCES Trait(Id),
    CONSTRAINT DungeoneerTraitUnique UNIQUE (DungeoneerId,TraitId)
);

CREATE TABLE ItemDiscipline(
    ItemId INTEGER NOT NULL,
    DisciplineId INTEGER NOT NULL,
    Level INTEGER NOT NULL,
    FOREIGN KEY(ItemId) REFERENCES Item(Id),
    FOREIGN KEY(DisciplineId) REFERENCES Discipline(Id),
    CONSTRAINT ItemDisciplineUnique UNIQUE (ItemId,DisciplineId)
);

CREATE TABLE Card(
    Id INTEGER PRIMARY KEY ASC NOT NULL,
    Name VARCHAR(50) NOT NULL,
    CONSTRAINT NameUnique UNIQUE (Name)
);

CREATE TABLE Effect(
    Id INTEGER PRIMARY KEY ASC,
    Name VARCHAR(50),
    Description VARCHAR(200),
    CONSTRAINT NameUnique UNIQUE (Name)
);

CREATE TABLE CardEffect(
    CardId INTEGER NOT NULL,
    EffectId INTEGER NOT NULL,
    Quantity INTEGER NULL,
    NeedsSuccess INTEGER NULL,
    FOREIGN KEY(CardId) REFERENCES Card(Id),
    FOREIGN KEY(EffectId) REFERENCES Effect(Id),
    CONSTRAINT CardEffectUnique UNIQUE (CardId, EffectId)
);

CREATE TABLE DisciplineCard(
    DisciplineId INTEGER NOT NULL,
    CardId INTEGER NOT NULL,
    Level INTEGER NOT NULL,
    FOREIGN KEY(DisciplineId) REFERENCES Discipline(Id),
    FOREIGN KEY(CardId) REFERENCES Card(Id),
    CONSTRAINT DisciplineCardUnique UNIQUE (DisciplineId,CardId)
);

CREATE TABLE DungeoneerCard(
    DungeoneerId INTEGER NOT NULL,
    CardId INTEGER NOT NULL,
    Quantity INTEGER NOT NULL,
    FOREIGN KEY(DungeoneerId) REFERENCES Dungeoneer(Id),
    FOREIGN KEY(CardId) REFERENCES Card(Id),
    CONSTRAINT DungeoneerCard UNIQUE (DungeoneerId,CardId)
);

CREATE TABLE Scar(
    Id INTEGER PRIMARY KEY ASC,
    Name VARCHAR(50),
    EarlyStageDescription VARCHAR(200),
    FinalStageDescription VARCHAR(200),
    CONSTRAINT NameUnique UNIQUE (Name)
);

CREATE TABLE AdventureDependency(
    ParentAdventureId INTEGER NOT NULL,
    ChildAdventureId INTEGER NOT NULL,
    FOREIGN KEY(ParentAdventureId) REFERENCES Adventure(Id),
    FOREIGN KEY(ChildAdventureId) REFERENCES Adventure(Id),
    CONSTRAINT ParentChildUnique UNIQUE (ParentAdventureId,ChildAdventureId)
);