-- Создание таблицы пользователей (если её ещё нет)
CREATE TABLE IF NOT EXISTS usersr (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Создание таблицы задач
CREATE TABLE IF NOT EXISTS tasksr (
    id SERIAL PRIMARY KEY,
    text TEXT NOT NULL,
    ischecked BOOLEAN DEFAULT FALSE,
    userId INTEGER REFERENCES usersr(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Создание индекса для ускорения поиска задач по пользователю
CREATE INDEX IF NOT EXISTS tasksr_userid_idx ON tasksr(userId);

-- Вывод информации о созданных таблицах
SELECT 'Таблицы usersr и tasksr успешно созданы!' as message; 