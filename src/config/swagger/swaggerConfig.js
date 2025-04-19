const swaggerJSDoc = require('swagger-jsdoc');

const options = {
definition: {
    openapi: '3.0.0',
    info: {
    title: 'TrebolDrinks API',
    version: '1.0.0',
    description: 'Documentación de la API de TrebolDrinks 🚀',
    contact: {
        name: 'Soporte TrebolDrinks',
        email: 'soporte@treboldrinks.com',
    },
    },
    servers: [
    {
        url: process.env.APP_URL || `http://localhost:${process.env.PORT || 3000}`,
        description: 'Servidor de desarrollo',
    },
    ],
    components: {
    securitySchemes: {
        bearerAuth: {
        type: 'http',
        scheme: 'bearer',
        bearerFormat: 'JWT',
        },
    },
    },
},
apis: [
    './src/routes/api/*.js', // Documentación de rutas api admin/client
    './src/controllers/**/*.js', // Opcional si documentas desde controladores
],
};

const swaggerSpec = swaggerJSDoc(options);

module.exports = swaggerSpec;
