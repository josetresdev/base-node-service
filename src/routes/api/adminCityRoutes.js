const express = require('express');
const router = express.Router();

const cityController = require('../../controllers/admin/cityController');

/**
 * @swagger
 * tags:
 *   name: Admin Cities
 *   description: Endpoints de administración para gestionar las ciudades
 */

/**
 * @swagger
 * /api/admin/cities:
 *   get:
 *     summary: Obtener ciudades paginadas
 *     tags: [Admin Cities]
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
 *           enum: [city_id, name, display_order, created_at, updated_at]
 *           default: display_order
 *       - in: query
 *         name: order
 *         schema:
 *           type: string
 *           enum: [ASC, DESC]
 *           default: ASC
 *     responses:
 *       200:
 *         description: Lista paginada de ciudades
 *       500:
 *         description: Error interno del servidor
 */
router.get('/', cityController.getCitiesPaginated);

/**
 * @swagger
 * /api/admin/cities/all:
 *   get:
 *     summary: Obtener todas las ciudades (sin paginación)
 *     tags: [Admin Cities]
 *     responses:
 *       200:
 *         description: Lista completa de ciudades
 *       500:
 *         description: Error interno del servidor
 */
router.get('/all', cityController.getAllCities);

/**
 * @swagger
 * /api/admin/cities/{id}:
 *   get:
 *     summary: Obtener una ciudad por ID
 *     tags: [Admin Cities]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Ciudad encontrada
 *       404:
 *         description: Ciudad no encontrada
 */
router.get('/:id', cityController.getCityById);

/**
 * @swagger
 * /api/admin/cities:
 *   post:
 *     summary: Crear una nueva ciudad
 *     tags: [Admin Cities]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - name
 *               - department_id
 *             properties:
 *               name:
 *                 type: string
 *               department_id:
 *                 type: integer
 *               is_active:
 *                 type: boolean
 *               display_order:
 *                 type: integer
 *     responses:
 *       201:
 *         description: Ciudad creada correctamente
 *       500:
 *         description: Error interno del servidor
 */
router.post('/', cityController.createCity);

/**
 * @swagger
 * /api/admin/cities/{id}:
 *   put:
 *     summary: Actualizar una ciudad
 *     tags: [Admin Cities]
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
 *               department_id:
 *                 type: integer
 *               is_active:
 *                 type: boolean
 *               display_order:
 *                 type: integer
 *     responses:
 *       200:
 *         description: Ciudad actualizada correctamente
 *       404:
 *         description: Ciudad no encontrada
 */
router.put('/:id', cityController.updateCity);

/**
 * @swagger
 * /api/admin/cities/{id}:
 *   delete:
 *     summary: Eliminar una ciudad (soft delete)
 *     tags: [Admin Cities]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Ciudad eliminada correctamente
 *       404:
 *         description: Ciudad no encontrada
 */
router.delete('/:id', cityController.deleteCity);

/**
 * @swagger
 * /api/admin/cities/{id}/restore:
 *   patch:
 *     summary: Restaurar una ciudad eliminada
 *     tags: [Admin Cities]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Ciudad restaurada correctamente
 *       404:
 *         description: Ciudad no encontrada o no eliminada
 */
router.patch('/:id/restore', cityController.restoreCity);

module.exports = router;
