const express = require('express');
const router = express.Router();

const identityTypeController = require('../../controllers/admin/identityTypeController');

/**
 * @swagger
 * tags:
 *   name: Admin Identity Types
 *   description: Endpoints de administración para gestionar los tipos de identidad
 */

/**
 * @swagger
 * /api/admin/identity-types:
 *   get:
 *     summary: Obtener tipos de identidad paginados
 *     tags: [Admin Identity Types]
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
 *           enum: [identity_type_id, name, display_order, created_at, updated_at]
 *           default: display_order
 *       - in: query
 *         name: order
 *         schema:
 *           type: string
 *           enum: [ASC, DESC]
 *           default: ASC
 *     responses:
 *       200:
 *         description: Lista paginada de tipos de identidad
 *       500:
 *         description: Error interno del servidor
 */
router.get('/', identityTypeController.getIdentityTypesPaginated);

/**
 * @swagger
 * /api/admin/identity-types/all:
 *   get:
 *     summary: Obtener todos los tipos de identidad (sin paginación)
 *     tags: [Admin Identity Types]
 *     responses:
 *       200:
 *         description: Lista completa de tipos de identidad
 *       500:
 *         description: Error interno del servidor
 */
router.get('/all', identityTypeController.getAllIdentityTypes);

/**
 * @swagger
 * /api/admin/identity-types/{id}:
 *   get:
 *     summary: Obtener un tipo de identidad por ID
 *     tags: [Admin Identity Types]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Tipo de identidad encontrado
 *       404:
 *         description: Tipo de identidad no encontrado
 */
router.get('/:id', identityTypeController.getIdentityTypeById);

/**
 * @swagger
 * /api/admin/identity-types:
 *   post:
 *     summary: Crear un nuevo tipo de identidad
 *     tags: [Admin Identity Types]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - name
 *             properties:
 *               name:
 *                 type: string
 *               description:
 *                 type: string
 *               is_active:
 *                 type: boolean
 *               display_order:
 *                 type: integer
 *     responses:
 *       201:
 *         description: Tipo de identidad creado correctamente
 *       500:
 *         description: Error interno del servidor
 */
router.post('/', identityTypeController.createIdentityType);

/**
 * @swagger
 * /api/admin/identity-types/{id}:
 *   put:
 *     summary: Actualizar un tipo de identidad
 *     tags: [Admin Identity Types]
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
 *               name:
 *                 type: string
 *               description:
 *                 type: string
 *               is_active:
 *                 type: boolean
 *               display_order:
 *                 type: integer
 *     responses:
 *       200:
 *         description: Tipo de identidad actualizado correctamente
 *       404:
 *         description: Tipo de identidad no encontrado
 */
router.put('/:id', identityTypeController.updateIdentityType);

/**
 * @swagger
 * /api/admin/identity-types/{id}:
 *   delete:
 *     summary: Eliminar un tipo de identidad (soft delete)
 *     tags: [Admin Identity Types]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Tipo de identidad eliminado correctamente
 *       404:
 *         description: Tipo de identidad no encontrado
 */
router.delete('/:id', identityTypeController.deleteIdentityType);

/**
 * @swagger
 * /api/admin/identity-types/{id}/restore:
 *   patch:
 *     summary: Restaurar un tipo de identidad eliminado
 *     tags: [Admin Identity Types]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Tipo de identidad restaurado correctamente
 *       404:
 *         description: Tipo de identidad no encontrado o no eliminado
 */
router.patch('/:id/restore', identityTypeController.restoreIdentityType);

module.exports = router;