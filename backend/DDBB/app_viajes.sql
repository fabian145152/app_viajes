-- Adminer 5.4.2 PostgreSQL 18.3 dump

DROP DATABASE IF EXISTS "app_viajes";
CREATE DATABASE "app_viajes";
\connect "app_viajes";

DROP TABLE IF EXISTS "autorizantes";
DROP SEQUENCE IF EXISTS "public".autorizantes_id_seq;
CREATE SEQUENCE "public".autorizantes_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."autorizantes" (
    "id" integer DEFAULT nextval('autorizantes_id_seq') NOT NULL,
    "nombre" character varying NOT NULL,
    "apellido" character varying NOT NULL,
    "cel" character varying(20),
    "email" character varying NOT NULL,
    "id_empresa" integer,
    CONSTRAINT "autorizantes_pkey" PRIMARY KEY ("id")
)
WITH (oids = false);

INSERT INTO "autorizantes" ("id", "nombre", "apellido", "cel", "email", "id_empresa") VALUES
(1,	'ARTURO',	'MOSTES',	'1145678965',	'montes@gmail.com',	1),
(2,	'JORGE',	'TARGA',	'1145789645',	'targa@gmail.com',	1),
(3,	'MARIA',	'SANTILLAN',	'1123568956',	'maria_santillan@gmail.com',	2);

DROP TABLE IF EXISTS "choferes";
DROP SEQUENCE IF EXISTS "public".choferes_id_seq;
CREATE SEQUENCE "public".choferes_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."choferes" (
    "id" integer DEFAULT nextval('choferes_id_seq') NOT NULL,
    "nombre" character varying NOT NULL,
    "apellido" character varying NOT NULL,
    "cel" integer,
    "dir" character varying,
    "barrio" character varying,
    "cp" integer,
    CONSTRAINT "choferes_pkey" PRIMARY KEY ("id")
)
WITH (oids = false);

INSERT INTO "choferes" ("id", "nombre", "apellido", "cel", "dir", "barrio", "cp") VALUES
(3,	'MARIA ROSA',	'YORIO',	NULL,	NULL,	NULL,	NULL),
(2,	'ARTURO',	'COPES',	1125895689,	'Camacua 2025',	'Villa Crespo',	1604),
(4,	'FABIAN',	'NOGUEROLES',	1169356236,	'CARLOS GARDEL 3296',	'V. LIBERTAD SAN MARTIN',	1650),
(1,	'JUAN CARLOS',	'PEREZ',	1154873265,	'CAMPICHUELO 2025',	'ONCE',	1401);

DROP TABLE IF EXISTS "cuenta_empresa";
DROP SEQUENCE IF EXISTS "public".empresa_id_seq;
CREATE SEQUENCE "public".empresa_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."cuenta_empresa" (
    "id" integer DEFAULT nextval('empresa_id_seq') NOT NULL,
    "razon_social" character varying NOT NULL,
    "dir" character varying NOT NULL,
    "cuit" character varying NOT NULL,
    "inc_brutos" character varying NOT NULL,
    "cel_1" integer,
    "cel_2" integer,
    "cel_3" character varying NOT NULL,
    "contacto_1" character varying NOT NULL,
    "contacto_2" character varying NOT NULL,
    "contacto_3" character varying NOT NULL,
    "numero_cuenta" integer NOT NULL,
    CONSTRAINT "empresa_pkey" PRIMARY KEY ("id")
)
WITH (oids = false);

INSERT INTO "cuenta_empresa" ("id", "razon_social", "dir", "cuit", "inc_brutos", "cel_1", "cel_2", "cel_3", "contacto_1", "contacto_2", "contacto_3", "numero_cuenta") VALUES
(1,	'AZ PLUS',	'JUAN B JUSTO 7730',	'30707651934',	'30707651934',	1145784512,	NULL,	'',	'JUAN PEREZ',	'',	'',	100),
(2,	'HTAL ITALIANO',	'GURRUCHAGA 2025',	'2014758911',	'2014758911',	1154659865,	NULL,	'',	'CARLOS PIRINCHO',	'',	'',	201);

DROP TABLE IF EXISTS "permisos";
DROP SEQUENCE IF EXISTS "public".permisos_id_seq;
CREATE SEQUENCE "public".permisos_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."permisos" (
    "id" integer DEFAULT nextval('permisos_id_seq') NOT NULL,
    "id_operador" integer,
    "nivel" character(30) NOT NULL,
    "id_user" integer NOT NULL,
    CONSTRAINT "permisos_pkey" PRIMARY KEY ("id")
)
WITH (oids = false);


DROP TABLE IF EXISTS "usuarios";
DROP SEQUENCE IF EXISTS "public".usuarios_id_seq;
CREATE SEQUENCE "public".usuarios_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."usuarios" (
    "id" integer DEFAULT nextval('usuarios_id_seq') NOT NULL,
    "nombre" character varying(100) NOT NULL,
    "telefono" character varying(20),
    "email" character varying(100) NOT NULL,
    "password" character varying(255) NOT NULL,
    "permisos" character varying(30),
    "estado" character varying(30),
    "nom_apellido" character varying(50),
    CONSTRAINT "usuarios_pkey" PRIMARY KEY ("id")
)
WITH (oids = false);

CREATE UNIQUE INDEX usuarios_email_key ON public.usuarios USING btree (email);

