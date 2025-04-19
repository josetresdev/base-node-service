const express = require('express');
const router = express.Router();

const categoryController = require('../../controllers/admin/categoryController')

/**
 * @swagger
 * tags:
 *   name: Admin Categories
 *   description: Endpoints para la gestión de categorías por el administrador
 */

/**
 * @swagger
 * /api/admin/categories:
 *   get:
 *     summary: Obtener categorías paginadas
 *     tags: [Admin Categories]
 *     parameters:
 *       - in: query
 *         name: page
 *         schema:
 *           type: integer
 *           default: 1
 *         description: Número de página para la paginación
 *       - in: query
 *         name: perPage
 *         schema:
 *           type: integer
 *           default: 10
 *         description: Cantidad de resultados por página
 *       - in: query
 *         name: sortBy
 *         schema:
 *           type: string
 *           default: created_at
 *         description: Campo por el cual ordenar los resultados
 *       - in: query
 *         name: order
 *         schema:
 *           type: string
 *           enum: [ASC, DESC]
 *           default: DESC
 *         description: Orden de los resultados ASC o DESC
 *     responses:
 *       200:
 *         description: Lista paginada de categorías
 *       500:
 *         description: Error interno del servidor
 */
router.get('/', categoryController.getCategoriesPaginated);

/**
 * @swagger
 * /api/admin/categories/all:
 *   get:
 *     summary: Obtener todas las categorías (sin paginación)
 *     tags: [Admin Categories]
 *     responses:
 *       200:
 *         description: Lista de todas las categorías
 *       500:
 *         description: Error interno del servidor
 */
router.get('/all', categoryController.getAllCategories);

/**
 * @swagger
 * /api/admin/categories/{id}:
 *   get:
 *     summary: Obtener una categoría por su ID
 *     tags: [Admin Categories]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID de la categoría
 *     responses:
 *       200:
 *         description: Categoría encontrada
 *       404:
 *         description: Categoría no encontrada
 *       500:
 *         description: Error interno del servidor
 */
router.get('/:id', categoryController.getCategoryById);

/**
 * @swagger
 * /api/admin/categories:
 *   post:
 *     summary: Crear una nueva categoría
 *     tags: [Admin Categories]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - name
 *               - slug
 *             properties:
 *               parent_category_id:
 *                 type: integer
 *               name:
 *                 type: string
 *               slug:
 *                 type: string
 *               description:
 *                 type: string
 *               image_url:
 *                 type: string
 *               is_active:
 *                 type: boolean
 *               meta_title:
 *                 type: string
 *               meta_description:
 *                 type: string
 *               display_order:
 *                 type: integer
 *     responses:
 *       201:
 *         description: Categoría creada correctamente
 *       500:
 *         description: Error interno del servidor
 */
router.post('/', categoryController.createCategory);

/**
 * @swagger
 * /api/admin/categories/{id}:
 *   put:
 *     summary: Actualizar una categoría existente
 *     tags: [Admin Categories]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID de la categoría a actualizar
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - name
 *               - slug
 *             properties:
 *               parent_category_id:
 *                 type: integer
 *               name:
 *                 type: string
 *               slug:
 *                 type: string
 *               description:
 *                 type: string
 *               image_url:
 *                 type: string
 *               is_active:
 *                 type: boolean
 *               meta_title:
 *                 type: string
 *               meta_description:
 *                 type: string
 *               display_order:
 *                 type: integer
 *     responses:
 *       200:
 *         description: Categoría actualizada correctamente
 *       404:
 *         description: Categoría no encontrada
 *       500:
 *         description: Error interno del servidor
 */
router.put('/:id', categoryController.updateCategory);

/**
 * @swagger
 * /api/admin/categories/{id}:
 *   delete:
 *     summary: Eliminar una categoría (soft delete)
 *     tags: [Admin Categories]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID de la categoría a eliminar
 *     responses:
 *       200:
 *         description: Categoría eliminada correctamente
 *       404:
 *         description: Categoría no encontrada
 *       500:
 *         description: Error interno del servidor
 */
router.delete('/:id', categoryController.deleteCategory);

/**
 * @swagger
 * /api/admin/categories/{id}/restore:
 *   patch:
 *     summary: Restaurar una categoría eliminada (soft restore)
 *     tags: [Admin Categories]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID de la categoría a restaurar
 *     responses:
 *       200:
 *         description: Categoría restaurada correctamente
 *       404:
 *         description: Categoría no encontrada o no eliminada
 *       500:
 *         description: Error interno del servidor
 */
router.patch('/:id/restore', categoryController.restoreCategory);

module.exports = router;
