-- Table: api.impresoras

-- DROP TABLE IF EXISTS api.impresoras;

CREATE TABLE IF NOT EXISTS api.impresoras
(
    id integer NOT NULL DEFAULT nextval('api.impresoras_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default" NOT NULL,
    modelo character varying(255) COLLATE pg_catalog."default",
    ubicacion character varying(255) COLLATE pg_catalog."default",
    color boolean,
    bn boolean,
    ip character varying(100) COLLATE pg_catalog."default",
    activa boolean,
    "fechaCreado" date,
    CONSTRAINT impresoras_pkey PRIMARY KEY (id),
    CONSTRAINT nombre_unico UNIQUE (nombre)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS api.impresoras
    OWNER to posadmin;