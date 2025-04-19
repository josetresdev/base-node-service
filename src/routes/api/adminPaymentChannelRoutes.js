const express = require('express');
const router = express.Router();

const paymentChannelController = require('../../controllers/admin/paymentChannelController');

/**
 * ================================
 * ADMIN ROUTES - Payment Channels
 * ================================
 */

/**
 * @swagger
 * tags:
 *   name: Admin Payment Channels
 *   description: Endpoints de administración para gestionar los canales de pago
 */

/**
 * @swagger
 * /api/admin/payment-channels:
 *   get:
 *     summary: Obtener canales de pago paginados
 *     tags: [Admin Payment Channels]
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
 *           enum: [payment_channel_id, name, is_active, created_at, updated_at]
 *           default: created_at
 *       - in: query
 *         name: order
 *         schema:
 *           type: string
 *           enum: [ASC, DESC]
 *           default: DESC
 *     responses:
 *       200:
 *         description: Lista paginada de canales de pago
 *       400:
 *         description: Parámetros inválidos
 *       500:
 *         description: Error interno del servidor
 */
router.get('/', paymentChannelController.getPaymentChannelsPaginated);

/**
 * @swagger
 * /api/admin/payment-channels/all:
 *   get:
 *     summary: Obtener todos los canales de pago (sin paginación)
 *     tags: [Admin Payment Channels]
 *     responses:
 *       200:
 *         description: Lista completa de canales de pago
 *       500:
 *         description: Error interno del servidor
 */
router.get('/all', paymentChannelController.getAllPaymentChannels);

/**
 * @swagger
 * /api/admin/payment-channels/{id}/restore:
 *   patch:
 *     summary: Restaurar un canal de pago eliminado
 *     tags: [Admin Payment Channels]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *           format: uuid
 *     responses:
 *       200:
 *         description: Canal de pago restaurado correctamente
 *       400:
 *         description: ID inválido
 *       404:
 *         description: Canal de pago no encontrado o no eliminado
 *       500:
 *         description: Error interno del servidor
 */
router.patch('/:id/restore', paymentChannelController.restorePaymentChannel);

/**
 * @swagger
 * /api/admin/payment-channels/{id}:
 *   get:
 *     summary: Obtener un canal de pago por ID
 *     tags: [Admin Payment Channels]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *           format: uuid
 *     responses:
 *       200:
 *         description: Canal de pago encontrado
 *       400:
 *         description: ID inválido
 *       404:
 *         description: Canal de pago no encontrado
 *       500:
 *         description: Error interno del servidor
 */
router.get('/:id', paymentChannelController.getPaymentChannelById);

/**
 * @swagger
 * /api/admin/payment-channels:
 *   post:
 *     summary: Crear un nuevo canal de pago
 *     tags: [Admin Payment Channels]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - payment_method_id
 *               - name
 *             properties:
 *               payment_method_id:
 *                 type: string
 *                 format: uuid
 *                 example: "uuid-method-id"
 *               name:
 *                 type: string
 *                 example: "Visa"
 *               description:
 *                 type: string
 *                 example: "Canal de pago con tarjeta Visa"
 *               is_active:
 *                 type: boolean
 *                 example: true
 *     responses:
 *       201:
 *         description: Canal de pago creado correctamente
 *       400:
 *         description: Datos inválidos
 *       500:
 *         description: Error interno del servidor
 */
router.post('/', paymentChannelController.createPaymentChannel);

/**
 * @swagger
 * /api/admin/payment-channels/{id}:
 *   put:
 *     summary: Actualizar un canal de pago existente
 *     tags: [Admin Payment Channels]
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
 *               payment_method_id:
 *                 type: string
 *                 format: uuid
 *                 example: "uuid-method-id"
 *               name:
 *                 type: string
 *                 example: "Mastercard Updated"
 *               description:
 *                 type: string
 *                 example: "Descripción actualizada"
 *               is_active:
 *                 type: boolean
 *                 example: false
 *     responses:
 *       200:
 *         description: Canal de pago actualizado correctamente
 *       400:
 *         description: Datos inválidos
 *       404:
 *         description: Canal de pago no encontrado
 *       500:
 *         description: Error interno del servidor
 */
router.put('/:id', paymentChannelController.updatePaymentChannel);

/**
 * @swagger
 * /api/admin/payment-channels/{id}:
 *   delete:
 *     summary: Eliminar un canal de pago (soft delete)
 *     tags: [Admin Payment Channels]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *           format: uuid
 *     responses:
 *       200:
 *         description: Canal de pago eliminado correctamente
 *       400:
 *         description: ID inválido
 *       404:
 *         description: Canal de pago no encontrado
 *       500:
 *         description: Error interno del servidor
 */
router.delete('/:id', paymentChannelController.deletePaymentChannel);

module.exports = router;
