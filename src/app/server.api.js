require('dotenv').config();
const { app, listApiRoutes } = require('./app');
const { connectDB } = require('../config/database/database');

const PORT = process.env.PORT || 3005;
const APP_NAME = process.env.APP_NAME || 'Base Service API';

(async () => {
try {
    await connectDB();
    app.listen(PORT, () => {
    console.log(`\n🚀 API corriendo en http://localhost:${PORT}\n`);
    listApiRoutes().forEach(route => console.log(`📌 ${route}`));
    });
} catch (err) {
    console.error('❌ Error al iniciar API:', err);
    process.exit(1);
}
})();
