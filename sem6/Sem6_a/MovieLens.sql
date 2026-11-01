CREATE DATABASE IF NOT EXISTS movielens_dwh;
USE movielens_dwh;

CREATE TABLE dim_user (
    user_key        INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id         INT NOT NULL,
    gender          CHAR(1),
    age             INT,
    age_group       VARCHAR(45),
    occupation      VARCHAR(255),
    zip_code        VARCHAR(255)
);

CREATE TABLE dim_movie (
    movie_key       INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    movie_id        INT NOT NULL,
    title           VARCHAR(255),
    release_year    CHAR(4)
);

CREATE TABLE dim_genre (
    genre_key       INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    genre_id        INT NOT NULL,
    name            VARCHAR(255)
);

CREATE TABLE dim_date (
    date_key        INT NOT NULL PRIMARY KEY,
    full_date       DATE NOT NULL,
    day             INT,
    month           INT,
    month_name      VARCHAR(20),
    quarter         INT,
    year            INT,
    day_of_week     INT
);

CREATE TABLE bridge_movie_genre (
    movie_key       INT NOT NULL,
    genre_key       INT NOT NULL,
    PRIMARY KEY (movie_key, genre_key),
    CONSTRAINT fk_bridge_movie FOREIGN KEY (movie_key) REFERENCES dim_movie(movie_key),
    CONSTRAINT fk_bridge_genre FOREIGN KEY (genre_key) REFERENCES dim_genre(genre_key)
);

CREATE TABLE fact_ratings (
    rating_id       INT NOT NULL PRIMARY KEY,
    user_key        INT NOT NULL,
    movie_key       INT NOT NULL,
    date_key        INT NOT NULL,
    rating          INT NOT NULL,
    CONSTRAINT fk_ratings_user  FOREIGN KEY (user_key)  REFERENCES dim_user(user_key),
    CONSTRAINT fk_ratings_movie FOREIGN KEY (movie_key) REFERENCES dim_movie(movie_key),
    CONSTRAINT fk_ratings_date  FOREIGN KEY (date_key)  REFERENCES dim_date(date_key)
);

CREATE TABLE fact_tags (
    tag_id          INT NOT NULL PRIMARY KEY,
    user_key        INT NOT NULL,
    movie_key       INT NOT NULL,
    date_key        INT NOT NULL,
    tag             VARCHAR(4000),
    CONSTRAINT fk_tags_user  FOREIGN KEY (user_key)  REFERENCES dim_user(user_key),
    CONSTRAINT fk_tags_movie FOREIGN KEY (movie_key) REFERENCES dim_movie(movie_key),
    CONSTRAINT fk_tags_date  FOREIGN KEY (date_key)  REFERENCES dim_date(date_key)
);