CREATE DATABASE IF NOT EXISTS chinook_dwh;
USE chinook_dwh;

CREATE TABLE dim_customer (
    customer_key    INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id     INT NOT NULL,
    first_name      VARCHAR(40),
    last_name       VARCHAR(20),
    company         VARCHAR(80),
    address         VARCHAR(70),
    city            VARCHAR(40),
    state           VARCHAR(40),
    country         VARCHAR(40),
    postal_code     VARCHAR(10),
    phone           VARCHAR(24),
    fax             VARCHAR(24),
    email           VARCHAR(60)
);

CREATE TABLE dim_employee (
    employee_key    INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    employee_id     INT NOT NULL,
    first_name      VARCHAR(20),
    last_name       VARCHAR(20),
    title           VARCHAR(30),
    reports_to      INT,
    birth_date      DATETIME,
    hire_date       DATETIME,
    city            VARCHAR(40),
    state           VARCHAR(40),
    country         VARCHAR(40),
    email           VARCHAR(60)
);

CREATE TABLE dim_track (
    track_key       INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    track_id        INT NOT NULL,
    track_name      VARCHAR(200),
    composer        VARCHAR(220),
    milliseconds    INT,
    bytes           INT,
    unit_price      DECIMAL(10,2),
    album_title     VARCHAR(160),
    artist_name     VARCHAR(120),
    genre_name      VARCHAR(120),
    media_type_name VARCHAR(120)
);

CREATE TABLE dim_playlist (
    playlist_key    INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    playlist_id     INT NOT NULL,
    name            VARCHAR(120)
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


CREATE TABLE bridge_playlist_track (
    playlist_key    INT NOT NULL,
    track_key       INT NOT NULL,
    PRIMARY KEY (playlist_key, track_key),
    CONSTRAINT fk_bridge_playlist FOREIGN KEY (playlist_key) REFERENCES dim_playlist(playlist_key),
    CONSTRAINT fk_bridge_track    FOREIGN KEY (track_key)    REFERENCES dim_track(track_key)
);


CREATE TABLE fact_invoice_line (
    invoice_line_id INT NOT NULL PRIMARY KEY,
    invoice_id      INT NOT NULL,               
    customer_key    INT NOT NULL,
    employee_key    INT,                        
    track_key       INT NOT NULL,
    date_key        INT NOT NULL,
    billing_city    VARCHAR(40),
    billing_country VARCHAR(40),
    unit_price      DECIMAL(10,2) NOT NULL,     
    quantity        INT NOT NULL,               
    line_total      DECIMAL(10,2) NOT NULL,     
    CONSTRAINT fk_fact_customer FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key),
    CONSTRAINT fk_fact_employee FOREIGN KEY (employee_key) REFERENCES dim_employee(employee_key),
    CONSTRAINT fk_fact_track    FOREIGN KEY (track_key)    REFERENCES dim_track(track_key),
    CONSTRAINT fk_fact_date     FOREIGN KEY (date_key)     REFERENCES dim_date(date_key)
);