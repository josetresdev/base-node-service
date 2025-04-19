const express = require('express');
const router = express.Router();

const productController = require('../../controllers/client/productController');

/**
 * ================================
 * CLIENT ROUTES - Products
 * ================================
 */

/**
 * @swagger
 * tags:
 *   name: Client Products
 *   description: Endpoints públicos para obtener productos visibles en el frontend
 */

/**
 * @swagger
 * /api/client/products:
 *   get:
 *     summary: Obtener productos activos visibles al cliente (paginado)
 *     tags: [Client Products]
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
 *           default: created_at
 *       - in: query
 *         name: order
 *         schema:
 *           type: string
 *           enum: [ASC, DESC]
 *           default: ASC
 *     responses:
 *       200:
 *         description: Lista de productos activos obtenida exitosamente
 */
router.get('/', productController.getActiveProducts);

/**
 * @swagger
 * /api/client/products/featured:
 *   get:
 *     summary: Obtener productos destacados
 *     tags: [Client Products]
 *     parameters:
 *       - in: query
 *         name: limit
 *         schema:
 *           type: integer
 *           default: 10
 *       - in: query
 *         name: sortBy
 *         schema:
 *           type: string
 *           default: created_at
 *       - in: query
 *         name: order
 *         schema:
 *           type: string
 *           enum: [ASC, DESC]
 *           default: DESC
 *     responses:
 *       200:
 *         description: Lista de productos destacados obtenida exitosamente
 */
router.get('/featured', productController.getFeaturedProducts);

/**
 * @swagger
 * /api/client/products/best-sellers:
 *   get:
 *     summary: Obtener best sellers (los más vendidos)
 *     tags: [Client Products]
 *     parameters:
 *       - in: query
 *         name: limit
 *         schema:
 *           type: integer
 *           default: 10
 *     responses:
 *       200:
 *         description: Lista de best sellers obtenida exitosamente
 */
router.get('/best-sellers', productController.getBestSellers);

/**
 * @swagger
 * /api/client/products/count:
 *   get:
 *     summary: Obtener el conteo total de productos activos
 *     tags: [Client Products]
 *     responses:
 *       200:
 *         description: Conteo de productos activos obtenido exitosamente
 *       500:
 *         description: Error inesperado en el servidor
 */
router.get('/count', productController.getActiveProductsCount);

/**
 * @swagger
 * /api/client/products/search:
 *   get:
 *     summary: Buscar productos activos por nombre, descripción u otros criterios
 *     tags: [Client Products]
 *     parameters:
 *       - in: query
 *         name: query
 *         required: true
 *         schema:
 *           type: string
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
 *           default: created_at
 *       - in: query
 *         name: order
 *         schema:
 *           type: string
 *           enum: [ASC, DESC]
 *           default: DESC
 *     responses:
 *       200:
 *         description: Resultados de la búsqueda obtenidos exitosamente
 *       400:
 *         description: Parámetros de búsqueda inválidos
 */
router.get('/search', productController.searchProducts);

/**
 * @swagger
 * /api/client/products/category/{categoryId}:
 *   get:
 *     summary: Obtener productos activos por categoría (paginado)
 *     tags: [Client Products]
 *     parameters:
 *       - in: path
 *         name: categoryId
 *         required: true
 *         schema:
 *           type: string
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
 *           default: created_at
 *       - in: query
 *         name: order
 *         schema:
 *           type: string
 *           enum: [ASC, DESC]
 *           default: DESC
 *     responses:
 *       200:
 *         description: Productos por categoría obtenidos exitosamente
 *       404:
 *         description: Categoría no encontrada o sin productos
 */
router.get('/category/:categoryId', productController.getProductsByCategory);

/**
 * @swagger
 * /api/client/products/price-range:
 *   get:
 *     summary: Obtener productos activos dentro de un rango de precio
 *     tags: [Client Products]
 *     parameters:
 *       - in: query
 *         name: minPrice
 *         required: true
 *         schema:
 *           type: number
 *         description: Precio mínimo
 *       - in: query
 *         name: maxPrice
 *         required: true
 *         schema:
 *           type: number
 *         description: Precio máximo
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
 *           default: price
 *       - in: query
 *         name: order
 *         schema:
 *           type: string
 *           enum: [ASC, DESC]
 *           default: ASC
 *     responses:
 *       200:
 *         description: Productos dentro del rango de precios obtenidos exitosamente
 *       400:
 *         description: Parámetros inválidos o incompletos
 */
router.get('/price-range', productController.getProductsByPriceRange);

/**
 * @swagger
 * /api/client/products/{slug}:
 *   get:
 *     summary: Obtener un producto activo por su slug
 *     tags: [Client Products]
 *     parameters:
 *       - in: path
 *         name: slug
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Producto obtenido exitosamente
 *       404:
 *         description: Producto no encontrado
 */
router.get('/:slug', productController.getProductBySlug);

module.exports = router;
