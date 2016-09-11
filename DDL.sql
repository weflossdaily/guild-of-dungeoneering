CREATE TABLE Region(
    Id INTEGER PRIMARY KEY ASC,
    Name VARCHAR(50)
);

CREATE TABLE Adventure(
    Id INTEGER PRIMARY KEY ASC,
    RegionId INTEGER,
    Name VARCHAR(50),
    FOREIGN KEY(RegionId) REFERENCES Region(Id)
);

CREATE TABLE Consequence(
    Id INTEGER PRIMARY KEY ASC,
    Name VARCHAR(50)
);

CREATE TABLE Quest(
    Id INTEGER PRIMARY KEY ASC,
    AdventureId INTEGER,
    Name VARCHAR(50),
    Bonus INTEGER,
    LastAward INTEGER,
    Objective VARCHAR(200),
    BossChase INTEGER,
    TurnLimit INTEGER,
    LimitConsequenceId INTEGER,
    FOREIGN KEY(AdventureId) REFERENCES Adventure(Id),
    FOREIGN KEY(LimitConsequenceId) REFERENCES Consequence(Id)
);

CREATE TABLE Monster(
    Id INTEGER PRIMARY KEY ASC,
    Name VARCHAR(50),
    Level INTEGER,
    Hearts INTEGER
);

CREATE TABLE MonsterQuest(
    MonsterId INTEGER,
    QuestId INTEGER,
    FOREIGN KEY(MonsterId) REFERENCES Monster(Id),
    FOREIGN KEY(QuestId) REFERENCES Quest(Id)
);

CREATE TABLE Dungeoneer(
    Id INTEGER PRIMARY KEY ASC,
    Name VARCHAR(50),
    Hearts INTEGER,
    UnlockCost INTEGER
);

CREATE TABLE Discipline(
    Id INTEGER PRIMARY KEY ASC,
    Name VARCHAR(50)
);

CREATE TABLE Trait(
    Id INTEGER PRIMARY KEY ASC,
    Name VARCHAR(50),
    Description VARCHAR(200)
);

CREATE TABLE Rarity(
    Id INTEGER PRIMARY KEY ASC,
    Name VARCHAR(50)
);

CREATE TABLE Tier(
    Id INTEGER PRIMARY KEY ASC,
    Level INTEGER,
    Cost INTEGER
);

CREATE TABLE GuildUpgrade(
    Id INTEGER PRIMARY KEY ASC,
    Name VARCHAR(50),
    TierId INTEGER,
    FOREIGN KEY(TierId) REFERENCES Tier(Id)
);

CREATE TABLE Item(
    Id INTEGER PRIMARY KEY ASC,
    Name VARCHAR(50),
    GuildUpgradeId INTEGER,
    RarityId INTEGER,
    Level INTEGER,
    Hearts INTEGER,
    FOREIGN KEY(GuildUpgradeId) REFERENCES GuildUpgrade(Id),
    FOREIGN KEY(RarityId) REFERENCES Rarity(Id)
);

CREATE TABLE MonsterDiscipline(
    MonsterId INTEGER,
    DisciplineId INTEGER,
    Level INTEGER,
    FOREIGN KEY(MonsterId) REFERENCES Monster(Id),
    FOREIGN KEY(DisciplineId) REFERENCES Discipline(Id)
);

CREATE TABLE ItemTrait(
    ItemId INTEGER,
    TraitId INTEGER,
    FOREIGN KEY(ItemId) REFERENCES Item(Id),
    FOREIGN KEY(TraitId) REFERENCES Trait(Id)
);

CREATE TABLE MonsterTrait(
    MonsterId INTEGER,
    TraitId INTEGER,
    FOREIGN KEY(MonsterId) REFERENCES Monster(Id),
    FOREIGN KEY(TraitId) REFERENCES Trait(Id)
);

CREATE TABLE DungeoneerTrait(
    DungeoneerId INTEGER,
    TraitId INTEGER,
    FOREIGN KEY(DungeoneerId) REFERENCES Dungeoneer(Id),
    FOREIGN KEY(TraitId) REFERENCES Trait(Id)
);

CREATE TABLE ItemDiscipline(
    ItemId INTEGER,
    DisciplineId INTEGER,
    Level INTEGER,
    FOREIGN KEY(ItemId) REFERENCES Item(Id),
    FOREIGN KEY(DisciplineId) REFERENCES Discipline(Id)
);

CREATE TABLE Card(
    Id INTEGER PRIMARY KEY ASC,
    Name VARCHAR(50),
    PhysicalDamage INTEGER,
    MagicDamage INTEGER,
    Quick INTEGER,
    Unblockable INTEGER,
    PhysicalBlocks INTEGER,
    MagicBlocks INTEGER,
    AllBlock INTEGER,
    StealOnSuccess INTEGER,
    ConcealOnSuccess INTEGER,
    CloneOnSuccess INTEGER,
    DiscardOnSuccess INTEGER,
    Hearts INTEGER,
    AddedPhysicalToNext INTEGER,
    AddedMagicToNext INTEGER,
    Swap INTEGER,
    Draw INTEGER
);

CREATE TABLE DisciplineCard(
    DisciplineId INTEGER,
    CardId INTEGER,
    Level INTEGER,
    FOREIGN KEY(DisciplineId) REFERENCES Discipline(Id),
    FOREIGN KEY(CardId) REFERENCES Card(Id)
);

CREATE TABLE DungeoneerCard(
    DungeoneerId INTEGER,
    CardId INTEGER,
    Quantity INTEGER,
    FOREIGN KEY(DungeoneerId) REFERENCES Dungeoneer(Id),
    FOREIGN KEY(CardId) REFERENCES Card(Id)
);