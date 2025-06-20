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
	total_facturas DECIMAL(12,2) NOT NULL,
    cant_facturas DECIMAL(18,0) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.BI_hecho_pedido(
	idTiempo DECIMAL(18,0) NOT NULL,
    idTurnoVenta DECIMAL(18,0) NOT NULL,
    idUbicacion DECIMAL(18,0) NOT NULL,
    idBiEstadoPedido DECIMAL(18,0) NOT NULL,
    cant_pedidos DECIMAL(18,0) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.BI_hecho_venta(
	idTiempo DECIMAL(18,0) NOT NULL,
    idRangoEtario DECIMAL(18,0) NOT NULL,
    idUbicacion DECIMAL(18,0) NOT NULL,
    idBiModeloSillon DECIMAL(18,0) NOT NULL,
    total_ventas DECIMAL(12,2) NOT NULL,
    cant_ventas DECIMAL(18,0) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.BI_hecho_compra(
	idTiempo DECIMAL(18,0) NOT NULL,
    idUbicacion DECIMAL(18,0) NOT NULL,
    idBiTipoMaterial DECIMAL(18,0) NOT NULL,
    total_compras DECIMAL(12,2) NOT NULL,
    cant_compras DECIMAL(18,0) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.BI_hecho_envio(
	idTiempo DECIMAL(18,0) NOT NULL,
    idUbicacion DECIMAL(18,0) NOT NULL,
    cant_envios_cumplidos DECIMAL(18,0) NOT NULL,
    cant_envios_total DECIMAL(18,0) NOT NULL,
    total_costo_envio DECIMAL(12,2) NOT NULL
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

ALTER TABLE LOS_BASEADOS.BI_dimension_modelo_sillon ADD CONSTRAINT PK_idBiModeloSillon PRIMARY KEY(idBiModeloSillon);
GO

ALTER TABLE LOS_BASEADOS.BI_hecho_factura ADD CONSTRAINT PK_hechoFactura PRIMARY KEY(idTiempo, idUbicacion);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_factura ADD CONSTRAINT FK_hechoFactura_idTiempo FOREIGN KEY(idTiempo) REFERENCES LOS_BASEADOS.BI_dimension_tiempo(idTiempo);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_factura ADD CONSTRAINT FK_hechoFactura_idUbicacion FOREIGN KEY(idUbicacion) REFERENCES LOS_BASEADOS.BI_dimension_ubicacion(idUbicacion);
GO

ALTER TABLE LOS_BASEADOS.BI_hecho_envio ADD CONSTRAINT PK_hechoEnvio PRIMARY KEY(idTiempo, idUbicacion);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_envio ADD CONSTRAINT FK_hechoEnvio_idTiempo FOREIGN KEY(idTiempo) REFERENCES LOS_BASEADOS.BI_dimension_tiempo(idTiempo);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_envio ADD CONSTRAINT FK_hechoEnvio_idUbicacion FOREIGN KEY(idUbicacion) REFERENCES LOS_BASEADOS.BI_dimension_ubicacion(idUbicacion);
GO

ALTER TABLE LOS_BASEADOS.BI_hecho_pedido ADD CONSTRAINT PK_hechoPedido PRIMARY KEY(idTiempo, idUbicacion, idTurnoVenta, idBiEstadoPedido);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_pedido ADD CONSTRAINT FK_hechoPedido_idTiempo FOREIGN KEY(idTiempo) REFERENCES LOS_BASEADOS.BI_dimension_tiempo(idTiempo);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_pedido ADD CONSTRAINT FK_hechoPedido_idUbicacion FOREIGN KEY(idUbicacion) REFERENCES LOS_BASEADOS.BI_dimension_ubicacion(idUbicacion);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_pedido ADD CONSTRAINT FK_hechoPedido_idTurnoVenta FOREIGN KEY(idTurnoVenta) REFERENCES LOS_BASEADOS.BI_dimension_turno_venta(idTurnoVenta);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_pedido ADD CONSTRAINT FK_hechoPedido_idBiEstadoPedido FOREIGN KEY(idBiEstadoPedido) REFERENCES LOS_BASEADOS.BI_dimension_estado_pedido(idBiEstadoPedido);
GO

ALTER TABLE LOS_BASEADOS.BI_hecho_venta ADD CONSTRAINT PK_hechoVenta PRIMARY KEY(idTiempo, idUbicacion, idRangoEtario, idBiModeloSillon);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_venta ADD CONSTRAINT FK_hechoVenta_idTiempo FOREIGN KEY(idTiempo) REFERENCES LOS_BASEADOS.BI_dimension_tiempo(idTiempo);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_venta ADD CONSTRAINT FK_hechoVenta_idUbicacion FOREIGN KEY(idUbicacion) REFERENCES LOS_BASEADOS.BI_dimension_ubicacion(idUbicacion);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_venta ADD CONSTRAINT FK_hechoVenta_idRangoEtario FOREIGN KEY(idRangoEtario) REFERENCES LOS_BASEADOS.BI_dimension_rango_etario(idRangoEtario);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_venta ADD CONSTRAINT FK_hechoVenta_idBiModeloSillon FOREIGN KEY(idBiModeloSillon) REFERENCES LOS_BASEADOS.BI_dimension_modelo_sillon(idBiModeloSillon);
GO

ALTER TABLE LOS_BASEADOS.BI_hecho_compra ADD CONSTRAINT PK_hechoCompra PRIMARY KEY(idTiempo, idUbicacion, idBiTipoMaterial);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_compra ADD CONSTRAINT FK_hechoCompra_idTiempo FOREIGN KEY(idTiempo) REFERENCES LOS_BASEADOS.BI_dimension_tiempo(idTiempo);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_compra ADD CONSTRAINT FK_hechoCompra_idUbicacion FOREIGN KEY(idUbicacion) REFERENCES LOS_BASEADOS.BI_dimension_ubicacion(idUbicacion);
GO
ALTER TABLE LOS_BASEADOS.BI_hecho_compra ADD CONSTRAINT FK_hechoCompra_idTipoMaterial FOREIGN KEY(idBiTipoMaterial) REFERENCES LOS_BASEADOS.BI_dimension_tipo_material(idBiTipoMaterial);
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
        SET @turno = 'Maniana'
    ELSE IF @HORA BETWEEN 14 AND 20
        SET @turno = 'Tarde'
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
    INSERT LOS_BASEADOS.BI_hecho_compra(idTiempo,idUbicacion,idBiTipoMaterial,total_compras,cant_compras)
    SELECT tiempo.idTiempo, ubi.idUbicacion, tipo_mat.idBiTipoMaterial, count (distinct compra.numeroCompra) as cant_compras,sum(compra.total) as total_compras
    FROM LOS_BASEADOS.compra compra
        JOIN LOS_BASEADOS.sucursal sucursal ON compra.numeroSucursal=SUCURSAL.numeroSucursal
		JOIN LOS_BASEADOS.localidad localidad on sucursal.idLocalidad= localidad.idLocalidad
		JOIN LOS_BASEADOS.detalle_compra ON compra.idCompra=detalle_compra.idCompra
		JOIN LOS_BASEADOS.material material on material.idMaterial=detalle_compra.idMaterial
		JOIN LOS_BASEADOS.bi_dimension_tiempo tiempo on  LOS_BASEADOS.comparar_fecha(tiempo.anio,tiempo.mes,tiempo.cuatrimestre,compra.fecha)=1
		JOIN LOS_BASEADOS.BI_dimension_ubicacion ubi ON sucursal.idLocalidad=ubi.idLocalidad and localidad.idProvincia=ubi.idProvincia
		JOIN LOS_BASEADOS.BI_dimension_tipo_material tipo_mat on tipo_mat.idTipoMaterial=material.idTipoMaterial
    GROUP BY idTiempo, idUbicacion, idBiTipoMaterial
END
GO

CREATE PROCEDURE LOS_BASEADOS.BI_migrar_hecho_envio
AS
BEGIN
	INSERT LOS_BASEADOS.BI_hecho_envio(idTiempo, idUbicacion,cant_envios_cumplidos,cant_envios_total,total_costo_envio)
	SELECT tiempo.idTiempo, ubi.idUbicacion, count(LOS_BASEADOS.envio_cumplido(envio.fechaProgramada,envio.fechaEntrega)), count(*) as total, sum(envio.total)
	FROM LOS_BASEADOS.envio envio
	JOIN LOS_BASEADOS.factura factura on envio.idFactura = factura.idFactura
	JOIN LOS_BASEADOS.cliente cliente on cliente.idCliente= factura.idCliente
	JOIN LOS_BASEADOS.localidad localidad on localidad.idLocalidad=cliente.idLocalidad
	JOIN LOS_BASEADOS.BI_dimension_tiempo tiempo ON LOS_BASEADOS.comparar_fecha(tiempo.anio,tiempo.mes,tiempo.cuatrimestre,envio.fechaEntrega)=1
	JOIN LOS_BASEADOS.BI_dimension_ubicacion ubi on cliente.idLocalidad=ubi.idLocalidad and localidad.idProvincia=ubi.idProvincia
	GROUP BY tiempo.idTiempo, ubi.idUbicacion
END
GO

CREATE PROCEDURE LOS_BASEADOS.BI_migrar_hecho_factura
AS
BEGIN
	INSERT LOS_BASEADOS.BI_hecho_factura(idTiempo,idUbicacion,total_facturas,cant_facturas)
	SELECT tiempo.idTiempo,ubi.idUbicacion,sum(factura.total) as total_facturas, count(*) as cant_facturas
	FROM LOS_BASEADOS.factura factura 
	JOIN LOS_BASEADOS.cliente cliente on cliente.idCliente= factura.idCliente
	JOIN LOS_BASEADOS.localidad localidad on localidad.idLocalidad=cliente.idLocalidad
	JOIN LOS_BASEADOS.BI_dimension_tiempo tiempo ON LOS_BASEADOS.comparar_fecha(tiempo.anio,tiempo.mes,tiempo.cuatrimestre,factura.fecha)=1
	JOIN LOS_BASEADOS.BI_dimension_ubicacion ubi on cliente.idLocalidad=ubi.idLocalidad and localidad.idProvincia=ubi.idProvincia
	GROUP BY tiempo.idTiempo, ubi.idUbicacion
END
GO

CREATE PROCEDURE LOS_BASEADOS.BI_migrar_hecho_pedido
AS
BEGIN
    INSERT LOS_BASEADOS.BI_hecho_pedido(idTiempo,idTurnoVenta,idUbicacion,idBiEstadoPedido,cant_pedidos)
    SELECT tiempo.idTiempo, ubi.idUbicacion,turn.idTurnoVenta,est_ped.idBiEstadoPedido,COUNT(pedido.numeroPedido)
    FROM LOS_BASEADOS.pedido
	JOIN LOS_BASEADOS.estado est ON est.idEstado = pedido.idEstado
	JOIN LOS_BASEADOS.sucursal sucursal ON sucursal.numeroSucursal = pedido.numeroSucursal --VER ESTOO
	JOIN LOS_BASEADOS.localidad localidad ON sucursal.idLocalidad = localidad.idLocalidad
	JOIN LOS_BASEADOS.BI_dimension_tiempo tiempo ON LOS_BASEADOS.comparar_fecha(tiempo.anio,tiempo.mes,tiempo.cuatrimestre,pedido.fecha)=1
	JOIN LOS_BASEADOS.BI_dimension_ubicacion ubi ON sucursal.idLocalidad=ubi.idLocalidad and localidad.idProvincia=ubi.idProvincia
	JOIN LOS_BASEADOS.BI_dimension_turno_venta turn ON LOS_BASEADOS.comparar_turno(turn.turno,pedido.fecha) = 1 
	JOIN LOS_BASEADOS.BI_dimension_estado_pedido est_ped ON est_ped.idEstado = pedido.idEstado
	GROUP BY tiempo.idTiempo, ubi.idUbicacion,turn.idTurnoVenta,est_ped.idBiEstadoPedido
END
GO

--JOIN LOS_BASEADOS.BI_dimension_tiempo tiempo ON dbo.comparar_fecha(CAST(tiempo.anio AS INT),
--																	   CAST(tiempo.mes AS INT),
--																	   CAST(tiempo.cuatrimestre AS INT),pedido.fecha)=1

/*
CREATE PROCEDURE LOS_BASEADOS.BI_migrar_hecho_venta
AS
BEGIN
	INSERT LOS_BASEADOS.BI_hecho_venta(idTiempo,idUbicacion,idRangoEtario,idBiModeloSillon,total_ventas,cant_ventas)
	SELECT tiempo.idTiempo,ubi.idUbicacion,
	FROM LOS_BASEADOS.?
	JOIN LOS_BASEADOS.cliente cliente on cliente.idCliente= factura.idCliente
	JOIN LOS_BASEADOS.localidad localidad on localidad.idLocalidad=cliente.idLocalidad
	JOIN LOS_BASEADOS.BI_dimension_tiempo tiempo ON LOS_BASEADOS.comparar_fecha(tiempo.anio,tiempo.mes,tiempo.cuatrimestre,factura.fecha)=1
	JOIN LOS_BASEADOS.BI_dimension_ubicacion ubi on cliente.idLocalidad=ubi.idLocalidad and localidad.idProvincia=ubi.idProvincia
END
GO
*/

-- CREACION DE VISTAS --------------------------------------------------------------------

/*
CREATE VIEW LOS_BASEADOS.gananciasView AS
GO

CREATE VIEW LOS_BASEADOS.facturaPromedioMensualView AS
GO

CREATE VIEW LOS_BASEADOS.rendimientoModelosView AS
GO

CREATE VIEW LOS_BASEADOS.volumenPedidosView AS
GO

CREATE VIEW LOS_BASEADOS.conversionPedidosView AS
GO

CREATE VIEW LOS_BASEADOS.tiempoPromedioFabricacionView AS
GO

CREATE VIEW LOS_BASEADOS.promedioComprasView AS
GO

CREATE VIEW LOS_BASEADOS.comprasPorTipoMaterialView AS
GO

CREATE VIEW LOS_BASEADOS.porcentajeCumplimientoEnviosView AS
GO

CREATE VIEW LOS_BASEADOS.localidadesConMayorCostoEnvioView AS
GO
*/

-- EJECUCION DE PROCEDURES --------------------------------------------------------------------

EXEC LOS_BASEADOS.BI_migrar_dimension_estado_pedido
EXEC LOS_BASEADOS.BI_migrar_dimension_modelo_sillon
EXEC LOS_BASEADOS.BI_migrar_dimension_rango_etario
EXEC LOS_BASEADOS.BI_migrar_dimension_tiempo
EXEC LOS_BASEADOS.BI_migrar_dimension_tipo_material
EXEC LOS_BASEADOS.BI_migrar_dimension_turno_venta
EXEC LOS_BASEADOS.BI_migrar_dimension_ubicaciones

EXEC LOS_BASEADOS.BI_migrar_hecho_compra
EXEC LOS_BASEADOS.BI_migrar_hecho_envio
EXEC LOS_BASEADOS.BI_migrar_hecho_factura
EXEC LOS_BASEADOS.BI_migrar_hecho_pedido
--EXEC LOS_BASEADOS.BI_migrar_hecho_venta



