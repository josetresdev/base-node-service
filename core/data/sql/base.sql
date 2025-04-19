-- ============================================================
-- 🧩 Resumen del Esquema: Plataforma de Comercio Electrónico + Gestión Administrativa
-- ============================================================
-- 🌐 Proyecto: TrebolDrinks — Backend Operativo y Administrativo
-- 🗓️ Versión: 1.0
-- 🧱 Motor: PostgreSQL

-- 📦 Módulos Principales:
-- 1️⃣  Autenticación:
--     - users, employees, customers
--     - sesiones, verificación, logs
-- 2️⃣  Permisos y Roles:
--     - roles, modules, actions
--     - asignación dinámica por rol
-- 3️⃣  Catálogo de Productos:
--     - parent_categories, categories, products, inventory
--     - reseñas, visibilidad, control de stock
-- 4️⃣  Pedidos y Pagos:
--     - orders, payments, payment_methods, payment_status, payment_channels
--     - cupones, shipping, historial de estado
-- 5️⃣  Carrito de Compras:
--     - cart, cart_items
-- 6️⃣  Localización y Clientes:
--     - countries, departments, cities, identity_types
-- 7️⃣  Funciones Extra:
--     - módulos promocionales, sistema de tickets, reseñas verificadas

-- 🚀 Características Clave:
--     ✅ Auditoría completa (created_at, updated_at, deleted_at, restored_at)
--     ✅ Soporte multicanal (web, mobile)
--     ✅ Validaciones e integridad de datos
--     ✅ Arquitectura escalable y modular
--     ✅ Documentación mantenible

-- 🔐 Seguridad y Flexibilidad:
--     - Roles y permisos granulares
--     - Tokens únicos por sesión
--     - Soft deletes
--     - Métodos de pago integrados

-- ✍️ Autor: Jose Luis Trespalacios
-- 🧑‍💼 Rol: CTO y Arquitecto de Software
-- 🏢 Compañía: BitLink Technology Partner, TrebolDrinks
-- 📅 Última modificación: 30/03/25
-- -- ============================================================================
-- 🗃️ ENTIDADES
-- ============================================================================
-- ================================================
-- 🗃️ Tabla: countries — Catálogo de países
-- ================================================
-- 🗃️ Tabla: countries — Catálogo de países
-- 📌 Uso: Base geográfica (país → depto → ciudad)
-- 🔗 Relación: departments.country_id
-- 📏 Unicidad: name, iso_code | Orden ≥ 0 | Activo/inactivo
-- 🌐 Campos: ISO (alfa-2), teléfono, idioma, bandera, orden
-- 🔄 Auditoría: created_at, updated_at, deleted_at, restored_at
-- ✍️ Jose Luis Trespalacios | CTO | BitLink | 📅 30/03/25
CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    iso_code CHAR(2) NOT NULL UNIQUE, -- Código ISO alfa-2 (ej: 'US', 'MX')
    phone_code VARCHAR(10),           -- Código telefónico internacional (ej: '+1', '+52')
    primary_language VARCHAR(100),    -- Idioma principal del país (ej: 'Español', 'Inglés')
    flag_url TEXT,                    -- URL o path de la bandera del país
    display_order INT DEFAULT 0 CHECK (display_order >= 0), -- orden en el frontend
    is_active BOOLEAN DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)), -- estado activo/inactivo
    deleted_at TIMESTAMP NULL,    -- borrado lógico (soft delete)
    restored_at TIMESTAMP NULL,   -- restauración de borrado lógico
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
INSERT INTO countries (
    name, iso_code, phone_code, primary_language, flag_url,
    display_order, is_active, created_at, updated_at, deleted_at, restored_at
)
VALUES
-- 🇨🇴 Sede Principal
('Colombia', 'CO', '+57', 'Español', 'https://flags.example.com/co.svg', 1, TRUE, NOW(), NOW(), NULL, NULL),
-- 🌎 LATAM estratégica
('México', 'MX', '+52', 'Español', 'https://flags.example.com/mx.svg', 2, TRUE, NOW(), NOW(), NULL, NULL),
('Chile', 'CL', '+56', 'Español', 'https://flags.example.com/cl.svg', 3, TRUE, NOW(), NOW(), NULL, NULL),
('Ecuador', 'EC', '+593', 'Español', 'https://flags.example.com/ec.svg', 4, TRUE, NOW(), NOW(), NULL, NULL),
('Perú', 'PE', '+51', 'Español', 'https://flags.example.com/pe.svg', 5, TRUE, NOW(), NOW(), NULL, NULL),
('Argentina', 'AR', '+54', 'Español', 'https://flags.example.com/ar.svg', 6, TRUE, NOW(), NOW(), NULL, NULL),
('Brasil', 'BR', '+55', 'Portugués', 'https://flags.example.com/br.svg', 7, TRUE, NOW(), NOW(), NULL, NULL),
('Panamá', 'PA', '+507', 'Español', 'https://flags.example.com/pa.svg', 8, TRUE, NOW(), NOW(), NULL, NULL),
('Uruguay', 'UY', '+598', 'Español', 'https://flags.example.com/uy.svg', 9, TRUE, NOW(), NOW(), NULL, NULL),
('Paraguay', 'PY', '+595', 'Español', 'https://flags.example.com/py.svg', 10, TRUE, NOW(), NOW(), NULL, NULL),
('Costa Rica', 'CR', '+506', 'Español', 'https://flags.example.com/cr.svg', 11, TRUE, NOW(), NOW(), NULL, NULL),
-- 🇺🇸 Norteamérica clave
('Estados Unidos', 'US', '+1', 'Inglés', 'https://flags.example.com/us.svg', 12, TRUE, NOW(), NOW(), NULL, NULL),
('Canadá', 'CA', '+1', 'Inglés / Francés', 'https://flags.example.com/ca.svg', 13, TRUE, NOW(), NOW(), NULL, NULL),
-- 🌍 Europa Occidental
('España', 'ES', '+34', 'Español', 'https://flags.example.com/es.svg', 14, TRUE, NOW(), NOW(), NULL, NULL),
('Portugal', 'PT', '+351', 'Portugués', 'https://flags.example.com/pt.svg', 15, TRUE, NOW(), NOW(), NULL, NULL),
-- 🌍 Europa Central
('Francia', 'FR', '+33', 'Francés', 'https://flags.example.com/fr.svg', 16, TRUE, NOW(), NOW(), NULL, NULL),
('Alemania', 'DE', '+49', 'Alemán', 'https://flags.example.com/de.svg', 17, TRUE, NOW(), NOW(), NULL, NULL),
('Italia', 'IT', '+39', 'Italiano', 'https://flags.example.com/it.svg', 18, TRUE, NOW(), NOW(), NULL, NULL),
('Países Bajos', 'NL', '+31', 'Neerlandés', 'https://flags.example.com/nl.svg', 19, TRUE, NOW(), NOW(), NULL, NULL),
('Bélgica', 'BE', '+32', 'Neerlandés / Francés / Alemán', 'https://flags.example.com/be.svg', 20, TRUE, NOW(), NOW(), NULL, NULL),
-- 🌍 Europa Nórdica
('Suecia', 'SE', '+46', 'Sueco', 'https://flags.example.com/se.svg', 21, TRUE, NOW(), NOW(), NULL, NULL),
('Dinamarca', 'DK', '+45', 'Danés', 'https://flags.example.com/dk.svg', 22, TRUE, NOW(), NOW(), NULL, NULL),
-- 🌍 Europa diversa con hubs logísticos
('Suiza', 'CH', '+41', 'Alemán / Francés / Italiano', 'https://flags.example.com/ch.svg', 23, TRUE, NOW(), NOW(), NULL, NULL),
('Reino Unido', 'GB', '+44', 'Inglés', 'https://flags.example.com/gb.svg', 24, TRUE, NOW(), NOW(), NULL, NULL);
-- ================================================
-- 🗃️ Tabla: departments — Catálogo de departamentos/regiones
-- ================================================
-- 🗃️ Tabla: departments — Catálogo de departamentos/estados
-- 📌 Uso: Subdivisión geográfica por país (país → depto)
-- 🔗 Relación: countries.country_id (ON DELETE CASCADE)
-- 📏 Unicidad: name | Orden ≥ 0 | Activo/inactivo
-- 🌐 Campos: idioma, bandera, orden de visualización
-- 🔄 Auditoría: created_at, updated_at, deleted_at, restored_at
-- ✍️ Jose Luis Trespalacios | CTO | BitLink | 📅 30/03/25
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    country_id INTEGER NOT NULL REFERENCES countries(country_id) ON DELETE CASCADE,
    primary_language VARCHAR(100),  -- Idioma principal del departamento/estado
    flag_url TEXT,                  -- URL o path de la bandera del departamento
    display_order INTEGER DEFAULT 0 CHECK (display_order >= 0),
    is_active BOOLEAN DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),
    deleted_at TIMESTAMP NULL,
    restored_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
