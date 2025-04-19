const express = require('express');
const router = express.Router();

const paymentStatusController = require('../../controllers/admin/paymentStatusController');

/**
 * ================================
 * ADMIN ROUTES - Payment Status
 * ================================
 */

/**
 * @swagger
 * tags:
 *   name: Admin Payment Status
 *   description: Endpoints para la gestión de estados de pago por el administrador
 */

/**
 * @swagger
 * /api/admin/payment-status:
 *   get:
 *     summary: Obtener estados de pago paginados
 *     tags: [Admin Payment Status]
 *     parameters:
 *       - in: query
 *         name: page
 *         schema:
 *           type: integer
 *           default: 1
 *         description: Página actual
 *       - in: query
 *         name: perPage
 *         schema:
 *           type: integer
 *           default: 10
 *         description: Registros por página
 *       - in: query
 *         name: sortBy
 *         schema:
 *           type: string
 *           default: created_at
 *         description: Campo por el cual ordenar
 *       - in: query
 *         name: order
 *         schema:
 *           type: string
 *           enum: [ASC, DESC]
 *           default: DESC
 *         description: Orden de los resultados
 *     responses:
 *       200:
 *         description: Estados de pago obtenidos correctamente
 *       500:
 *         description: Error interno del servidor
 */
router.get('/', paymentStatusController.getPaymentStatusesPaginated);

/**
 * @swagger
 * /api/admin/payment-status/all:
 *   get:
 *     summary: Obtener todos los estados de pago (sin paginación)
 *     tags: [Admin Payment Status]
 *     responses:
 *       200:
 *         description: Lista completa de estados de pago
 *       500:
 *         description: Error interno del servidor
 */
router.get('/all', paymentStatusController.getAllPaymentStatuses);

/**
 * @swagger
 * /api/admin/payment-status/{id}:
 *   get:
 *     summary: Obtener un estado de pago por su ID
 *     tags: [Admin Payment Status]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID del estado de pago
 *     responses:
 *       200:
 *         description: Estado de pago obtenido correctamente
 *       404:
 *         description: Estado de pago no encontrado
 *       500:
 *         description: Error interno del servidor
 */
router.get('/:id', paymentStatusController.getPaymentStatusById);

/**
 * @swagger
 * /api/admin/payment-status:
 *   post:
 *     summary: Crear un nuevo estado de pago
 *     tags: [Admin Payment Status]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - status_name
 *               - status_key
 *             properties:
 *               status_name:
 *                 type: string
 *               status_key:
 *                 type: string
 *               description:
 *                 type: string
 *               is_active:
 *                 type: boolean
 *     responses:
 *       201:
 *         description: Estado de pago creado correctamente
 *       400:
 *         description: Error de validación
 *       500:
 *         description: Error interno del servidor
 */
router.post('/', paymentStatusController.createPaymentStatus);

/**
 * @swagger
 * /api/admin/payment-status/{id}:
 *   put:
 *     summary: Actualizar un estado de pago existente
 *     tags: [Admin Payment Status]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               status_name:
 *                 type: string
 *               status_key:
 *                 type: string
 *               description:
 *                 type: string
 *               is_active:
 *                 type: boolean
 *     responses:
 *       200:
 *         description: Estado de pago actualizado correctamente
 *       404:
 *         description: Estado de pago no encontrado
 *       500:
 *         description: Error interno del servidor
 */
router.put('/:id', paymentStatusController.updatePaymentStatus);

/**
 * @swagger
 * /api/admin/payment-status/{id}:
 *   delete:
 *     summary: Eliminar (soft delete) un estado de pago
 *     tags: [Admin Payment Status]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Estado de pago eliminado correctamente
 *       404:
 *         description: Estado de pago no encontrado
 *       500:
 *         description: Error interno del servidor
 */
router.delete('/:id', paymentStatusController.deletePaymentStatus);

/**
 * @swagger
 * /api/admin/payment-status/{id}/restore:
 *   patch:
 *     summary: Restaurar un estado de pago eliminado (soft restore)
 *     tags: [Admin Payment Status]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Estado de pago restaurado correctamente
 *       404:
 *         description: Estado de pago no encontrado o no eliminado
 *       500:
 *         description: Error interno del servidor
 */
router.patch('/:id/restore', paymentStatusController.restorePaymentStatus);

module.exports = router;
