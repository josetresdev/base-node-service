const express = require('express');
const path = require('path');
const router = express.Router();

// ✅ Rutas de vistas públicas
const publicPath = path.join(__dirname, '../../web/public/views');

// 🎨 CLIENTE
router.get('/', (req, res) => res.sendFile(path.join(publicPath, 'client/index.html')));

// 🔐 ADMINISTRADOR
router.get('/administrador', (req, res) => res.sendFile(path.join(publicPath, 'admin/dashboard.html')));
router.get('/administrador/ingreso', (req, res) => res.sendFile(path.join(publicPath, 'admin/auth/login.html')));

module.exports = router;
