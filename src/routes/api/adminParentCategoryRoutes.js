const express = require('express');
const router = express.Router();

const parentCategoryController = require('../../controllers/admin/parentCategoryController');

/**
 * @swagger
 * tags:
 *   name: Admin Parent Categories
 *   description: Endpoints de administración para gestionar las categorías padre
 */

/**
 * @swagger
 * /api/admin/parent-categories:
 *   get:
 *     summary: Obtener Parent Categories paginadas
 *     tags: [Admin Parent Categories]
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
 *           enum: [id, name, slug, display_order, created_at, updated_at]
 *           default: created_at
 *       - in: query
 *         name: order
 *         schema:
 *           type: string
 *           enum: [ASC, DESC]
 *           default: DESC
 *     responses:
 *       200:
 *         description: Lista paginada de Parent Categories
 *       500:
 *         description: Error interno del servidor
 */
router.get('/', parentCategoryController.getParentCategoriesPaginated);

/**
 * @swagger
 * /api/admin/parent-categories/all:
 *   get:
 *     summary: Obtener todas las Parent Categories (sin paginación)
 *     tags: [Admin Parent Categories]
 *     responses:
 *       200:
 *         description: Lista completa de Parent Categories
 *       500:
 *         description: Error interno del servidor
 */
router.get('/all', parentCategoryController.getAllParentCategories);

/**
 * @swagger
 * /api/admin/parent-categories/{id}:
 *   get:
 *     summary: Obtener una Parent Category por ID
 *     tags: [Admin Parent Categories]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Parent Category encontrada
 *       404:
 *         description: No encontrada
 */
router.get('/:id', parentCategoryController.getParentCategoryById);

/**
 * @swagger
 * /api/admin/parent-categories:
 *   post:
 *     summary: Crear una nueva Parent Category
 *     tags: [Admin Parent Categories]
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
 *         description: Parent Category creada
 */
router.post('/', parentCategoryController.createParentCategory);

/**
 * @swagger
 * /api/admin/parent-categories/{id}:
 *   put:
 *     summary: Actualizar una Parent Category
 *     tags: [Admin Parent Categories]
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
 *         description: Parent Category actualizada
 *       404:
 *         description: No encontrada
 */
router.put('/:id', parentCategoryController.updateParentCategory);

/**
 * @swagger
 * /api/admin/parent-categories/{id}:
 *   delete:
 *     summary: Eliminar una Parent Category (soft delete)
 *     tags: [Admin Parent Categories]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Parent Category eliminada
 *       404:
 *         description: No encontrada
 */
router.delete('/:id', parentCategoryController.deleteParentCategory);

/**
 * @swagger
 * /api/admin/parent-categories/{id}/restore:
 *   patch:
 *     summary: Restaurar una Parent Category eliminada
 *     tags: [Admin Parent Categories]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Parent Category restaurada
 *       404:
 *         description: No encontrada o no eliminada
 */
router.patch('/:id/restore', parentCategoryController.restoreParentCategory);

module.exports = router;
