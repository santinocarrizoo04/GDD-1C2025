-- PRUEBAS HECHO COMPRA

/*
SELECT tiempo.idTiempo, ubi.idUbicacion, ds.idSucursal, dtm.idBiTipoMaterial, count (distinct compra.numeroCompra), sum(detalle_compra.subtotal)
FROM LOS_BASEADOS.compra compra
JOIN LOS_BASEADOS.sucursal sucursal ON compra.numeroSucursal=sucursal.numeroSucursal
JOIN LOS_BASEADOS.localidad localidad ON sucursal.idLocalidad= localidad.idLocalidad
JOIN LOS_BASEADOS.detalle_compra ON compra.idCompra=detalle_compra.idCompra
JOIN LOS_BASEADOS.material material ON material.idMaterial=detalle_compra.idMaterial
JOIN LOS_BASEADOS.tipo_material tipo_mat ON material.idTipoMaterial = tipo_mat.idTipoMaterial

JOIN LOS_BASEADOS.bi_dimension_tiempo tiempo ON LOS_BASEADOS.comparar_fecha(tiempo.anio,tiempo.mes,tiempo.cuatrimestre,compra.fecha)=1
JOIN LOS_BASEADOS.BI_dimension_ubicacion ubi ON sucursal.idLocalidad=ubi.idLocalidad AND localidad.idProvincia=ubi.idProvincia
JOIN LOS_BASEADOS.BI_dimension_tipo_material dtm ON dtm.tipo = tipo_mat.tipo
JOIN LOS_BASEADOS.BI_dimension_sucursal ds ON ds.numeroSucursal = sucursal.numeroSucursal
GROUP BY tiempo.idTiempo, ds.idSucursal, dtm.idBiTipoMaterial, ubi.idUbicacion
*/

-- MIGRAR TODAS LAS COMPRAS Y AGRUPAR POR TIEMPO(FECHA), UBICACION(SUCURSAL), SUCURSAL, TIPO_MATERIAL
-- CALCULAR TOTAL_COMPRAS Y CANT_COMPRAS

SELECT tiempo.mes, tiempo.anio, ubi.localidad, ubi.provincia, ds.numeroSucursal, dtm.tipo, count (compra.numeroCompra) cant, sum(detalle_compra.subtotal) tot
FROM LOS_BASEADOS.compra compra
JOIN LOS_BASEADOS.sucursal sucursal ON compra.numeroSucursal=sucursal.numeroSucursal
JOIN LOS_BASEADOS.localidad localidad ON sucursal.idLocalidad= localidad.idLocalidad
JOIN LOS_BASEADOS.detalle_compra ON compra.idCompra=detalle_compra.idCompra
JOIN LOS_BASEADOS.material material ON material.idMaterial=detalle_compra.idMaterial
JOIN LOS_BASEADOS.tipo_material tipo_mat ON material.idTipoMaterial = tipo_mat.idTipoMaterial

JOIN LOS_BASEADOS.bi_dimension_tiempo tiempo ON LOS_BASEADOS.comparar_fecha(tiempo.anio,tiempo.mes,tiempo.cuatrimestre,compra.fecha)=1
JOIN LOS_BASEADOS.BI_dimension_ubicacion ubi ON sucursal.idLocalidad=ubi.idLocalidad AND localidad.idProvincia=ubi.idProvincia
JOIN LOS_BASEADOS.BI_dimension_tipo_material dtm ON dtm.tipo = tipo_mat.tipo
JOIN LOS_BASEADOS.BI_dimension_sucursal ds ON ds.numeroSucursal = sucursal.numeroSucursal
GROUP BY tiempo.mes, tiempo.anio, ubi.localidad, ubi.provincia, ds.numeroSucursal, dtm.tipo
ORDER BY tiempo.mes, tiempo.anio, ubi.localidad, ubi.provincia, ds.numeroSucursal, dtm.tipo

/*

1	2026	Alta Gracia	Santia; Del Estero	107	Madera	3	5887169.68
1	2026	Alta Gracia	Santia; Del Estero	107	Relleno	3	6544578.53
1	2026	Alta Gracia	Santia; Del Estero	107	Tela	3	5825206.03
1	2026	Cuartel 2	Buenos Aires	37	Madera	6	8934970.80
1	2026	Cuartel 2	Buenos Aires	37	Relleno	6	9961816.59
1	2026	Cuartel 2	Buenos Aires	37	Tela	6	8838224.31

*/

-- MIGRAR TODAS LAS COMPRAS Y AGRUPAR POR TIEMPO(FECHA), UBICACION(SUCURSAL), SUCURSAL, TIPO_MATERIAL
-- CALCULAR TOTAL_COMPRAS Y CANT_COMPRAS

