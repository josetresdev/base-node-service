const express = require('express');
const router = express.Router();

const parentCategoryController = require('../../controllers/client/parentCategoryController');

/**
 * @swagger
 * tags:
 *   name: Client Parent Categories
 *   description: Endpoints públicos para obtener las categorías padre activas visibles en la tienda
 */

/**
 * @swagger
 * /api/client/parent-categories:
 *   get:
 *     summary: Obtener Parent Categories activas (paginadas)
 *     tags: [Client Parent Categories]
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
 *           default: display_order
 *       - in: query
 *         name: order
 *         schema:
 *           type: string
 *           enum: [ASC, DESC]
 *           default: ASC
 *     responses:
 *       200:
 *         description: Lista paginada de categorías padre activas
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
 *                   example: "Parent Categories fetched successfully"
 *                 data:
 *                   type: array
 *                   items:
 *                     type: object
 *                     properties:
 *                       id:
 *                         type: integer
 *                       name:
 *                         type: string
 *                       slug:
 *                         type: string
 *                       description:
 *                         type: string
 *                       image_url:
 *                         type: string
 *                       is_active:
 *                         type: boolean
 *                       meta_title:
 *                         type: string
 *                       meta_description:
 *                         type: string
 *                       display_order:
 *                         type: integer
 *                       created_at:
 *                         type: string
 *                         format: date-time
 *                       updated_at:
 *                         type: string
 *                         format: date-time
 *                 pagination:
 *                   type: object
 *                   properties:
 *                     currentPage:
 *                       type: integer
 *                     perPage:
 *                       type: integer
 *                     totalPages:
 *                       type: integer
 *                     totalItems:
 *                       type: integer
 *                 links:
 *                   type: object
 *                   properties:
 *                     self:
 *                       type: string
 *                     next:
 *                       type: string
 *                     prev:
 *                       type: string
 *                 requestId:
 *                   type: string
 *       500:
 *         description: Error interno del servidor
 */
router.get('/', parentCategoryController.getActiveParentCategories);

module.exports = router;
