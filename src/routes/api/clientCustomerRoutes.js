const express = require('express');
const router = express.Router();

const customerController = require('../../controllers/client/customerController');

/**
 * ================================
 * CLIENT ROUTES - Customers
 * ================================
 */

/**
 * @swagger
 * tags:
 *   name: Client Customers
 *   description: Endpoints públicos para que el cliente gestione su cuenta y perfil
 */

/**
 * @swagger
 * /api/client/customers/profile:
 *   get:
 *     summary: Obtener el perfil del cliente autenticado
 *     tags: [Client Customers]
 *     description: Retorna la información del perfil del cliente autenticado
 *     responses:
 *       200:
 *         description: Perfil del cliente obtenido exitosamente
 *       400:
 *         description: ID de cliente no válido
 *       404:
 *         description: Cliente no encontrado
 */
router.get('/profile', customerController.getCustomerProfile);

/**
 * @swagger
 * /api/client/customers/profile:
 *   put:
 *     summary: Actualizar el perfil del cliente autenticado
 *     tags: [Client Customers]
 *     description: Permite actualizar los datos personales del cliente (excepto email, documentos y password)
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               first_name:
 *                 type: string
 *                 example: "Juan"
 *               last_name:
 *                 type: string
 *                 example: "Pérez"
 *               phone:
 *                 type: string
 *                 example: "555123456"
 *               is_whatsapp:
 *                 type: boolean
 *                 example: true
 *               city_id:
 *                 type: integer
 *                 example: 1
 *               shipping_address:
 *                 type: string
 *                 example: "Calle Falsa 123"
 *               notes:
 *                 type: string
 *                 example: "Cliente frecuente"
 *               preferred_language:
 *                 type: string
 *                 example: "es"
 *               gender:
 *                 type: string
 *                 example: "male"
 *               date_of_birth:
 *                 type: string
 *                 format: date
 *                 example: "1990-05-05"
 *     responses:
 *       200:
 *         description: Perfil actualizado correctamente
 *       400:
 *         description: Datos inválidos
 *       404:
 *         description: Cliente no encontrado
 */
router.put('/profile', customerController.updateCustomerProfile);

/**
 * @swagger
 * /api/client/customers/profile/deactivate:
 *   patch:
 *     summary: Desactivar la cuenta del cliente autenticado
 *     tags: [Client Customers]
 *     description: Permite desactivar (soft delete) la cuenta del cliente autenticado
 *     responses:
 *       200:
 *         description: Cuenta desactivada correctamente
 *       400:
 *         description: ID de cliente no válido
 *       404:
 *         description: Cliente no encontrado
 */
router.patch('/profile/deactivate', customerController.deactivateCustomerAccount);

/**
 * @swagger
 * /api/client/customers/profile/reactivate:
 *   patch:
 *     summary: Reactivar la cuenta del cliente autenticado
 *     tags: [Client Customers]
 *     description: Permite reactivar la cuenta del cliente autenticado previamente desactivada
 *     responses:
 *       200:
 *         description: Cuenta reactivada correctamente
 *       400:
 *         description: ID de cliente no válido
 *       404:
 *         description: Cliente no encontrado o no desactivado previamente
 */
router.patch('/profile/reactivate', customerController.reactivateCustomerAccount);

/**
 * @swagger
 * /api/client/customers/profile/change-password:
 *   patch:
 *     summary: Cambiar la contraseña del cliente autenticado
 *     tags: [Client Customers]
 *     description: Permite al cliente cambiar su contraseña (requiere contraseña actual)
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - currentPassword
 *               - newPassword
 *             properties:
 *               currentPassword:
 *                 type: string
 *                 example: "current_password_123"
 *               newPassword:
 *                 type: string
 *                 example: "new_secure_password_456"
 *     responses:
 *       200:
 *         description: Contraseña cambiada correctamente
 *       400:
 *         description: Contraseña actual incorrecta o datos inválidos
 *       404:
 *         description: Cliente no encontrado
 */
router.patch('/profile/change-password', customerController.changeCustomerPassword);

module.exports = router;