SELECT MONTH(c.fecha) mes, YEAR(c.fecha) anio, l.localidad,p.provincia, s.numeroSucursal, SUM(dc.subtotal)
FROM LOS_BASEADOS.compra c
JOIN LOS_BASEADOS.sucursal s ON c.numeroSucursal = s.numeroSucursal
JOIN LOS_BASEADOS.localidad l ON s.idLocalidad = l.idLocalidad
JOIN LOS_BASEADOS.provincia p ON l.idProvincia = p.idProvincia
JOIN LOS_BASEADOS.detalle_compra dc ON dc.idCompra = c.idCompra
JOIN LOS_BASEADOS.material m ON dc.idMaterial = m.idMaterial
JOIN LOS_BASEADOS.tipo_material tm ON tm.idTipoMaterial = m.idTipoMaterial
WHERE s.numeroSucursal = 107 AND tm.tipo = 'Madera'
AND MONTH(c.fecha) = 1 AND YEAR(c.fecha) = 2026
GROUP BY s.numeroSucursal, l.localidad, p.provincia, c.fecha

-- 1	2026	Alta Gracia	Santia; Del Estero	107	5887169.68 -> Madera
-- 1	2026	Alta Gracia	Santia; Del Estero	107	6544578.53 --> Relleno
-- 1	2026	Alta Gracia	Santia; Del Estero	107	5825206.03 -> Tela

-- 1	2026	Cuartel 2	Buenos Aires	37	4902248.13 --> Tela
-- 1	2026	Cuartel 2	Buenos Aires	37	3935976.18 --> Tela
-- 1	2026	Cuartel 2	Buenos Aires	37	5549826.04 --> Relleno
-- 1	2026	Cuartel 2	Buenos Aires	37	4411990.55 --> Relleno
-- 1	2026	Cuartel 2	Buenos Aires	37	4954091.27 --> Madera
-- 1	2026	Cuartel 2	Buenos Aires	37	3980879.53 --> Madera

SELECT *
FROM LOS_BASEADOS.compra c
JOIN LOS_BASEADOS.detalle_compra dc ON dc.idCompra = c.idCompra
JOIN LOS_BASEADOS.material m ON m.idMaterial = dc.idMaterial
JOIN LOS_BASEADOS.tipo_material tm ON tm.idTipoMaterial = m.idTipoMaterial 
WHERE MONTH(c.fecha) = 1 AND YEAR(c.fecha) = 2026 AND c.numeroSucursal = 107 AND tm.tipo = 'Tela'

-- 5	12242157	107	6	2026-01-29 00:00:00.000000	18256954.25 --> Total (Tela + Madera + Relleno)

-- OK - COINCIDEN LOS MONTOS DE LA TABLA HECHOS CON CONSULTAS SOBRE EL MODELO RELACIONAL










---------------------------------------------------------------------------------------------------------------------------------------------
-- PRUEBAS HECHO ENVIO

/*
SELECT tiempo.idTiempo, ubi.idUbicacion, ds.idSucursal, count(LOS_BASEADOS.envio_cumplido(envio.fechaProgramada,envio.fechaEntrega)), count(*), sum(envio.total)
FROM LOS_BASEADOS.envio envio
JOIN LOS_BASEADOS.factura factura ON envio.idFactura = factura.idFactura
JOIN LOS_BASEADOS.sucursal sucursal ON sucursal.numeroSucursal= factura.numeroSucursal
JOIN LOS_BASEADOS.localidad localidad ON localidad.idLocalidad=sucursal.idLocalidad

JOIN LOS_BASEADOS.BI_dimension_tiempo tiempo ON LOS_BASEADOS.comparar_fecha(tiempo.anio,tiempo.mes,tiempo.cuatrimestre,envio.fechaEntrega)=1
JOIN LOS_BASEADOS.BI_dimension_ubicacion ubi ON sucursal.idLocalidad=ubi.idLocalidad AND localidad.idProvincia=ubi.idProvincia
JOIN LOS_BASEADOS.BI_dimension_sucursal ds ON ds.numeroSucursal = sucursal.numeroSucursal
GROUP BY tiempo.idTiempo, ubi.idUbicacion, ds.idSucursal
*/

-- MIGRAR TODOS LOS ENVIOS Y AGRUPAR POR TIEMPO(FECHA), UBICACION(SUCURSAL), SUCURSAL
-- CALCULAR MONTO TOTAL, CANT TOTAL Y CANT CUMPLIDOS (FECHA ENTREGA = FECHA PROGRAMADA)

SELECT tiempo.mes, tiempo.anio, ubi.provincia, ubi.localidad, ds.numeroSucursal, count(LOS_BASEADOS.envio_cumplido(envio.fechaProgramada,envio.fechaEntrega)) cantCumplidos,
 		count(*) cantTotal, sum(envio.total) montoTotal
FROM LOS_BASEADOS.envio envio
JOIN LOS_BASEADOS.factura factura ON envio.idFactura = factura.idFactura
JOIN LOS_BASEADOS.sucursal sucursal ON sucursal.numeroSucursal= factura.numeroSucursal
JOIN LOS_BASEADOS.localidad localidad ON localidad.idLocalidad=sucursal.idLocalidad

