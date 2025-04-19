const jwt = require('jsonwebtoken');

const SECRET_KEY = process.env.JWT_SECRET || 'clave_secreta'; // Usa variables de entorno en producción

/**
 * Genera un token JWT para un usuario.
 * @param {number|string} userId - ID del usuario.
 * @param {string} role - Rol del usuario.
 * @param {string} [expiresIn='1h'] - Tiempo de expiración del token.
 * @returns {string} - Token JWT generado.
 */
const generateToken = (userId, role, expiresIn = '1h') => {
    const payload = { userId, role };
    return jwt.sign(payload, SECRET_KEY, { expiresIn });
};

module.exports = { generateToken };
