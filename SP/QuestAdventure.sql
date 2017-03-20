SELECT
    q.Name
FROM Quest q
JOIN Adventure a
    ON q.AdventureId = a.Id
WHERE a.Name = 'Rats? How Original!';