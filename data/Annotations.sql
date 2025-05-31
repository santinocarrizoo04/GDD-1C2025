-- SI QUIERO INSERTAR UN DATO QUE NO SE PUEDE, POR EJ UNA FK A UNA PK Q NO ESTA, LA PK DE ESA TABLA SE SALTEA UNO!!!

-- NO HAY PEDIDOS CON EL ESTADO EN NULL 
SELECT * FROM Maestra WHERE Pedido_estado IS NULL --18119 rows
SELECT * FROM Maestra WHERE Pedido_estado IS NULL AND Pedido_numero IS NOT NULL --0 rows

--NO HAY CLIENTES CON PROVINCIA EN NULL
SELECT DISTINCT *
FROM Maestra
WHERE Maestra.Cliente_Provincia IS NULL AND Cliente_nombre IS NOT NULL


-- RANDOM // PRUEBAS

SELECT DISTINCT Pedido_estado, COUNT(*) cantidad FROM Maestra
GROUP BY Pedido_estado

SELECT * FROM LOS_BASEADOS.estado
SELECT * FROM LOS_BASEADOS.provincia

SELECT name AS schema_name
FROM sys.schemas;

SELECT * FROM LOS_BASEADOS.localidad WHERE localidad = '1 De Mayo'
SELECT * FROM LOS_BASEADOS.provincia WHERE idProvincia = 6
SELECT * FROM LOS_BASEADOS.provincia WHERE idProvincia = 13

SELECT * FROM Maestra WHERE Cliente_Localidad = '1 De Mayo'


SELECT * FROM LOS_BASEADOS.localidad WHERE localidad = 'El Simbolar'
SELECT * FROM Maestra WHERE Sucursal_NroSucursal = 92

SElECT DISTINCT Material_tipo FROM Maestra WHERE Material_tipo IS NOT NULL

SELECT DISTINCT Madera_dureza, Madera_Color FROM Maestra WHERE Madera_dureza IS NOT NULL AND Madera_color IS NOT NULL

SELECT * FROM Maestra WHERE Pedido_Numero = 56360503

SELECT Material_tipo, Material_nombre, Material_descripcion, Material_Precio, Tela_color, Tela_textura, Madera_color, Madera_dureza, Relleno_densidad
FROM Maestra WHERE Material_tipo IS NOT NULL AND Material_nombre = 'Poliester'

 SELECT DISTINCT Tela_color, Tela_textura FROM Maestra

SELECT DISTINCT Material_tipo, Material_nombre, Material_descripcion
FROM Maestra 
WHERE Material_tipo IS NOT NULL

-- Si la consulta devuelve filas, significa que hay detalles de pedido que estan siendo facturados mas de una vez.
/*
SELECT idDetallePedido, COUNT(*) AS apariciones
FROM LOS_BASEADOS.detalle_factura
GROUP BY idDetallePedido
HAVING COUNT(*) > 1;
*/

-- SELECTS DE NUESTRAS TABLAS

SELECT * FROM LOS_BASEADOS.estado
SELECT * FROM LOS_BASEADOS.provincia
SELECT * FROM LOS_BASEADOS.localidad
SELECT * FROM LOS_BASEADOS.sucursal
SELECT * FROM LOS_BASEADOS.proveedor
SELECT * FROM LOS_BASEADOS.tipo_material
SELECT * FROM LOS_BASEADOS.material
SELECT * FROM LOS_BASEADOS.tela
SELECT * FROM LOS_BASEADOS.madera
SELECT * FROM LOS_BASEADOS.relleno
SELECT * FROM LOS_BASEADOS.compra
SELECT * FROM LOS_BASEADOS.detalle_compra