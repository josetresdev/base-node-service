const express = require('express');
const router = express.Router();
const orderStatusController = require('../../controllers/client/orderStatusController');

/**
 * ================================
 * CLIENT ROUTES - OrderStatus
 * ================================
 */

/**
 * @swagger
 * tags:
 *   name: Client OrderStatus
 *   description: Estados de orden visibles para el cliente (activos)
 */

/**
 * @swagger
 * /api/client/order-statuses:
 *   get:
 *     summary: Obtener estados de orden activos
 *     tags: [Client OrderStatus]
 *     description: Devuelve todos los estados de orden activos que el cliente puede ver (sin paginación)
 *     responses:
 *       200:
 *         description: Lista de estados activos
 *       500:
 *         description: Error interno
 */
router.get('/', orderStatusController.getActiveOrderStatuses);

module.exports = router;
