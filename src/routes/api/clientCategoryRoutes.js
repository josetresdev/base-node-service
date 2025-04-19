const express = require('express');
const router = express.Router();

// ✅ Controlador de categorías para el cliente
const categoryController = require('../../controllers/client/categoryController');

/**
 * @swagger
 * tags:
 *   name: Client Categories
 *   description: Endpoints públicos para obtener categorías visibles en el frontend
 */

/**
 * @swagger
 * /api/client/categories:
 *   get:
 *     summary: Obtener categorías activas visibles al cliente
 *     tags: [Client Categories]
 *     responses:
 *       200:
 *         description: Lista de categorías activas obtenida exitosamente
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                   example: true
 *                 message:
 *                   type: string
 *                   example: Active categories fetched successfully
 *                 data:
 *                   type: array
 *                   items:
 *                     type: object
 *                     properties:
 *                       id:
 *                         type: integer
 *                         example: 1
 *                       name:
 *                         type: string
 *                         example: Bebidas energéticas
 *                       slug:
 *                         type: string
 *                         example: bebidas-energeticas
 *                       description:
 *                         type: string
 *                         example: Todas las bebidas energéticas disponibles
 *                       image_url:
 *                         type: string
 *                         example: https://cdn.trebol.com/categories/bebidas-energeticas.jpg
 *                       display_order:
 *                         type: integer
 *                         example: 1
 *                 statusCode:
 *                   type: integer
 *                   example: 200
 *                 requestId:
 *                   type: string
 *                   example: b34cd2b2-d5e5-4cc7-a963-35a81dc9d6d9
 *       500:
 *         description: Error inesperado en el servidor
 */
router.get('/', categoryController.getActiveCategories);

module.exports = router;
