CREATE TABLE simulation_results (
    user_id INT,
    result_id INT PRIMARY KEY,
    simulation_name VARCHAR(255),
    count INT,
    grid_size VARCHAR(50),
    initial_state TEXT,
    final_state TEXT,
    completed BOOLEAN,
    status VARCHAR(50),
    creation_date TIMESTAMP,
    media_url TEXT,
    input_parameters JSONB,
    ai_predictions JSONB
);
