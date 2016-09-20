WITH Weapon AS (
    SELECT
        Weapon.ItemId WeaponId,
        Weapon.ItemName WeaponName
    FROM (
        SELECT
            Item.Id ItemId,
            Item.Name ItemName
        FROM Item
        JOIN Bodypart
            ON Item.BodypartId = Bodypart.Id
        WHERE Bodypart.Name = 'Weapon'
    ) Weapon
),
Headgear AS (
    SELECT
        Headgear.ItemId HeadgearId,
        Headgear.ItemName HeadgearName
    FROM (
        SELECT
            Item.Id ItemId,
            Item.Name ItemName
        FROM Item
        JOIN Bodypart
            ON Item.BodypartId = Bodypart.Id
        WHERE Bodypart.Name = 'Headgear'
    ) Headgear
),
Body AS (
    SELECT
        Body.ItemId BodyId,
        Body.ItemName BodyName
    FROM (
        SELECT
            Item.Id ItemId,
            Item.Name ItemName
        FROM Item
        JOIN Bodypart
            ON Item.BodypartId = Bodypart.Id
        WHERE Bodypart.Name = 'Body'
    ) Body
),
Offhand AS (
    SELECT
        Offhand.ItemId OffhandId,
        Offhand.ItemName OffhandName
    FROM (
        SELECT
            Item.Id ItemId,
            Item.Name ItemName
        FROM Item
        JOIN Bodypart
            ON Item.BodypartId = Bodypart.Id
        WHERE Bodypart.Name = 'Offhand'
    ) Offhand
),
Outfit AS (
    SELECT
        WeaponId,
        WeaponName,
        HeadgearId,
        HeadgearName,
        BodyId,
        BodyName,
        OffhandId,
        OffhandName
    FROM Weapon
    CROSS JOIN Headgear
    CROSS JOIN Body
    CROSS JOIN Offhand
),
OutfitDiscipline AS (
    SELECT
        Outfit.WeaponId,
        Outfit.WeaponName,
        Outfit.HeadgearId,
        Outfit.HeadgearName,
        Outfit.BodyId,
        Outfit.BodyName,
        Outfit.OffhandId,
        Outfit.OffhandName,
        WeaponDiscipline.DisciplineId,
        WeaponDiscipline.Level
    FROM Outfit
    JOIN ItemDiscipline WeaponDiscipline
        ON Outfit.WeaponId = WeaponDiscipline.ItemId
    UNION ALL
    SELECT
        Outfit.WeaponId,
        Outfit.WeaponName,
        Outfit.HeadgearId,
        Outfit.HeadgearName,
        Outfit.BodyId,
        Outfit.BodyName,
        Outfit.OffhandId,
        Outfit.OffhandName,
        HeadgearDiscipline.DisciplineId,
        HeadgearDiscipline.Level
    FROM Outfit
    JOIN ItemDiscipline HeadgearDiscipline
        ON Outfit.HeadgearId = HeadgearDiscipline.ItemId
    UNION ALL
    SELECT
        Outfit.WeaponId,
        Outfit.WeaponName,
        Outfit.HeadgearId,
        Outfit.HeadgearName,
        Outfit.BodyId,
        Outfit.BodyName,
        Outfit.OffhandId,
        Outfit.OffhandName,
        BodyDiscipline.DisciplineId,
        BodyDiscipline.Level
    FROM Outfit
    JOIN ItemDiscipline BodyDiscipline
        ON Outfit.BodyId = BodyDiscipline.ItemId
    UNION ALL
    SELECT
        Outfit.WeaponId,
        Outfit.WeaponName,
        Outfit.HeadgearId,
        Outfit.HeadgearName,
        Outfit.BodyId,
        Outfit.BodyName,
        Outfit.OffhandId,
        Outfit.OffhandName,
        OffhandDiscipline.DisciplineId,
        OffhandDiscipline.Level
    FROM Outfit
    JOIN ItemDiscipline OffhandDiscipline
        ON Outfit.OffhandId = OffhandDiscipline.ItemId
),

OutfitSumDiscipline AS (
    SELECT
        OutfitDiscipline.WeaponId,
        OutfitDiscipline.WeaponName,
        OutfitDiscipline.HeadgearId,
        OutfitDiscipline.HeadgearName,
        OutfitDiscipline.BodyId,
        OutfitDiscipline.BodyName,
        OutfitDiscipline.OffhandId,
        OutfitDiscipline.OffhandName,
        OutfitDiscipline.DisciplineId,
        SUM(OutfitDiscipline.Level) SumDisciplineLevel
    FROM OutfitDiscipline
    GROUP BY OutfitDiscipline.WeaponId,
        OutfitDiscipline.WeaponName,
        OutfitDiscipline.HeadgearId,
        OutfitDiscipline.HeadgearName,
        OutfitDiscipline.BodyId,
        OutfitDiscipline.BodyName,
        OutfitDiscipline.OffhandId,
        OutfitDiscipline.OffhandName,
        OutfitDiscipline.DisciplineId
),

OutfitDisciplineLevel AS (
    SELECT
        OutfitSumDiscipline.WeaponId,
        OutfitSumDiscipline.WeaponName,
        OutfitSumDiscipline.HeadgearId,
        OutfitSumDiscipline.HeadgearName,
        OutfitSumDiscipline.BodyId,
        OutfitSumDiscipline.BodyName,
        OutfitSumDiscipline.OffhandId,
        OutfitSumDiscipline.OffhandName,
        OutfitSumDiscipline.DisciplineId,
        CASE
            WHEN OutfitSumDiscipline.SumDisciplineLevel > 4
                THEN 4
            ELSE OutfitSumDiscipline.SumDisciplineLevel
        END AS OutfitDisciplineLevel
    FROM OutfitSumDiscipline
)

SELECT
    OutfitDisciplineLevel.WeaponId,
    OutfitDisciplineLevel.WeaponName,
    OutfitDisciplineLevel.HeadgearId,
    OutfitDisciplineLevel.HeadgearName,
    OutfitDisciplineLevel.BodyId,
    OutfitDisciplineLevel.BodyName,
    OutfitDisciplineLevel.OffhandId,
    OutfitDisciplineLevel.OffhandName,
    AVG(OutfitDisciplineLevel.OutfitDisciplineLevel) AverageOutfitDisciplineLevel
FROM OutfitDisciplineLevel
GROUP BY OutfitDisciplineLevel.WeaponId,
    OutfitDisciplineLevel.WeaponName,
    OutfitDisciplineLevel.HeadgearId,
    OutfitDisciplineLevel.HeadgearName,
    OutfitDisciplineLevel.BodyId,
    OutfitDisciplineLevel.BodyName,
    OutfitDisciplineLevel.OffhandId,
    OutfitDisciplineLevel.OffhandName
ORDER BY AverageOutfitDisciplineLevel ASC;