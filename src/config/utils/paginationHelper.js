/**
 * Extrae y valida los parámetros de paginación y orden desde los query params.
 * Devuelve los valores normalizados y listos para usarse en los servicios Sequelize o SQL.
 *
 * @param {Object} query - Los query params enviados en la URL (req.query)
 * @returns {Object} - page, perPage, offset, sortBy, order
 */
const getPaginationParams = (query = {}) => {
    // Extraemos los valores desde el query string
    let { page, perPage, sortBy, order } = query;

    // ===============================
    // 🎛️ CONFIGURACIONES
    // ===============================
    const DEFAULT_PAGE = 1;
    const DEFAULT_PER_PAGE = 10;
    const DEFAULT_SORT_BY = 'created_at';
    const DEFAULT_ORDER = 'DESC';

    const MIN_LIMIT = 1;
    const MAX_LIMIT = 100;

    // ===============================
    // 🧹 NORMALIZACIÓN DE PARÁMETROS
    // ===============================

    // Page
    page = parseInt(page, 10);
    page = isNaN(page) || page < DEFAULT_PAGE ? DEFAULT_PAGE : page;

    // perPage
    perPage = parseInt(perPage, 10);
    if (isNaN(perPage)) perPage = DEFAULT_PER_PAGE;
    if (perPage < MIN_LIMIT) perPage = MIN_LIMIT;
    if (perPage > MAX_LIMIT) perPage = MAX_LIMIT;

    // sortBy
    sortBy = (typeof sortBy === 'string' && sortBy.trim()) || DEFAULT_SORT_BY;

    // order
    order = (order || DEFAULT_ORDER).toString().toUpperCase();
    if (!['ASC', 'DESC'].includes(order)) order = DEFAULT_ORDER;

    // Offset
    const offset = (page - 1) * perPage;

    return {
        page,
        perPage,
        offset,
        sortBy,
        order
    };
};

module.exports = {
    getPaginationParams
};
