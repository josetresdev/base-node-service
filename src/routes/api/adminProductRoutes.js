const express = require('express');
const router = express.Router();

const productController = require('../../controllers/admin/productController');

/**
 * ================================
 * ADMIN ROUTES - Products
 * ================================
 */

/**
 * @swagger
 * tags:
 *   name: Admin Products
 *   description: Endpoints para la gestión de productos por el administrador
 */

/**
 * @swagger
 * /api/admin/products:
 *   get:
 *     summary: Obtener productos paginados
 *     tags: [Admin Products]
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
 *         description: Lista paginada de productos
 *       500:
 *         description: Error interno del servidor
 */
router.get('/', productController.getProductsPaginated);

/**
 * @swagger
 * /api/admin/products/all:
 *   get:
 *     summary: Obtener todos los productos (sin paginación)
 *     tags: [Admin Products]
 *     responses:
 *       200:
 *         description: Lista de todos los productos
 *       500:
 *         description: Error interno del servidor
 */
router.get('/all', productController.getAllProducts);

/**
 * @swagger
 * /api/admin/products/{id}:
 *   get:
 *     summary: Obtener un producto por su ID
 *     tags: [Admin Products]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: ID del producto (UUID)
 *     responses:
 *       200:
 *         description: Producto encontrado
 *       404:
 *         description: Producto no encontrado
 *       500:
 *         description: Error interno del servidor
 */
router.get('/:id', productController.getProductById);

/**
 * @swagger
 * /api/admin/products:
 *   post:
 *     summary: Crear un nuevo producto
 *     tags: [Admin Products]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - category_id
 *               - name
 *               - slug
 *               - price
 *             properties:
 *               category_id:
 *                 type: integer
 *                 example: 1
 *               name:
 *                 type: string
 *                 example: Cerveza Heineken
 *               slug:
 *                 type: string
 *                 example: cerveza-heineken
 *               description:
 *                 type: string
 *                 example: Cerveza holandesa premium
 *               price:
 *                 type: number
 *                 example: 8000
 *               stock:
 *                 type: integer
 *                 example: 100
 *               image_url:
 *                 type: string
 *                 example: https://cdn.trebol.com/products/cerveza-heineken.jpg
 *               is_active:
 *                 type: boolean
 *                 example: true
 *     responses:
 *       201:
 *         description: Producto creado correctamente
 *       400:
 *         description: Error en la solicitud
 *       500:
 *         description: Error interno del servidor
 */
router.post('/', productController.createProduct);

/**
 * @swagger
 * /api/admin/products/{id}:
 *   put:
 *     summary: Actualizar un producto existente
 *     tags: [Admin Products]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: ID del producto a actualizar (UUID)
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               category_id:
 *                 type: integer
 *               name:
 *                 type: string
 *               slug:
 *                 type: string
 *               description:
 *                 type: string
 *               price:
 *                 type: number
 *               stock:
 *                 type: integer
 *               image_url:
 *                 type: string
 *               is_active:
 *                 type: boolean
 *     responses:
 *       200:
 *         description: Producto actualizado correctamente
 *       400:
 *         description: Error en la solicitud
 *       404:
 *         description: Producto no encontrado
 *       500:
 *         description: Error interno del servidor
 */
router.put('/:id', productController.updateProduct);

/**
 * @swagger
 * /api/admin/products/{id}:
 *   delete:
 *     summary: Eliminar un producto (soft delete)
 *     tags: [Admin Products]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: ID del producto a eliminar (UUID)
 *     responses:
 *       200:
 *         description: Producto eliminado correctamente
 *       404:
 *         description: Producto no encontrado
 *       500:
 *         description: Error interno del servidor
 */
router.delete('/:id', productController.deleteProduct);

/**
 * @swagger
 * /api/admin/products/{id}/restore:
 *   patch:
 *     summary: Restaurar un producto eliminado (soft restore)
 *     tags: [Admin Products]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: ID del producto a restaurar (UUID)
 *     responses:
 *       200:
 *         description: Producto restaurado correctamente
 *       404:
 *         description: Producto no encontrado o no eliminado
 *       500:
 *         description: Error interno del servidor
 */
router.patch('/:id/restore', productController.restoreProduct);

module.exports = router;
