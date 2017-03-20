SELECT
    Quest.Name,
    Monster.Level,
    Monster.Name,
    Discipline.Name,
    DisciplineCard.Level,
    Card.Name
FROM Monster
JOIN MonsterDiscipline
    ON Monster.Id = MonsterDiscipline.MonsterId
JOIN Discipline
    ON MonsterDiscipline.DisciplineId = Discipline.Id
JOIN DisciplineCard
    ON Discipline.Id = DisciplineCard.DisciplineId
JOIN Card
    ON DisciplineCard.CardId = Card.Id
    AND MonsterDiscipline.Level >= DisciplineCard.Level
JOIN MonsterQuest
    ON Monster.Id = MonsterQuest.MonsterId
JOIN Quest
    ON MonsterQuest.QuestId = Quest.Id
WHERE Quest.Name = 'Eatin Ettin'
ORDER BY
    Quest.Name ASC,
    Monster.Level ASC,
    Monster.Name ASC,
    Discipline.Name ASC,
    DisciplineCard.Level ASC
;