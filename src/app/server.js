require('dotenv').config();
const { app, listApiRoutes, listWebRoutes } = require('./app');
const { connectDB } = require('../config/database/database');

// 🌍 Variables de entorno
const PORT = process.env.PORT || 3001;
const APP_NAME = process.env.APP_NAME || 'TrebolDrinks';
const APP_URL = process.env.APP_URL || `http://localhost:${PORT}`;
const NODE_ENV = process.env.NODE_ENV || 'development';

(async () => {
    try {
        // 🔌 Conectar a la base de datos
        await connectDB();

        // 🚀 Iniciar el servidor
        app.listen(PORT, (err) => {
            if (err) {
                console.error('❌ Error al iniciar el servidor:', err);
                process.exit(1);
            }

            console.log('-----------------------------------------------------');
            console.log(`🚀 ${APP_NAME} está en marcha! 🎉`);
            console.log(`🌍 Producción: ${APP_URL}`);
            console.log(`🏠 Local:      http://localhost:${PORT}`);
            console.log(`🛠️ Entorno:    ${NODE_ENV}`);
            console.log(`📅 Fecha:      ${new Date().toLocaleString()}`);
            console.log(`🟢 Node.js:    ${process.version}`);
            console.log('-----------------------------------------------------');

            // 🔗 Mostrar rutas de API
            const apiRoutes = listApiRoutes();
            console.log('🔗 Rutas de API:');
            apiRoutes.length > 0
                ? apiRoutes.forEach(route => console.log(route))
                : console.log('⚠️ No se encontraron rutas de API.');

            console.log('-----------------------------------------------------');

            // 🌍 Mostrar rutas Web
            const webRoutes = listWebRoutes();
            console.log('🌍 Rutas Web (Frontend):');
            webRoutes.length > 0
                ? webRoutes.forEach(route => console.log(route))
                : console.log('⚠️ No se encontraron rutas Web.');

            console.log('-----------------------------------------------------');
        });

    } catch (err) {
        console.error('❌ Error al conectar con la base de datos:', err);
        process.exit(1);
    }
})();
