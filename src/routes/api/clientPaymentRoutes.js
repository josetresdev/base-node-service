const express = require('express');
const router = express.Router();

const paymentController = require('../../controllers/client/paymentController');

/**
 * ================================
 * CLIENT ROUTES - Payments
 * ================================
 */

/**
 * @swagger
 * tags:
 *   name: Client Payments
 *   description: Endpoints públicos para que el cliente gestione sus pagos
 */

/**
 * @swagger
 * /api/client/payments:
 *   get:
 *     summary: Obtener todos los pagos del cliente autenticado
 *     tags: [Client Payments]
 *     description: Retorna el historial de pagos del cliente autenticado (con paginación opcional)
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
 *           enum: [payment_date, amount, created_at]
 *           default: payment_date
 *       - in: query
 *         name: order
 *         schema:
 *           type: string
 *           enum: [ASC, DESC]
 *           default: DESC
 *     responses:
 *       200:
 *         description: Historial de pagos obtenido correctamente
 *       400:
 *         description: Parámetros inválidos
 *       500:
 *         description: Error interno del servidor
 */
router.get('/', paymentController.getClientPayments);

/**
 * @swagger
 * /api/client/payments/{id}:
 *   get:
 *     summary: Obtener el detalle de un pago del cliente autenticado
 *     tags: [Client Payments]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: ID del pago a consultar
 *         schema:
 *           type: string
 *           format: uuid
 *     responses:
 *       200:
 *         description: Detalle del pago obtenido correctamente
 *       404:
 *         description: Pago no encontrado o no pertenece al cliente autenticado
 *       400:
 *         description: ID de pago inválido
 */
router.get('/:id', paymentController.getClientPaymentById);

/**
 * @swagger
 * /api/client/payments:
 *   post:
 *     summary: Registrar un nuevo pago desde el cliente (checkout)
 *     tags: [Client Payments]
 *     description: Permite al cliente iniciar un nuevo pago (checkout)
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - payment_method_id
 *               - payment_channel_id
 *               - amount
 *             properties:
 *               payment_method_id:
 *                 type: string
 *                 format: uuid
 *                 example: "uuid-method-id"
 *               payment_channel_id:
 *                 type: string
 *                 format: uuid
 *                 example: "uuid-channel-id"
 *               amount:
 *                 type: number
 *                 example: 100.50
 *               currency:
 *                 type: string
 *                 example: "USD"
 *               transaction_reference:
 *                 type: string
 *                 example: "TXN987654"
 *               payment_method_details:
 *                 type: string
 *                 example: "Last 4 digits 4321"
 *     responses:
 *       201:
 *         description: Pago creado correctamente
 *       400:
 *         description: Datos inválidos
 *       500:
 *         description: Error interno del servidor
 */
router.post('/', paymentController.createClientPayment);

/**
 * @swagger
 * /api/client/payments/{id}/cancel:
 *   patch:
 *     summary: Cancelar un pago iniciado por el cliente
 *     tags: [Client Payments]
 *     description: Permite al cliente cancelar un pago en estado pendiente
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: ID del pago a cancelar
 *         schema:
 *           type: string
 *           format: uuid
 *     responses:
 *       200:
 *         description: Pago cancelado correctamente
 *       400:
 *         description: No se puede cancelar este pago
 *       404:
 *         description: Pago no encontrado
 */
router.patch('/:id/cancel', paymentController.cancelPayment);

module.exports = router;
