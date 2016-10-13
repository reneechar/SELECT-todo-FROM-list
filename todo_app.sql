\c rchar;


DROP USER IF EXISTS michael;

CREATE USER michael WITH ENCRYPTED PASSWORD 'stonebreaker';

DROP DATABASE IF EXISTS todo_app;

CREATE DATABASE todo_app;

\c todo_app;

CREATE TABLE tasks (
  id serial PRIMARY KEY,
  title varchar(225) NOT NULL,
  description text,
  created_at timestamp NOT NULL DEFAULT now(),
  updated_at timestamp DEFAULT null,
  completed boolean NOT NULL
);

ALTER TABLE tasks * DROP COLUMN IF EXISTS completed;

ALTER TABLE tasks * ADD COLUMN completed_at timestamp;

--not sure if this is working
ALTER TABLE tasks * ALTER COLUMN completed_at SET DEFAULT null;

ALTER TABLE tasks * ALTER COLUMN updated_at SET DEFAULT now();

ALTER TABLE tasks * ALTER COLUMN updated_at SET NOT NULL;


INSERT INTO tasks (title, description, created_at, updated_at,completed_at)
VALUES (
  'Study SQL',
  'Complete this exercise',
  now(),
  now(),
  NULL
);

INSERT INTO tasks (title, description)
VALUES (
  'Study PostgreSQL',
  'Read all the documentation'
);

--*
SELECT title
FROM tasks
WHERE completed_at IS null;


UPDATE tasks
SET completed_at = now()
WHERE title = 'Study SQL';

--*
SELECT title, description
FROM tasks
WHERE completed_at IS null;


INSERT INTO tasks (title, description)
VALUES (
  'mistake 1',
  'a test entry'
);

INSERT INTO tasks (title, description)
VALUES (
  'mistake 2',
  'another test entry'
);

INSERT INTO tasks (title, description)
VALUES (
  'third mistake',
  'another test entry'
);

--*
SELECT title
FROM tasks
WHERE title LIKE 'mistake%' OR title LIKE '%mistake';

DELETE
FROM tasks
WHERE title LIKE 'mistake%' OR title LIKE '%mistake';

SELECT *
FROM tasks
ORDER BY title;