-- ✍️ INSERT de datos
INSERT INTO departments (
    name,
    country_id,
    primary_language,
    flag_url,
    display_order,
    is_active,
    created_at,
    updated_at,
    deleted_at,
    restored_at
) VALUES
-- 🇨🇴 Colombia (country_id = 1)
('Cundinamarca', 1, 'Español', 'https://flags.example.com/co-cundinamarca.svg', 1, TRUE, NOW(), NOW(), NULL, NULL),
('Antioquia', 1, 'Español', 'https://flags.example.com/co-antioquia.svg', 2, TRUE, NOW(), NOW(), NULL, NULL),
('Valle del Cauca', 1, 'Español', 'https://flags.example.com/co-valle.svg', 3, TRUE, NOW(), NOW(), NULL, NULL),
('Atlántico', 1, 'Español', 'https://flags.example.com/co-atlantico.svg', 4, TRUE, NOW(), NOW(), NULL, NULL),
('Bolívar', 1, 'Español', 'https://flags.example.com/co-bolivar.svg', 5, TRUE, NOW(), NOW(), NULL, NULL),
('Santander', 1, 'Español', 'https://flags.example.com/co-santander.svg', 6, TRUE, NOW(), NOW(), NULL, NULL),
-- 🇲🇽 México (country_id = 2)
('Ciudad de México', 2, 'Español', 'https://flags.example.com/mx-cdmx.svg', 1, TRUE, NOW(), NOW(), NULL, NULL),
('Jalisco', 2, 'Español', 'https://flags.example.com/mx-jalisco.svg', 2, TRUE, NOW(), NOW(), NULL, NULL),
('Nuevo León', 2, 'Español', 'https://flags.example.com/mx-nuevoleon.svg', 3, TRUE, NOW(), NOW(), NULL, NULL),
('Estado de México', 2, 'Español', 'https://flags.example.com/mx-edomex.svg', 4, TRUE, NOW(), NOW(), NULL, NULL),
('Querétaro', 2, 'Español', 'https://flags.example.com/mx-queretaro.svg', 5, TRUE, NOW(), NOW(), NULL, NULL),
-- 🇨🇱 Chile (country_id = 3)
('Región Metropolitana', 3, 'Español', 'https://flags.example.com/cl-metropolitana.svg', 1, TRUE, NOW(), NOW(), NULL, NULL),
('Valparaíso', 3, 'Español', 'https://flags.example.com/cl-valparaiso.svg', 2, TRUE, NOW(), NOW(), NULL, NULL),
('Biobío', 3, 'Español', 'https://flags.example.com/cl-biobio.svg', 3, TRUE, NOW(), NOW(), NULL, NULL),
-- 🇪🇨 Ecuador (country_id = 4)
('Pichincha', 4, 'Español', 'https://flags.example.com/ec-pichincha.svg', 1, TRUE, NOW(), NOW(), NULL, NULL),
('Guayas', 4, 'Español', 'https://flags.example.com/ec-guayas.svg', 2, TRUE, NOW(), NOW(), NULL, NULL),
('Azuay', 4, 'Español', 'https://flags.example.com/ec-azuay.svg', 3, TRUE, NOW(), NOW(), NULL, NULL),
-- 🇵🇪 Perú (country_id = 5)
('Lima', 5, 'Español', 'https://flags.example.com/pe-lima.svg', 1, TRUE, NOW(), NOW(), NULL, NULL),
('Arequipa', 5, 'Español', 'https://flags.example.com/pe-arequipa.svg', 2, TRUE, NOW(), NOW(), NULL, NULL),
('La Libertad', 5, 'Español', 'https://flags.example.com/pe-lalibertad.svg', 3, TRUE, NOW(), NOW(), NULL, NULL),
-- 🇦🇷 Argentina (country_id = 6)
('Buenos Aires', 6, 'Español', 'https://flags.example.com/ar-buenosaires.svg', 1, TRUE, NOW(), NOW(), NULL, NULL),
('Ciudad Autónoma de Buenos Aires', 6, 'Español', 'https://flags.example.com/ar-caba.svg', 2, TRUE, NOW(), NOW(), NULL, NULL),
('Córdoba', 6, 'Español', 'https://flags.example.com/ar-cordoba.svg', 3, TRUE, NOW(), NOW(), NULL, NULL),
('Santa Fe', 6, 'Español', 'https://flags.example.com/ar-santafe.svg', 4, TRUE, NOW(), NOW(), NULL, NULL),
-- 🇧🇷 Brasil (country_id = 7)
('São Paulo', 7, 'Portugués', 'https://flags.example.com/br-saopaulo.svg', 1, TRUE, NOW(), NOW(), NULL, NULL),
('Rio de Janeiro', 7, 'Portugués', 'https://flags.example.com/br-riodejaneiro.svg', 2, TRUE, NOW(), NOW(), NULL, NULL),
('Minas Gerais', 7, 'Portugués', 'https://flags.example.com/br-minasgerais.svg', 3, TRUE, NOW(), NOW(), NULL, NULL),
('Paraná', 7, 'Portugués', 'https://flags.example.com/br-parana.svg', 4, TRUE, NOW(), NOW(), NULL, NULL),
-- 🇺🇸 Estados Unidos (country_id = 8)
('Florida', 8, 'Inglés', 'https://flags.example.com/us-florida.svg', 1, TRUE, NOW(), NOW(), NULL, NULL),
('Texas', 8, 'Inglés', 'https://flags.example.com/us-texas.svg', 2, TRUE, NOW(), NOW(), NULL, NULL),
('California', 8, 'Inglés', 'https://flags.example.com/us-california.svg', 3, TRUE, NOW(), NOW(), NULL, NULL),
('Nueva York', 8, 'Inglés', 'https://flags.example.com/us-newyork.svg', 4, TRUE, NOW(), NOW(), NULL, NULL),
('Illinois', 8, 'Inglés', 'https://flags.example.com/us-illinois.svg', 5, TRUE, NOW(), NOW(), NULL, NULL),
-- 🇨🇦 Canadá (country_id = 9)
('Ontario', 9, 'Inglés', 'https://flags.example.com/ca-ontario.svg', 1, TRUE, NOW(), NOW(), NULL, NULL),
('Quebec', 9, 'Francés', 'https://flags.example.com/ca-quebec.svg', 2, TRUE, NOW(), NOW(), NULL, NULL),
('Columbia Británica', 9, 'Inglés', 'https://flags.example.com/ca-britishcolumbia.svg', 3, TRUE, NOW(), NOW(), NULL, NULL),
-- 🇪🇸 España (country_id = 10)
('Madrid', 10, 'Español', 'https://flags.example.com/es-madrid.svg', 1, TRUE, NOW(), NOW(), NULL, NULL),
('Cataluña', 10, 'Catalán / Español', 'https://flags.example.com/es-catalunya.svg', 2, TRUE, NOW(), NOW(), NULL, NULL),
('Andalucía', 10, 'Español', 'https://flags.example.com/es-andalucia.svg', 3, TRUE, NOW(), NOW(), NULL, NULL),
('Valencia', 10, 'Valenciano / Español', 'https://flags.example.com/es-valencia.svg', 4, TRUE, NOW(), NOW(), NULL, NULL),
-- 🇫🇷 Francia (country_id = 11)
('Île-de-France', 11, 'Francés', 'https://flags.example.com/fr-idf.svg', 1, TRUE, NOW(), NOW(), NULL, NULL),
('Auvernia-Ródano-Alpes', 11, 'Francés', 'https://flags.example.com/fr-ara.svg', 2, TRUE, NOW(), NOW(), NULL, NULL),
('Occitania', 11, 'Francés', 'https://flags.example.com/fr-occitania.svg', 3, TRUE, NOW(), NOW(), NULL, NULL),
-- 🇩🇪 Alemania (country_id = 12)
('Baviera', 12, 'Alemán', 'https://flags.example.com/de-baviera.svg', 1, TRUE, NOW(), NOW(), NULL, NULL),
('Renania del Norte-Westfalia', 12, 'Alemán', 'https://flags.example.com/de-renania.svg', 2, TRUE, NOW(), NOW(), NULL, NULL),
('Berlín', 12, 'Alemán', 'https://flags.example.com/de-berlin.svg', 3, TRUE, NOW(), NOW(), NULL, NULL);
-- ================================================
-- 🗃️ Tabla: cities — Catálogo de ciudades o municipios
-- ================================================
-- 🗃️ Tabla: cities — Catálogo de ciudades o municipios
-- 📌 Uso: Tercer nivel geográfico (país → depto → ciudad)
-- 🔗 Relación: departments.department_id (ON DELETE CASCADE)
-- 📏 Unicidad: name | Orden ≥ 0 | Activo/inactivo
-- 🌐 Campos: idioma, bandera, orden de visualización
-- 🔄 Auditoría: created_at, updated_at, deleted_at, restored_at
-- ✍️ Jose Luis Trespalacios | CTO | BitLink | 📅 30/03/25
CREATE TABLE cities (
    city_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    department_id INTEGER NOT NULL REFERENCES departments(department_id) ON DELETE CASCADE,
    primary_language VARCHAR(100),  -- Idioma principal en la ciudad o municipio
    flag_url TEXT,                  -- URL o path de la bandera local (si aplica)
    display_order INTEGER NOT NULL DEFAULT 0 CHECK (display_order >= 0),
    is_active BOOLEAN NOT NULL DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),
    deleted_at TIMESTAMP NULL,
    restored_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
