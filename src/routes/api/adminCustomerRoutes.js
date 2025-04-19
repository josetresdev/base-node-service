const express = require('express');
const router = express.Router();

const customerController = require('../../controllers/admin/customerController');

/**
 * ================================
 * ADMIN ROUTES - Customers
 * ================================
 */

/**
 * @swagger
 * tags:
 *   name: Admin Customers
 *   description: Endpoints de administración para gestionar los clientes
 */

/**
 * @swagger
 * /api/admin/customers:
 *   get:
 *     summary: Obtener clientes paginados
 *     tags: [Admin Customers]
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
 *           enum: [customer_id, first_name, last_name, identity_number, email, created_at, updated_at]
 *           default: created_at
 *       - in: query
 *         name: order
 *         schema:
 *           type: string
 *           enum: [ASC, DESC]
 *           default: DESC
 *     responses:
 *       200:
 *         description: Lista paginada de clientes
 *       500:
 *         description: Error interno del servidor
 */
router.get('/', customerController.getCustomersPaginated);

/**
 * @swagger
 * /api/admin/customers/all:
 *   get:
 *     summary: Obtener todos los clientes (sin paginación)
 *     tags: [Admin Customers]
 *     responses:
 *       200:
 *         description: Lista completa de clientes
 *       500:
 *         description: Error interno del servidor
 */
router.get('/all', customerController.getAllCustomers);

/**
 * @swagger
 * /api/admin/customers/{id}:
 *   get:
 *     summary: Obtener un cliente por ID
 *     tags: [Admin Customers]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *           format: uuid
 *     responses:
 *       200:
 *         description: Cliente encontrado
 *       404:
 *         description: Cliente no encontrado
 */
router.get('/:id', customerController.getCustomerById);

/**
 * @swagger
 * /api/admin/customers:
 *   post:
 *     summary: Crear un nuevo cliente
 *     tags: [Admin Customers]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - identity_type_id
 *               - identity_number
 *               - first_name
 *               - last_name
 *               - email
 *               - password_hash
 *               - city_id
 *             properties:
 *               identity_type_id:
 *                 type: integer
 *                 example: 1
 *               identity_number:
 *                 type: string
 *                 example: "123456789"
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
 *               email:
 *                 type: string
 *                 example: "juan.perez@example.com"
 *               password_hash:
 *                 type: string
 *                 example: "$2b$10$hashedpassword"  # bcrypt hash
 *               shipping_address:
 *                 type: string
 *                 example: "Calle Ficticia 123"
 *               city_id:
 *                 type: integer
 *                 example: 1
 *               notes:
 *                 type: string
 *                 example: "Cliente importante"
 *               is_active:
 *                 type: boolean
 *                 example: true
 *               preferred_language:
 *                 type: string
 *                 example: "es"
 *               gender:
 *                 type: string
 *                 example: "masculino"
 *               date_of_birth:
 *                 type: string
 *                 format: date
 *                 example: "1990-01-01"
 *               updated_by:
 *                 type: string
 *                 format: uuid
 *     responses:
 *       201:
 *         description: Cliente creado correctamente
 *       400:
 *         description: Datos inválidos
 *       500:
 *         description: Error interno del servidor
 */
router.post('/', customerController.createCustomer);

/**
 * @swagger
 * /api/admin/customers/{id}:
 *   put:
 *     summary: Actualizar un cliente
 *     tags: [Admin Customers]
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
 *               first_name:
 *                 type: string
 *                 example: "Ana"
 *               last_name:
 *                 type: string
 *                 example: "Gómez"
 *               phone:
 *                 type: string
 *                 example: "555234567"
 *               is_whatsapp:
 *                 type: boolean
 *                 example: false
 *               shipping_address:
 *                 type: string
 *                 example: "Avenida Siempre Viva 742"
 *               city_id:
 *                 type: integer
 *                 example: 2
 *               notes:
 *                 type: string
 *                 example: "Actualización de perfil"
 *               is_active:
 *                 type: boolean
 *                 example: true
 *               preferred_language:
 *                 type: string
 *                 example: "es"
 *               gender:
 *                 type: string
 *                 example: "femenino"
 *               date_of_birth:
 *                 type: string
 *                 format: date
 *                 example: "1995-05-15"
 *               updated_by:
 *                 type: string
 *                 format: uuid
 *     responses:
 *       200:
 *         description: Cliente actualizado correctamente
 *       400:
 *         description: Datos inválidos
 *       404:
 *         description: Cliente no encontrado
 */
router.put('/:id', customerController.updateCustomer);

/**
 * @swagger
 * /api/admin/customers/{id}:
 *   delete:
 *     summary: Eliminar un cliente (soft delete)
 *     tags: [Admin Customers]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *           format: uuid
 *     responses:
 *       200:
 *         description: Cliente eliminado correctamente
 *       404:
 *         description: Cliente no encontrado
 */
router.delete('/:id', customerController.deleteCustomer);

/**
 * @swagger
 * /api/admin/customers/{id}/restore:
 *   patch:
 *     summary: Restaurar un cliente eliminado
 *     tags: [Admin Customers]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *           format: uuid
 *     responses:
 *       200:
 *         description: Cliente restaurado correctamente
 *       404:
 *         description: Cliente no encontrado o no eliminado
 */
router.patch('/:id/restore', customerController.restoreCustomer);

module.exports = router;
