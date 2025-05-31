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




-- VERSION 1 -- 61.228 filas
/*
CREATE PROC LOS_BASEADOS.migrar_detalleFactura AS
BEGIN
    INSERT INTO LOS_BASEADOS.detalle_factura (idFactura, idDetallePedido, precioUnitario, cantidad, subtotal)
    SELECT DISTINCT 
        f.idFactura,
        dp.idDetallePedido,
        m.Detalle_Factura_Precio,
        m.Detalle_Factura_Cantidad,
        m.Detalle_Factura_SubTotal
    FROM Maestra m
    JOIN LOS_BASEADOS.factura f ON m.Factura_Numero = f.numeroFactura
    JOIN LOS_BASEADOS.detalle_pedido dp ON 
        m.Pedido_Numero = dp.numeroPedido AND
        m.Detalle_Pedido_Precio = dp.precio AND
        m.Detalle_Pedido_Cantidad = dp.cantidad
    WHERE m.Factura_Numero IS NOT NULL
	ORDER BY f.idFactura
END
GO 
*/

-- VERSION 2 -- 61.092 -- usa ROW_NUMBER() OVER + PARTITION BY
/*
CREATE PROC LOS_BASEADOS.migrar_detalleFactura AS
BEGIN
    WITH dp_filtrado AS (
        SELECT 
            dp.idDetallePedido,
            dp.numeroPedido,
            dp.precio,
            dp.cantidad,
            dp.subtotal,
            ROW_NUMBER() OVER (
                PARTITION BY dp.numeroPedido, dp.precio, dp.cantidad, dp.subtotal
                ORDER BY dp.idDetallePedido
            ) AS rn
        FROM LOS_BASEADOS.detalle_pedido dp
    )
    INSERT INTO LOS_BASEADOS.detalle_factura (idFactura, idDetallePedido, precioUnitario, cantidad, subtotal)
    SELECT 
        f.idFactura,
        dpf.idDetallePedido,
        m.Detalle_Factura_Precio,
        m.Detalle_Factura_Cantidad,
        m.Detalle_Factura_SubTotal
    FROM Maestra m
    JOIN LOS_BASEADOS.factura f ON m.Factura_Numero = f.numeroFactura
    JOIN dp_filtrado dpf ON 
        dpf.numeroPedido = m.Pedido_Numero AND
        dpf.precio = m.Detalle_Pedido_Precio AND
        dpf.cantidad = m.Detalle_Pedido_Cantidad AND
        dpf.subtotal = m.Detalle_Pedido_SubTotal AND
        dpf.rn = 1
    WHERE m.Factura_Numero IS NOT NULL
    ORDER BY f.idFactura
END
GO 
*/

-- VERSION 3 -- 61.092 -- usa CORSS APPLY
/*
CREATE PROC LOS_BASEADOS.migrar_detalleFactura AS
BEGIN
    INSERT INTO LOS_BASEADOS.detalle_factura (idFactura, idDetallePedido, precioUnitario, cantidad, subtotal)
    SELECT
        f.idFactura,
        dp.idDetallePedido,
        m.Detalle_Factura_Precio,
        m.Detalle_Factura_Cantidad,
        m.Detalle_Factura_SubTotal
    FROM Maestra m
    JOIN LOS_BASEADOS.factura f ON m.Factura_Numero = f.numeroFactura
    CROSS APPLY (
        SELECT TOP 1 dp2.idDetallePedido
        FROM LOS_BASEADOS.detalle_pedido dp2
        WHERE dp2.numeroPedido = m.Pedido_Numero AND
              dp2.precio = m.Detalle_Pedido_Precio AND
              dp2.cantidad = m.Detalle_Pedido_Cantidad AND
              dp2.subtotal = m.Detalle_Pedido_SubTotal
    ) dp
    WHERE m.Factura_Numero IS NOT NULL
    ORDER BY f.idFactura
END
GO 
*/