-- ✍️ INSERT de datos
INSERT INTO cities (
    name,
    department_id,
    primary_language,
    flag_url,
    display_order,
    is_active,
    created_at,
    updated_at,
    deleted_at,
    restored_at
) VALUES
('Bogotá', 1, 'Español', 'https://flags.example.com/co-bogota.svg', 0, TRUE, NOW(), NOW(), NULL, NULL),
('Medellín', 2, 'Español', 'https://flags.example.com/co-medellin.svg', 1, TRUE, NOW(), NOW(), NULL, NULL),
('Envigado', 2, 'Español', 'https://flags.example.com/co-envigado.svg', 2, TRUE, NOW(), NOW(), NULL, NULL),
('Itagüí', 2, 'Español', 'https://flags.example.com/co-itagui.svg', 3, TRUE, NOW(), NOW(), NULL, NULL),
('Cali', 3, 'Español', 'https://flags.example.com/co-cali.svg', 4, TRUE, NOW(), NOW(), NULL, NULL),
('Palmira', 3, 'Español', 'https://flags.example.com/co-palmira.svg', 5, TRUE, NOW(), NOW(), NULL, NULL),
('Barranquilla', 4, 'Español', 'https://flags.example.com/co-barranquilla.svg', 6, TRUE, NOW(), NOW(), NULL, NULL),
('Soledad', 4, 'Español', 'https://flags.example.com/co-soledad.svg', 7, TRUE, NOW(), NOW(), NULL, NULL),
('Cartagena', 5, 'Español', 'https://flags.example.com/co-cartagena.svg', 8, TRUE, NOW(), NOW(), NULL, NULL),
('Turbaco', 5, 'Español', 'https://flags.example.com/co-turbaco.svg', 9, TRUE, NOW(), NOW(), NULL, NULL),
('Bucaramanga', 6, 'Español', 'https://flags.example.com/co-bucaramanga.svg', 10, TRUE, NOW(), NOW(), NULL, NULL),
('Floridablanca', 6, 'Español', 'https://flags.example.com/co-floridablanca.svg', 11, TRUE, NOW(), NOW(), NULL, NULL),
('Pereira', 7, 'Español', 'https://flags.example.com/co-pereira.svg', 12, TRUE, NOW(), NOW(), NULL, NULL),
('Dosquebradas', 7, 'Español', 'https://flags.example.com/co-dosquebradas.svg', 13, TRUE, NOW(), NOW(), NULL, NULL),
('Manizales', 8, 'Español', 'https://flags.example.com/co-manizales.svg', 14, TRUE, NOW(), NOW(), NULL, NULL),
('Villamaría', 8, 'Español', 'https://flags.example.com/co-villamaria.svg', 15, TRUE, NOW(), NOW(), NULL, NULL),
('Cúcuta', 9, 'Español', 'https://flags.example.com/co-cucuta.svg', 16, TRUE, NOW(), NOW(), NULL, NULL),
('Villa del Rosario', 9, 'Español', 'https://flags.example.com/co-villadelrosario.svg', 17, TRUE, NOW(), NOW(), NULL, NULL),
('Santa Marta', 10, 'Español', 'https://flags.example.com/co-santamarta.svg', 18, TRUE, NOW(), NOW(), NULL, NULL),
('Ciénaga', 10, 'Español', 'https://flags.example.com/co-cienaga.svg', 19, TRUE, NOW(), NOW(), NULL, NULL),
('Monterrey', 11, 'Español', 'https://flags.example.com/mx-monterrey.svg', 20, TRUE, NOW(), NOW(), NULL, NULL),
('Guadalajara', 12, 'Español', 'https://flags.example.com/mx-guadalajara.svg', 21, TRUE, NOW(), NOW(), NULL, NULL),
('Cancún', 13, 'Español', 'https://flags.example.com/mx-cancun.svg', 22, TRUE, NOW(), NOW(), NULL, NULL),
('Playa del Carmen', 13, 'Español', 'https://flags.example.com/mx-playadelcarmen.svg', 23, TRUE, NOW(), NOW(), NULL, NULL),
('Santiago', 14, 'Español', 'https://flags.example.com/cl-santiago.svg', 24, TRUE, NOW(), NOW(), NULL, NULL),
('Guayaquil', 15, 'Español', 'https://flags.example.com/ec-guayaquil.svg', 25, TRUE, NOW(), NOW(), NULL, NULL),
('Quito', 16, 'Español', 'https://flags.example.com/ec-quito.svg', 26, TRUE, NOW(), NOW(), NULL, NULL),
('Lima', 17, 'Español', 'https://flags.example.com/pe-lima.svg', 27, TRUE, NOW(), NOW(), NULL, NULL),
('Arequipa', 18, 'Español', 'https://flags.example.com/pe-arequipa.svg', 28, TRUE, NOW(), NOW(), NULL, NULL),
('São Paulo', 19, 'Portugués', 'https://flags.example.com/br-saopaulo.svg', 29, TRUE, NOW(), NOW(), NULL, NULL),
('Campinas', 19, 'Portugués', 'https://flags.example.com/br-campinas.svg', 30, TRUE, NOW(), NOW(), NULL, NULL),
('Ciudad de Panamá', 20, 'Español', 'https://flags.example.com/pa-ciudad.svg', 31, TRUE, NOW(), NOW(), NULL, NULL),
('Buenos Aires', 21, 'Español', 'https://flags.example.com/ar-buenosaires.svg', 32, TRUE, NOW(), NOW(), NULL, NULL),
('La Paz', 22, 'Español', 'https://flags.example.com/bo-lapaz.svg', 33, TRUE, NOW(), NOW(), NULL, NULL),
('Asunción', 23, 'Español', 'https://flags.example.com/py-asuncion.svg', 34, TRUE, NOW(), NOW(), NULL, NULL),
('Caracas', 24, 'Español', 'https://flags.example.com/ve-caracas.svg', 35, TRUE, NOW(), NOW(), NULL, NULL),
('Montevideo', 25, 'Español', 'https://flags.example.com/uy-montevideo.svg', 36, TRUE, NOW(), NOW(), NULL, NULL),
('San José', 26, 'Español', 'https://flags.example.com/cr-sanjose.svg', 37, TRUE, NOW(), NOW(), NULL, NULL),
('Madrid', 27, 'Español', 'https://flags.example.com/es-madrid.svg', 38, TRUE, NOW(), NOW(), NULL, NULL),
('Alcalá de Henares', 27, 'Español', 'https://flags.example.com/es-alcala.svg', 39, TRUE, NOW(), NOW(), NULL, NULL),
('Barcelona', 28, 'Catalán / Español', 'https://flags.example.com/es-barcelona.svg', 40, TRUE, NOW(), NOW(), NULL, NULL),
('Lisboa', 29, 'Portugués', 'https://flags.example.com/pt-lisboa.svg', 41, TRUE, NOW(), NOW(), NULL, NULL),
('Berlín', 30, 'Alemán', 'https://flags.example.com/de-berlin.svg', 42, TRUE, NOW(), NOW(), NULL, NULL),
('París', 31, 'Francés', 'https://flags.example.com/fr-paris.svg', 43, TRUE, NOW(), NOW(), NULL, NULL),
('Milán', 32, 'Italiano', 'https://flags.example.com/it-milan.svg', 44, TRUE, NOW(), NOW(), NULL, NULL),
('Ámsterdam', 33, 'Neerlandés', 'https://flags.example.com/nl-amsterdam.svg', 45, TRUE, NOW(), NOW(), NULL, NULL);
-- ================================================
-- 🗃️ Tabla: identity_types — Tipos de documento de identidad
-- ================================================
-- 🗃️ Tabla: identity_types — Tipos de documento de identidad
-- 📌 Uso: Clasificación de documentos (ej: DNI, pasaporte)
-- 📏 Unicidad: name | Orden ≥ 0 | Activo/inactivo
-- 🌐 Campos: nombre, descripción, orden de visualización
-- 🔄 Auditoría: created_at, updated_at, deleted_at, restored_at
-- ✍️ Jose Luis Trespalacios | CTO | BitLink | 📅 30/03/25
CREATE TABLE identity_types (
    identity_type_id SMALLSERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255),
    display_order INTEGER DEFAULT 0 CHECK (display_order >= 0),
    is_active BOOLEAN DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),
    deleted_at TIMESTAMP NULL,
    restored_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
-- ✍️ INSERT de datos
INSERT INTO identity_types (name, description, display_order, is_active)
VALUES
-- 🌍 Documentos globales
('PASSPORT', 'Pasaporte internacional válido para viajes', 1, TRUE),
-- 🇨🇴 Colombia
('CC', 'Cédula de ciudadanía para residentes colombianos', 2, TRUE),
('CE', 'Cédula de extranjería para extranjeros en Colombia', 3, TRUE),
('TI', 'Tarjeta de identidad para menores de edad en Colombia', 4, TRUE),
('NIT', 'Número de identificación tributaria (Colombia)', 5, TRUE),
('RUT', 'Registro único tributario para empresas (Colombia)', 6, TRUE),
-- 🇲🇽 México
('CURP', 'Clave Única de Registro de Población (México)', 7, FALSE),
('RFC', 'Registro Federal de Contribuyentes (México)', 8, FALSE),
('IFE', 'Credencial del Instituto Nacional Electoral (México)', 9, FALSE),
-- 🇨🇱 Chile
('RUN', 'Rol Único Nacional (Chile)', 10, FALSE),
('RUT_CL', 'Rol Único Tributario (Chile)', 11, FALSE),
-- 🇦🇷 Argentina
('DNI', 'Documento Nacional de Identidad (Argentina)', 12, FALSE),
('CUIL', 'Código Único de Identificación Laboral (Argentina)', 13, FALSE),
('CUIT', 'Código Único de Identificación Tributaria (Argentina)', 14, FALSE),
-- 🇪🇸 España
('DNI_ES', 'Documento Nacional de Identidad (España)', 15, FALSE),
('NIE', 'Número de Identificación de Extranjero (España)', 16, FALSE),
('CIF', 'Código de Identificación Fiscal (España)', 17, FALSE),
-- 🇵🇪 Perú
('DNI_PE', 'Documento Nacional de Identidad (Perú)', 18, FALSE),
('RUC', 'Registro Único de Contribuyentes (Perú)', 19, FALSE),
-- 🇺🇸 Estados Unidos
('SSN', 'Social Security Number (EE.UU.)', 20, FALSE),
('ITIN', 'Individual Taxpayer Identification Number (EE.UU.)', 21, FALSE);
-- ================================================
-- 🗃️ Tabla: areas — Áreas organizacionales o funcionales
-- ================================================
-- 🗃️ Tabla: areas — Áreas organizacionales o funcionales
-- 📌 Uso: Agrupación de funciones o departamentos internos
-- 📏 Unicidad: name | Activo/inactivo
-- 🌐 Campos: nombre, descripción
-- 🔄 Auditoría: created_at, updated_at, deleted_at, restored_at
-- ✍️ Jose Luis Trespalacios | CTO | BitLink | 📅 30/03/25
CREATE TABLE areas (
    area_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),
    deleted_at TIMESTAMP NULL,
    restored_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
-- ✍️ INSERT de datos
INSERT INTO areas (name, description) VALUES
('Administración', 'Área encargada de la gestión general de la empresa'),
('Logística', 'Área que gestiona el almacenamiento y distribución de productos'),
('Desarrollo', 'Área técnica de desarrollo de software y tecnología'),
('Atención al Cliente', 'Área dedicada a soporte y relación con clientes'),
('Marketing', 'Área encargada de publicidad, marca y adquisición de usuarios'),
('Ventas', 'Área responsable de los procesos comerciales y conversión');
-- ================================================
-- 🗃️ Tabla: positions — Cargos o puestos laborales
-- ================================================
-- 🗃️ Tabla: positions — Cargos o puestos laborales
-- 📌 Uso: Definición de roles laborales dentro del área o empresa
-- 📏 Unicidad: name | Salario base ≥ 0 | Activo/inactivo
-- 🌐 Campos: nombre, descripción, salario base
-- 🔄 Auditoría: created_at, updated_at, deleted_at, restored_at
-- ✍️ Jose Luis Trespalacios | CTO | BitLink | 📅 30/03/25
CREATE TABLE positions (
    position_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    base_salary NUMERIC(12, 2) CHECK (base_salary >= 0),
    is_active BOOLEAN DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),
    deleted_at TIMESTAMP NULL,
    restored_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
-- ✍️ INSERT de datos
INSERT INTO positions (name, description, base_salary) VALUES
('Administrador General', 'Responsable de toda la operación', 7000000),
('Gerente de Logística', 'Encargado de la operación logística', 5000000),
('Desarrollador Backend', 'Encargado de sistemas y backend del ecommerce', 4500000),
('Agente de Soporte', 'Brinda atención al cliente', 2200000),
('Diseñador UX/UI', 'Responsable de diseño e interfaz de usuario', 4000000),
('Especialista en Marketing Digital', 'Planifica y ejecuta campañas', 3500000),
('Ejecutivo de Ventas', 'Gestiona ventas y seguimiento a clientes', 3000000);
-- ===========================================================
-- 🌐 GESTIÓN DE USUARIOS, ROLES Y PERMISOS PARA ECOMMERCE
-- 🔄 Relacionando: empleados, clientes y usuarios
-- 📅 Versión optimizada y corregida: 30/03/2025
-- ===========================================================
-- ===========================================
-- 1. ROLES DEL SISTEMA
-- ===========================================
CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    slug VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    scope VARCHAR(50) NOT NULL CHECK (scope IN ('admin', 'frontend', 'both')) DEFAULT 'both',
    is_active BOOLEAN DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),
    deleted_at TIMESTAMP DEFAULT NULL,
    restored_at TIMESTAMP DEFAULT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
INSERT INTO roles (name, slug, description, scope) VALUES
('Admin', 'admin', 'Acceso total al sistema', 'admin'),
('Supervisor', 'supervisor', 'Supervisa operaciones y gestión general', 'admin'),
('Vendedor', 'vendedor', 'Gestión de productos y pedidos', 'admin'),
('Inventarista', 'inventarista', 'Control de inventario y stock', 'admin'),
('Soporte', 'soporte', 'Atención al cliente y gestión de tickets', 'admin'),
('Call Center', 'call-center', 'Atención telefónica a clientes', 'admin'),
('Marketing', 'marketing', 'Gestión de campañas y promociones', 'admin'),
('Diseñador', 'disenador', 'Gestión de interfaz visual y UX/UI', 'admin'),
('Auditor', 'auditor', 'Revisión y control de registros del sistema', 'admin'),
('Cliente', 'cliente', 'Acceso cliente desde frontend', 'frontend'),
('Invitado', 'invitado', 'Solo vista pública sin acceso autenticado', 'frontend');

