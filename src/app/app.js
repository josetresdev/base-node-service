require('dotenv').config();
const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
const path = require('path');
const { apiRouter, webRouter } = require('../routes');
const swaggerRoutes = require('../routes/swaggerRoutes');
const attachRequestId = require('../config/middlewares/requestId');
const errorHandler = require('../config/middlewares/errorHandler');

const app = express();

const NODE_ENV = process.env.NODE_ENV || 'development';
const PORT = process.env.PORT || 3001;
const APP_URL = process.env.APP_URL || `http://localhost:${PORT}`;

// Middlewares
app.use(cors());
app.use(express.json());
app.use(attachRequestId); // ✅ no ejecutar la función, solo pasar la referencia

if (NODE_ENV === 'development') {
app.use(morgan('dev'));
}

// Archivos estáticos
const publicViewsPath = path.join(__dirname, '../web/public/views');
const publicAssetsPath = path.join(__dirname, '../web/public');
app.use(express.static(publicViewsPath));
app.use(express.static(publicAssetsPath));

// Rutas
app.use('/', swaggerRoutes);
app.use('/api', apiRouter);
app.use('/', webRouter);

// 404 Not Found
app.use((req, res) => {
const requestId = req.requestId;
return res.status(404).json({
    success: false,
    message: 'Ruta no encontrada',
    statusCode: 404,
    errorCode: 'ROUTE_NOT_FOUND',
    data: null,
    meta: null,
    timestamp: new Date().toISOString(),
    requestId
});
});

// Error handler global
app.use(errorHandler);

// 🔍 Limpieza de rutas para logs
const cleanPathPart = (regexpSource) => {
return regexpSource
    ?.replace(/^\^\\\//, '/')
    ?.replace(/\\\/$/, '')
    ?.replace(/\\\//g, '/')
    ?.replace(/\(\?:\(\[\^\\\/]\+\?\)\)/g, ':param')
    ?.replace(/\?\(\?=\/\|\$\)/, '')
    ?.replace(/^\^/, '') || '';
};

// 🔎 Función para listar rutas
const listRoutes = (stack, basePath = '', prefixFilter = null) => {
const routes = [];

const extract = (stack, base = '') => {
    if (!Array.isArray(stack)) return;

    stack.forEach(layer => {
    if (layer.route) {
        const methods = Object.keys(layer.route.methods).map(m => m.toUpperCase());
        routes.push(`[${methods.join(', ')}] ${APP_URL}${base}${layer.route.path}`.replace(/\/+/g, '/'));
    } else if (layer.name === 'router' && layer.handle?.stack) {
        const pathPart = cleanPathPart(layer.regexp?.source);
        extract(layer.handle.stack, `${base}${pathPart}`);
    }
    });
};

stack.forEach(layer => {
    const path = layer?.regexp?.source;
    const isApi = prefixFilter === 'api';

    if ((isApi && path?.startsWith('^\\/api')) || (!isApi && (!path || !path.startsWith('^\\/api')))) {
    if (layer.handle?.stack) {
        extract(layer.handle.stack, isApi ? '/api' : '');
    }
    }
});

return routes;
};

module.exports = {
app,
listApiRoutes: () => listRoutes(app._router.stack, '', 'api'),
listWebRoutes: () => listRoutes(app._router.stack, '', 'web')
};
