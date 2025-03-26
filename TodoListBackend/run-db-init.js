import fs from 'fs';
import pkg from 'pg';
import dotenv from 'dotenv';

dotenv.config();
const { Pool } = pkg;

// Подключение к базе данных
const pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT,
});

async function initDatabase() {
    try {
        // Чтение SQL-скрипта
        const sqlScript = fs.readFileSync('./db_init.sql', 'utf8');
        
        // Выполнение SQL-скрипта
        const result = await pool.query(sqlScript);
        
        console.log('База данных успешно инициализирована!');
        console.log(result[result.length - 1].rows[0].message);
        
        // Закрытие соединения
        await pool.end();
    } catch (error) {
        console.error('Ошибка при инициализации базы данных:', error);
        process.exit(1);
    }
}

// Запуск инициализации
initDatabase(); 