const { Sequelize } = require('sequelize');
require('dotenv').config();

console.log('⛳ Variables de entorno:', {
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    user: process.env.DB_USER,
    pass: process.env.DB_PASS,
    name: process.env.DB_NAME
});

const sequelize = new Sequelize(
    process.env.DB_NAME,
    process.env.DB_USER,
    process.env.DB_PASS,
    {
        host: process.env.DB_HOST,
        port: Number(process.env.DB_PORT),
        dialect: process.env.DB_DIALECT,
        logging: process.env.NODE_ENV === 'development' ? console.log : false,
    }
);

const connectDB = async () => {
    try {
        await sequelize.authenticate();
        console.log('✅ Conexión a la base de datos establecida con éxito.');
        await sequelize.sync({ force: false, alter: false });
    } catch (error) {
        console.error('❌ Error al conectar con la base de datos:', error);
        process.exit(1);
    }
};

module.exports = { sequelize, connectDB };
