-- ============================================================
-- 🧩 Resumen del esquema: Base de servicio Rest comunicado con MySQL o PostgreSQL
-- ============================================================
-- 🌐 Proyecto: Node Base Service — Backend Operativo y Administrativo
-- 🗓️ Versión: 1.0
-- 🧱 Motor: PostgreSQL, MySQL
-- 📦 Módulos principales:
-- 1️⃣  Autenticación:
--     - users, employees, customers
--     - sesiones, verificación, logs
-- 2️⃣  Permisos y roles:
--     - roles, modules, actions
--     - asignación dinámica por rol
-- 🚀 Características clave:
--     ✅ Auditoría completa (created_at, updated_at, deleted_at, restored_at)
--     ✅ Soporte multicanal (web, mobile)
--     ✅ Validaciones e integridad de datos
--     ✅ Arquitectura escalable y modular
--     ✅ Documentación mantenible
-- 🔐 Seguridad y flexibilidad:
--     - Roles y permisos granulares
--     - Tokens únicos por sesión
--     - Soft deletes
--     - Métodos de pago integrados
-- ✍️ Autor: Jose Luis Trespalacios
-- 🧑‍💼 Rol: CTO y Arquitecto de Software
-- 🏢 Compañía: BitLink Technology Partner
-- 📅 Última modificación: 19/04/25
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
-- 7. INSERT DE USUARIOS, EMPLEADOS Y CLIENTES
-- ===========================================
-- Usuarios (3 empleados + 3 clientes)
INSERT INTO users (id, name, email, password_hash, is_active, is_verified, created_at, updated_at)
VALUES
-- Empleados
('11111111-1111-1111-1111-111111111111', 'Juan Pérez', 'juan@example.com', 'hash1', TRUE, TRUE, NOW(), NOW()),
('22222222-2222-2222-2222-222222222222', 'Carla Torres', 'carla@example.com', 'hash2', TRUE, TRUE, NOW(), NOW()),
('33333333-3333-3333-3333-333333333333', 'Luis Martínez', 'luis@example.com', 'hash3', TRUE, TRUE, NOW(), NOW()),
-- Roles asignados
INSERT INTO user_roles (user_id, role_id)
VALUES
-- Empleados
('11111111-1111-1111-1111-111111111111', (SELECT id FROM roles WHERE slug = 'admin')),
('22222222-2222-2222-2222-222222222222', (SELECT id FROM roles WHERE slug = 'vendedor')),
('33333333-3333-3333-3333-333333333333', (SELECT id FROM roles WHERE slug = 'vendedor')),
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