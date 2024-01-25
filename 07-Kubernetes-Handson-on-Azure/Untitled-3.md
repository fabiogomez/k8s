 Field                      | Type         | Null | Key | Default    | Extra          |
+----------------------------+--------------+------+-----+------------+----------------+
| id                         | int(10)      | NO   | PRI | NULL       | auto_increment |
| codigo                     | bigint(20)   | NO   | MUL | NULL       |                |
| direccion                  | varchar(200) | NO   |     | NULL       |                |
| ciudad                     | int(7)       | NO   | MUL | NULL       |                |
| zona    *                   | int(3)       | NO   | MUL | NULL       |                |
| barrio                     | varchar(50)  | NO   |     | NULL       |                |
| tipo_inmueble  *             | int(3)       | NO   | MUL | NULL       |                |
| gestion        *            | int(2)       | NO   | MUL | NULL       |                |
| area_construida            | float        | NO   |     | NULL       |                |
| area_lote                  | float        | NO   |     | NULL       |                |
| tipo_piso                  | varchar(20)  | NO   |     | NULL       |                |
| nivel                      | varchar(10)  | NO   |     | NULL       |                |
| habitaciones               | int(3)       | NO   |     | NULL       |                |
| banos                      | int(3)       | NO   |     | NULL       |                |
| estrato                    | int(3)       | NO   |     | NULL       |                |
| canon                      | bigint(10)   | NO   |     | NULL       |                |
| administracion             | bigint(10)   | NO   |     | NULL       |                |
| venta                      | bigint(10)   | NO   |     | NULL       |                |
| descripcion                | text         | NO   |     | NULL       |                |
| descripcion_ingles         | text         | NO   |     | NULL       |                |
| descripcion_frances        | text         | NO   |     | NULL       |                |
| restricciones              | text         | NO   |     | NULL       |                |
| comentario                 | text         | NO   |     | NULL       |                |
| comentario2                | text         | NO   |     | NULL       |                |
| cocina                     | int(4)       | NO   |     | NULL       |                |
| zona_oficios               | int(4)       | NO   |     | NULL       |                |
| id_perfil_asesor           | int(11)      | NO   | MUL | NULL       |                |
| propietario                | tinyint(1)   | NO   |     | NULL       |                |
| video                      | varchar(200) | NO   |     | NULL       |                |
| visitas                    | int(8)       | NO   |     | NULL       |                |
| parqueadero                | int(10)      | NO   |     | NULL       |                |
| parq_cubierto              | int(10)      | NO   |     | NULL       |                |
| fecha_consignacion         | date         | NO   |     | NULL       |                |
| fecha_registro             | datetime     | NO   |     | NULL       |                |
| latitud                    | varchar(20)  | NO   |     | NULL       |                |
| longitud                   | varchar(20)  | NO   |     | NULL       |                |
| estado                     | int(4)       | NO   | MUL | NULL       |                |
| ano_construccion           | int(5)       | NO   |     | NULL       |                |
| publicado                  | varchar(4)   | NO   |     | NULL       |                |
| destacado                  | varchar(2)   | NO   |     | NULL       |                |
| unidad_edificio            | varchar(255) | NO   |     | NULL       |                |
| usuario                    | int(11)      | NO   | MUL | NULL       |                |
| sucursal                   | int(11)      | NO   | MUL | NULL       |                |
| aviso_ventana              | tinyint(4)   | NO   |     | NULL       |                |
| frente                     | float        | NO   |     | NULL       |                |
| fondo                      | float        | NO   |     | NULL       |                |
| area_privada               | float        | NO   |     | NULL       |                |
| id_proyecto                | int(11)      | NO   |     | NULL       |                |
| id_destinacion             | int(11)      | NO   |     | NULL       |                |
| id_barrio                  | int(6)       | NO   |     | NULL       |                |
| mostrar_en_portal          | tinyint(1)   | NO   |     | NULL       |                |
| fecha_publicacion          | datetime     | NO   |     | NULL       |                |
| fecha_actualizacion        | datetime     | NO   |     | NULL       |                |
| id_portal                  | int(9)       | NO   | MUL | NULL       |                |
| porcentaje_comision        | int(4)       | NO   |     | NULL       |                |
| numero_matricula           | varchar(30)  | NO   |     | NULL       |                |
| referencia                 | varchar(13)  | NO   |     | NULL       |                |
| zona_ciudad_id  *           | int(11)      | YES  |     | 0          |                |
| fecha_ultimo_cambio_estado | date         | NO   |     | 2021-09-01 |                |
