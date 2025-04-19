const express = require('express');
const path = require('path');
const router = express.Router();

// ✅ Rutas de vistas públicas
const publicPath = path.join(__dirname, '../../web/public/views');

// 🎨 CLIENTE
router.get('/', (req, res) => res.sendFile(path.join(publicPath, 'client/index.html')));
router.get('/nosotros', (req, res) => res.sendFile(path.join(publicPath, 'client/about.html')));
router.get('/valores', (req, res) => res.sendFile(path.join(publicPath, 'client/mission-vision.html')));
router.get('/contacto', (req, res) => res.sendFile(path.join(publicPath, 'client/contact.html')));
router.get('/favoritos', (req, res) => res.sendFile(path.join(publicPath, 'client/featured.html')));
router.get('/promociones', (req, res) => res.sendFile(path.join(publicPath, 'client/promotions.html')));
router.get('/novedades', (req, res) => res.sendFile(path.join(publicPath, 'client/news.html')));

// 🌎 POLÍTICAS
router.get('/politicas/privacidad', (req, res) => res.sendFile(path.join(publicPath, 'client/policies/privacy-policy.html')));
router.get('/politicas/consumo-responsable', (req, res) => res.sendFile(path.join(publicPath, 'client/policies/responsible-drinking-policy.html')));
router.get('/politicas/envios-devoluciones', (req, res) => res.sendFile(path.join(publicPath, 'client/policies/shipping-and-returns.html')));
router.get('/politicas/terminos-condiciones', (req, res) => res.sendFile(path.join(publicPath, 'client/policies/terms-conditions.html')));

// 🛒 TIENDA
router.get('/tienda', (req, res) => res.sendFile(path.join(publicPath, 'client/store.html')));
router.get('/tienda/categoria', (req, res) => res.sendFile(path.join(publicPath, 'client/store/products/category.html')));
router.get('/tienda/categorias', (req, res) => res.sendFile(path.join(publicPath, 'client/store/products/categories.html')));
router.get('/tienda/producto', (req, res) => res.sendFile(path.join(publicPath, 'client/store/products/product.html')));
router.get('/tienda/productos', (req, res) => res.sendFile(path.join(publicPath, 'client/store/products/products.html')));
router.get('/tienda/carrito-compras', (req, res) => res.sendFile(path.join(publicPath, 'client/store/cart/cart.html')));
router.get('/tienda/confirmar-compra', (req, res) => res.sendFile(path.join(publicPath, 'client/store/cart/cart-settlement.html')));
router.get('/tienda/orden/seguimiento', (req, res) => res.sendFile(path.join(publicPath, 'client/store/orders/order-tracking.html')));
router.get('/tienda/orden/seguimiento/invitado', (req, res) => res.sendFile(path.join(publicPath, 'client/store/orders/guest-order-tracking.html')));
router.get('/tienda/pago/checkout', (req, res) => res.sendFile(path.join(publicPath, 'client/store/payments/checkout.html')));

// 👤 CLIENTE CUENTA
router.get('/cliente/ingreso', (req, res) => res.sendFile(path.join(publicPath, 'client/account/login.html')));
router.get('/cliente/registro', (req, res) => res.sendFile(path.join(publicPath, 'client/account/register.html')));
router.get('/cliente/cuenta', (req, res) => res.sendFile(path.join(publicPath, 'client/account/profile.html')));

// 🔐 ADMINISTRADOR
router.get('/administrador', (req, res) => res.sendFile(path.join(publicPath, 'admin/dashboard.html')));
router.get('/administrador/ingreso', (req, res) => res.sendFile(path.join(publicPath, 'admin/auth/login.html')));

// 🛒 ADMIN - CARRITOS
router.get('/administrador/carritos', (req, res) => res.sendFile(path.join(publicPath, 'admin/cart/list.html')));
router.get('/administrador/carrito/crear', (req, res) => res.sendFile(path.join(publicPath, 'admin/cart/create.html')));
router.get('/administrador/carrito/ver', (req, res) => res.sendFile(path.join(publicPath, 'admin/cart/show.html')));

// 🗂️ ADMIN - CATEGORÍAS
router.get('/administrador/categorias', (req, res) => res.sendFile(path.join(publicPath, 'admin/categories/list.html')));
router.get('/administrador/categoria/crear', (req, res) => res.sendFile(path.join(publicPath, 'admin/categories/create.html')));
router.get('/administrador/categoria/ver', (req, res) => res.sendFile(path.join(publicPath, 'admin/categories/show.html')));

module.exports = router;
