const express = require('express');
const router = express.Router();

const swaggerUi = require('swagger-ui-express');
const swaggerSpec = require('../config/swagger/swaggerConfig');

// Ruta para acceder a la documentación interactiva
router.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

module.exports = router;