-- ===========================================
-- 2. MÓDULOS Y ACCIONES DEL SISTEMA
-- ===========================================
CREATE TABLE modules (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    slug VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    icon VARCHAR(100),
    group_name VARCHAR(100),
    show_in_menu BOOLEAN DEFAULT TRUE,
    is_public BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),
    deleted_at TIMESTAMP DEFAULT NULL,
    restored_at TIMESTAMP DEFAULT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
INSERT INTO modules (
    name, slug, description, icon, group_name, show_in_menu, is_public, is_active, created_at, updated_at
) VALUES
('Dashboard', 'dashboard', 'Panel administrativo general', 'layout-dashboard', 'Administración', TRUE, FALSE, TRUE, NOW(), NOW()),
('Configuración', 'configuracion', 'Configuración general del sistema', 'settings', 'Administración', TRUE, FALSE, TRUE, NOW(), NOW()),
('Empleados', 'empleados', 'Gestión del personal interno', 'users', 'Administración', TRUE, FALSE, TRUE, NOW(), NOW()),
('Roles y Permisos', 'roles-permisos', 'Gestión de roles y acciones del sistema', 'lock', 'Administración', TRUE, FALSE, TRUE, NOW(), NOW()),
('Órdenes', 'ordenes', 'Gestión de pedidos de clientes', 'shopping-cart', 'Ventas', TRUE, FALSE, TRUE, NOW(), NOW()),
('Pagos', 'pagos', 'Control de transacciones y métodos de pago', 'credit-card', 'Ventas', TRUE, FALSE, TRUE, NOW(), NOW()),
('Cupones', 'cupones', 'Descuentos promocionales aplicables a órdenes', 'ticket-percent', 'Ventas', TRUE, FALSE, TRUE, NOW(), NOW()),
('Clientes', 'clientes', 'Gestión de clientes registrados', 'user', 'Clientes', TRUE, FALSE, TRUE, NOW(), NOW()),
('Soporte al Cliente', 'soporte-cliente', 'Sistema de tickets y atención', 'life-buoy', 'Clientes', TRUE, FALSE, TRUE, NOW(), NOW()),
('Productos', 'productos', 'Listado y edición de productos', 'box', 'Catálogo', TRUE, FALSE, TRUE, NOW(), NOW()),
('Inventario', 'inventario', 'Control de stock y disponibilidad', 'archive', 'Catálogo', TRUE, FALSE, TRUE, NOW(), NOW()),
('Categorías', 'categorias', 'Gestión jerárquica de categorías', 'tags', 'Catálogo', TRUE, FALSE, TRUE, NOW(), NOW()),
('Envíos', 'envios', 'Gestión de envíos y proveedores logísticos', 'truck', 'Logística', TRUE, FALSE, TRUE, NOW(), NOW()),
('Tarifas de Envío', 'tarifas-envio', 'Control de tarifas por peso/método', 'dollar-sign', 'Logística', TRUE, FALSE, TRUE, NOW(), NOW()),
('Promociones', 'promociones', 'Promociones visibles en el frontend', 'sparkles', 'Marketing', TRUE, FALSE, TRUE, NOW(), NOW()),
('Localización', 'localizacion', 'Gestión de países, departamentos y ciudades', 'globe', 'Geografía', TRUE, FALSE, TRUE, NOW(), NOW()),
('Tipos de Documento', 'tipos-documento', 'Tipos de identidad válidos para clientes', 'id-card', 'Geografía', TRUE, FALSE, TRUE, NOW(), NOW()),
('Logs de Pagos', 'logs-pagos', 'Historial y trazabilidad de pagos', 'file-text', 'Auditoría', TRUE, FALSE, TRUE, NOW(), NOW()),
('Historial de Órdenes', 'historial-ordenes', 'Cambios y trazabilidad de órdenes', 'clock', 'Auditoría', TRUE, FALSE, TRUE, NOW(), NOW()),
('Promociones Frontend', 'frontend-promociones', 'Promociones visibles en tienda', 'star', 'Frontend Público', FALSE, TRUE, TRUE, NOW(), NOW())
;

-- ===========================================
-- 3. USUARIOS DEL SISTEMA
-- ===========================================
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    is_verified BOOLEAN NOT NULL DEFAULT FALSE,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    last_login TIMESTAMP DEFAULT NULL,
    notes TEXT DEFAULT NULL,
    deleted_at TIMESTAMP DEFAULT NULL,
    restored_at TIMESTAMP DEFAULT NULL,
    created_by UUID REFERENCES users(id) ON DELETE SET NULL,
    updated_by UUID REFERENCES users(id) ON DELETE SET NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);
