USE GD1C2025 -- Usa la DB GD1C2025
GO

-- CREACION DE TABLAS DE DIMENSIONES --------------------------------------------------------------------

CREATE TABLE LOS_BASEADOS.BI_dimension_tiempo(
	idTiempo DECIMAL(18,0) NOT NULL IDENTITY(1,1),
	anio DECIMAL(18,0) NOT NULL,
	cuatrimestre DECIMAL(18,0) NOT NULL,
	mes DECIMAL(18,0) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.BI_dimension_ubicacion (
	idUbicacion DECIMAL(18,0) NOT NULL IDENTITY(1,1),
	idProvincia TINYINT NOT NULL,
	provincia NVARCHAR(255) NOT NULL,
	idLocalidad SMALLINT NOT NULL,
	localidad NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.BI_dimension_sucursal (
	idSucursal DECIMAL(18,0) NOT NULL IDENTITY(1,1),
	numeroSucursal BIGINT NOT NULL,
	direccion NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.BI_dimension_rango_etario(
	idRangoEtario DECIMAL(18,0) NOT NULL IDENTITY(1,1),
	rango NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.BI_dimension_turno_venta(
	idTurnoVenta DECIMAL(18,0) NOT NULL IDENTITY(1,1),
	turno NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.BI_dimension_tipo_material(
	idBiTipoMaterial DECIMAL(18,0) NOT NULL IDENTITY(1,1),
    idTipoMaterial INT NOT NULL,
	tipo NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.BI_dimension_modelo_sillon(
	idBiModeloSillon DECIMAL(18,0) NOT NULL IDENTITY(1,1),
    codigoModelo BIGINT NOT NULL,
	descripcion NVARCHAR(255) NOT NULL,
    precio DECIMAL(18,2) NOT NULL,
    modelo NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.BI_dimension_estado_pedido(
	idBiEstadoPedido DECIMAL(18,0) NOT NULL IDENTITY(1,1),
    idEstado TINYINT NOT NULL,
	estado NVARCHAR(255) NOT NULL
);
GO

-- CREACION DE TABLAS DE HECHOS --------------------------------------------------------------------

CREATE TABLE LOS_BASEADOS.BI_hecho_factura(
	idTiempo DECIMAL(18,0) NOT NULL,
    idUbicacion DECIMAL(18,0) NOT NULL,
	idSucursal DECIMAL(18,0) NOT NULL,
	total_facturas DECIMAL(12,2) NOT NULL,
    cant_facturas DECIMAL(18,0) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.BI_hecho_pedido(
	idTiempo DECIMAL(18,0) NOT NULL,
    idTurnoVenta DECIMAL(18,0) NOT NULL,
    idUbicacion DECIMAL(18,0) NOT NULL,
	idSucursal DECIMAL(18,0) NOT NULL,
    idBiEstadoPedido DECIMAL(18,0) NOT NULL,
    cant_pedidos DECIMAL(18,0) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.BI_hecho_venta(
	idTiempo DECIMAL(18,0) NOT NULL,
    idRangoEtario DECIMAL(18,0) NOT NULL,
    idUbicacion DECIMAL(18,0) NOT NULL,
	idSucursal DECIMAL(18,0) NOT NULL,
    idBiModeloSillon DECIMAL(18,0) NOT NULL,
    total_ventas DECIMAL(12,2) NOT NULL,
    cant_ventas DECIMAL(18,0) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.BI_hecho_compra(
	idTiempo DECIMAL(18,0) NOT NULL,
    idUbicacion DECIMAL(18,0) NOT NULL,
	idSucursal DECIMAL(18,0) NOT NULL,
    idBiTipoMaterial DECIMAL(18,0) NOT NULL,
    total_compras DECIMAL(12,2) NOT NULL,
    cant_compras DECIMAL(18,0) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.BI_hecho_envio(
	idTiempo DECIMAL(18,0) NOT NULL,
    idUbicacion DECIMAL(18,0) NOT NULL,
	idSucursal DECIMAL(18,0) NOT NULL,
    cant_envios_cumplidos DECIMAL(18,0) NOT NULL,
    cant_envios_total DECIMAL(18,0) NOT NULL,
    total_costo_envio DECIMAL(12,2) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.BI_hecho_fabricacion(
	idTiempo DECIMAL(18,0) NOT NULL,
    idUbicacion DECIMAL(18,0) NOT NULL,
	idSucursal DECIMAL(18,0) NOT NULL,
	total_tiempo DECIMAL(12,2) NOT NULL,
    cant_pedidos DECIMAL(18,0) NOT NULL
);
GO

-- CREACION DE CONSTRAINTS --------------------------------------------------------------------

ALTER TABLE LOS_BASEADOS.BI_dimension_estado_pedido ADD CONSTRAINT PK_idBiEstadoPedido PRIMARY KEY(idBiEstadoPedido);
GO

ALTER TABLE LOS_BASEADOS.BI_dimension_turno_venta ADD CONSTRAINT PK_idTurnoVenta PRIMARY KEY(idTurnoVenta);
GO

ALTER TABLE LOS_BASEADOS.BI_dimension_tiempo ADD CONSTRAINT PK_idTiempo PRIMARY KEY(idTiempo);
GO
ALTER TABLE LOS_BASEADOS.BI_dimension_tiempo ADD CONSTRAINT UNIQUE_tiempo UNIQUE(anio,cuatrimestre,mes) 
GO

ALTER TABLE LOS_BASEADOS.BI_dimension_tipo_material ADD CONSTRAINT PK_idBiTipoMaterial PRIMARY KEY(idBiTipoMaterial);
GO

ALTER TABLE LOS_BASEADOS.BI_dimension_rango_etario ADD CONSTRAINT PK_idRangoEtario PRIMARY KEY(idRangoEtario);
GO

ALTER TABLE LOS_BASEADOS.BI_dimension_ubicacion ADD CONSTRAINT PK_idUbicacion PRIMARY KEY(idUbicacion);
GO

ALTER TABLE LOS_BASEADOS.BI_dimension_sucursal ADD CONSTRAINT PK_idSucursal PRIMARY KEY(idSucursal);
GO

ALTER TABLE LOS_BASEADOS.BI_dimension_modelo_sillon ADD CONSTRAINT PK_idBiModeloSillon PRIMARY KEY(idBiModeloSillon);
GO

ALTER TABLE LOS_BASEADOS.BI_hecho_factura ADD CONSTRAINT PK_hechoFactura PRIMARY KEY(idTiempo, idUbicacion, idSucursal);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_factura ADD CONSTRAINT FK_hechoFactura_idTiempo FOREIGN KEY(idTiempo) REFERENCES LOS_BASEADOS.BI_dimension_tiempo(idTiempo);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_factura ADD CONSTRAINT FK_hechoFactura_idUbicacion FOREIGN KEY(idUbicacion) REFERENCES LOS_BASEADOS.BI_dimension_ubicacion(idUbicacion);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_factura ADD CONSTRAINT FK_hechoFactura_idSucursal FOREIGN KEY(idSucursal) REFERENCES LOS_BASEADOS.BI_dimension_sucursal(idSucursal);
GO

ALTER TABLE LOS_BASEADOS.BI_hecho_envio ADD CONSTRAINT PK_hechoEnvio PRIMARY KEY(idTiempo, idUbicacion, idSucursal);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_envio ADD CONSTRAINT FK_hechoEnvio_idTiempo FOREIGN KEY(idTiempo) REFERENCES LOS_BASEADOS.BI_dimension_tiempo(idTiempo);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_envio ADD CONSTRAINT FK_hechoEnvio_idUbicacion FOREIGN KEY(idUbicacion) REFERENCES LOS_BASEADOS.BI_dimension_ubicacion(idUbicacion);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_envio ADD CONSTRAINT FK_hechoEnvio_idSucursal FOREIGN KEY(idSucursal) REFERENCES LOS_BASEADOS.BI_dimension_sucursal(idSucursal);
GO

ALTER TABLE LOS_BASEADOS.BI_hecho_pedido ADD CONSTRAINT PK_hechoPedido PRIMARY KEY(idTiempo, idUbicacion, idTurnoVenta, idBiEstadoPedido, idSucursal);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_pedido ADD CONSTRAINT FK_hechoPedido_idTiempo FOREIGN KEY(idTiempo) REFERENCES LOS_BASEADOS.BI_dimension_tiempo(idTiempo);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_pedido ADD CONSTRAINT FK_hechoPedido_idUbicacion FOREIGN KEY(idUbicacion) REFERENCES LOS_BASEADOS.BI_dimension_ubicacion(idUbicacion);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_pedido ADD CONSTRAINT FK_hechoPedido_idSucursal FOREIGN KEY(idSucursal) REFERENCES LOS_BASEADOS.BI_dimension_sucursal(idSucursal);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_pedido ADD CONSTRAINT FK_hechoPedido_idTurnoVenta FOREIGN KEY(idTurnoVenta) REFERENCES LOS_BASEADOS.BI_dimension_turno_venta(idTurnoVenta);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_pedido ADD CONSTRAINT FK_hechoPedido_idBiEstadoPedido FOREIGN KEY(idBiEstadoPedido) REFERENCES LOS_BASEADOS.BI_dimension_estado_pedido(idBiEstadoPedido);
GO

ALTER TABLE LOS_BASEADOS.BI_hecho_venta ADD CONSTRAINT PK_hechoVenta PRIMARY KEY(idTiempo, idUbicacion, idRangoEtario, idBiModeloSillon, idSucursal);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_venta ADD CONSTRAINT FK_hechoVenta_idTiempo FOREIGN KEY(idTiempo) REFERENCES LOS_BASEADOS.BI_dimension_tiempo(idTiempo);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_venta ADD CONSTRAINT FK_hechoVenta_idUbicacion FOREIGN KEY(idUbicacion) REFERENCES LOS_BASEADOS.BI_dimension_ubicacion(idUbicacion);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_venta ADD CONSTRAINT FK_hechoVenta_idSucursal FOREIGN KEY(idSucursal) REFERENCES LOS_BASEADOS.BI_dimension_sucursal(idSucursal);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_venta ADD CONSTRAINT FK_hechoVenta_idRangoEtario FOREIGN KEY(idRangoEtario) REFERENCES LOS_BASEADOS.BI_dimension_rango_etario(idRangoEtario);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_venta ADD CONSTRAINT FK_hechoVenta_idBiModeloSillon FOREIGN KEY(idBiModeloSillon) REFERENCES LOS_BASEADOS.BI_dimension_modelo_sillon(idBiModeloSillon);
GO

ALTER TABLE LOS_BASEADOS.BI_hecho_compra ADD CONSTRAINT PK_hechoCompra PRIMARY KEY(idTiempo, idUbicacion, idBiTipoMaterial, idSucursal);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_compra ADD CONSTRAINT FK_hechoCompra_idTiempo FOREIGN KEY(idTiempo) REFERENCES LOS_BASEADOS.BI_dimension_tiempo(idTiempo);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_compra ADD CONSTRAINT FK_hechoCompra_idUbicacion FOREIGN KEY(idUbicacion) REFERENCES LOS_BASEADOS.BI_dimension_ubicacion(idUbicacion);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_compra ADD CONSTRAINT FK_hechoCompra_idSucursal FOREIGN KEY(idSucursal) REFERENCES LOS_BASEADOS.BI_dimension_sucursal(idSucursal);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_compra ADD CONSTRAINT FK_hechoCompra_idTipoMaterial FOREIGN KEY(idBiTipoMaterial) REFERENCES LOS_BASEADOS.BI_dimension_tipo_material(idBiTipoMaterial);
GO

ALTER TABLE LOS_BASEADOS.BI_hecho_fabricacion ADD CONSTRAINT PK_hechoFabricacion PRIMARY KEY(idTiempo, idUbicacion, idSucursal);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_fabricacion ADD CONSTRAINT FK_hechoFabricacion_idTiempo FOREIGN KEY(idTiempo) REFERENCES LOS_BASEADOS.BI_dimension_tiempo(idTiempo);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_fabricacion ADD CONSTRAINT FK_hechoFabricacion_idUbicacion FOREIGN KEY(idUbicacion) REFERENCES LOS_BASEADOS.BI_dimension_ubicacion(idUbicacion);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_fabricacion ADD CONSTRAINT FK_hechoFabricacion_idSucursal FOREIGN KEY(idSucursal) REFERENCES LOS_BASEADOS.BI_dimension_sucursal(idSucursal);
GO

-- CREACION DE FUNCIONES --------------------------------------------------------------------

CREATE FUNCTION LOS_BASEADOS.obtener_cuatrimestre (@MES INT)
RETURNS INT 
BEGIN
	DECLARE @CUATRIMESTRE INT;
	IF @MES IN (1,2,3,4) set @CUATRIMESTRE = 1
	ELSE IF @MES IN (5,6,7,8) set @CUATRIMESTRE = 2
	ELSE IF @MES IN (9,10,11,12) set @CUATRIMESTRE=3
	RETURN @CUATRIMESTRE
END
GO

CREATE FUNCTION LOS_BASEADOS.envio_cumplido(@FECHA_PROGRAMADA DATETIME2, @FECHA_ENTREGA DATETIME2)
RETURNS INT
BEGIN	
	DECLARE @CONT INT;
	SET @CONT = 0;
		IF(YEAR(@FECHA_PROGRAMADA) = YEAR(@FECHA_ENTREGA) AND MONTH(@FECHA_PROGRAMADA) = MONTH(@FECHA_ENTREGA) AND DAY(@FECHA_PROGRAMADA) = DAY(@FECHA_ENTREGA)) SET @CONT = 1;
	RETURN @CONT;
END
GO

CREATE FUNCTION LOS_BASEADOS.comparar_fecha(@ANIO INT,@MES INT,@CUATRI INT,@FECHA DATETIME2)
RETURNS INT
AS
BEGIN 
	RETURN CASE 
	WHEN YEAR(@FECHA) = @ANIO 
        AND LOS_BASEADOS.obtener_cuatrimestre(MONTH(@FECHA)) = @CUATRI
        AND MONTH(@FECHA) = @MES
        THEN 1
        ELSE 0
	END
END
GO

CREATE FUNCTION LOS_BASEADOS.obtener_turno_venta (@HORA INT)
RETURNS NVARCHAR(255)
AS
BEGIN
    DECLARE @turno NVARCHAR(255)

    IF @HORA BETWEEN 8 AND 13
        SET @turno = '08:00 - 14:00'
    ELSE IF @HORA BETWEEN 14 AND 20
        SET @turno = '14:00 - 20:00'
    ELSE
        SET @turno = 'Fuera de horario'

    RETURN @turno
END
GO

CREATE FUNCTION LOS_BASEADOS.comparar_turno(@TURNO VARCHAR(255),@FECHA DATETIME2)
RETURNS INT
AS
BEGIN
	RETURN CASE 
	WHEN LOS_BASEADOS.obtener_turno_venta(DATEPART(HOUR, @FECHA)) = @TURNO 
        THEN 1
        ELSE 0
	END
END
GO

CREATE FUNCTION LOS_BASEADOS.obtener_rango_etario(@DIA INT, @MES INT, @ANIO INT)
RETURNS VARCHAR(255)
AS
BEGIN
    DECLARE @fechaNacimiento DATE = DATEFROMPARTS(@anio, @mes, @dia);
    DECLARE @edad INT = DATEDIFF(YEAR, @fechaNacimiento, GETDATE());

    -- Ajuste por si aún no cumplió años este año
    IF DATEADD(YEAR, @edad, @fechaNacimiento) > CAST(GETDATE() AS DATE)
        SET @edad = @edad - 1;

    DECLARE @rango VARCHAR(10);

    IF @edad < 25
        SET @rango = '<25';
    ELSE IF @edad BETWEEN 25 AND 35
        SET @rango = '25-35';
    ELSE IF @edad BETWEEN 36 AND 50
        SET @rango = '35-50';
    ELSE
        SET @rango = '>50';

    RETURN @rango;
END
GO

CREATE FUNCTION LOS_BASEADOS.comparar_rango_etario(@RANGO VARCHAR(255),@FECHANAC DATETIME2(6))
RETURNS INT
AS
BEGIN
	RETURN CASE 
	WHEN LOS_BASEADOS.obtener_rango_etario(DATEPART(DAY, @FECHANAC),DATEPART(MONTH, @FECHANAC),DATEPART(YEAR, @FECHANAC)) = @RANGO 
        THEN 1
        ELSE 0
	END
END
GO

-- CREACION DE PROCEDURES PARA MIGRAR DATOS A DIMENSIONES --------------------------------------------------------------------

CREATE PROCEDURE LOS_BASEADOS.BI_migrar_dimension_ubicaciones
AS
BEGIN
	INSERT LOS_BASEADOS.BI_dimension_ubicacion(idProvincia, provincia, idLocalidad, localidad)
	SELECT p.idProvincia, p.provincia, l.idLocalidad, l.localidad
	FROM LOS_BASEADOS.provincia p 
	JOIN LOS_BASEADOS.localidad l ON l.idProvincia = p.idProvincia
END
GO

CREATE PROCEDURE LOS_BASEADOS.BI_migrar_dimension_sucursal
AS
BEGIN
	INSERT LOS_BASEADOS.BI_dimension_sucursal(numeroSucursal, direccion)
	SELECT s.numeroSucursal, s.direccion
	FROM LOS_BASEADOS.sucursal s
END
GO

CREATE PROCEDURE LOS_BASEADOS.BI_migrar_dimension_rango_etario
AS
BEGIN
	INSERT INTO LOS_BASEADOS.BI_dimension_rango_etario(rango)
    VALUES ('<25'),('25-35'), ('35-50'),('>50')
END
GO

CREATE PROCEDURE LOS_BASEADOS.BI_migrar_dimension_tipo_material
AS
BEGIN
	INSERT INTO LOS_BASEADOS.BI_dimension_tipo_material(idTipoMaterial, tipo)
    SELECT idTipoMaterial, tipo
	FROM LOS_BASEADOS.tipo_material
END
GO

CREATE PROCEDURE LOS_BASEADOS.BI_migrar_dimension_estado_pedido
AS
BEGIN
	insert into LOS_BASEADOS.BI_dimension_estado_pedido(idEstado, estado)
    SELECT idEstado, estado
	FROM LOS_BASEADOS.estado
END
GO

CREATE PROCEDURE LOS_BASEADOS.BI_migrar_dimension_turno_venta
AS
BEGIN
	INSERT INTO LOS_BASEADOS.BI_dimension_turno_venta(turno)
    VALUES ('08:00 - 14:00'),('14:00 - 20:00')
END
GO

CREATE PROCEDURE LOS_BASEADOS.BI_migrar_dimension_modelo_sillon
AS
BEGIN
	INSERT INTO LOS_BASEADOS.BI_dimension_modelo_sillon(codigoModelo, descripcion, modelo, precio)
    SELECT codigoModelo, descripcion, modelo, precio
	FROM LOS_BASEADOS.modelo_sillon
END
GO

CREATE PROCEDURE LOS_BASEADOS.BI_migrar_dimension_tiempo
AS
BEGIN
	INSERT INTO LOS_BASEADOS.BI_dimension_tiempo(anio, cuatrimestre, mes)
    SELECT DISTINCT YEAR(e.fechaEntrega), LOS_BASEADOS.obtener_cuatrimestre(MONTH(e.fechaEntrega)), MONTH(e.fechaEntrega)
	FROM LOS_BASEADOS.envio e
	UNION
    SELECT DISTINCT YEAR(c.fecha), LOS_BASEADOS.obtener_cuatrimestre(MONTH(c.fecha)),MONTH(c.fecha)
	FROM LOS_BASEADOS.compra c
	UNION
    SELECT DISTINCT YEAR(p.fecha), LOS_BASEADOS.obtener_cuatrimestre(MONTH(p.fecha)), MONTH(p.fecha)
	FROM LOS_BASEADOS.pedido p
	UNION
    SELECT DISTINCT YEAR(f.fecha), LOS_BASEADOS.obtener_cuatrimestre(MONTH(f.fecha)),MONTH(f.fecha)
	FROM LOS_BASEADOS.factura f
END
GO

-- CREACION DE PROCEDURES PARA MIGRAR DATOS A HECHOS --------------------------------------------------------------------

CREATE PROCEDURE LOS_BASEADOS.BI_migrar_hecho_compra
AS
BEGIN
    INSERT LOS_BASEADOS.BI_hecho_compra(idTiempo, idUbicacion, idSucursal, idBiTipoMaterial, cant_compras, total_compras)
	SELECT tiempo.idTiempo, ubi.idUbicacion, ds.idSucursal, dtm.idBiTipoMaterial, count (compra.numeroCompra), sum(detalle_compra.subtotal)
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
END
GO

CREATE PROCEDURE LOS_BASEADOS.BI_migrar_hecho_envio
AS
BEGIN
	INSERT LOS_BASEADOS.BI_hecho_envio(idTiempo, idUbicacion, idSucursal, cant_envios_cumplidos, cant_envios_total, total_costo_envio)
	SELECT tiempo.idTiempo, ubi.idUbicacion, ds.idSucursal, count(LOS_BASEADOS.envio_cumplido(envio.fechaProgramada,envio.fechaEntrega)), count(*), sum(envio.total)
	FROM LOS_BASEADOS.envio envio
	JOIN LOS_BASEADOS.factura factura ON envio.idFactura = factura.idFactura
	JOIN LOS_BASEADOS.sucursal sucursal ON sucursal.numeroSucursal= factura.numeroSucursal
	JOIN LOS_BASEADOS.localidad localidad ON localidad.idLocalidad=sucursal.idLocalidad

	JOIN LOS_BASEADOS.BI_dimension_tiempo tiempo ON LOS_BASEADOS.comparar_fecha(tiempo.anio,tiempo.mes,tiempo.cuatrimestre,envio.fechaEntrega)=1
	JOIN LOS_BASEADOS.BI_dimension_ubicacion ubi ON sucursal.idLocalidad=ubi.idLocalidad AND localidad.idProvincia=ubi.idProvincia
	JOIN LOS_BASEADOS.BI_dimension_sucursal ds ON ds.numeroSucursal = sucursal.numeroSucursal
	GROUP BY tiempo.idTiempo, ubi.idUbicacion, ds.idSucursal
END
GO

CREATE PROCEDURE LOS_BASEADOS.BI_migrar_hecho_factura
AS
BEGIN
	INSERT LOS_BASEADOS.BI_hecho_factura(idTiempo,idUbicacion,idSucursal, total_facturas,cant_facturas)
	SELECT tiempo.idTiempo,ubi.idUbicacion, ds.idSucursal, sum(factura.total), count(*)
	FROM LOS_BASEADOS.factura factura 
	JOIN LOS_BASEADOS.sucursal sucursal ON sucursal.numeroSucursal= factura.numeroSucursal
	JOIN LOS_BASEADOS.localidad localidad ON localidad.idLocalidad=sucursal.idLocalidad
	JOIN LOS_BASEADOS.BI_dimension_tiempo tiempo ON LOS_BASEADOS.comparar_fecha(tiempo.anio,tiempo.mes,tiempo.cuatrimestre,factura.fecha)=1
	JOIN LOS_BASEADOS.BI_dimension_ubicacion ubi ON sucursal.idLocalidad=ubi.idLocalidad AND localidad.idProvincia=ubi.idProvincia
	JOIN LOS_BASEADOS.BI_dimension_sucursal ds ON sucursal.numeroSucursal = ds.numeroSucursal
	GROUP BY tiempo.idTiempo, ubi.idUbicacion, ds.idSucursal
END
GO

CREATE PROCEDURE LOS_BASEADOS.BI_migrar_hecho_pedido
AS
BEGIN
    INSERT LOS_BASEADOS.BI_hecho_pedido(idTiempo,idTurnoVenta,idSucursal,idUbicacion,idBiEstadoPedido,cant_pedidos)
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
END
GO

CREATE PROCEDURE LOS_BASEADOS.BI_migrar_hecho_venta
AS
BEGIN
	INSERT LOS_BASEADOS.BI_hecho_venta(idTiempo,idUbicacion,idSucursal,idRangoEtario,idBiModeloSillon,total_ventas,cant_ventas)
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
END
GO

CREATE PROCEDURE LOS_BASEADOS.BI_migrar_hecho_fabricacion
AS
BEGIN
	INSERT LOS_BASEADOS.BI_hecho_fabricacion(idTiempo,idUbicacion,idSucursal, total_tiempo,cant_pedidos)
	SELECT dt.idTiempo,du.idUbicacion, ds.idSucursal, sum(DATEDIFF(DAY, p.fecha, f.fecha)), count(*)
	FROM LOS_BASEADOS.factura f
	JOIN LOS_BASEADOS.detalle_factura df ON df.idFactura = f.idFactura
	JOIN LOS_BASEADOS.detalle_pedido dp ON dp.idDetallePedido = df.idDetallePedido
	JOIN LOS_BASEADOS.pedido p ON dp.numeroPedido = p.numeroPedido
	JOIN LOS_BASEADOS.sucursal s ON s.numeroSucursal = f.numeroSucursal
	JOIN LOS_BASEADOS.localidad l ON l.idLocalidad = s.idLocalidad
	JOIN LOS_BASEADOS.BI_dimension_tiempo dt ON LOS_BASEADOS.comparar_fecha(dt.anio,dt.mes,dt.cuatrimestre,f.fecha)=1
	JOIN LOS_BASEADOS.BI_dimension_ubicacion du ON s.idLocalidad=du.idLocalidad AND l.idProvincia=du.idProvincia
	JOIN LOS_BASEADOS.BI_dimension_sucursal ds ON s.numeroSucursal = ds.numeroSucursal
	GROUP BY dt.idTiempo, du.idUbicacion, ds.idSucursal
END
GO

-- CREACION DE VISTAS --------------------------------------------------------------------

-- 1) 171 Rows + ganancias bien calculadas
-- Total ingresos - Total egresos por mes y sucursal
CREATE VIEW LOS_BASEADOS.gananciasView AS
	SELECT dt.mes, dt.anio, ds.numeroSucursal, ds.direccion, du.provincia, du.localidad,
		( SELECT hf1.total_facturas - COALESCE(SUM(hc1.total_compras),0)
			FROM LOS_BASEADOS.BI_hecho_factura hf1
			LEFT JOIN LOS_BASEADOS.BI_hecho_compra hc1 ON hc1.idTiempo = hf1.idTiempo AND hc1.idSucursal = hf1.idSucursal
			WHERE hf1.idSucursal = hf.idSucursal AND hf1.idTiempo = hf.idTiempo
			GROUP BY hf1.total_facturas
		) AS Ganancia 
	FROM LOS_BASEADOS.BI_hecho_factura hf
	JOIN LOS_BASEADOS.BI_dimension_tiempo dt ON hf.idTiempo = dt.idTiempo
	JOIN LOS_BASEADOS.BI_dimension_sucursal ds ON hf.idSucursal = ds.idSucursal
	JOIN LOS_BASEADOS.BI_dimension_ubicacion du ON hf.idUbicacion = du.idUbicacion
	LEFT JOIN LOS_BASEADOS.BI_hecho_compra hc ON hc.idTiempo = hf.idTiempo AND hc.idSucursal = hf.idSucursal
	GROUP BY dt.mes, dt.anio, ds.numeroSucursal, ds.direccion, hf.idSucursal, hf.idTiempo, du.provincia, du.localidad
GO

-- 2) 35 Rows
-- Factura promedio mensual por provincia (de la sucursal) y cuatrimestre
CREATE VIEW LOS_BASEADOS.facturaPromedioMensualView AS
	SELECT 
		dt.anio,
		dt.cuatrimestre,
		du.provincia,
		AVG(hf.total_facturas) AS factura_promedio
	FROM LOS_BASEADOS.BI_hecho_factura hf
	JOIN LOS_BASEADOS.BI_dimension_tiempo dt ON hf.idTiempo = dt.idTiempo
	JOIN LOS_BASEADOS.BI_dimension_ubicacion du ON hf.idUbicacion = du.idUbicacion
	GROUP BY dt.anio, dt.cuatrimestre, du.provincia
GO

-- 3) 405 Rows
-- Rendimiento de modelos: Top 3 modelos más vendidos por cuatrimestre, localidad y rango etario
CREATE VIEW LOS_BASEADOS.rendimientoModelosView AS
	SELECT *
	FROM (
		SELECT 
			dt.anio,
			dt.cuatrimestre,
			du.localidad,
			dre.rango AS rango_etario,
			dms.modelo,
			dms.descripcion,
			hv.cant_ventas,
			ROW_NUMBER() OVER (
				PARTITION BY dt.anio, dt.cuatrimestre, du.localidad, dre.rango
				ORDER BY hv.cant_ventas DESC
			) AS Ranking
		FROM LOS_BASEADOS.BI_hecho_venta hv
		JOIN LOS_BASEADOS.BI_dimension_tiempo dt ON hv.idTiempo = dt.idTiempo
		JOIN LOS_BASEADOS.BI_dimension_ubicacion du ON hv.idUbicacion = du.idUbicacion
		JOIN LOS_BASEADOS.BI_dimension_rango_etario dre ON hv.idRangoEtario = dre.idRangoEtario
		JOIN LOS_BASEADOS.BI_dimension_modelo_sillon dms ON hv.idBiModeloSillon = dms.idBiModeloSillon
	) t
	WHERE Ranking <= 3
GO

-- 4) 342 Rows
-- Cantidad de pedidos por turno, sucursal y mes
CREATE VIEW LOS_BASEADOS.volumenPedidosView AS
    SELECT 
        dt.anio,
        dt.mes,
        ds.numeroSucursal,
        dtv.turno,
        SUM(hp.cant_pedidos) AS cant_pedidos
    FROM LOS_BASEADOS.BI_hecho_pedido hp
    JOIN LOS_BASEADOS.BI_dimension_tiempo dt ON hp.idTiempo = dt.idTiempo
    JOIN LOS_BASEADOS.BI_dimension_sucursal ds ON hp.idSucursal = ds.idSucursal
    JOIN LOS_BASEADOS.BI_dimension_turno_venta dtv ON hp.idTurnoVenta = dtv.idTurnoVenta
    GROUP BY dt.anio, dt.mes, ds.numeroSucursal, dtv.turno
GO

-- 5) 90 Rows
-- Conversión de pedidos: % de pedidos según estado, por cuatrimestre y sucursal
CREATE VIEW LOS_BASEADOS.conversionPedidosView AS
	SELECT 
		dt.anio,
		dt.cuatrimestre,
		ds.numeroSucursal,
		dep.estado,
		SUM(hp.cant_pedidos) AS pedidos_estado,
		SUM(SUM(hp.cant_pedidos)) OVER (PARTITION BY dt.anio, dt.cuatrimestre, ds.numeroSucursal) AS total_pedidos,
		CAST(SUM(hp.cant_pedidos) * 100.0 / NULLIF( SUM(SUM(hp.cant_pedidos)) OVER (PARTITION BY dt.anio, dt.cuatrimestre, ds.numeroSucursal), 0) AS DECIMAL(5,2)) AS porcentaje
	FROM LOS_BASEADOS.BI_hecho_pedido hp
	JOIN LOS_BASEADOS.BI_dimension_tiempo dt ON hp.idTiempo = dt.idTiempo
	JOIN LOS_BASEADOS.BI_dimension_sucursal ds ON hp.idSucursal = ds.idSucursal
	JOIN LOS_BASEADOS.BI_dimension_estado_pedido dep ON hp.idBiEstadoPedido = dep.idBiEstadoPedido
	GROUP BY dt.anio, dt.cuatrimestre, ds.numeroSucursal, dep.estado
GO

-- 6) 45 Rows
-- Tiempo promedio de fabricación: Promedio de días entre pedido y factura por sucursal y cuatrimestre

CREATE VIEW LOS_BASEADOS.tiempoPromedioFabricacionView AS
	SELECT dt.anio, dt.cuatrimestre, ds.numeroSucursal, SUM(hf.total_tiempo)/SUM(hf.cant_pedidos) TiempoPromedio
	FROM LOS_BASEADOS.BI_hecho_fabricacion hf
	JOIN LOS_BASEADOS.BI_dimension_sucursal ds ON hf.idSucursal = ds.idSucursal
	JOIN LOS_BASEADOS.BI_dimension_tiempo dt ON hf.idTiempo = dt.idTiempo
	GROUP BY dt.cuatrimestre, dt.anio, ds.numeroSucursal
GO

-- 7) 19 Rows
-- Promedio de compras por mes
CREATE VIEW LOS_BASEADOS.promedioComprasView AS
	SELECT 
		dt.anio,
		dt.mes,
		AVG(hc.total_compras * 1.0 ) AS promedio_compras
	FROM LOS_BASEADOS.BI_hecho_compra hc
	JOIN LOS_BASEADOS.BI_dimension_tiempo dt ON hc.idTiempo = dt.idTiempo
	GROUP BY dt.anio, dt.mes
GO

-- 8) 114 Rows
-- Compras por Tipo de Material, sucursal y cuatrimestre
CREATE VIEW LOS_BASEADOS.comprasPorTipoMaterialView AS
	SELECT 
		dt.anio,
		dt.cuatrimestre,
		ds.numeroSucursal,
		dtm.tipo,
		SUM(hc.total_compras) AS total_gastado
	FROM LOS_BASEADOS.BI_hecho_compra hc
	JOIN LOS_BASEADOS.BI_dimension_tiempo dt ON hc.idTiempo = dt.idTiempo
	JOIN LOS_BASEADOS.BI_dimension_sucursal ds ON hc.idSucursal = ds.idSucursal
	JOIN LOS_BASEADOS.BI_dimension_tipo_material dtm ON hc.idBiTipoMaterial = dtm.idBiTipoMaterial
	GROUP BY dt.anio, dt.cuatrimestre, ds.numeroSucursal, dtm.tipo
GO

-- 9) 19 Rows - Es por mes solamente, no por sucursal
-- Porcentaje de cumplimiento de envíos en tiempo por mes
CREATE VIEW LOS_BASEADOS.porcentajeCumplimientoEnviosView AS
	SELECT 
		dt.anio,
		dt.mes,
		SUM(he.cant_envios_cumplidos) AS envios_cumplidos,
		SUM(he.cant_envios_total) AS envios_totales,
		CAST(SUM(he.cant_envios_cumplidos) * 100.0 / NULLIF(SUM(he.cant_envios_total),0) AS DECIMAL(5,2)) AS porcentaje_cumplimiento
	FROM LOS_BASEADOS.BI_hecho_envio he
	JOIN LOS_BASEADOS.BI_dimension_tiempo dt ON he.idTiempo = dt.idTiempo
	JOIN LOS_BASEADOS.BI_dimension_sucursal ds ON he.idSucursal = ds.idSucursal
	GROUP BY dt.anio, dt.mes
GO

-- 10) 3 Rows
-- Localidades con mayor costo de envío promedio (top 3)
CREATE VIEW LOS_BASEADOS.localidadesConMayorCostoEnvioView AS
	SELECT TOP 3
		du.localidad,
		AVG(he.total_costo_envio * 1.0) AS promedio_costo_envio
	FROM LOS_BASEADOS.BI_hecho_envio he
	JOIN LOS_BASEADOS.BI_dimension_ubicacion du ON he.idUbicacion = du.idUbicacion
	GROUP BY du.localidad
	ORDER BY promedio_costo_envio DESC
GO

-- EJECUCION DE PROCEDURES --------------------------------------------------------------------

EXEC LOS_BASEADOS.BI_migrar_dimension_estado_pedido
EXEC LOS_BASEADOS.BI_migrar_dimension_modelo_sillon
EXEC LOS_BASEADOS.BI_migrar_dimension_rango_etario
EXEC LOS_BASEADOS.BI_migrar_dimension_tiempo
EXEC LOS_BASEADOS.BI_migrar_dimension_tipo_material
EXEC LOS_BASEADOS.BI_migrar_dimension_turno_venta
EXEC LOS_BASEADOS.BI_migrar_dimension_sucursal
EXEC LOS_BASEADOS.BI_migrar_dimension_ubicaciones

EXEC LOS_BASEADOS.BI_migrar_hecho_compra
EXEC LOS_BASEADOS.BI_migrar_hecho_envio
EXEC LOS_BASEADOS.BI_migrar_hecho_factura
EXEC LOS_BASEADOS.BI_migrar_hecho_pedido
EXEC LOS_BASEADOS.BI_migrar_hecho_venta
EXEC LOS_BASEADOS.BI_migrar_hecho_fabricacion

SELECT * FROM LOS_BASEADOS.localidadesConMayorCostoEnvioView