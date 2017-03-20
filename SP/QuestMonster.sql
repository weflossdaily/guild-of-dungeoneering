SELECT
    m.Name
FROM Monster m
JOIN MonsterQuest mq
    ON m.Id = mq.MonsterId
JOIN Quest q
    ON mq.QuestId = q.Id
WHERE q.Id = 'Squeak squeak';