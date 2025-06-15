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

CREATE TABLE LOS_BASEADOS.BI_dimension_rango_etario_cliente(
	idRangoEtario DECIMAL(18,0) NOT NULL IDENTITY(1,1),
	rango NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.BI_dimension_turno_venta(
	idTurnoVentas DECIMAL(18,0) NOT NULL IDENTITY(1,1),
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
    idTipoMaterial DECIMAL(18,0) NOT NULL,
    total_compras DECIMAL(12,2) NOT NULL,
    cant_compras DECIMAL(18,0) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.BI_hecho_envio(
	idTiempo DECIMAL(18,0) NOT NULL,
    idUbicacion DECIMAL(18,0) NOT NULL,
    cant_envios_cumplidos DECIMAL(18,0) NOT NULL,
    cant_envios_total DECIMAL(18,0) NOT NULL,
    total_costo DECIMAL(12,2) NOT NULL
);
GO

-- CREACION DE CONSTRAINTS --------------------------------------------------------------------

ALTER TABLE LOS_BASEADOS.BI_dimension_estado_pedido ADD CONSTRAINT PK_idBiEstadoPedido PRIMARY KEY(idBiEstadoPedido);
GO


ALTER TABLE LOS_BASEADOS.BI_dimension_turno_venta ADD CONSTRAINT PK_idTurnoVentas PRIMARY KEY(idTurnoVentas);
GO


ALTER TABLE LOS_BASEADOS.BI_dimension_tiempo ADD CONSTRAINT PK_idTiempo PRIMARY KEY(idTiempo);
GO


ALTER TABLE LOS_BASEADOS.BI_dimension_tipo_material ADD CONSTRAINT PK_idBiTipoMaterial PRIMARY KEY(idBiTipoMaterial);
GO


ALTER TABLE LOS_BASEADOS.BI_dimension_rango_etario_cliente ADD CONSTRAINT PK_idRangoEtario PRIMARY KEY(idRangoEtario);
GO


ALTER TABLE LOS_BASEADOS.BI_dimension_ubicacion ADD CONSTRAINT PK_idUbicacion PRIMARY KEY(idUbicacion);
GO


ALTER TABLE LOS_BASEADOS.BI_dimension_modelo_sillon ADD CONSTRAINT PK_idBiModeloSillon PRIMARY KEY(idBiModeloSillon);
GO

/* #######TODO
ALTER TABLE LOS_BASEADOS.sucursal ADD CONSTRAINT FK_sucursal_localidad FOREIGN KEY(idLocalidad) REFERENCES LOS_BASEADOS.localidad(idLocalidad);
GO
ALTER TABLE LOS_BASEADOS.sucursal ADD CONSTRAINT FK_sucursal_localidad FOREIGN KEY(idLocalidad) REFERENCES LOS_BASEADOS.localidad(idLocalidad);
GO


ALTER TABLE LOS_BASEADOS.sucursal ADD CONSTRAINT FK_sucursal_localidad FOREIGN KEY(idLocalidad) REFERENCES LOS_BASEADOS.localidad(idLocalidad);
GO
ALTER TABLE LOS_BASEADOS.sucursal ADD CONSTRAINT FK_sucursal_localidad FOREIGN KEY(idLocalidad) REFERENCES LOS_BASEADOS.localidad(idLocalidad);
GO


ALTER TABLE LOS_BASEADOS.sucursal ADD CONSTRAINT FK_sucursal_localidad FOREIGN KEY(idLocalidad) REFERENCES LOS_BASEADOS.localidad(idLocalidad);
GO
ALTER TABLE LOS_BASEADOS.sucursal ADD CONSTRAINT FK_sucursal_localidad FOREIGN KEY(idLocalidad) REFERENCES LOS_BASEADOS.localidad(idLocalidad);
GO
ALTER TABLE LOS_BASEADOS.sucursal ADD CONSTRAINT FK_sucursal_localidad FOREIGN KEY(idLocalidad) REFERENCES LOS_BASEADOS.localidad(idLocalidad);
GO
ALTER TABLE LOS_BASEADOS.sucursal ADD CONSTRAINT FK_sucursal_localidad FOREIGN KEY(idLocalidad) REFERENCES LOS_BASEADOS.localidad(idLocalidad);
GO


ALTER TABLE LOS_BASEADOS.sucursal ADD CONSTRAINT FK_sucursal_localidad FOREIGN KEY(idLocalidad) REFERENCES LOS_BASEADOS.localidad(idLocalidad);
GO
ALTER TABLE LOS_BASEADOS.sucursal ADD CONSTRAINT FK_sucursal_localidad FOREIGN KEY(idLocalidad) REFERENCES LOS_BASEADOS.localidad(idLocalidad);
GO
ALTER TABLE LOS_BASEADOS.sucursal ADD CONSTRAINT FK_sucursal_localidad FOREIGN KEY(idLocalidad) REFERENCES LOS_BASEADOS.localidad(idLocalidad);
GO
ALTER TABLE LOS_BASEADOS.sucursal ADD CONSTRAINT FK_sucursal_localidad FOREIGN KEY(idLocalidad) REFERENCES LOS_BASEADOS.localidad(idLocalidad);
GO


ALTER TABLE LOS_BASEADOS.sucursal ADD CONSTRAINT FK_sucursal_localidad FOREIGN KEY(idLocalidad) REFERENCES LOS_BASEADOS.localidad(idLocalidad);
GO
ALTER TABLE LOS_BASEADOS.sucursal ADD CONSTRAINT FK_sucursal_localidad FOREIGN KEY(idLocalidad) REFERENCES LOS_BASEADOS.localidad(idLocalidad);
GO
ALTER TABLE LOS_BASEADOS.sucursal ADD CONSTRAINT FK_sucursal_localidad FOREIGN KEY(idLocalidad) REFERENCES LOS_BASEADOS.localidad(idLocalidad);
GO
*/

-- CREACION DE FUNCIONES --------------------------------------------------------------------

-- CREACION DE PROCEDURES PARA MIGRAR DATOS A DIMENSIONES --------------------------------------------------------------------

-- CREACION DE PROCEDURES PARA MIGRAR DATOS A HECHOS --------------------------------------------------------------------

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
