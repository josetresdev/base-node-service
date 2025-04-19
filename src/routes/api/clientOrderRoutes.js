const express = require('express');
const router = express.Router();
const orderClientController = require('../../controllers/client/orderClientController');
const validateUUID = require('../../middlewares/validateUUID');
const validatePagination = require('../../middlewares/validatePagination');

/**
 * ================================
 *        CLIENT ORDER ROUTES
 * ================================
 */

// ✅ Obtener historial de órdenes del cliente autenticado (paginado)
router.get('/', validatePagination, orderClientController.getClientOrders);

// ✅ Obtener detalle de una orden específica del cliente
router.get('/:id', validateUUID, orderClientController.getClientOrderById);

// ✅ Crear nueva orden (checkout)
router.post('/', orderClientController.createClientOrder);

// ✅ Cancelar una orden (si aún está pendiente o en procesamiento)
router.patch('/:id/cancel', validateUUID, orderClientController.cancelClientOrder);

module.exports = router;
