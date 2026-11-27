-- Pruebas del esquema sigev (datos ficticios)
SET search_path TO sigev;
INSERT INTO roles VALUES ('superadmin','Superadministrador','{roles:asignar,bitacora:auditar}'),('organizador','Organizador','{evento:programar,asistentes:cargar}'),('validador','Validador','{ingreso:controlar}'),('asistente','Asistente','{entrada:generar}');
INSERT INTO personas (id,tipo_doc,numero_doc,nombre_completo,correo_contacto) VALUES
 ('11111111-1111-1111-1111-111111111111','CC','900000001','Organizador Demo','org@demo.test'),
 ('22222222-2222-2222-2222-222222222222','CC','900000002','Asistente Demo','asis@demo.test'),
 ('33333333-3333-3333-3333-333333333333','CC','900000003','Validador Demo','val@demo.test');
INSERT INTO cuentas (id,persona_id,correo_acceso,hash_clave) VALUES
 ('a1111111-1111-1111-1111-111111111111','11111111-1111-1111-1111-111111111111','org@demo.test','$argon2id$v=19$m=65536,t=3,p=4$c2FsdGVqZW1wbG8$hashdemo'),
 ('a3333333-3333-3333-3333-333333333333','33333333-3333-3333-3333-333333333333','val@demo.test','$argon2id$v=19$m=65536,t=3,p=4$c2FsdGVqZW1wbG8$hashdemo2');
INSERT INTO asignaciones (cuenta_id,rol_codigo) VALUES ('a1111111-1111-1111-1111-111111111111','organizador'),('a3333333-3333-3333-3333-333333333333','validador');
INSERT INTO recintos (id,nombre,direccion,capacidad_fisica) VALUES ('b1111111-1111-1111-1111-111111111111','Centro de Convenciones Demo','Cra 1 # 1-1',2000);
INSERT INTO puertas VALUES ('b1111111-1111-1111-1111-111111111111',1,'Norte',true),('b1111111-1111-1111-1111-111111111111',2,'Sur',true);
INSERT INTO eventos (id,recinto_id,organizador_id,titulo,inicia_en,termina_en,aforo_maximo) VALUES ('c1111111-1111-1111-1111-111111111111','b1111111-1111-1111-1111-111111111111','a1111111-1111-1111-1111-111111111111','Congreso de Innovación 2026','2026-12-05 08:00-05','2026-12-05 17:00-05',1200);
INSERT INTO tipos_entrada (id,evento_id,nombre,cupo,precio) VALUES ('d1111111-1111-1111-1111-111111111111','c1111111-1111-1111-1111-111111111111','General',1000,0);
INSERT INTO entradas (id,codigo,tipo_entrada_id,titular_id) VALUES ('e1111111-1111-1111-1111-111111111111','SIG-000001','d1111111-1111-1111-1111-111111111111','22222222-2222-2222-2222-222222222222');
INSERT INTO registros_ingreso (entrada_id,recinto_id,nro_puerta,validador_id,sentido,resultado) VALUES ('e1111111-1111-1111-1111-111111111111','b1111111-1111-1111-1111-111111111111',1,'a3333333-3333-3333-3333-333333333333','E','aceptado');
INSERT INTO bitacora (cuenta_id,comando,detalle,huella) VALUES ('a3333333-3333-3333-3333-333333333333','ControlIngreso','{"puerta":1,"resultado":"aceptado"}',repeat('b',64));
SELECT (SELECT count(*) FROM personas) personas, (SELECT count(*) FROM entradas) entradas, (SELECT count(*) FROM registros_ingreso) registros;
\echo '--- Pruebas negativas (cada una DEBE fallar) ---'
-- 1 CHECK: rechazo sin motivo
INSERT INTO registros_ingreso (entrada_id,recinto_id,nro_puerta,validador_id,sentido,resultado) VALUES ('e1111111-1111-1111-1111-111111111111','b1111111-1111-1111-1111-111111111111',1,'a3333333-3333-3333-3333-333333333333','E','rechazado');
-- 2 FK compuesta: puerta inexistente
INSERT INTO registros_ingreso (entrada_id,recinto_id,nro_puerta,validador_id,sentido,resultado) VALUES ('e1111111-1111-1111-1111-111111111111','b1111111-1111-1111-1111-111111111111',9,'a3333333-3333-3333-3333-333333333333','E','aceptado');
-- 3 CHECK: más de 5 intentos fallidos
UPDATE cuentas SET intentos_fallidos = 6 WHERE correo_acceso = 'org@demo.test';
-- 4 UNIQUE: la misma persona con dos entradas del mismo tipo
INSERT INTO entradas (codigo,tipo_entrada_id,titular_id) VALUES ('SIG-000002','d1111111-1111-1111-1111-111111111111','22222222-2222-2222-2222-222222222222');
-- 5 CHECK: filas rechazadas mayores que leídas
INSERT INTO lotes_carga (evento_id,cargado_por,nombre_archivo,filas_leidas,filas_rechazadas) VALUES ('c1111111-1111-1111-1111-111111111111','a1111111-1111-1111-1111-111111111111','x.csv',10,20);
-- 6 RESTRICT: no se borra una persona titular de entradas
DELETE FROM personas WHERE id = '22222222-2222-2222-2222-222222222222';
-- 7 Bitácora de solo inserción
UPDATE bitacora SET comando = 'X';
DELETE FROM bitacora;
\echo '--- Prueba positiva: CASCADE de puertas al borrar un recinto sin eventos ---'
INSERT INTO recintos (id,nombre,direccion,capacidad_fisica) VALUES ('b2222222-2222-2222-2222-222222222222','Recinto temporal','Calle 9',100);
INSERT INTO puertas VALUES ('b2222222-2222-2222-2222-222222222222',1,'Única',true);
DELETE FROM recintos WHERE id = 'b2222222-2222-2222-2222-222222222222';
SELECT count(*) AS puertas_del_recinto_borrado FROM puertas WHERE recinto_id = 'b2222222-2222-2222-2222-222222222222';
\echo '--- Prueba de RLS: como sigev_api con app.persona_id = asistente, solo ve su entrada ---'
SET ROLE sigev_api; SET app.persona_id = '22222222-2222-2222-2222-222222222222'; SET app.rol = 'asistente';
SELECT codigo FROM entradas;
SET app.persona_id = '33333333-3333-3333-3333-333333333333'; SET app.rol = 'asistente';
SELECT count(*) AS entradas_visibles_para_otra_persona FROM entradas;
RESET ROLE;
