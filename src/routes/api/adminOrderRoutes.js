const express = require('express');
const router = express.Router();
const orderAdminController = require('../../controllers/admin/orderAdminController');
const validateUUID = require('../../middlewares/validateUUID'); // Asumiendo que tienes un middleware genérico
const validatePagination = require('../../middlewares/validatePagination'); // Para controlar paginación

/**
 * ================================
 *        ADMIN ORDER ROUTES
 * ================================
 */

// ✅ Listar órdenes (paginadas, filtros opcionales)
router.get('/', validatePagination, orderAdminController.getAllOrders);

// ✅ Obtener detalle de una orden por ID
router.get('/:id', validateUUID, orderAdminController.getOrderById);

// ✅ Crear orden manual desde admin (en caso de ajustes o ventas internas)
router.post('/', orderAdminController.createOrder);

// ✅ Actualizar orden (cambio de estado, tracking, notas, etc.)
router.put('/:id', validateUUID, orderAdminController.updateOrder);

// ✅ Soft delete
router.delete('/:id', validateUUID, orderAdminController.softDeleteOrder);

// ✅ Restaurar orden eliminada lógicamente
router.post('/:id/restore', validateUUID, orderAdminController.restoreOrder);

module.exports = router;