-- VERSION 4 -- 61.092 -- no usa nada raro
/*
CREATE PROC LOS_BASEADOS.migrar_detalleFactura AS
BEGIN
    INSERT INTO LOS_BASEADOS.detalle_factura (idFactura, idDetallePedido, precioUnitario, cantidad, subtotal)
    SELECT
        f.idFactura,
        (
            SELECT TOP 1 dp2.idDetallePedido
            FROM LOS_BASEADOS.detalle_pedido dp2
            WHERE dp2.numeroPedido = m.Pedido_Numero
              AND dp2.precio = m.Detalle_Pedido_Precio
              AND dp2.cantidad = m.Detalle_Pedido_Cantidad
              AND dp2.subtotal = m.Detalle_Pedido_SubTotal
        ) AS idDetallePedido,
        m.Detalle_Factura_Precio,
        m.Detalle_Factura_Cantidad,
        m.Detalle_Factura_SubTotal
    FROM Maestra m
    JOIN LOS_BASEADOS.factura f ON m.Factura_Numero = f.numeroFactura
    WHERE m.Factura_Numero IS NOT NULL
      AND (
          SELECT TOP 1 dp2.idDetallePedido
          FROM LOS_BASEADOS.detalle_pedido dp2
          WHERE dp2.numeroPedido = m.Pedido_Numero
            AND dp2.precio = m.Detalle_Pedido_Precio
            AND dp2.cantidad = m.Detalle_Pedido_Cantidad
            AND dp2.subtotal = m.Detalle_Pedido_SubTotal
      ) IS NOT NULL
    ORDER BY f.idFactura;
END
GO
*/

-- VERSION 5 -- 61.092 -- no usa nada raro
/*
CREATE PROC LOS_BASEADOS.migrar_detalleFactura AS
BEGIN
    WITH MaestraConDetalle AS (
        SELECT 
            m.*,
            (
                SELECT TOP 1 dp2.idDetallePedido
                FROM LOS_BASEADOS.detalle_pedido dp2
                WHERE dp2.numeroPedido = m.Pedido_Numero
                  AND dp2.precio = m.Detalle_Pedido_Precio
                  AND dp2.cantidad = m.Detalle_Pedido_Cantidad
                  AND dp2.subtotal = m.Detalle_Pedido_SubTotal
            ) AS idDetallePedido
        FROM Maestra m
    )
    INSERT INTO LOS_BASEADOS.detalle_factura (
        idFactura, idDetallePedido, precioUnitario, cantidad, subtotal
    )
    SELECT 
        f.idFactura,
        mcd.idDetallePedido,
        mcd.Detalle_Factura_Precio,
        mcd.Detalle_Factura_Cantidad,
        mcd.Detalle_Factura_SubTotal
    FROM MaestraConDetalle mcd
    JOIN LOS_BASEADOS.factura f 
        ON mcd.Factura_Numero = f.numeroFactura
    WHERE mcd.Factura_Numero IS NOT NULL
      AND mcd.idDetallePedido IS NOT NULL
    ORDER BY f.idFactura;
END
GO
*/

/*
-- VERSION 6 -- 61.087 -- no repite detalle_pedido en los detalle_factura PERO usa ROW_NUMBER() OVER + PARTITION BY
CREATE PROC LOS_BASEADOS.migrar_detalleFactura AS
BEGIN
	WITH posibles_pareos AS (
		SELECT 
			f.idFactura,
			dp.idDetallePedido,
			m.Detalle_Factura_Precio,
			m.Detalle_Factura_Cantidad,
			m.Detalle_Factura_SubTotal,
			ROW_NUMBER() OVER (
				PARTITION BY m.Pedido_Numero, m.Detalle_Pedido_Precio, m.Detalle_Pedido_Cantidad, m.Detalle_Pedido_SubTotal
				ORDER BY f.idFactura, dp.idDetallePedido
			) AS rn
		FROM Maestra m
		JOIN LOS_BASEADOS.factura f ON m.Factura_Numero = f.numeroFactura
		JOIN LOS_BASEADOS.detalle_pedido dp ON 
			dp.numeroPedido = m.Pedido_Numero AND
			dp.precio = m.Detalle_Pedido_Precio AND
			dp.cantidad = m.Detalle_Pedido_Cantidad AND
			dp.subtotal = m.Detalle_Pedido_SubTotal
		WHERE m.Factura_Numero IS NOT NULL
	)
	INSERT INTO LOS_BASEADOS.detalle_factura (idFactura, idDetallePedido, precioUnitario, cantidad, subtotal)
	SELECT 
		idFactura,
		idDetallePedido,
		Detalle_Factura_Precio AS precioUnitario,
		Detalle_Factura_Cantidad AS cantidad,
		Detalle_Factura_SubTotal AS subtotal
	FROM posibles_pareos
	WHERE rn = 1
	ORDER BY idFactura;
END
GO 
*/




        -- DETALLE_PEDIDO por ??
-- CREATE INDEX IX_detallePedido_numeroPedido ON LOS_BASEADOS.detalle_pedido (??);