-- ===========================================
-- 4. RELACIÓN ROLES ↔ USUARIOS
-- ===========================================
CREATE TABLE user_roles (
    id SERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role_id INT NOT NULL REFERENCES roles(id) ON DELETE CASCADE,
    deleted_at TIMESTAMP DEFAULT NULL,
    restored_at TIMESTAMP DEFAULT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE actions (
    id SERIAL PRIMARY KEY,
    module_id INT NOT NULL REFERENCES modules(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),
    deleted_at TIMESTAMP NULL,
    restored_at TIMESTAMP NULL,
    created_by UUID REFERENCES users(id) ON DELETE SET NULL,
    updated_by UUID REFERENCES users(id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(module_id, slug)
);
INSERT INTO actions (module_id, name, slug, description, created_at, updated_at)
SELECT m.id, a.name, a.slug, a.description, NOW(), NOW()
FROM modules m
JOIN (
    -- Acciones comunes
    VALUES
        ('dashboard',        'Ver',     'view',     'Visualizar el panel general'),
        -- Configuración del sistema
        ('configuracion',    'Ver',     'view',     'Ver configuración general'),
        ('configuracion',    'Editar',  'update',   'Modificar parámetros del sistema'),
        -- Empleados
        ('empleados',        'Ver',     'view',     'Ver listado de empleados'),
        ('empleados',        'Crear',   'create',   'Agregar nuevo empleado'),
        ('empleados',        'Editar',  'update',   'Actualizar datos del empleado'),
        ('empleados',        'Eliminar','delete',   'Eliminar o desactivar empleado'),
        -- Roles y permisos
        ('roles-permisos',   'Ver',     'view',     'Ver roles y permisos'),
        ('roles-permisos',   'Crear',   'create',   'Crear nuevos roles o acciones'),
        ('roles-permisos',   'Editar',  'update',   'Actualizar roles existentes'),
        ('roles-permisos',   'Eliminar','delete',   'Eliminar rol o permiso'),
        -- Órdenes
        ('ordenes',          'Ver',     'view',     'Ver órdenes registradas'),
        ('ordenes',          'Editar',  'update',   'Actualizar estado de la orden'),
        ('ordenes',          'Cancelar','cancel',   'Cancelar orden de cliente'),
        -- Pagos
        ('pagos',            'Ver',     'view',     'Ver pagos y transacciones'),
        ('pagos',            'Reembolsar','refund', 'Gestionar devoluciones de dinero'),
        -- Cupones
        ('cupones',          'Ver',     'view',     'Ver cupones registrados'),
        ('cupones',          'Crear',   'create',   'Crear cupones de descuento'),
        ('cupones',          'Editar',  'update',   'Editar cupones existentes'),
        ('cupones',          'Eliminar','delete',   'Eliminar o desactivar cupones'),
        -- Clientes
        ('clientes',         'Ver',     'view',     'Ver clientes registrados'),
        ('clientes',         'Editar',  'update',   'Actualizar información del cliente'),
        -- Soporte
        ('soporte-cliente',  'Ver',     'view',     'Ver tickets de soporte'),
        ('soporte-cliente',  'Responder','reply',   'Responder solicitudes de clientes'),
        ('soporte-cliente',  'Cerrar',  'close',    'Cerrar ticket de soporte'),
        -- Productos
        ('productos',        'Ver',     'view',     'Ver productos disponibles'),
        ('productos',        'Crear',   'create',   'Registrar nuevos productos'),
        ('productos',        'Editar',  'update',   'Editar productos existentes'),
        ('productos',        'Eliminar','delete',   'Eliminar o desactivar productos'),
        -- Inventario
        ('inventario',       'Ver',     'view',     'Ver estado del inventario'),
        ('inventario',       'Actualizar','update', 'Actualizar stock de productos'),
        -- Categorías
        ('categorias',       'Ver',     'view',     'Ver listado de categorías'),
        ('categorias',       'Crear',   'create',   'Crear nueva categoría'),
        ('categorias',       'Editar',  'update',   'Editar categoría'),
        ('categorias',       'Eliminar','delete',   'Eliminar o desactivar categoría'),
        -- Envíos
        ('envios',           'Ver',     'view',     'Ver envíos realizados'),
        ('envios',           'Actualizar','update', 'Actualizar estado del envío'),
        ('envios',           'Asignar', 'assign',   'Asignar proveedor de envío'),
        -- Tarifas de envío
        ('tarifas-envio',    'Ver',     'view',     'Ver tarifas registradas'),
        ('tarifas-envio',    'Crear',   'create',   'Crear nuevas tarifas de envío'),
        ('tarifas-envio',    'Editar',  'update',   'Editar tarifa existente'),
        ('tarifas-envio',    'Eliminar','delete',   'Eliminar o desactivar tarifa'),
        -- Promociones
        ('promociones',      'Ver',     'view',     'Ver promociones activas'),
        ('promociones',      'Crear',   'create',   'Crear promoción nueva'),
        ('promociones',      'Editar',  'update',   'Editar promoción'),
        ('promociones',      'Eliminar','delete',   'Eliminar promoción'),
        -- Localización
        ('localizacion',     'Ver',     'view',     'Ver países y ciudades'),
        ('localizacion',     'Editar',  'update',   'Actualizar datos geográficos'),
        -- Tipos de documento
        ('tipos-documento',  'Ver',     'view',     'Ver tipos de documento'),
        ('tipos-documento',  'Crear',   'create',   'Crear nuevo tipo'),
        ('tipos-documento',  'Editar',  'update',   'Actualizar tipo existente'),
        ('tipos-documento',  'Eliminar','delete',   'Eliminar tipo de documento'),
        -- Logs de pagos
        ('logs-pagos',       'Ver',     'view',     'Ver historial de logs de pago'),
        -- Historial de órdenes
        ('historial-ordenes','Ver',     'view',     'Ver historial de cambios en órdenes'),
        -- Frontend promociones
        ('frontend-promociones', 'Ver', 'view',     'Ver promociones públicas desde frontend')
) AS a(slug_modulo, name, slug, description)
ON m.slug = a.slug_modulo;
-- ===========================================
-- 5. EMPLEADOS (usuarios internos)
-- ===========================================
CREATE TABLE employees (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
    employee_code VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20),
    gender VARCHAR(10) CHECK (gender IN ('male', 'female', 'other')),
    position_id INTEGER,
    area_id INTEGER,
    salary NUMERIC(12, 2) CHECK (salary >= 0),
    hire_date DATE,
    birth_date DATE,
    address TEXT,
    notes TEXT,
    is_active BOOLEAN DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),
    deleted_at TIMESTAMP NULL,
    restored_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
-- ===========================================
-- 6. CLIENTES (usuarios frontend)
-- ===========================================
CREATE TABLE customers (
    customer_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
    identity_type_id SMALLINT,
    identity_number VARCHAR(30) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    is_whatsapp BOOLEAN DEFAULT FALSE,
    email VARCHAR(100) NOT NULL UNIQUE,
    shipping_address VARCHAR(255),
    city_id INT,
    notes TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    deleted_at TIMESTAMP NULL,
    restored_at TIMESTAMP NULL,
    last_login TIMESTAMP,
    preferred_language VARCHAR(20) DEFAULT 'es',
    gender VARCHAR(10) CHECK (gender IN ('male', 'female', 'other')),
    date_of_birth DATE,
    updated_by UUID
);
-- ===========================================
-- 7. INSERT DE USUARIOS, EMPLEADOS Y CLIENTES
-- ===========================================
-- Usuarios (3 empleados + 3 clientes)
INSERT INTO users (id, name, email, password_hash, is_active, is_verified, created_at, updated_at)
VALUES
-- Empleados
('11111111-1111-1111-1111-111111111111', 'Juan Pérez', 'juan@example.com', 'hash1', TRUE, TRUE, NOW(), NOW()),
('22222222-2222-2222-2222-222222222222', 'Carla Torres', 'carla@example.com', 'hash2', TRUE, TRUE, NOW(), NOW()),
('33333333-3333-3333-3333-333333333333', 'Luis Martínez', 'luis@example.com', 'hash3', TRUE, TRUE, NOW(), NOW()),
-- Clientes
('44444444-4444-4444-4444-444444444444', 'Ana Gómez', 'ana@example.com', 'hash4', TRUE, TRUE, NOW(), NOW()),
('55555555-5555-5555-5555-555555555555', 'Carlos López', 'carlos@example.com', 'hash5', TRUE, TRUE, NOW(), NOW()),
('66666666-6666-6666-6666-666666666666', 'Laura Martínez', 'laura@example.com', 'hash6', TRUE, TRUE, NOW(), NOW());
-- Roles asignados
INSERT INTO user_roles (user_id, role_id)
VALUES
-- Empleados
('11111111-1111-1111-1111-111111111111', (SELECT id FROM roles WHERE slug = 'admin')),
('22222222-2222-2222-2222-222222222222', (SELECT id FROM roles WHERE slug = 'vendedor')),
('33333333-3333-3333-3333-333333333333', (SELECT id FROM roles WHERE slug = 'vendedor')),
-- Clientes
('44444444-4444-4444-4444-444444444444', (SELECT id FROM roles WHERE slug = 'cliente')),
('55555555-5555-5555-5555-555555555555', (SELECT id FROM roles WHERE slug = 'cliente')),
('66666666-6666-6666-6666-666666666666', (SELECT id FROM roles WHERE slug = 'cliente'));
-- Empleados
INSERT INTO employees (id, user_id, employee_code, first_name, last_name, email, phone, gender, hire_date, birth_date, address, notes)
VALUES
('aaaa1111-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 'EMP001', 'Juan', 'Pérez', 'juan@example.com', '3012345678', 'male', '2020-01-01', '1985-06-15', 'Calle Falsa 123', 'Administrador principal'),
('aaaa2222-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '22222222-2222-2222-2222-222222222222', 'EMP002', 'Carla', 'Torres', 'carla@example.com', '3104567890', 'female', '2021-06-01', '1987-07-20', 'Carrera 10 #20-30', 'Encargada logística'),
('aaaa3333-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '33333333-3333-3333-3333-333333333333', 'EMP003', 'Luis', 'Martínez', 'luis@example.com', '3123456789', 'male', '2022-03-01', '1990-11-11', 'Av. Siempre Viva 742', 'Desarrollador backend');
-- Clientes
INSERT INTO customers (customer_id, user_id, identity_type_id, identity_number, first_name, last_name, email, phone, is_whatsapp, shipping_address, city_id, gender, date_of_birth)
VALUES
(gen_random_uuid(), '44444444-4444-4444-4444-444444444444', 1, 'CC123456', 'Ana', 'Gómez', 'ana@example.com', '3100001111', TRUE, 'Calle 1 #2-3', 1, 'female', '1990-01-01'),
(gen_random_uuid(), '55555555-5555-5555-5555-555555555555', 1, 'CC234567', 'Carlos', 'López', 'carlos@example.com', '3200002222', FALSE, 'Carrera 4 #5-6', 1, 'male', '1985-05-05'),
(gen_random_uuid(), '66666666-6666-6666-6666-666666666666', 1, 'CC345678', 'Laura', 'Martínez', 'laura@example.com', '3000003333', TRUE, 'Transversal 8 #9-10', 1, 'female', '1993-08-08');
-- ================================================================
-- 🏷️ Tabla: parent_categories — Categorías principales del catálogo
-- ================================================================
-- 📌 Propósito:
--     Representa las categorías padre o principales del catálogo de productos,
--     permitiendo agrupar subcategorías y facilitar la navegación en el frontend.
-- 🔗 Relaciones:
--     - Puede relacionarse con subcategorías a través de la tabla `categories` (via `parent_category_id`).
-- 
-- 📏 Restricciones:
--     - `name`: obligatorio.
--     - `slug`: obligatorio y único, usado para URLs amigables.
--     - `display_order`: controla el orden de presentación visual.
--     - `is_active`: habilita/deshabilita la visibilidad de la categoría.
-- 🔄 Auditoría:
--     - `created_at` / `updated_at`: control de cambios.
--     - `deleted_at`: soporte para borrado lógico.
-- ✍️ Autor: Jose Luis Trespalacios | CTO | BitLink Technology Partner | 📅 30/03/25
CREATE TABLE parent_categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    image_url VARCHAR(255) DEFAULT NULL,
    is_active BOOLEAN DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),
    display_order INT DEFAULT 0 CHECK (display_order >= 0),
    deleted_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
-- ====================================================================
-- 📥 Insert: parent_categories — Registro de categorías principales
-- ====================================================================
-- 📌 Propósito:
--     Inserta las categorías raíz del catálogo de productos que agrupan
--     subcategorías específicas. Estas categorías son visibles en el frontend.
-- 🏷 Ejemplos:
--     - Cervezas, Licores fuertes, Snacks, Vinos, Cocteles, etc.
-- 🔗 Uso:
--     - Se conectan con `categories` mediante `parent_category_id`.
--     - Se utilizan en navegación, filtros y agrupación de productos.
-- ✍️ Autor: Jose Luis Trespalacios | Arquitecto de Software | Trebol Drinks
-- 📅 Última modificación: 30/03/25
INSERT INTO parent_categories (
    name,
    slug,
    description,
    image_url,
    is_active,
    display_order, -- Campo agregado
    created_at,
    updated_at,
    deleted_at
)
VALUES
('Cervezas', 'cervezas', 'Cervezas nacionales e internacionales.', 'https://treboldrinks.co/images/cervezas.jpg', TRUE, 1, NOW(), NOW(), NULL),
('Licores fuertes', 'licores-fuertes', 'Whisky, ron, tequila y más.', 'https://treboldrinks.co/images/licores_fuerte.jpg', TRUE, 2, NOW(), NOW(), NULL),
('Licores de alta gama', 'licores-alta-gama', 'Ediciones limitadas y premium.', 'https://treboldrinks.co/images/licores_alta_gama.jpg', TRUE, 3, NOW(), NOW(), NULL),
('Snacks', 'snacks', 'Aperitivos y acompañamientos.', 'https://treboldrinks.co/images/snacks.jpg', TRUE, 4, NOW(), NOW(), NULL),
('Artículos de licorera', 'articulos-licorera', 'Accesorios y herramientas para bebidas.', 'https://treboldrinks.co/images/articulos_licorera.jpg', TRUE, 5, NOW(), NOW(), NULL),
('Vinos y champagnes', 'vinos-champagnes', 'Vinos y espumantes.', 'https://treboldrinks.co/images/vinos_champagnes.jpg', TRUE, 6, NOW(), NOW(), NULL),
('Licores internacionales', 'licores-internacionales', 'Licores importados de todo el mundo.', 'https://treboldrinks.co/images/licores_internacionales.jpg', TRUE, 7, NOW(), NOW(), NULL),
('Aperitivos', 'aperitivos', 'Bebidas para iniciar una comida.', 'https://treboldrinks.co/images/aperitivos.jpg', TRUE, 8, NOW(), NOW(), NULL),
('Cocteles y mezcladores', 'cocteles-mezcladores', 'Bebidas listas para mezclar y disfrutar.', 'https://treboldrinks.co/images/cocteles.jpg', TRUE, 9, NOW(), NOW(), NULL),
('Bebidas sin alcohol', 'bebidas-sin-alcohol', 'Refrescos, jugos y más opciones sin alcohol.', 'https://treboldrinks.co/images/bebidas_sin_alcohol.jpg', TRUE, 10, NOW(), NOW(), NULL),
('Licores artesanales', 'licores-artesanales', 'Bebidas destiladas artesanalmente.', 'https://treboldrinks.co/images/licores_artesanales.jpg', TRUE, 11, NOW(), NOW(), NULL);
-- ================================================
-- 🗃️ Tabla: categories — Subcategorías de productos
-- ================================================
-- 📌 Propósito:
--     Define subcategorías dentro del catálogo, vinculadas opcionalmente a categorías padre.
-- 🔗 Relaciones:
--     - parent_category_id → parent_categories.id
--     - Se asocia a: productos (products).
-- 📏 Restricciones:
--     - slug: índice único externo.
--     - display_order: define orden en interfaces.
--     - is_active: control de visibilidad.
-- 🔄 Auditoría:
--     - Campos estándar: created_at, updated_at, deleted_at, restored_at.
-- ✍️ Autor: Jose Luis Trespalacios | Arquitecto de Software  
-- 📅 Última modificación: 30/03/25
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    parent_category_id INT NULL REFERENCES parent_categories(id) ON DELETE SET NULL,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL, -- Se quitó UNIQUE aquí
    description TEXT,
    image_url VARCHAR(255) DEFAULT NULL,
    is_active BOOLEAN DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),
    meta_title VARCHAR(255),
    meta_description TEXT,
    display_order INT DEFAULT 0 CHECK (display_order >= 0),
    deleted_at TIMESTAMP NULL,
    restored_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
-- 🔐 Índice único para slugs
DROP INDEX IF EXISTS categories_slug;
CREATE UNIQUE INDEX IF NOT EXISTS categories_slug ON categories(slug);
-- ========================================================
-- 📥 Inserción inicial — Subcategorías (categories)
-- ========================================================
-- 📌 Descripción:
--     Registra las subcategorías agrupadas bajo categorías principales (ej. Cervezas, Licores).
-- 🔗 Dependencias:
--     - parent_category_id → parent_categories.id
-- 🧩 Estructura:
--     - slug, meta_title y meta_description permiten SEO y navegación clara.
--     - display_order define el orden en catálogos y menús.
-- ✍️ Autor: Jose Luis Trespalacios | Arquitecto de Software  
-- 📅 Última modificación: 30/03/25
INSERT INTO categories (
    parent_category_id, 
    name, 
    slug, 
    description, 
    image_url, 
    is_active, 
    meta_title, 
    meta_description, 
    display_order, 
    created_at, 
    updated_at, 
    deleted_at
) VALUES
-- 🌎 Cervezas (ID 1)
(1, 'Cervezas nacionales', 'cervezas-nacionales', 'Cervezas de producción nacional.', 'https://treboldrinks.co/images/cervezas_nacionales.jpg', TRUE, 'Cervezas nacionales', 'Variedad de cervezas nacionales.', 1, NOW(), NOW(), NULL),
(1, 'Cervezas importadas', 'cervezas-importadas', 'Cervezas premium de distintas partes del mundo.', 'https://treboldrinks.co/images/cervezas_internacionales.jpg', TRUE, 'Cervezas importadas', 'Las mejores cervezas internacionales.', 2, NOW(), NOW(), NULL),
-- 🥃 Licores fuertes (ID 2)
(2, 'Whisky', 'whisky', 'Variedad de whiskys premium.', 'https://treboldrinks.co/images/whisky.jpg', TRUE, 'Whisky', 'Whiskys de alta calidad.', 3, NOW(), NOW(), NULL),
(2, 'Ron', 'ron', 'Selección de rones oscuros y blancos.', 'https://treboldrinks.co/images/ron.jpg', TRUE, 'Ron', 'Rones caribeños y premium.', 4, NOW(), NOW(), NULL),
(2, 'Tequila', 'tequila', 'Mejores tequilas para disfrutar.', 'https://treboldrinks.co/images/tequila.jpg', TRUE, 'Tequila', 'Tequilas de agave azul.', 5, NOW(), NOW(), NULL),
-- 🍷 Vinos y champagnes (ID 6)
(6, 'Vinos tintos', 'vinos-tintos', 'Los mejores vinos tintos.', 'https://treboldrinks.co/images/vinos_rojos.jpg', TRUE, 'Vinos tintos', 'Vinos perfectos para cenas.', 6, NOW(), NOW(), NULL),
(6, 'Vinos blancos', 'vinos-blancos', 'Vinos blancos frescos.', 'https://treboldrinks.co/images/vinos_blancos.jpg', TRUE, 'Vinos blancos', 'Vinos ideales para pescados.', 7, NOW(), NOW(), NULL),
-- 🍸 Cocteles y mezcladores (ID 9)
(9, 'Mixers y tónicas', 'mixers-tonicas', 'Mixers para preparar tragos.', 'https://treboldrinks.co/images/mixers.jpg', TRUE, 'Mixers', 'Mixers para cócteles y bebidas.', 8, NOW(), NOW(), NULL),
(9, 'Sangrías y cocteles listos', 'sangrias-cocteles', 'Bebidas listas para servir.', 'https://treboldrinks.co/images/sangrias.jpg', TRUE, 'Sangrías', 'Sangrías y cocteles listos.', 9, NOW(), NOW(), NULL);

CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- ID como UUID generado automáticamente
    category_id INT NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL CHECK (char_length(name) > 0),
    slug VARCHAR(255) NOT NULL UNIQUE CHECK (char_length(slug) > 0),
    description TEXT,
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    stock INT DEFAULT 0 CHECK (stock >= 0),
    image_url VARCHAR(255) DEFAULT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    deleted_at TIMESTAMP DEFAULT NULL,
    restored_at TIMESTAMP DEFAULT NULL,
    created_by UUID DEFAULT NULL REFERENCES users(id) ON DELETE SET NULL,
    updated_by UUID DEFAULT NULL REFERENCES users(id) ON DELETE SET NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);
INSERT INTO products 
(
    category_id, 
    name, 
    slug, 
    description, 
    price, 
    stock, 
    image_url, 
    is_active, 
    deleted_at, 
    restored_at, 
    created_by, 
    updated_by, 
    created_at, 
    updated_at
) VALUES
(
    1, 
    'Cerveza Águila', 
    'cerveza-aguila', 
    'Cerveza colombiana refrescante y ligera.', 
    5000, 
    100, 
    'https://treboldrinks.co/images/cerveza_aguila.jpg', 
    TRUE, 
    NULL, 
    NULL, 
    '11111111-1111-1111-1111-111111111111',  -- created_by: Juan Pérez (admin)
    '11111111-1111-1111-1111-111111111111',  -- updated_by: Juan Pérez (admin)
    NOW(), 
    NOW()
),
(
    1, 
    'Cerveza Club Colombia', 
    'cerveza-club-colombia', 
    'Cerveza premium con un sabor equilibrado y maltoso.', 
    7000, 
    80, 
    'https://treboldrinks.co/images/cerveza_club_colombia.jpg', 
    TRUE, 
    NULL, 
    NULL, 
    '11111111-1111-1111-1111-111111111111', 
    '11111111-1111-1111-1111-111111111111', 
    NOW(), 
    NOW()
),
(
    2, 
    'Cerveza Heineken', 
    'cerveza-heineken', 
    'Cerveza holandesa con un sabor suave y refrescante.', 
    8000, 
    90, 
    'https://treboldrinks.co/images/cerveza_heineken.jpg', 
    TRUE, 
    NULL, 
    NULL, 
    '11111111-1111-1111-1111-111111111111', 
    '11111111-1111-1111-1111-111111111111', 
    NOW(), 
    NOW()
),
(
    2, 
    'Cerveza Corona', 
    'cerveza-corona', 
    'Cerveza mexicana ligera y refrescante, ideal para el verano.', 
    8500, 
    75, 
    'https://treboldrinks.co/images/cerveza_corona.jpg', 
    TRUE, 
    NULL, 
    NULL, 
    '11111111-1111-1111-1111-111111111111', 
    '11111111-1111-1111-1111-111111111111', 
    NOW(), 
    NOW()
);
-- ===========================================
-- Tabla de estados de pago
-- ===========================================
-- Tabla de estados de pago
CREATE TABLE IF NOT EXISTS payment_status (
    id SERIAL PRIMARY KEY,
    status_name VARCHAR(255) NOT NULL,  
    status_key VARCHAR(50) NOT NULL UNIQUE,  
    description TEXT DEFAULT NULL,
    order_status_mapping VARCHAR(50) DEFAULT NULL,
    color VARCHAR(20) DEFAULT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),
    
    deleted_at TIMESTAMP DEFAULT NULL,
    restored_at TIMESTAMP DEFAULT NULL,
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NULL
);
INSERT INTO payment_status (
    status_name,
    status_key,
    description,
    order_status_mapping,
    color,
    is_active,
    created_at,
    updated_at
)
VALUES
('Pendiente', 'pending', 'El pago está pendiente de confirmación.', 'waiting_payment', '#FFA500', TRUE, NOW(), NOW()),
('Completado', 'completed', 'El pago se ha realizado con éxito.', 'order_completed', '#28A745', TRUE, NOW(), NOW()),
('Fallido', 'failed', 'El pago ha sido rechazado o ha fallado.', 'order_failed', '#DC3545', TRUE, NOW(), NOW()),
('Reembolsado', 'refunded', 'El pago ha sido reembolsado.', 'order_refunded', '#17A2B8', TRUE, NOW(), NOW()),
('Cancelado', 'canceled', 'El pago ha sido cancelado.', 'order_canceled', '#6C757D', TRUE, NOW(), NOW());
CREATE TABLE IF NOT EXISTS payment_methods (
    payment_method_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),        -- <== CORREGIDO
    name VARCHAR(255) NOT NULL,
    method_key VARCHAR(50) NOT NULL UNIQUE,
    place_holder VARCHAR(255),
    description TEXT,
    is_active BOOLEAN NOT NULL DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),
    deleted_at TIMESTAMP DEFAULT NULL,
    restored_at TIMESTAMP DEFAULT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);
