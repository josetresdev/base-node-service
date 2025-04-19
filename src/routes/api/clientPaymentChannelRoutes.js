const express = require('express');
const router = express.Router();

const paymentChannelController = require('../../controllers/client/paymentChannelController');

/**
 * ================================
 * CLIENT ROUTES - Payment Channels
 * ================================
 */

/**
 * @swagger
 * tags:
 *   name: Client Payment Channels
 *   description: Endpoints públicos para que el cliente consulte los canales de pago disponibles por método de pago
 */

/**
 * @swagger
 * /api/client/payment-channels:
 *   get:
 *     summary: Obtener los canales de pago activos para el cliente
 */
router.get('/', paymentChannelController.getActivePaymentChannels);

/**
 * @swagger
 * /api/client/payment-channels/by-method/{payment_method_id}:
 *   get:
 *     summary: Obtener los canales de pago activos por método de pago
 */
router.get('/by-method/:payment_method_id', paymentChannelController.getActivePaymentChannelsByPaymentMethodId);

/**
 * @swagger
 * /api/client/payment-channels/{id}:
 *   get:
 *     summary: Obtener un canal de pago activo por ID
 */
router.get('/:id', paymentChannelController.getActivePaymentChannelById);

module.exports = router;