JOIN LOS_BASEADOS.BI_dimension_tiempo tiempo ON LOS_BASEADOS.comparar_fecha(tiempo.anio,tiempo.mes,tiempo.cuatrimestre,envio.fechaEntrega)=1
JOIN LOS_BASEADOS.BI_dimension_ubicacion ubi ON sucursal.idLocalidad=ubi.idLocalidad AND localidad.idProvincia=ubi.idProvincia
JOIN LOS_BASEADOS.BI_dimension_sucursal ds ON ds.numeroSucursal = sucursal.numeroSucursal
GROUP BY tiempo.mes, tiempo.anio, ubi.provincia, ubi.localidad, ds.numeroSucursal
ORDER BY tiempo.mes, tiempo.anio, ubi.provincia, ubi.localidad, ds.numeroSucursal

/*

1	2026	Buenos Aires	Cuartel 2	37	42	42	725146.55
1	2026	Buenos Aires	Lezama	108	42	42	734248.76
1	2026	Cordoba	Sinsacate	190	35	35	588669.17
1	2026	Entre Rios	Colonia Luca	142	46	46	761303.62

*/

-- MIGRAR TODOS LOS ENVIOS Y AGRUPAR POR TIEMPO(FECHA), UBICACION(SUCURSAL), SUCURSAL
-- CALCULAR MONTO TOTAL, CANT TOTAL Y CANT CUMPLIDOS (FECHA ENTREGA = FECHA PROGRAMADA)

SELECT MONTH(e.fechaEntrega) mes, YEAR(e.fechaEntrega) anio, l.localidad,p.provincia, s.numeroSucursal,  COUNT(*)
FROM LOS_BASEADOS.envio e
JOIN LOS_BASEADOS.factura f ON f.idFactura = e.idFactura
JOIN LOS_BASEADOS.sucursal s ON f.numeroSucursal = s.numeroSucursal
JOIN LOS_BASEADOS.localidad l ON s.idLocalidad = l.idLocalidad
JOIN LOS_BASEADOS.provincia p ON l.idProvincia = p.idProvincia
WHERE s.numeroSucursal = 142
AND MONTH(e.fechaEntrega) = 1 AND YEAR(e.fechaEntrega) = 2026
GROUP BY s.numeroSucursal, l.localidad, p.provincia, MONTH(e.fechaEntrega), YEAR(e.fechaEntrega)

-- 1	2026	Cuartel 2	Buenos Aires	37	42
-- 1	2026	Lezama	Buenos Aires	108	42
-- 1	2026	Sinsacate	Cordoba	190	35
-- 1	2026	Colonia Luca	Entre Rios	142	46

SELECT COUNT(*) FROM LOS_BASEADOS.envio e
JOIN LOS_BASEADOS.factura f ON f.idFactura = e.idFactura
WHERE MONTH(e.fechaEntrega) = 1 AND YEAR(e.fechaEntrega) = 2026 AND f.numeroSucursal = 142
GROUP BY f.numeroSucursal

-- 42 (numeroSucursal = 37)
-- 42 (numeroSucursal = 108)
-- 35 (numeroSucursal = 190)
-- 46 (numeroSucursal = 142)

-- OK - COINCIDEN LOS MONTOS DE LA TABLA HECHOS CON CONSULTAS SOBRE EL MODELO RELACIONAL










-------------------------------------------------------------------------------------------------------------------------------------------
-- PRUEBAS HECHO FACTURA

/*
SELECT tiempo.idTiempo,ubi.idUbicacion, ds.idSucursal, sum(factura.total), count(*)
FROM LOS_BASEADOS.factura factura 
JOIN LOS_BASEADOS.sucursal sucursal ON sucursal.numeroSucursal= factura.numeroSucursal
JOIN LOS_BASEADOS.localidad localidad ON localidad.idLocalidad=sucursal.idLocalidad
JOIN LOS_BASEADOS.BI_dimension_tiempo tiempo ON LOS_BASEADOS.comparar_fecha(tiempo.anio,tiempo.mes,tiempo.cuatrimestre,factura.fecha)=1
JOIN LOS_BASEADOS.BI_dimension_ubicacion ubi ON sucursal.idLocalidad=ubi.idLocalidad AND localidad.idProvincia=ubi.idProvincia
JOIN LOS_BASEADOS.BI_dimension_sucursal ds ON sucursal.numeroSucursal = ds.numeroSucursal
GROUP BY tiempo.idTiempo, ubi.idUbicacion, ds.idSucursal
*/

-- MIGRAR TODAS LAS FACTURAS Y AGRUPAR POR TIEMPO(FECHA), UBICACION(SUCURSAL), SUCURSAL
-- CALCULAR MONTO TOTAL Y CANT TOTAL 

