const express = require('express');
const router = express.Router();

const paymentMethodController = require('../../controllers/client/paymentMethodController');

/**
 * ================================
 * CLIENT ROUTES - Payment Methods
 * ================================
 */

/**
 * @swagger
 * tags:
 *   name: Client Payment Methods
 *   description: Endpoints públicos para que el cliente consulte los métodos de pago disponibles
 */

/**
 * @swagger
 * /api/client/payment-methods:
 *   get:
 *     summary: Obtener los métodos de pago activos para el cliente
 *     tags: [Client Payment Methods]
 *     description: Retorna la lista de métodos de pago activos y disponibles para el cliente (por ejemplo, para el checkout)
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
 *           enum: [payment_method_id, name, created_at, display_order]
 *           default: created_at
 *       - in: query
 *         name: order
 *         schema:
 *           type: string
 *           enum: [ASC, DESC]
 *           default: ASC
 *     responses:
 *       200:
 *         description: Lista de métodos de pago activos obtenida correctamente
 *       400:
 *         description: Parámetros inválidos
 *       500:
 *         description: Error interno del servidor
 */
router.get('/', paymentMethodController.getActivePaymentMethods);

/**
 * @swagger
 * /api/client/payment-methods/key/{method_key}:
 *   get:
 *     summary: Obtener un método de pago activo por clave (key)
 *     tags: [Client Payment Methods]
 *     description: Retorna el método de pago activo correspondiente a la clave (key) enviada
 *     parameters:
 *       - in: path
 *         name: method_key
 *         required: true
 *         schema:
 *           type: string
 *         description: Clave única (key) del método de pago
 *     responses:
 *       200:
 *         description: Método de pago obtenido correctamente
 *       400:
 *         description: Clave inválida
 *       404:
 *         description: Método de pago no encontrado
 *       500:
 *         description: Error interno del servidor
 */
router.get('/key/:method_key', paymentMethodController.getActivePaymentMethodByKey);

/**
 * @swagger
 * /api/client/payment-methods/{id}:
 *   get:
 *     summary: Obtener un método de pago activo por ID
 *     tags: [Client Payment Methods]
 *     description: Retorna el método de pago activo correspondiente al ID enviado
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *           format: uuid
 *         description: ID del método de pago
 *     responses:
 *       200:
 *         description: Método de pago obtenido correctamente
 *       400:
 *         description: ID inválido
 *       404:
 *         description: Método de pago no encontrado
 *       500:
 *         description: Error interno del servidor
 */
router.get('/:id', paymentMethodController.getActivePaymentMethodById);

module.exports = router;
