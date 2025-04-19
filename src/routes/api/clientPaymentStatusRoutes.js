const express = require('express');
const router = express.Router();

const paymentStatusController = require('../../controllers/client/paymentStatusController');

/**
 * ================================
 * CLIENT ROUTES - Payment Status
 * ================================
 */

/**
 * @swagger
 * tags:
 *   name: Client Payment Status
 *   description: Endpoints públicos para consultar estados de pago
 */

/**
 * @swagger
 * /api/client/payment-status:
 *   get:
 *     summary: Obtener estados de pago activos (paginado)
 *     tags: [Client Payment Status]
 *     parameters:
 *       - in: query
 *         name: page
 *         schema:
 *           type: integer
 *           default: 1
 *       - in: query
 *         name: perPage
 *         schema:
 *           type: integer
 *           default: 10
 *       - in: query
 *         name: sortBy
 *         schema:
 *           type: string
 *           default: created_at
 *       - in: query
 *         name: order
 *         schema:
 *           type: string
 *           enum: [ASC, DESC]
 *           default: ASC
 *     responses:
 *       200:
 *         description: Lista de estados de pago activos obtenida exitosamente
 *       500:
 *         description: Error interno del servidor
 */
router.get('/', paymentStatusController.getActivePaymentStatuses);

/**
 * @swagger
 * /api/client/payment-status/{status_key}:
 *   get:
 *     summary: Obtener un estado de pago activo por clave (status_key)
 *     tags: [Client Payment Status]
 *     parameters:
 *       - in: path
 *         name: status_key
 *         required: true
 *         schema:
 *           type: string
 *         description: Clave del estado de pago
 *     responses:
 *       200:
 *         description: Estado de pago obtenido exitosamente
 *       400:
 *         description: Clave inválida
 *       404:
 *         description: Estado de pago no encontrado
 *       500:
 *         description: Error interno del servidor
 */
router.get('/:status_key', paymentStatusController.getPaymentStatusByKey);

module.exports = router;
