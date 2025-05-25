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

-- SELECTS DE NUESTRAS TABLAS

SELECT * FROM LOS_BASEADOS.estado
SELECT * FROM LOS_BASEADOS.provincia
SELECT * FROM LOS_BASEADOS.localidad
SELECT * FROM LOS_BASEADOS.sucursal
SELECT * FROM LOS_BASEADOS.proveedor