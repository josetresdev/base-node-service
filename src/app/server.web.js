require('dotenv').config();
const { app, listWebRoutes } = require('./app');
const { connectDB } = require('../config/database/database');

const PORT = process.env.PORT || 3001; // Puerto exclusivo para Web
const APP_NAME = process.env.APP_NAME || 'TrebolDrinks Web';

(async () => {
try {
    await connectDB();
    app.listen(PORT, () => {
    console.log(`\n🎨 Frontend corriendo en http://localhost:${PORT}\n`);
    listWebRoutes().forEach(route => console.log(`🔍 ${route}`));
    });
} catch (err) {
    console.error('❌ Error al iniciar Web:', err);
    process.exit(1);
}
})();