SELECT tiempo.mes, tiempo.anio ,ubi.localidad, ubi.provincia, ds.numeroSucursal, sum(factura.total), count(*)
FROM LOS_BASEADOS.factura factura 
JOIN LOS_BASEADOS.sucursal sucursal ON sucursal.numeroSucursal= factura.numeroSucursal
JOIN LOS_BASEADOS.localidad localidad ON localidad.idLocalidad=sucursal.idLocalidad
JOIN LOS_BASEADOS.BI_dimension_tiempo tiempo ON LOS_BASEADOS.comparar_fecha(tiempo.anio,tiempo.mes,tiempo.cuatrimestre,factura.fecha)=1
JOIN LOS_BASEADOS.BI_dimension_ubicacion ubi ON sucursal.idLocalidad=ubi.idLocalidad AND localidad.idProvincia=ubi.idProvincia
JOIN LOS_BASEADOS.BI_dimension_sucursal ds ON sucursal.numeroSucursal = ds.numeroSucursal
GROUP BY tiempo.mes, tiempo.anio, ubi.localidad, ubi.provincia, ds.numeroSucursal
ORDER BY tiempo.mes, tiempo.anio, ubi.localidad, ubi.provincia, ds.numeroSucursal

/*
1	2026	Alta Gracia	Santia; Del Estero	107	30730206.32	39
1	2026	Colonia Luca	Entre Rios	142	48852461.13	57
1	2026	Cuartel 2	Buenos Aires	37	40792803.98	52
1	2026	El Brete	Salta	58	45023628.16	58
*/

-- MIGRAR TODAS LAS FACTURAS Y AGRUPAR POR TIEMPO(FECHA), UBICACION(SUCURSAL), SUCURSAL
-- CALCULAR MONTO TOTAL Y CANT TOTAL 

SELECT MONTH(f.fecha) mes, YEAR(f.fecha) anio, l.localidad,p.provincia, s.numeroSucursal, f.total
FROM LOS_BASEADOS.factura f
JOIN LOS_BASEADOS.sucursal s ON f.numeroSucursal = s.numeroSucursal
JOIN LOS_BASEADOS.localidad l ON s.idLocalidad = l.idLocalidad
JOIN LOS_BASEADOS.provincia p ON l.idProvincia = p.idProvincia
WHERE s.numeroSucursal = 58
AND MONTH(f.fecha) = 1 AND YEAR(f.fecha) = 2026

/*
COUNT = 39 -- SUM = 30730206.32 --> Sucursal 107
COUNT = 57 -- SUM = 48852461.13 --> Sucursal 142
COUNT = 52 -- SUM = 40792803.98 --> Sucursal 37
COUNT = 58 -- SUM = 45023628.16 --> Sucursal 58
*/

SELECT * FROM LOS_BASEADOS.factura f
WHERE MONTH(f.fecha) = 1 AND YEAR(f.fecha) = 2026 AND f.numeroSucursal = 142

-- 52 (numeroSucursal = 37)
-- 39 (numeroSucursal = 107)
-- 58 (numeroSucursal = 58)
-- 57 (numeroSucursal = 142)

-- OK - COINCIDEN LOS MONTOS DE LA TABLA HECHOS CON CONSULTAS SOBRE EL MODELO RELACIONAL










---------------------------------------------------------------------------------------------------------------------------------------
-- PRUEBAS HECHO PEDIDO

-- MIGRAR TODOS LOS PEDIDOS Y AGRUPAR POR TIEMPO(FECHA), UBICACION(SUCURSAL), SUCURSAL, TURNO DE VENTA Y ESTADO DEL PEDIDO
-- CALCULAR CANTIDAD DE PEDIDOS

/*
SELECT tiempo.idTiempo,turn.idTurnoVenta, ds.idSucursal, ubi.idUbicacion, est_ped.idBiEstadoPedido,COUNT(pedido.numeroPedido)
FROM LOS_BASEADOS.pedido
JOIN LOS_BASEADOS.estado est ON est.idEstado = pedido.idEstado
JOIN LOS_BASEADOS.sucursal sucursal ON sucursal.numeroSucursal = pedido.numeroSucursal
JOIN LOS_BASEADOS.localidad localidad ON localidad.idLocalidad=sucursal.idLocalidad
JOIN LOS_BASEADOS.BI_dimension_tiempo tiempo ON LOS_BASEADOS.comparar_fecha(tiempo.anio,tiempo.mes,tiempo.cuatrimestre,pedido.fecha)=1
JOIN LOS_BASEADOS.BI_dimension_ubicacion ubi ON localidad.idLocalidad = ubi.idLocalidad and localidad.idProvincia=ubi.idProvincia
JOIN LOS_BASEADOS.BI_dimension_turno_venta turn ON LOS_BASEADOS.comparar_turno(turn.turno,pedido.fecha) = 1 
JOIN LOS_BASEADOS.BI_dimension_estado_pedido est_ped ON est_ped.idEstado = pedido.idEstado
JOIN LOS_BASEADOS.BI_dimension_sucursal ds ON sucursal.numeroSucursal = ds.numeroSucursal
GROUP BY tiempo.idTiempo, ubi.idUbicacion,turn.idTurnoVenta,est_ped.idBiEstadoPedido, ds.idSucursal
*/