INSERT INTO payment_methods (
    payment_method_id,            -- <== Ahora explícito (opcional, si quieres asignar un UUID)
    name,
    method_key,
    place_holder,
    description,
    is_active,
    deleted_at,
    restored_at,
    created_at,
    updated_at
)
VALUES
-- Tarjeta de Crédito
(gen_random_uuid(), 'Tarjeta de Crédito', 'credit_card', 'Ingresa los datos de tu tarjeta de crédito.', 'Pago con tarjetas de crédito.', TRUE, NULL, NULL, NOW(), NOW()),
-- Tarjeta de Débito
(gen_random_uuid(), 'Tarjeta de Débito', 'debit_card', 'Ingresa los datos de tu tarjeta de débito.', 'Pago con tarjetas de débito.', TRUE, NULL, NULL, NOW(), NOW()),
-- PSE
(gen_random_uuid(), 'PSE', 'pse', 'Selecciona tu banco para continuar.', 'Pago con PSE (banca en línea).', TRUE, NULL, NULL, NOW(), NOW()),
-- Nequi
(gen_random_uuid(), 'Nequi', 'nequi', 'Ingresa tu número Nequi.', 'Pago con billetera Nequi.', TRUE, NULL, NULL, NOW(), NOW()),
-- Daviplata
(gen_random_uuid(), 'Daviplata', 'daviplata', 'Ingresa tu número Daviplata.', 'Pago con billetera Daviplata.', TRUE, NULL, NULL, NOW(), NOW()),
-- Efectivo
(gen_random_uuid(), 'Efectivo', 'cash', 'Selecciona el punto de pago autorizado.', 'Pago en efectivo en puntos autorizados.', TRUE, NULL, NULL, NOW(), NOW()),
-- Transferencia Bancaria
(gen_random_uuid(), 'Transferencia Bancaria', 'bank_transfer', 'Sigue las instrucciones para la transferencia.', 'Transferencias bancarias directas.', TRUE, NULL, NULL, NOW(), NOW()),
-- PayPal
(gen_random_uuid(), 'PayPal', 'paypal', 'Ingresa los datos de tu cuenta PayPal.', 'Pago con cuenta PayPal.', TRUE, NULL, NULL, NOW(), NOW()),
-- Criptomonedas
(gen_random_uuid(), 'Criptomonedas', 'crypto', 'Escanea el código QR para pagar.', 'Pago con Bitcoin, Ethereum y otras criptomonedas.', TRUE, NULL, NULL, NOW(), NOW());
CREATE TABLE IF NOT EXISTS payment_channels (
    payment_channel_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),   -- UUID como PK
    payment_method_id UUID NOT NULL REFERENCES payment_methods(payment_method_id) ON DELETE CASCADE, -- FK correcta
    name VARCHAR(100) NOT NULL,
    description TEXT DEFAULT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),
    deleted_at TIMESTAMP NULL,
    restored_at TIMESTAMP NULL,     -- ✅ Campo agregado
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW() NOT NULL
);
INSERT INTO payment_channels (
    payment_channel_id,
    payment_method_id,
    name,
    description,
    is_active,
    deleted_at,
    restored_at,      -- ✅ Campo agregado en el INSERT
    created_at,
    updated_at
)
VALUES
-- Visa (para método de pago "credit_card")
(gen_random_uuid(),
(SELECT payment_method_id FROM payment_methods WHERE method_key = 'credit_card'),
'Visa',
'Pago con tarjeta de crédito Visa.',
TRUE,
NULL,
NULL,    -- restored_at NULL al inicio
NOW(),
NOW()
),
-- Mastercard
(gen_random_uuid(),
(SELECT payment_method_id FROM payment_methods WHERE method_key = 'credit_card'),
'Mastercard',
'Pago con tarjeta de crédito Mastercard.',
TRUE,
NULL,
NULL,
NOW(),
NOW()
),
-- American Express
(gen_random_uuid(),
(SELECT payment_method_id FROM payment_methods WHERE method_key = 'credit_card'),
'American Express',
'Pago con tarjeta de crédito American Express.',
TRUE,
NULL,
NULL,
NOW(),
NOW()
),
-- Nequi
(gen_random_uuid(),
(SELECT payment_method_id FROM payment_methods WHERE method_key = 'nequi'),
'Nequi',
'Pago a través de la billetera digital Nequi.',
TRUE,
NULL,
NULL,
NOW(),
NOW()
),
-- Bitcoin
(gen_random_uuid(),
(SELECT payment_method_id FROM payment_methods WHERE method_key = 'crypto'),
'Bitcoin',
'Pago con Bitcoin.',
TRUE,
NULL,
NULL,
NOW(),
NOW()
),
-- PayPal
(gen_random_uuid(),
(SELECT payment_method_id FROM payment_methods WHERE method_key = 'paypal'),
'PayPal',
'Pago a través de PayPal.',
TRUE,
NULL,
NULL,
NOW(),
NOW()
);
CREATE TABLE IF NOT EXISTS payments (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    customer_id UUID NOT NULL 
        REFERENCES customers(customer_id) ON DELETE CASCADE,
    payment_method_id UUID NOT NULL 
        REFERENCES payment_methods(payment_method_id) ON DELETE CASCADE,
    payment_channel_id UUID NOT NULL 
        REFERENCES payment_channels(payment_channel_id) ON DELETE CASCADE,
    payment_status_id INT NOT NULL 
        REFERENCES payment_status(id) ON DELETE CASCADE,
    amount NUMERIC(12,2) NOT NULL CHECK (amount >= 0),
    currency VARCHAR(3) NOT NULL DEFAULT 'USD',
    transaction_reference VARCHAR(255) UNIQUE,
    payment_date TIMESTAMP DEFAULT NOW(),
    payment_method_details TEXT,
    is_successful BOOLEAN DEFAULT FALSE CHECK (is_successful IN (TRUE, FALSE)),
    failure_reason TEXT,
    order_id UUID NULL, -- Relación futura (por ejemplo, a una tabla "orders")
    metadata JSONB, -- Para campos dinámicos como respuesta del gateway, IP, etc.
    deleted_at TIMESTAMP NULL,
    restored_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW() NOT NULL
);
-- Primero asegúrate de que el canal PayPal exista
INSERT INTO payment_channels (
    payment_method_id, 
    name, 
    description, 
    is_active, 
    created_at, 
    updated_at
)
VALUES
(
    (SELECT payment_method_id FROM payment_methods WHERE method_key = 'paypal'),
    'PayPal',
    'Pago a través de PayPal.',
    TRUE,
    NOW(),
    NOW()
);
-- INSERT a payments con customer_id, order_id NULL y metadata JSONB
INSERT INTO payments (
    id,
    customer_id,
    payment_method_id,
    payment_channel_id,
    payment_status_id,
    amount,
    currency,
    transaction_reference,
    payment_date,
    payment_method_details,
    is_successful,
    failure_reason,
    order_id,
    metadata,
    deleted_at,
    restored_at,
    created_at,
    updated_at
)
VALUES
-- Pago exitoso con tarjeta Visa
(
    gen_random_uuid(),
    (SELECT customer_id FROM customers OFFSET 0 LIMIT 1),
    (SELECT payment_method_id FROM payment_methods WHERE method_key = 'credit_card' LIMIT 1),
    (SELECT payment_channel_id FROM payment_channels WHERE name = 'Visa' LIMIT 1),
    (SELECT id FROM payment_status WHERE status_key = 'completed' LIMIT 1),
    150.75,
    'USD',
    'TXN10001',
    NOW(),
    'Tarjeta terminada en 1234',
    TRUE,
    NULL,
    NULL,
    '{"ip":"192.168.1.1","device":"iPhone 14"}',
    NULL,
    NULL,
    NOW(),
    NOW()
),
-- Pago fallido con tarjeta Mastercard
(
    gen_random_uuid(),
    (SELECT customer_id FROM customers OFFSET 1 LIMIT 1),
    (SELECT payment_method_id FROM payment_methods WHERE method_key = 'debit_card' LIMIT 1),
    (SELECT payment_channel_id FROM payment_channels WHERE name = 'Mastercard' LIMIT 1),
    (SELECT id FROM payment_status WHERE status_key = 'pending' LIMIT 1),
    320.00,
    'EUR',
    'TXN10002',
    NOW(),
    'Tarjeta terminada en 5678',
    FALSE,
    'Fondos insuficientes',
    NULL,
    '{"ip":"10.0.0.22","geo_location":"Madrid, ES"}',
    NULL,
    NULL,
    NOW(),
    NOW()
),
-- Pago exitoso con PayPal
(
    gen_random_uuid(),
    (SELECT customer_id FROM customers OFFSET 2 LIMIT 1),
    (SELECT payment_method_id FROM payment_methods WHERE method_key = 'paypal' LIMIT 1),
    (SELECT payment_channel_id FROM payment_channels WHERE name = 'PayPal' LIMIT 1),
    (SELECT id FROM payment_status WHERE status_key = 'completed' LIMIT 1),
    89.99,
    'USD',
    'TXN10003',
    NOW(),
    'Cuenta PayPal asociada a juan@example.com',
    TRUE,
    NULL,
    NULL,
    '{"browser":"Chrome","transaction_gateway_id":"abc123"}',
    NULL,
    NULL,
    NOW(),
    NOW()
),
-- Pago fallido con Bitcoin
(
    gen_random_uuid(),
    (SELECT customer_id FROM customers OFFSET 0 LIMIT 1), -- ✅ Reutiliza cliente 1
    (SELECT payment_method_id FROM payment_methods WHERE method_key = 'crypto' LIMIT 1),
    (SELECT payment_channel_id FROM payment_channels WHERE name = 'Bitcoin' LIMIT 1),
    (SELECT id FROM payment_status WHERE status_key = 'failed' LIMIT 1),
    500.00,
    'MXN',
    'TXN10004',
    NOW(),
    'Pago con wallet X',
    FALSE,
    'Error en confirmación de red',
    NULL,
    '{"network_delay":"12s","attempts":3}',
    NULL,
    NULL,
    NOW(),
    NOW()
),
-- Pago devuelto por Nequi
(
    gen_random_uuid(),
    (SELECT customer_id FROM customers OFFSET 1 LIMIT 1), -- ✅ Reutiliza cliente 2
    (SELECT payment_method_id FROM payment_methods WHERE method_key = 'nequi' LIMIT 1),
    (SELECT payment_channel_id FROM payment_channels WHERE name = 'Nequi' LIMIT 1),
    (SELECT id FROM payment_status WHERE status_key = 'refunded' LIMIT 1),
    45.50,
    'USD',
    'TXN10005',
    NOW(),
    'Cuenta Nequi 3001234567',
    TRUE,
    'Cliente solicitó devolución',
    NULL,
    '{"refund_type":"manual","requested_by":"user"}',
    NULL,
    NULL,
    NOW(),
    NOW()
);
CREATE TABLE shipping_methods (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),
    deleted_at TIMESTAMP DEFAULT NULL,
    restored_at TIMESTAMP DEFAULT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
