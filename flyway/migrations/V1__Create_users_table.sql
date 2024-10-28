-- sql/V1__Create_users_table.sql
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    nome VARCHAR(255),
    cognome VARCHAR(255),
    username VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    password_hash VARCHAR(255),
    role VARCHAR(50),
    status VARCHAR(50),
    session_token VARCHAR(255),
    jwt_token TEXT,
    two_factor_enabled BOOLEAN,
    profile_picture VARCHAR(255)
);