SELECT tiempo.mes, tiempo.anio ,ubi.provincia, ubi.localidad, sucursal.numeroSucursal,turn.turno,est_ped.estado,COUNT(pedido.numeroPedido) CantidadPedidos
FROM LOS_BASEADOS.pedido
JOIN LOS_BASEADOS.estado est ON est.idEstado = pedido.idEstado
JOIN LOS_BASEADOS.sucursal sucursal ON sucursal.numeroSucursal = pedido.numeroSucursal
JOIN LOS_BASEADOS.localidad localidad ON localidad.idLocalidad=sucursal.idLocalidad
JOIN LOS_BASEADOS.BI_dimension_tiempo tiempo ON LOS_BASEADOS.comparar_fecha(tiempo.anio,tiempo.mes,tiempo.cuatrimestre,pedido.fecha)=1
JOIN LOS_BASEADOS.BI_dimension_ubicacion ubi ON localidad.idLocalidad = ubi.idLocalidad and localidad.idProvincia=ubi.idProvincia
JOIN LOS_BASEADOS.BI_dimension_turno_venta turn ON LOS_BASEADOS.comparar_turno(turn.turno,pedido.fecha) = 1 
JOIN LOS_BASEADOS.BI_dimension_estado_pedido est_ped ON est_ped.idEstado = pedido.idEstado
GROUP BY tiempo.mes, tiempo.anio ,ubi.provincia, ubi.localidad,turn.turno,est_ped.estado, sucursal.numeroSucursal

/*

1	2026	Buenos Aires	Cuartel 2	37	08:00 - 13:00	CANCELADO	10
1	2026	Buenos Aires	Cuartel 2	37	08:00 - 13:00	ENTREGADO	57
1	2026	Buenos Aires	Cuartel 2	37	14:00 - 20:00	CANCELADO	10
1	2026	Buenos Aires	Cuartel 2	37	14:00 - 20:00	ENTREGADO	68

1	2026	Buenos Aires	Lezama	108	08:00 - 13:00	CANCELADO	6
1	2026	Buenos Aires	Lezama	108	08:00 - 13:00	ENTREGADO	54
1	2026	Buenos Aires	Lezama	108	14:00 - 20:00	CANCELADO	13
1	2026	Buenos Aires	Lezama	108	14:00 - 20:00	ENTREGADO	75

*/

-- MIGRAR TODOS LOS PEDIDOS Y AGRUPAR POR TIEMPO(FECHA), UBICACION(SUCURSAL), SUCURSAL, TURNO DE VENTA Y ESTADO DEL PEDIDO
-- CALCULAR CANTIDAD DE PEDIDOS

SELECT MONTH(p.fecha) mes, YEAR(p.fecha) anio, l.localidad, pr.provincia, s.numeroSucursal
FROM LOS_BASEADOS.pedido p
JOIN LOS_BASEADOS.sucursal s ON p.numeroSucursal = s.numeroSucursal
JOIN LOS_BASEADOS.localidad l ON s.idLocalidad = l.idLocalidad
JOIN LOS_BASEADOS.provincia pr ON l.idProvincia = pr.idProvincia
JOIN LOS_BASEADOS.estado e ON e.idEstado = p.idEstado
WHERE s.numeroSucursal = 108 AND DATEPART(HOUR, p.fecha) BETWEEN 8 AND 13 AND e.estado = 'ENTREGADO'
AND MONTH(p.fecha) = 1 AND YEAR(p.fecha) = 2026

/*
COUNT = 57 --> Sucursal 37, Turno maniana, entregados
COUNT = 10 --> Sucursal 37, Turno maniana, cancelados
COUNT = 68 --> Sucursal 37, Turno tarde, entregados
COUNT = 10 --> Sucursal 37, Turno tarde, cancelados

COUNT = 54 --> Sucursal 108, Turno maniana, entregados
COUNT = 6 --> Sucursal 108, Turno maniana, cancelados
COUNT = 75 --> Sucursal 108, Turno tarde, entregados
COUNT = 13 --> Sucursal 108, Turno tarde, cancelados
*/

SELECT COUNT(DISTINCT p.numeroPedido) FROM LOS_BASEADOS.pedido p
JOIN LOS_BASEADOS.estado e ON p.idEstado = e.idEstado
WHERE p.numeroSucursal = 37 AND DATEPART(HOUR, p.fecha) BETWEEN 8 AND 13 AND e.estado = 'ENTREGADO'
AND MONTH(p.fecha) = 1 AND YEAR(p.fecha) = 2026

-- 52 - 108 TM ENTREGADO
-- 6 - 108 TM CANCELADO
-- 75 - 108 TT ENTREGADO
-- 13 - 108 TT CANCELADO

-- 57 - 37 TM ENTREGADO
-- 10 - 37 TM CANCELADO
-- 68 - 37 TT ENTREGADO
-- 10 - 37 TT CANCELADO

