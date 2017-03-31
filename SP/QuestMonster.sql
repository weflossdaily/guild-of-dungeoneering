SELECT
    m.Name,
    'Level ' || m.Level,
    d.Name,
    dc.Level,
    c.Name,
    e.Name,
    ce.Quantity,
    ce.NeedsSuccess
FROM Quest q
JOIN MonsterQuest mq
    ON mq.QuestId = q.Id
JOIN Monster m
    ON m.Id = mq.MonsterId
LEFT JOIN MonsterDiscipline md
    ON m.Id = md.MonsterId
LEFT JOIN Discipline d
    ON d.Id = md.DisciplineId
LEFT JOIN DisciplineCard dc
    ON d.Id = dc.DisciplineId
    AND md.Level >= dc.Level
LEFT JOIN Card c
    ON dc.CardId = c.Id
LEFT JOIN CardEffect ce
    ON c.Id = ce.CardId
LEFT JOIN Effect e
    ON ce.EffectId = e.Id
WHERE q.name = "Parrot Treasure";