INSERT INTO "usuarios" ("id", "nombre", "telefono", "email", "password", "permisos", "estado", "nom_apellido") VALUES
(13,	'Alberto',	'1145781245',	'alberto@gmail.com',	'$2y$10$bJsnLSiRMIM6aTmvYWWS/OtnM829PKaN3XFtJPy6AGAbhPVtfuvku',	'3',	'suspendido',	NULL),
(11,	'Anibal',	'1145781223',	'anibal@gmail.com',	'$2y$10$hZWDhVigZqK4GpWjwpv4HOBbalwp5cDtVE51yJQQ6z95BRmG7yaei',	'2',	'suspendido',	NULL),
(9,	'juana',	'1145781245',	'juana@gmail.com',	'$2y$10$.l9SMApqjavcDfv8TZqv5uwTfZv3oJLPBbr77CFVNW51iOuY.3rGu',	'3',	'Activo',	NULL),
(10,	'Laura',	'1166669900',	'laura@gmail.com',	'$2y$10$L13olhamrlMvrKO8s0XMvewGcn1eMkB3i1LypDh7nSYJQZX27abeG',	'1',	'activo',	NULL),
(8,	'maria',	'1169356237',	'maria@gmail.com',	'$2y$10$2WfIJXWw7TCcRR.jV9/rb.lKQi8cmmXpDf/qZkXKOXa./jCKb7B0C',	'2',	'activo',	'Maria Carpen'),
(1,	'fabian',	'1169356236',	'fabian_12345@hotmail.com',	'$2y$10$9Y7tFQpxkwpYwzSulzEaju0/jbKU4lS2yx3Rv5.PWkY075nv2rikC',	'0',	'activo',	'Fabian Nogueroles'),
(6,	'lucas',	'1156892356',	'lucas@gmail.com',	'$2y$10$H1rsKkh0SDJA82BznVXwz.gb8NKxNBpId9/UPQJGjaeLp9s3JE./K',	'3',	'activo',	'Lucas Nogueroles'),
(7,	'sofi',	'1178458956',	'sofi@gmail.com',	'$2y$10$vUkaNbW7bbRyOqwf2lTvEu0Uc8jOrHzyk9yFf//kR.JGqdcrqCJ9G',	'1',	'activo',	'Sofia Fiorella');

DROP TABLE IF EXISTS "vehiculos";
DROP SEQUENCE IF EXISTS "public".conductores_id_seq;
CREATE SEQUENCE "public".conductores_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."vehiculos" (
    "id" integer DEFAULT nextval('conductores_id_seq') NOT NULL,
    "marca" character varying(30) NOT NULL,
    "modelo" character varying(50),
    "patente" character varying(20),
    "estado" character varying(20) DEFAULT 'disponible',
    "color" character varying(20),
    "id_chofer" integer,
    CONSTRAINT "conductores_pkey" PRIMARY KEY ("id")
)
WITH (oids = false);

CREATE UNIQUE INDEX conductores_patente_key ON public.vehiculos USING btree (patente);

INSERT INTO "vehiculos" ("id", "marca", "modelo", "patente", "estado", "color", "id_chofer") VALUES
(3,	'CHEVROLET',	'spin',	'AA456FG',	'disponible',	'ROJO',	NULL),
(5,	'CHEVROLET',	'SPIN',	'AA456FH',	'ocupado',	'GRIS PLATA',	1),
(6,	'FIAT',	'CRONOS',	'AT484GF',	'ocupado',	'BLANCO',	4);

DROP TABLE IF EXISTS "viajes";
DROP SEQUENCE IF EXISTS "public".viajes_id_seq;
CREATE SEQUENCE "public".viajes_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."viajes" (
    "id" integer DEFAULT nextval('viajes_id_seq') NOT NULL,
    "pasajero_id" integer,
    "conductor_id" integer,
    "origen_lat" numeric(10,8),
    "origen_lng" numeric(11,8),
    "destino_lat" numeric(10,8),
    "destino_lng" numeric(11,8),
    "precio" numeric(10,2),
    "estado" character varying(20) DEFAULT 'pendiente',
    "creado_at" timestamp DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "viajes_pkey" PRIMARY KEY ("id")
)
WITH (oids = false);


ALTER TABLE ONLY "public"."autorizantes" ADD CONSTRAINT "fk_autorizante_empresa" FOREIGN KEY (id_empresa) REFERENCES cuenta_empresa(id) ON DELETE CASCADE;

ALTER TABLE ONLY "public"."permisos" ADD CONSTRAINT "permisos_id_user_fkey" FOREIGN KEY (id_user) REFERENCES usuarios(id);

ALTER TABLE ONLY "public"."vehiculos" ADD CONSTRAINT "fk_vehiculo_chofer" FOREIGN KEY (id_chofer) REFERENCES choferes(id) ON DELETE SET NULL;

ALTER TABLE ONLY "public"."viajes" ADD CONSTRAINT "viajes_conductor_id_fkey" FOREIGN KEY (conductor_id) REFERENCES vehiculos(id);
ALTER TABLE ONLY "public"."viajes" ADD CONSTRAINT "viajes_pasajero_id_fkey" FOREIGN KEY (pasajero_id) REFERENCES usuarios(id);

-- 2026-04-07 19:45:25 UTC