-- OK - COINCIDEN LOS MONTOS DE LA TABLA HECHOS CON CONSULTAS SOBRE EL MODELO RELACIONAL










---------------------------------------------------------------------------------------------------------------------------------------
-- PRUEBAS HECHO VENTAS

/*
SELECT tiempo.idTiempo,ubi.idUbicacion, ds.idSucursal, dre.idRangoEtario, dms.idBiModeloSillon, SUM(df.subtotal), COUNT(f.numeroFactura)
FROM LOS_BASEADOS.factura f
JOIN LOS_BASEADOS.cliente cliente ON cliente.idCliente= f.idCliente
JOIN LOS_BASEADOS.sucursal su ON su.numeroSucursal = f.numeroSucursal
JOIN LOS_BASEADOS.localidad localidad ON localidad.idLocalidad=su.idLocalidad
JOIN LOS_BASEADOS.detalle_factura df ON df.idFactura = f.idFactura
JOIN LOS_BASEADOS.detalle_pedido dp ON df.idDetallePedido = dp.idDetallePedido
JOIN LOS_BASEADOS.sillon s ON s.codigoSillon = dp.codigoSillon
JOIN LOS_BASEADOS.modelo_sillon ms ON s.codigoModelo = ms.codigoModelo
JOIN LOS_BASEADOS.BI_dimension_tiempo tiempo ON LOS_BASEADOS.comparar_fecha(tiempo.anio,tiempo.mes,tiempo.cuatrimestre,f.fecha)=1
JOIN LOS_BASEADOS.BI_dimension_ubicacion ubi ON su.idLocalidad=ubi.idLocalidad AND localidad.idProvincia=ubi.idProvincia
JOIN LOS_BASEADOS.BI_dimension_sucursal ds ON ds.numeroSucursal = f.numeroSucursal
JOIN LOS_BASEADOS.BI_dimension_rango_etario dre ON LOS_BASEADOS.comparar_rango_etario(dre.rango,cliente.fechaNacimiento) = 1
JOIN LOS_BASEADOS.BI_dimension_modelo_sillon dms ON dms.codigoModelo = ms.codigoModelo
GROUP BY tiempo.idTiempo,ubi.idUbicacion, ds.idSucursal, dre.idRangoEtario, dms.idBiModeloSillon
*/

/* SIN DISTINCT EN EL COUNT (2 SEGUNDOS DE EXECUTION) -- 3584 ROWS -- EL SUM DE CANT TE DA = 61092
1	434	1	2	1	818482.26	4
1	434	1	2	2	1146212.81	5
1	434	1	2	3	413983.65	4
1	434	1	2	4	1186803.87	6
1	434	1	2	5	201263.56	2
1	434	1	2	6	549951.20	3
1	434	1	2	7	856908.56	4
*/

/* CON DISTINCT EN EL COUNT (30 SEGUNDOS DE EXECUTION) -- 3584 ROWS -- EL SUM DE CANT TE DA <61092
1	434	1	2	1	818482.26	3
1	434	1	2	2	1146212.81	3
1	434	1	2	3	413983.65	3
1	434	1	2	4	1186803.87	4
1	434	1	2	5	201263.56	2
1	434	1	2	6	549951.20	3
1	434	1	2	7	856908.56	3
*/

-- EN MI OPINION, POR UN TEMA DE LOGICA, PARA MI VA SIN EL DISTINCT

-- MIGRAR TODAS LAS VENTAS Y AGRUPAR POR TIEMPO(FECHA), UBICACION(SUCURSAL), SUCURSAL, RANGO ETARIO Y MODELO DEL SILLON VENDIDO
-- CALCULAR CANTIDAD DE VENTAS Y MONTO TOTAL

SELECT tiempo.mes, tiempo.anio,ubi.provincia, ubi.localidad, ds.numeroSucursal, dre.rango, dms.modelo, 
SUM(df.subtotal) monto, COUNT(f.numeroFactura) cant
FROM LOS_BASEADOS.factura f
JOIN LOS_BASEADOS.cliente cliente ON cliente.idCliente= f.idCliente
JOIN LOS_BASEADOS.sucursal su ON su.numeroSucursal = f.numeroSucursal
JOIN LOS_BASEADOS.localidad localidad ON localidad.idLocalidad=su.idLocalidad
JOIN LOS_BASEADOS.detalle_factura df ON df.idFactura = f.idFactura
JOIN LOS_BASEADOS.detalle_pedido dp ON df.idDetallePedido = dp.idDetallePedido
JOIN LOS_BASEADOS.sillon s ON s.codigoSillon = dp.codigoSillon
JOIN LOS_BASEADOS.modelo_sillon ms ON s.codigoModelo = ms.codigoModelo
JOIN LOS_BASEADOS.BI_dimension_tiempo tiempo ON LOS_BASEADOS.comparar_fecha(tiempo.anio,tiempo.mes,tiempo.cuatrimestre,f.fecha)=1
JOIN LOS_BASEADOS.BI_dimension_ubicacion ubi ON su.idLocalidad=ubi.idLocalidad AND localidad.idProvincia=ubi.idProvincia
JOIN LOS_BASEADOS.BI_dimension_sucursal ds ON ds.numeroSucursal = f.numeroSucursal
JOIN LOS_BASEADOS.BI_dimension_rango_etario dre ON LOS_BASEADOS.comparar_rango_etario(dre.rango,cliente.fechaNacimiento) = 1
JOIN LOS_BASEADOS.BI_dimension_modelo_sillon dms ON dms.codigoModelo = ms.codigoModelo
GROUP BY tiempo.mes, tiempo.anio,ubi.provincia, ubi.localidad, ds.numeroSucursal, dre.rango, dms.modelo
ORDER BY tiempo.mes, tiempo.anio,ubi.provincia, ubi.localidad, ds.numeroSucursal, dre.rango, dms.modelo

