const express = require('express');
const router = express.Router();

const countryController = require('../../controllers/admin/countryController');

/**
 * @swagger
 * tags:
 *   name: Admin Countries
 *   description: Endpoints de administración para gestionar los países
 */

/**
 * @swagger
 * /api/admin/countries:
 *   get:
 *     summary: Obtener países paginados
 *     tags: [Admin Countries]
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
 *           enum: [id, name, display_order, created_at, updated_at]
 *           default: created_at
 *       - in: query
 *         name: order
 *         schema:
 *           type: string
 *           enum: [ASC, DESC]
 *           default: DESC
 *     responses:
 *       200:
 *         description: Lista paginada de países
 *       500:
 *         description: Error interno del servidor
 */
router.get('/', countryController.getCountriesPaginated);

/**
 * @swagger
 * /api/admin/countries/all:
 *   get:
 *     summary: Obtener todos los países (sin paginación)
 *     tags: [Admin Countries]
 *     responses:
 *       200:
 *         description: Lista completa de países
 *       500:
 *         description: Error interno del servidor
 */
router.get('/all', countryController.getAllCountries);

/**
 * @swagger
 * /api/admin/countries/{id}:
 *   get:
 *     summary: Obtener un país por ID
 *     tags: [Admin Countries]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: País encontrado
 *       404:
 *         description: País no encontrado
 */
router.get('/:id', countryController.getCountryById);

/**
 * @swagger
 * /api/admin/countries:
 *   post:
 *     summary: Crear un nuevo país
 *     tags: [Admin Countries]
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
 *               is_active:
 *                 type: boolean
 *               display_order:
 *                 type: integer
 *     responses:
 *       201:
 *         description: País creado correctamente
 *       500:
 *         description: Error interno del servidor
 */
router.post('/', countryController.createCountry);

/**
 * @swagger
 * /api/admin/countries/{id}:
 *   put:
 *     summary: Actualizar un país
 *     tags: [Admin Countries]
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
 *               is_active:
 *                 type: boolean
 *               display_order:
 *                 type: integer
 *     responses:
 *       200:
 *         description: País actualizado correctamente
 *       404:
 *         description: País no encontrado
 */
router.put('/:id', countryController.updateCountry);

/**
 * @swagger
 * /api/admin/countries/{id}:
 *   delete:
 *     summary: Eliminar un país (soft delete)
 *     tags: [Admin Countries]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: País eliminado correctamente
 *       404:
 *         description: País no encontrado
 */
router.delete('/:id', countryController.deleteCountry);

/**
 * @swagger
 * /api/admin/countries/{id}/restore:
 *   patch:
 *     summary: Restaurar un país eliminado
 *     tags: [Admin Countries]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: País restaurado correctamente
 *       404:
 *         description: País no encontrado o no eliminado
 */
router.patch('/:id/restore', countryController.restoreCountry);

module.exports = router;
