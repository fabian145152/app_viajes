-- Adminer 5.4.2 PostgreSQL 18.3 dump

DROP DATABASE IF EXISTS "app_viajes";
CREATE DATABASE "app_viajes";
\connect "app_viajes";

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
(3,	'chevrolet',	'spin',	'AA456FG',	'ocupado',	'rojo',	NULL);

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


ALTER TABLE ONLY "public"."permisos" ADD CONSTRAINT "permisos_id_user_fkey" FOREIGN KEY (id_user) REFERENCES usuarios(id);

ALTER TABLE ONLY "public"."vehiculos" ADD CONSTRAINT "fk_vehiculo_chofer" FOREIGN KEY (id_chofer) REFERENCES usuarios(id);

ALTER TABLE ONLY "public"."viajes" ADD CONSTRAINT "viajes_conductor_id_fkey" FOREIGN KEY (conductor_id) REFERENCES vehiculos(id);
ALTER TABLE ONLY "public"."viajes" ADD CONSTRAINT "viajes_pasajero_id_fkey" FOREIGN KEY (pasajero_id) REFERENCES usuarios(id);

-- 2026-04-06 19:55:40 UTC