/*
1	2026	Buenos Aires	Cuartel 2	37	>50	Modelo N°: 204719	5164145.25	17
1	2026	Buenos Aires	Cuartel 2	37	>50	Modelo N°: 337085	1728446.12	12
1	2026	Buenos Aires	Cuartel 2	37	>50	Modelo N°: 406739	2336547.51	11
1	2026	Buenos Aires	Cuartel 2	37	>50	Modelo N°: 699551	3327136.75	13
1	2026	Buenos Aires	Cuartel 2	37	>50	Modelo N°: 700792	1547111.28	10
1	2026	Buenos Aires	Cuartel 2	37	>50	Modelo N°: 920973	2118326.07	11
1	2026	Buenos Aires	Cuartel 2	37	>50	Modelo N°: 971176	4510719.89	18
1	2026	Buenos Aires	Cuartel 2	37	25-35	Modelo N°: 204719	818482.26	4
1	2026	Buenos Aires	Cuartel 2	37	25-35	Modelo N°: 337085	1146212.81	5
1	2026	Buenos Aires	Cuartel 2	37	25-35	Modelo N°: 406739	413983.65	4
1	2026	Buenos Aires	Cuartel 2	37	25-35	Modelo N°: 699551	1186803.87	6
1	2026	Buenos Aires	Cuartel 2	37	25-35	Modelo N°: 700792	201263.56	2
1	2026	Buenos Aires	Cuartel 2	37	25-35	Modelo N°: 920973	549951.20	3
1	2026	Buenos Aires	Cuartel 2	37	25-35	Modelo N°: 971176	856908.56	4
1	2026	Buenos Aires	Cuartel 2	37	35-50	Modelo N°: 204719	2477730.53	7
1	2026	Buenos Aires	Cuartel 2	37	35-50	Modelo N°: 337085	1934891.94	7
1	2026	Buenos Aires	Cuartel 2	37	35-50	Modelo N°: 406739	1460962.58	9
1	2026	Buenos Aires	Cuartel 2	37	35-50	Modelo N°: 699551	3317908.64	10
1	2026	Buenos Aires	Cuartel 2	37	35-50	Modelo N°: 700792	1714205.24	10
1	2026	Buenos Aires	Cuartel 2	37	35-50	Modelo N°: 920973	2226203.09	10
1	2026	Buenos Aires	Cuartel 2	37	35-50	Modelo N°: 971176	864058.45	5

** LA SUMA DE LA COLUMNA CANT DA 61092, QUE ES LA CANTIDAD DE DETALLE_FACTURA EN EL MODELO RELACIONAL
** ES DECIR, QUE TODOS LOS DETALLES (QUE DIFIEREN POR MODELO DENTRO DE UNA MISMA FACTURA) ESTAN CONTENIDOS ACA
** INDICA QUE MIGRE TODOS LOS DATOS

*/

-- MIGRAR TODAS LAS VENTAS Y AGRUPAR POR TIEMPO(FECHA), UBICACION(SUCURSAL), SUCURSAL, RANGO ETARIO Y MODELO DEL SILLON VENDIDO
-- CALCULAR CANTIDAD DE VENTAS Y MONTO TOTAL

SELECT MONTH(f.fecha) mes, YEAR(f.fecha) anio,p.provincia,l.localidad, s.numeroSucursal, dre.rango, ms.modelo, df.subtotal
FROM LOS_BASEADOS.factura f
JOIN LOS_BASEADOS.cliente c ON c.idCliente = f.idCliente
JOIN LOS_BASEADOS.sucursal s ON f.numeroSucursal = s.numeroSucursal
JOIN LOS_BASEADOS.localidad l ON s.idLocalidad = l.idLocalidad
JOIN LOS_BASEADOS.provincia p ON l.idProvincia = p.idProvincia
JOIN LOS_BASEADOS.detalle_factura df ON df.idFactura = f.idFactura
JOIN LOS_BASEADOS.detalle_pedido dp ON df.idDetallePedido = dp.idDetallePedido
JOIN LOS_BASEADOS.sillon si ON si.codigoSillon = dp.codigoSillon
JOIN LOS_BASEADOS.modelo_sillon ms ON si.codigoModelo = ms.codigoModelo
JOIN LOS_BASEADOS.BI_dimension_rango_etario dre ON LOS_BASEADOS.comparar_rango_etario(dre.rango, c.fechaNacimiento) =1
WHERE s.numeroSucursal = 37 AND dre.rango = '>50' AND ms.modelo = 'Modelo N°: 204719'
AND MONTH(f.fecha) = 1 AND YEAR(f.fecha) = 2026

