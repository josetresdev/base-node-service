const { URL } = require('url');

/**
 * Formatea la respuesta paginada de manera estandarizada
 * @param {Object} params
 * @param {Array} params.data - Resultados de la consulta
 * @param {number} params.totalItems - Total de registros encontrados
 * @param {number} params.currentPage - Página actual
 * @param {number} params.perPage - Registros por página
 * @param {string} params.baseUrl - Ruta base sin query params (req.originalUrl.split('?')[0])
 * @param {Object} params.query - Query params originales (para persistencia en links)
 * @param {string} params.sortBy - Campo de ordenamiento
 * @param {string} params.order - Dirección de orden (ASC o DESC)
 * @returns {Object} Respuesta paginada
 */
const formatPaginatedResponse = ({
    data,
    totalItems,
    currentPage = 1,
    perPage = 10,
    baseUrl,
    query = {},
    sortBy = 'created_at',
    order = 'DESC'
}) => {

    // Saneamiento de entradas
    currentPage = Math.max(1, parseInt(currentPage, 10) || 1);
    perPage = Math.max(1, parseInt(perPage, 10) || 10);

    const totalPages = Math.max(1, Math.ceil(totalItems / perPage));
    const hasNextPage = currentPage < totalPages;
    const hasPrevPage = currentPage > 1;

    const baseAppUrl = process.env.APP_URL || 'http://localhost:3000';

    const buildUrl = (page) => {
        const url = new URL(baseUrl, baseAppUrl);

        // Re-aplicar los query params existentes excepto page y perPage
        Object.keys(query).forEach((key) => {
            if (!['page', 'perPage'].includes(key)) {
                url.searchParams.set(key, query[key]);
            }
        });

        // Asegurarse de que page y perPage siempre estén presentes
        url.searchParams.set('page', page);
        url.searchParams.set('perPage', perPage);

        return url.pathname + url.search;
    };

    return {
        success: true,
        message: 'Paginated results fetched successfully',
        statusCode: 200,
        errorCode: null,
        data,
        pagination: {
            totalItems,
            currentPage,
            perPage,
            totalPages,
            hasNextPage,
            hasPrevPage
        },
        sort: {
            sortBy,
            order
        },
        links: {
            self: buildUrl(currentPage),
            next: hasNextPage ? buildUrl(currentPage + 1) : null,
            prev: hasPrevPage ? buildUrl(currentPage - 1) : null
        },
        meta: null, // Puedes agregar otros datos extra aquí
        timestamp: new Date().toISOString()
    };
};

module.exports = {
    formatPaginatedResponse
};
