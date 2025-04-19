const express = require('express');
const router = express.Router();

const departmentController = require('../../controllers/admin/departmentController');

/**
 * @swagger
 * tags:
 *   name: Admin Departments
 *   description: Endpoints de administración para gestionar los departamentos
 */

/**
 * @swagger
 * /api/admin/departments:
 *   get:
 *     summary: Obtener departamentos paginados
 *     tags: [Admin Departments]
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
 *         description: Lista paginada de departamentos
 *       500:
 *         description: Error interno del servidor
 */
router.get('/', departmentController.getDepartmentsPaginated);

/**
 * @swagger
 * /api/admin/departments/all:
 *   get:
 *     summary: Obtener todos los departamentos (sin paginación)
 *     tags: [Admin Departments]
 *     responses:
 *       200:
 *         description: Lista completa de departamentos
 *       500:
 *         description: Error interno del servidor
 */
router.get('/all', departmentController.getAllDepartments);

/**
 * @swagger
 * /api/admin/departments/{id}:
 *   get:
 *     summary: Obtener un departamento por ID
 *     tags: [Admin Departments]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Departamento encontrado
 *       404:
 *         description: Departamento no encontrado
 */
router.get('/:id', departmentController.getDepartmentById);

/**
 * @swagger
 * /api/admin/departments:
 *   post:
 *     summary: Crear un nuevo departamento
 *     tags: [Admin Departments]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - name
 *               - country_id
 *             properties:
 *               name:
 *                 type: string
 *               country_id:
 *                 type: integer
 *               is_active:
 *                 type: boolean
 *               display_order:
 *                 type: integer
 *     responses:
 *       201:
 *         description: Departamento creado correctamente
 *       500:
 *         description: Error interno del servidor
 */
router.post('/', departmentController.createDepartment);

/**
 * @swagger
 * /api/admin/departments/{id}:
 *   put:
 *     summary: Actualizar un departamento
 *     tags: [Admin Departments]
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
 *               country_id:
 *                 type: integer
 *               is_active:
 *                 type: boolean
 *               display_order:
 *                 type: integer
 *     responses:
 *       200:
 *         description: Departamento actualizado correctamente
 *       404:
 *         description: Departamento no encontrado
 */
router.put('/:id', departmentController.updateDepartment);

/**
 * @swagger
 * /api/admin/departments/{id}:
 *   delete:
 *     summary: Eliminar un departamento (soft delete)
 *     tags: [Admin Departments]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Departamento eliminado correctamente
 *       404:
 *         description: Departamento no encontrado
 */
router.delete('/:id', departmentController.deleteDepartment);

/**
 * @swagger
 * /api/admin/departments/{id}/restore:
 *   patch:
 *     summary: Restaurar un departamento eliminado
 *     tags: [Admin Departments]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Departamento restaurado correctamente
 *       404:
 *         description: Departamento no encontrado o no eliminado
 */
router.patch('/:id/restore', departmentController.restoreDepartment);

module.exports = router;
