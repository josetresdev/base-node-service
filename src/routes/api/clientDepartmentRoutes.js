const express = require('express');
const router = express.Router();

const departmentController = require('../../controllers/client/departmentController');

/**
 * @swagger
 * tags:
 *   name: Client Departments
 *   description: Endpoints públicos para obtener los departamentos activos visibles en la tienda
 */

/**
 * @swagger
 * /api/client/departments:
 *   get:
 *     summary: Obtener departamentos activos (paginados)
 *     tags: [Client Departments]
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
 *           enum: [department_id, name, display_order, created_at, updated_at]
 *           default: display_order
 *       - in: query
 *         name: order
 *         schema:
 *           type: string
 *           enum: [ASC, DESC]
 *           default: ASC
 *     responses:
 *       200:
 *         description: Lista paginada de departamentos activos
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
 *                   example: "Departments fetched successfully"
 *                 data:
 *                   type: array
 *                   items:
 *                     type: object
 *                     properties:
 *                       department_id:
 *                         type: integer
 *                         example: 1
 *                       name:
 *                         type: string
 *                         example: "Cundinamarca"
 *                       country_id:
 *                         type: integer
 *                         example: 1
 *                       is_active:
 *                         type: boolean
 *                         example: true
 *                       display_order:
 *                         type: integer
 *                         example: 1
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
router.get('/', departmentController.getActiveDepartments);

module.exports = router;
