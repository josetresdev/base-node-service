const { v4: uuidv4 } = require('uuid');

/**
 * ✅ Formatea y envía una respuesta exitosa estandarizada.
 *
 * @param {Object} res - Objeto de respuesta de Express.
 * @param {Object} options - Opciones de respuesta.
 * @param {string} options.message - Mensaje de éxito para el consumidor de la API.
 * @param {Object} [options.data=null] - Cuerpo principal de datos.
 * @param {number} [options.statusCode=200] - Código de estado HTTP.
 * @param {Object} [options.pagination=null] - Objeto de paginación (opcional).
 * @param {Object} [options.links=null] - Links de paginación o relacionados.
 * @param {Object} [options.meta=null] - Datos adicionales de contexto o métricas.
 * @param {string} [options.requestId] - ID único de la request para trazabilidad.
 * @returns {Object} JSON Response
 */
const successResponse = (
    res,
    {
        message = 'Success',
        data = null,
        statusCode = 200,
        pagination = null,
        links = null,
        meta = null,
        requestId = uuidv4() // Si no viene del middleware, lo generamos
    } = {}
) => {
    return res.status(statusCode).json({
        success: true,
        message,
        statusCode,
        errorCode: null,
        data,
        pagination,
        links,
        meta,
        timestamp: new Date().toISOString(),
        requestId
    });
};

/**
 * ✅ Formatea y envía una respuesta de error estandarizada.
 *
 * @param {Object} res - Objeto de respuesta de Express.
 * @param {Object} options - Opciones de respuesta.
 * @param {string} options.message - Mensaje de error claro para el consumidor.
 * @param {number} [options.statusCode=500] - Código de estado HTTP.
 * @param {string} [options.errorCode='INTERNAL_ERROR'] - Código de error para frontend o logs.
 * @param {Object} [options.errors=null] - Lista detallada de errores (ejemplo: campos duplicados, validaciones fallidas).
 * @param {Object} [options.data=null] - Datos opcionales sobre el error.
 * @param {Object} [options.meta=null] - Datos adicionales o métricas.
 * @param {string} [options.requestId] - ID único de la request para trazabilidad.
 * @returns {Object} JSON Response
 */
const errorResponse = (
    res,
    {
        message = 'Internal Server Error',
        statusCode = 500,
        errorCode = 'INTERNAL_ERROR',
        errors = null,      // 🆕 Lista de errores detallados
        data = null,
        meta = null,
        requestId = uuidv4()
    } = {}
) => {
    return res.status(statusCode).json({
        success: false,
        message,
        statusCode,
        errorCode,
        errors,            // 🆕 Nuevo campo para más contexto
        data,
        meta,
        timestamp: new Date().toISOString(),
        requestId
    });
};

module.exports = {
    successResponse,
    errorResponse
};