/*
COUNT = 17 -- SUM = 5164145.25 --> Sucursal 37, Rango: >50, Modelo 204719
*/

SELECT f.numeroFactura, f.fecha, f.idCliente, f.idFactura, f.numeroSucursal, f.total, df.subtotal
FROM LOS_BASEADOS.factura f
JOIN LOS_BASEADOS.cliente c ON c.idCliente = f.idCliente
JOIN LOS_BASEADOS.detalle_factura df ON df.idFactura = f.idFactura
JOIN LOS_BASEADOS.detalle_pedido dp ON df.idDetallePedido = dp.idDetallePedido
JOIN LOS_BASEADOS.sillon si ON si.codigoSillon = dp.codigoSillon
JOIN LOS_BASEADOS.modelo_sillon ms ON si.codigoModelo = ms.codigoModelo
JOIN LOS_BASEADOS.BI_dimension_rango_etario dre ON LOS_BASEADOS.comparar_rango_etario(dre.rango, c.fechaNacimiento) =1
WHERE MONTH(f.fecha) = 1 AND YEAR(f.fecha) = 2026 AND f.numeroSucursal = 37 AND ms.modelo = 'Modelo N°: 204719' AND dre.rango = '>50'
ORDER BY f.numeroFactura, f.fecha, f.idCliente, f.idFactura, f.numeroSucursal, f.total, df.subtotal

-- DEBERIA ESTAR OK, COINCIDEN LOS MONTOS EN 1 SOLO CASO, NO LO PROBE EN OTROS CASOS










---------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM LOS_BASEADOS.BI_dimension_ubicacion
SELECT * FROM LOS_BASEADOS.BI_dimension_tiempo
SELECT * FROM LOS_BASEADOS.BI_dimension_sucursal
SELECT * FROM LOS_BASEADOS.BI_dimension_rango_etario
SELECT * FROM LOS_BASEADOS.BI_dimension_modelo_sillon
SELECT * FROM LOS_BASEADOS.BI_dimension_tipo_material
SELECT * FROM LOS_BASEADOS.BI_dimension_turno_venta
SELECT * FROM LOS_BASEADOS.BI_dimension_estado_pedido

SELECT * FROM LOS_BASEADOS.BI_hecho_compra
SELECT * FROM LOS_BASEADOS.BI_hecho_envio
SELECT * FROM LOS_BASEADOS.BI_hecho_factura
SELECT * FROM LOS_BASEADOS.BI_hecho_pedido
SELECT * FROM LOS_BASEADOS.BI_hecho_venta

SELECT * FROM LOS_BASEADOS.gananciasView
GO

/*
-- 1) 171 rows - ok? -- SI
-- Ganancias: Total de ingresos (facturación) - total de egresos (compras), por cada mes, por cada sucursal.
CREATE VIEW LOS_BASEADOS.gananciasView AS
	SELECT
		dt.anio,
		dt.mes,
		ds.numeroSucursal,
		ds.direccion,
		ubi.provincia,
		ubi.localidad,
		SUM(hf.total_facturas) - ISNULL(SUM(hc.total_compras), 0) AS Ganancia
	FROM LOS_BASEADOS.BI_hecho_factura hf
	JOIN LOS_BASEADOS.BI_dimension_tiempo dt ON hf.idTiempo = dt.idTiempo
	JOIN LOS_BASEADOS.BI_dimension_sucursal ds ON hf.idSucursal = ds.idSucursal
	JOIN LOS_BASEADOS.BI_dimension_ubicacion ubi ON hf.idUbicacion = ubi.idUbicacion
	LEFT JOIN LOS_BASEADOS.BI_hecho_compra hc
		ON hc.idTiempo = hf.idTiempo
		AND hc.idSucursal = hf.idSucursal
		AND hc.idUbicacion = hf.idUbicacion
	GROUP BY
		dt.anio, dt.mes, ds.numeroSucursal, ds.direccion, ubi.provincia, ubi.localidad
GO
*/

SELECT *
FROM LOS_BASEADOS.envio e1
JOIN LOS_BASEADOS.envio e2 ON e1.idEnvio = e2.idEnvio
WHERE e1.fechaEntrega != e2.fechaProgramada

SELECT * FROM LOS_BASEADOS.envio WHERE fechaEntrega != fechaProgramada

SELECT * FROM LOS_BASEADOS.BI_hecho_envio
SELECT * FROM LOS_BASEADOS.porcentajeCumplimientoEnviosView
