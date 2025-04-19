// Centraliza los imports de routers sin perder modularidad
const apiRouter = require('./api');
const webRouter = require('./web');

// Exporta los routers para ser usados en app.js
module.exports = {
    apiRouter,
    webRouter
};
