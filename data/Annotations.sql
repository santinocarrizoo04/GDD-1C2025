SELECT tiempo.mes, tiempo.anio ,ubi.localidad, ubi.provincia, ds.numeroSucursal, sum(factura.total), count(*)
	FROM LOS_BASEADOS.factura factura 
	JOIN LOS_BASEADOS.sucursal sucursal ON sucursal.numeroSucursal= factura.numeroSucursal
	JOIN LOS_BASEADOS.localidad localidad ON localidad.idLocalidad=sucursal.idLocalidad
	JOIN LOS_BASEADOS.BI_dimension_tiempo tiempo ON LOS_BASEADOS.comparar_fecha(tiempo.anio,tiempo.mes,tiempo.cuatrimestre,factura.fecha)=1
	JOIN LOS_BASEADOS.BI_dimension_ubicacion ubi ON sucursal.idLocalidad=ubi.idLocalidad AND localidad.idProvincia=ubi.idProvincia
	JOIN LOS_BASEADOS.BI_dimension_sucursal ds ON sucursal.numeroSucursal = ds.numeroSucursal
	GROUP BY tiempo.mes, tiempo.anio, ubi.localidad, ubi.provincia, ds.numeroSucursal
    ORDER BY tiempo.mes, tiempo.anio, ubi.localidad, ubi.provincia, ds.numeroSucursal

SELECT MONTH(f.fecha) mes, YEAR(f.fecha) anio, l.localidad,p.provincia, s.numeroSucursal, f.total
FROM LOS_BASEADOS.factura f
JOIN LOS_BASEADOS.sucursal s ON f.numeroSucursal = s.numeroSucursal
JOIN LOS_BASEADOS.localidad l ON s.idLocalidad = l.idLocalidad
JOIN LOS_BASEADOS.provincia p ON l.idProvincia = p.idProvincia
WHERE s.numeroSucursal = 107
AND MONTH(f.fecha) = 1 AND YEAR(f.fecha) = 2026

SELECT * FROM LOS_BASEADOS.BI_dimension_ubicacion
SELECT * FROM LOS_BASEADOS.BI_dimension_tiempo
SELECT * FROM LOS_BASEADOS.BI_dimension_sucursal

SELECT * FROM LOS_BASEADOS.gananciasView