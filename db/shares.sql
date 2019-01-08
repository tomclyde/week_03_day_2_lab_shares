DROP TABLE IF EXISTS shares;

CREATE TABLE shares (
  id SERIAL8 PRIMARY KEY,
  company VARCHAR(255),
  price INT2,
  volume INT,
  rating VARCHAR(255)
);
