const express = require('express');
const router = express.Router();

const paymentMethodController = require('../../controllers/admin/paymentMethodController');

/**
 * ================================
 * ADMIN ROUTES - Payment Methods
 * ================================
 */

/**
 * @swagger
 * tags:
 *   name: Admin Payment Methods
 *   description: Endpoints de administración para gestionar los métodos de pago
 */

/**
 * @swagger
 * /api/admin/payment-methods:
 *   get:
 *     summary: Obtener métodos de pago paginados
 *     tags: [Admin Payment Methods]
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
 *           enum: [payment_method_id, name, method_key, created_at, updated_at]
 *           default: created_at
 *       - in: query
 *         name: order
 *         schema:
 *           type: string
 *           enum: [ASC, DESC]
 *           default: DESC
 *     responses:
 *       200:
 *         description: Lista paginada de métodos de pago
 *       400:
 *         description: Parámetros inválidos
 *       500:
 *         description: Error interno del servidor
 */
router.get('/', paymentMethodController.getPaymentMethodsPaginated);

/**
 * @swagger
 * /api/admin/payment-methods/all:
 *   get:
 *     summary: Obtener todos los métodos de pago (sin paginación)
 *     tags: [Admin Payment Methods]
 *     responses:
 *       200:
 *         description: Lista completa de métodos de pago
 *       500:
 *         description: Error interno del servidor
 */
router.get('/all', paymentMethodController.getAllPaymentMethods);

/**
 * @swagger
 * /api/admin/payment-methods/{id}/restore:
 *   patch:
 *     summary: Restaurar un método de pago eliminado
 *     tags: [Admin Payment Methods]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *           format: uuid
 *     responses:
 *       200:
 *         description: Método de pago restaurado correctamente
 *       400:
 *         description: ID inválido
 *       404:
 *         description: Método de pago no encontrado o no eliminado
 *       500:
 *         description: Error interno del servidor
 */
router.patch('/:id/restore', paymentMethodController.restorePaymentMethod);

/**
 * @swagger
 * /api/admin/payment-methods/{id}:
 *   get:
 *     summary: Obtener un método de pago por ID
 *     tags: [Admin Payment Methods]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *           format: uuid
 *     responses:
 *       200:
 *         description: Método de pago encontrado
 *       400:
 *         description: ID inválido
 *       404:
 *         description: Método de pago no encontrado
 *       500:
 *         description: Error interno del servidor
 */
router.get('/:id', paymentMethodController.getPaymentMethodById);

/**
 * @swagger
 * /api/admin/payment-methods:
 *   post:
 *     summary: Crear un nuevo método de pago
 *     tags: [Admin Payment Methods]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - name
 *               - method_key
 *             properties:
 *               name:
 *                 type: string
 *                 example: "PayPal"
 *               method_key:
 *                 type: string
 *                 example: "paypal"
 *               place_holder:
 *                 type: string
 *                 example: "Correo electrónico de PayPal"
 *               description:
 *                 type: string
 *                 example: "Pago seguro vía PayPal"
 *               is_active:
 *                 type: boolean
 *                 example: true
 *     responses:
 *       201:
 *         description: Método de pago creado correctamente
 *       400:
 *         description: Datos inválidos
 *       500:
 *         description: Error interno del servidor
 */
router.post('/', paymentMethodController.createPaymentMethod);

/**
 * @swagger
 * /api/admin/payment-methods/{id}:
 *   put:
 *     summary: Actualizar un método de pago existente
 *     tags: [Admin Payment Methods]
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
 *               name:
 *                 type: string
 *                 example: "PayPal Updated"
 *               method_key:
 *                 type: string
 *                 example: "paypal"
 *               place_holder:
 *                 type: string
 *                 example: "Nuevo placeholder"
 *               description:
 *                 type: string
 *                 example: "Descripción actualizada"
 *               is_active:
 *                 type: boolean
 *                 example: false
 *     responses:
 *       200:
 *         description: Método de pago actualizado correctamente
 *       400:
 *         description: Datos inválidos
 *       404:
 *         description: Método de pago no encontrado
 *       500:
 *         description: Error interno del servidor
 */
router.put('/:id', paymentMethodController.updatePaymentMethod);

/**
 * @swagger
 * /api/admin/payment-methods/{id}:
 *   delete:
 *     summary: Eliminar un método de pago (soft delete)
 *     tags: [Admin Payment Methods]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *           format: uuid
 *     responses:
 *       200:
 *         description: Método de pago eliminado correctamente
 *       400:
 *         description: ID inválido
 *       404:
 *         description: Método de pago no encontrado
 *       500:
 *         description: Error interno del servidor
 */
router.delete('/:id', paymentMethodController.deletePaymentMethod);

module.exports = router;
