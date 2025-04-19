const express = require('express');
const router = express.Router();
const orderStatusController = require('../../controllers/admin/orderStatusController');

/**
 * ================================
 * ADMIN ROUTES - OrderStatus
 * ================================
 */

/**
 * @swagger
 * tags:
 *   name: Admin OrderStatus
 *   description: Endpoints de administración para los estados de órdenes
 */

/**
 * @swagger
 * /api/admin/order-statuses:
 *   get:
 *     summary: Obtener estados de orden paginados
 *     tags: [Admin OrderStatus]
 *     parameters:
 *       - in: query
 *         name: page
 *         schema:
 *           type: integer
 *         description: Página actual
 *       - in: query
 *         name: perPage
 *         schema:
 *           type: integer
 *         description: Resultados por página
 *       - in: query
 *         name: sortBy
 *         schema:
 *           type: string
 *           enum: [id, status_name, status_key, is_active, created_at, updated_at]
 *         description: Campo por el cual ordenar
 *       - in: query
 *         name: order
 *         schema:
 *           type: string
 *           enum: [ASC, DESC]
 *         description: Dirección del orden
 *     responses:
 *       200:
 *         description: Lista paginada de estados
 */
router.get('/', orderStatusController.getOrderStatusesPaginated);

/**
 * @swagger
 * /api/admin/order-statuses/all:
 *   get:
 *     summary: Obtener todos los estados (sin paginación)
 *     tags: [Admin OrderStatus]
 *     responses:
 *       200:
 *         description: Lista completa de estados
 */
router.get('/all', orderStatusController.getAllOrderStatuses);

/**
 * @swagger
 * /api/admin/order-statuses/{id}:
 *   get:
 *     summary: Obtener un estado por ID
 *     tags: [Admin OrderStatus]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: integer
 *         required: true
 *     responses:
 *       200:
 *         description: Estado encontrado
 *       404:
 *         description: Estado no encontrado
 */
router.get('/:id', orderStatusController.getOrderStatusById);

/**
 * @swagger
 * /api/admin/order-statuses:
 *   post:
 *     summary: Crear un nuevo estado
 *     tags: [Admin OrderStatus]
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
 *                 example: Enviado
 *               status_key:
 *                 type: string
 *                 example: shipped
 *               description:
 *                 type: string
 *                 example: La orden ha sido enviada.
 *               is_active:
 *                 type: boolean
 *                 example: true
 *     responses:
 *       201:
 *         description: Estado creado correctamente
 *       400:
 *         description: Error de validación
 */
router.post('/', orderStatusController.createOrderStatus);

/**
 * @swagger
 * /api/admin/order-statuses/{id}:
 *   put:
 *     summary: Actualizar un estado existente
 *     tags: [Admin OrderStatus]
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
 *         description: Estado actualizado
 *       404:
 *         description: Estado no encontrado
 */
router.put('/:id', orderStatusController.updateOrderStatus);

/**
 * @swagger
 * /api/admin/order-statuses/{id}:
 *   delete:
 *     summary: Eliminar (soft delete) un estado
 *     tags: [Admin OrderStatus]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Estado eliminado correctamente
 *       404:
 *         description: Estado no encontrado
 */
router.delete('/:id', orderStatusController.deleteOrderStatus);

/**
 * @swagger
 * /api/admin/order-statuses/{id}/restore:
 *   patch:
 *     summary: Restaurar un estado eliminado
 *     tags: [Admin OrderStatus]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Estado restaurado correctamente
 *       404:
 *         description: Estado no encontrado o no eliminado
 */
router.patch('/:id/restore', orderStatusController.restoreOrderStatus);

module.exports = router;
