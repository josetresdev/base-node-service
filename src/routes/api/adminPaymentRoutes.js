const express = require('express');
const router = express.Router();

const paymentController = require('../../controllers/admin/paymentController');

/**
 * ================================
 * ADMIN ROUTES - Payments
 * ================================
 */

/**
 * @swagger
 * tags:
 *   name: Admin Payments
 *   description: Endpoints de administración para gestionar los pagos
 */

/**
 * @swagger
 * /api/admin/payments:
 *   get:
 *     summary: Obtener pagos paginados
 *     tags: [Admin Payments]
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
 *           enum: [id, amount, currency, payment_date, created_at, updated_at]
 *           default: created_at
 *       - in: query
 *         name: order
 *         schema:
 *           type: string
 *           enum: [ASC, DESC]
 *           default: DESC
 *     responses:
 *       200:
 *         description: Lista paginada de pagos
 *       500:
 *         description: Error interno del servidor
 */
router.get('/', paymentController.getPaymentsPaginated);

/**
 * @swagger
 * /api/admin/payments/all:
 *   get:
 *     summary: Obtener todos los pagos (sin paginación)
 *     tags: [Admin Payments]
 *     responses:
 *       200:
 *         description: Lista completa de pagos
 *       500:
 *         description: Error interno del servidor
 */
router.get('/all', paymentController.getAllPayments);

/**
 * @swagger
 * /api/admin/payments/{id}:
 *   get:
 *     summary: Obtener un pago por ID
 *     tags: [Admin Payments]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *           format: uuid
 *     responses:
 *       200:
 *         description: Pago encontrado
 *       404:
 *         description: Pago no encontrado
 */
router.get('/:id', paymentController.getPaymentById);

/**
 * @swagger
 * /api/admin/payments:
 *   post:
 *     summary: Crear un nuevo pago manualmente (admin)
 *     tags: [Admin Payments]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - payment_method_id
 *               - payment_channel_id
 *               - payment_status_id
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
 *               payment_status_id:
 *                 type: integer
 *                 example: 1
 *               amount:
 *                 type: number
 *                 example: 150.75
 *               currency:
 *                 type: string
 *                 example: "USD"
 *               transaction_reference:
 *                 type: string
 *                 example: "TXN123456"
 *               payment_method_details:
 *                 type: string
 *                 example: "Last 4 digits 1234"
 *               is_successful:
 *                 type: boolean
 *                 example: true
 *               failure_reason:
 *                 type: string
 *                 example: "Insufficient funds"
 *     responses:
 *       201:
 *         description: Pago creado correctamente
 *       400:
 *         description: Datos inválidos
 *       500:
 *         description: Error interno del servidor
 */
router.post('/', paymentController.createPayment);

/**
 * @swagger
 * /api/admin/payments/{id}:
 *   put:
 *     summary: Actualizar un pago existente
 *     tags: [Admin Payments]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *           format: uuid
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               payment_status_id:
 *                 type: integer
 *                 example: 2
 *               payment_method_details:
 *                 type: string
 *                 example: "Updated details"
 *               is_successful:
 *                 type: boolean
 *                 example: false
 *               failure_reason:
 *                 type: string
 *                 example: "Payment gateway error"
 *     responses:
 *       200:
 *         description: Pago actualizado correctamente
 *       400:
 *         description: Datos inválidos
 *       404:
 *         description: Pago no encontrado
 */
router.put('/:id', paymentController.updatePayment);

/**
 * @swagger
 * /api/admin/payments/{id}:
 *   delete:
 *     summary: Eliminar un pago (soft delete)
 *     tags: [Admin Payments]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *           format: uuid
 *     responses:
 *       200:
 *         description: Pago eliminado correctamente
 *       404:
 *         description: Pago no encontrado
 */
router.delete('/:id', paymentController.deletePayment);

/**
 * @swagger
 * /api/admin/payments/{id}/restore:
 *   patch:
 *     summary: Restaurar un pago eliminado
 *     tags: [Admin Payments]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *           format: uuid
 *     responses:
 *       200:
 *         description: Pago restaurado correctamente
 *       404:
 *         description: Pago no encontrado o no eliminado
 */
router.patch('/:id/restore', paymentController.restorePayment);

module.exports = router;
