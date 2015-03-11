DROP TABLE IF EXISTS recipes;

CREATE TABLE recipes
(
  id SERIAL PRIMARY KEY,
  name varchar(100) NOT NULL
);