INSERT INTO shipping_methods (
    name,
    description,
    is_active,
    deleted_at,
    restored_at,
    created_at,
    updated_at
) VALUES 
('Estándar', 'Entrega en 5-7 días hábiles', TRUE, NULL, NULL, NOW(), NOW()),
('Express', 'Entrega en 1-3 días hábiles', TRUE, NULL, NULL, NOW(), NOW()),
('Día siguiente', 'Entrega al siguiente día hábil', TRUE, NULL, NULL, NOW(), NOW());
CREATE TABLE coupons (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE,
    discount_type VARCHAR(20) NOT NULL CHECK (discount_type IN ('percentage', 'fixed')),
    discount_value DECIMAL(10,2) NOT NULL CHECK (discount_value > 0),
    min_order_value DECIMAL(10,2) DEFAULT NULL CHECK (min_order_value >= 0),
    max_discount DECIMAL(10,2) DEFAULT NULL CHECK (max_discount >= 0),
    start_date DATE NOT NULL,
    expiration_date DATE NOT NULL CHECK (expiration_date > start_date),

    -- Nuevos campos sugeridos
    usage_limit INT DEFAULT NULL CHECK (usage_limit >= 0),
    times_used INT DEFAULT 0 CHECK (times_used >= 0),
    is_public BOOLEAN DEFAULT TRUE CHECK (is_public IN (TRUE, FALSE)),

    is_active BOOLEAN DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),
    deleted_at TIMESTAMP DEFAULT NULL,
    restored_at TIMESTAMP DEFAULT NULL,

    created_by UUID REFERENCES users(id) ON DELETE SET NULL,
    updated_by UUID REFERENCES users(id) ON DELETE SET NULL,

    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
