const { ValidationError, UniqueConstraintError } = require('sequelize');
const { v4: uuidv4 } = require('uuid');

/**
 * Global Error Handler Middleware
 * @param {Error} err - Error lanzado en el flujo de Express.
 * @param {Object} req - Objeto request de Express.
 * @param {Object} res - Objeto response de Express.
 * @param {Function} next - Función next de Express.
 */
const errorHandler = (err, req, res, next) => {
    const requestId = req.requestId || uuidv4();

    let statusCode = 500;
    let message = err.message || 'Internal Server Error';
    let errorCode = err.code || 'INTERNAL_SERVER_ERROR';
    let errors = null;

    // ✅ Manejo de errores de Sequelize (Unique constraint)
    if (err instanceof UniqueConstraintError) {
        statusCode = 400;
        errorCode = 'UNIQUE_CONSTRAINT_ERROR';
        message = 'Duplicate entry detected';
        errors = err.errors.map((e) => ({
            field: e.path,
            message: `The ${e.path} '${e.value}' already exists.`
        }));
    }

    // ✅ Manejo de errores de Sequelize (Validation errors)
    if (err instanceof ValidationError) {
        statusCode = 400;
        errorCode = 'VALIDATION_ERROR';
        message = 'Validation failed';
        errors = err.errors.map((e) => ({
            field: e.path,
            message: e.message
        }));
    }

    // ✅ Puedes agregar más casos aquí según tus necesidades
    // if (err instanceof SomeCustomError) { ... }

    return res.status(statusCode).json({
        success: false,
        message,
        statusCode,
        errorCode,
        errors,
        data: null,
        meta: null,
        timestamp: new Date().toISOString(),
        requestId
    });
};

module.exports = errorHandler;