INSERT INTO coupons (
    code, discount_type, discount_value, min_order_value, max_discount, 
    start_date, expiration_date,
    usage_limit, times_used, is_public,
    is_active, deleted_at, restored_at,
    created_by, updated_by, created_at, updated_at
)
VALUES
('SUMMER21', 'percentage', 15.00, 100.00, 30.00, '2021-06-01', '2021-09-30',
NULL, 0, TRUE,
TRUE, NULL, NULL,
'11111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111111', NOW(), NOW()),
('BLACKFRIDAY', 'fixed', 50.00, 200.00, 50.00, '2021-11-01', '2021-11-30',
500, 23, TRUE,
TRUE, NULL, NULL,
'11111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111111', NOW(), NOW()),
('WELCOME10', 'percentage', 10.00, 0.00, 0.00, '2022-01-01', '2022-12-31',
NULL, 10, TRUE,
TRUE, NULL, NULL,
'11111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111111', NOW(), NOW());
-- ================================
-- 🗃️ Tabla: order_status
-- ================================
CREATE TABLE IF NOT EXISTS order_status (
    id SERIAL PRIMARY KEY,
    status_name VARCHAR(255) NOT NULL,
    status_key VARCHAR(50) UNIQUE NOT NULL,
    description TEXT DEFAULT NULL,
    -- Control de estado
    is_active BOOLEAN NOT NULL DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),
    -- Auditoría
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    deleted_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NULL,
    restored_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NULL
);
-- ================================
-- 🚀 Inserts iniciales: order_status
-- ================================
INSERT INTO order_status (status_name, status_key, description, is_active)
VALUES
('Pendiente',    'pending',    'La orden ha sido creada.',                     TRUE),
('Procesando',   'processing', 'La orden está siendo procesada.',             TRUE),
('Enviada',      'shipped',    'La orden ha sido enviada al cliente.',        TRUE),
('Entregada',    'delivered',  'La orden ha sido entregada con éxito.',       TRUE),
('Cancelada',    'cancelled',  'La orden fue cancelada por el cliente o el sistema.', TRUE),
('Devuelta',     'returned',   'El cliente devolvió uno o más productos.',    TRUE),
('Reembolsada',  'refunded',   'Se realizó un reembolso al cliente.',         TRUE);
CREATE TABLE IF NOT EXISTS orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID REFERENCES customers(customer_id) ON DELETE SET NULL,
    payment_id UUID REFERENCES payments(id) ON DELETE SET NULL,
    order_status_id INT NOT NULL DEFAULT 1 REFERENCES order_status(id) ON DELETE RESTRICT,
    order_date TIMESTAMP NOT NULL DEFAULT NOW(),
    shipping_address TEXT NULL,
    billing_address TEXT NULL,
    tracking_number VARCHAR(50) UNIQUE,
    notes TEXT NULL,
    total_amount NUMERIC(12, 2) NOT NULL DEFAULT 0 CHECK (total_amount >= 0),
    currency VARCHAR(3) NOT NULL DEFAULT 'USD',
    estimated_delivery_date DATE,
    shipping_method_id INT REFERENCES shipping_methods(id) ON DELETE SET NULL,
    coupon_id INT REFERENCES coupons(id) ON DELETE SET NULL,
    -- Auditoría
    created_by UUID REFERENCES users(id) ON DELETE SET NULL,
    updated_by UUID REFERENCES users(id) ON DELETE SET NULL,
    -- Estado y control
    is_active BOOLEAN NOT NULL DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),
    deleted_at TIMESTAMP NULL,
    restored_at TIMESTAMP NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);
INSERT INTO orders (
    customer_id,
    payment_id,
    order_status_id,
    order_date,
    shipping_address,
    billing_address,
    tracking_number,
    notes,
    total_amount,
    currency,
    estimated_delivery_date,
    shipping_method_id,
    coupon_id,
    created_by,
    updated_by,
    is_active,
    created_at,
    updated_at
)
VALUES (
    -- Cliente activo
    (SELECT customer_id FROM customers WHERE is_active = TRUE LIMIT 1),
    -- Pago exitoso
    (SELECT id FROM payments WHERE is_successful = TRUE LIMIT 1),
    -- Estado "pendiente"
    (SELECT id FROM order_status WHERE status_key = 'pending' LIMIT 1),
    NOW(),
    -- Dirección de envío y facturación
    'Av. Siempre Viva 742, Springfield',
    'Calle Falsa 123, Springfield',
    -- Tracking
    'TRK987654321',
    -- Notas
    'El cliente pidió empaquetado especial.',
    -- Total y moneda
    159.75,
    'USD',
    -- Estimado de entrega (3 días después)
    NOW() + INTERVAL '3 days',
    -- Método de envío (Express por ejemplo)
    (SELECT id FROM shipping_methods WHERE name = 'Express' LIMIT 1),
    -- Cupón aplicado (opcional, por ejemplo WELCOME10)
    (SELECT id FROM coupons WHERE code = 'WELCOME10' LIMIT 1),
    -- Auditoría
    '11111111-1111-1111-1111-111111111111', -- created_by (admin Juan)
    '11111111-1111-1111-1111-111111111111', -- updated_by (admin Juan)
    TRUE,
    NOW(),
    NOW()
);
-- Relación entre Órdenes y Cupones
CREATE TABLE order_coupons (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Cambié el tipo de ID a UUID
    order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    coupon_id INT NOT NULL REFERENCES coupons(id) ON DELETE CASCADE,
    discount_applied DECIMAL(10,2) NOT NULL CHECK (discount_applied >= 0),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    deleted_at TIMESTAMP NULL
);
CREATE TABLE IF NOT EXISTS order_products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), 
    -- Relaciones
    order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    -- Detalle de la compra
    quantity INT NOT NULL DEFAULT 1 CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
    total_price DECIMAL(10,2) NOT NULL CHECK (total_price >= 0),
    -- Estado y auditoría
    is_active BOOLEAN DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),
    deleted_at TIMESTAMP NULL,
    restored_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW() NOT NULL
);
CREATE TABLE inventory (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE, -- Cambiado a UUID
    stock INT DEFAULT 0 CHECK (stock >= 0),
    reserved_stock INT DEFAULT 0 CHECK (reserved_stock >= 0),
    available_stock INT GENERATED ALWAYS AS (stock - reserved_stock) STORED,
    warehouse_location VARCHAR(100) DEFAULT NULL,
    last_restocked_at TIMESTAMP DEFAULT NULL,
    restock_quantity INT DEFAULT 0 CHECK (restock_quantity >= 0),
    deleted_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    updated_by UUID DEFAULT NULL,
    CONSTRAINT check_stock_availability CHECK (stock >= reserved_stock)
);
CREATE TABLE reviews (
    uid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,  -- ✅ Cambiado a UUID
    customer_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    rating SMALLINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    is_active BOOLEAN DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),
    deleted_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE cart (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID REFERENCES users(id) ON DELETE CASCADE, 
    session_id UUID NULL,  -- Permite carrito anónimo antes de que el usuario inicie sesión
    total_amount NUMERIC(12, 2) DEFAULT 0, 
    status BOOLEAN DEFAULT TRUE,  -- TRUE = Activo, FALSE = Abandonado o Completado
    deleted_at TIMESTAMP NULL,  -- Fecha de eliminación lógica (NULL si sigue activo)
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE cart_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    cart_id UUID NOT NULL REFERENCES cart(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE, -- Cambiado a UUID
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(12, 2) NOT NULL,
    total_price NUMERIC(12, 2) GENERATED ALWAYS AS (quantity * unit_price) STORED,
    status BOOLEAN DEFAULT TRUE,
    deleted_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE shipping_providers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    tracking_url VARCHAR(255) DEFAULT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE shipments (
    uid UUID PRIMARY KEY DEFAULT gen_random_uuid(),  -- Usar UID en lugar de ID
    order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,  -- Clave foránea a pedidos
    provider_id INT NOT NULL REFERENCES shipping_providers(id) ON DELETE CASCADE,  -- Clave foránea a proveedores de envío
    tracking_number VARCHAR(50) NOT NULL UNIQUE,  -- Número de seguimiento del envío
    estimated_delivery DATE NOT NULL,  -- Fecha estimada de entrega
    status VARCHAR(50) NOT NULL DEFAULT 'pending',  -- Estado del envío (pendiente, enviado, entregado, etc.)
    is_active BOOLEAN DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),  -- Campo para gestionar si el envío está activo o inactivo
    deleted_at TIMESTAMP NULL,  -- Campo para eliminar lógicamente el envío (soft delete)
    created_at TIMESTAMP DEFAULT NOW(),  -- Fecha de creación
    updated_at TIMESTAMP DEFAULT NOW()  -- Fecha de última actualización
);
CREATE TABLE shipping_rates (
    id SERIAL PRIMARY KEY,
    shipping_method_id INT NOT NULL REFERENCES shipping_methods(id) ON DELETE CASCADE,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    weight_limit DECIMAL(10,2) CHECK (weight_limit > 0),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE order_shipping (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Cambié el tipo de ID a UUID
    order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE, -- Referencia a la tabla de órdenes
    shipping_method_id INT NOT NULL REFERENCES shipping_methods(id) ON DELETE CASCADE, -- Referencia a la tabla de métodos de envío
    tracking_number VARCHAR(50) UNIQUE, -- Número de seguimiento del envío
    estimated_delivery_date DATE, -- Fecha estimada de entrega
    shipping_address VARCHAR(255), -- Dirección de envío
    shipping_cost DECIMAL(10,2) DEFAULT 0.00, -- Costo del envío
    status VARCHAR(50) DEFAULT 'pending', -- Estado del envío (pendiente, enviado, entregado, etc.)
    created_at TIMESTAMP DEFAULT NOW(), -- Fecha de creación del registro
    updated_at TIMESTAMP DEFAULT NOW(), -- Fecha de última actualización
    deleted_at TIMESTAMP NULL -- Eliminación lógica (NULL si sigue activo)
);
CREATE TABLE product_reviews (
    uid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE, -- Cambiado a UUID
    customer_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    rating SMALLINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review TEXT,
    is_verified BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    deleted_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE customer_support_tickets (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Cambio a UUID
    customer_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    subject VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    status VARCHAR(50) DEFAULT 'open' CHECK (status IN ('open', 'closed', 'in_progress')),
    deleted_at TIMESTAMP NULL, -- Eliminación lógica (NULL si sigue activo)
    restored_at TIMESTAMP NULL, -- Fecha de restauración (si se reactiva)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE order_history (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Cambié el tipo de ID a UUID
    order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    status VARCHAR(50) NOT NULL, -- Estado del pedido (ej. 'pending', 'shipped', 'delivered')
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora del cambio de estado
    reason TEXT, -- Motivo del cambio de estado (por ejemplo, 'Pago confirmado', 'Enviado', etc.)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación del registro
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Fecha de última actualización del registro
    deleted_at TIMESTAMP NULL -- Eliminación lógica (NULL si sigue activo)
);
CREATE TABLE payment_logs (
    id SERIAL PRIMARY KEY,  -- ID único para el log de pago
    payment_id UUID NOT NULL REFERENCES payments(id) ON DELETE CASCADE,  -- Referencia al pago relacionado
    status VARCHAR(50) NOT NULL,  -- Estado del pago registrado en el log
    log_details TEXT,  -- Detalles adicionales del log (pueden ser mensajes, errores, etc.)
    is_active BOOLEAN DEFAULT TRUE CHECK (is_active IN (TRUE, FALSE)),  -- Estado activo/inactivo del log
    deleted_at TIMESTAMP NULL,  -- Fecha de eliminación lógica (NULL si no se ha eliminado)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Fecha de creación del log
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Fecha de última actualización
);
INSERT INTO shipping_rates (shipping_method_id, price, weight_limit) VALUES 
(1, 5.99, 10.0),
(2, 9.99, 10.0),
(3, 14.99, 10.0);