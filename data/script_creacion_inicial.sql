USE GD1C2025
GO

CREATE SCHEMA LOS_BASEADOS
GO

CREATE SYNONYM Maestra FOR gd_esquema.Maestra;
GO

-- CREACION DE TABLAS (TODO DENTRO DEL SCHEMA LOS_BASEADOS!)


CREATE TABLE LOS_BASEADOS.provincia(
    idProvincia TINYINT NOT NULL IDENTITY(1,1),
    provincia NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.localidad(
    idLocalidad SMALLINT NOT NULL IDENTITY(1,1),
    idProvincia TINYINT NOT NULL,
    localidad NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.sucursal(
    numeroSucursal BIGINT NOT NULL,
    idLocalidad SMALLINT NOT NULL,
    direccion NVARCHAR(255) NOT NULL,
    telefono NVARCHAR(255) NOT NULL,
    mail NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.proveedor(
    idProveedor INT NOT NULL IDENTITY(1,1),
    idLocalidad SMALLINT NOT NULL,
    direccion NVARCHAR(255) NOT NULL,
    telefono NVARCHAR(255) NOT NULL,
    mail NVARCHAR(255) NOT NULL,
    razonSocial NVARCHAR(255) NOT NULL,
    cuit NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.compra(
    numeroCompra DECIMAL(18,0) NOT NULL,
    numeroSucursal BIGINT NOT NULL,
    idProveedor INT NOT NULL,
    fecha DATETIME2(6) NOT NULL,
    total DECIMAL(18,2) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.tipo_material(
    idTipoMaterial INT NOT NULL IDENTITY(1,1),
    tipo NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.tela(
    idTela INT NOT NULL IDENTITY(1,1),
    idTipoMaterial INT NOT NULL,
    color NVARCHAR(255) NOT NULL,
    textura NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.madera(
    idMadera INT NOT NULL IDENTITY(1,1),
    idTipoMaterial INT NOT NULL,
    color NVARCHAR(255) NOT NULL,
    dureza NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.relleno(
    idRelleno INT NOT NULL IDENTITY(1,1),
    idTipoMaterial INT NOT NULL,
    densidad NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.detalle_compra(
    idDetalleCompra BIGINT NOT NULL IDENTITY(1,1),
    numeroCompra DECIMAL(18,0) NOT NULL,
    idTipoMaterial INT NOT NULL,
    precioUnitario DECIMAL(18,2),
    cantidad DECIMAL(18,0),
    subtotal DECIMAL(18,2)
);
GO

CREATE TABLE LOS_BASEADOS.material(
    idMaterial INT NOT NULL IDENTITY(1,1),
    idTipoMaterial INT NOT NULL,
    nombre NVARCHAR(255) NOT NULL,
    descripcion NVARCHAR(255) NOT NULL,
    precio DECIMAL(38,2) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.modelo_sillon(
    codigoModelo BIGINT NOT NULL,
    descripcion NVARCHAR(255) NOT NULL,
    precio DECIMAL(18,2) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.medidas(
    idMedidas INT NOT NULL IDENTITY(1,1),
    alto DECIMAL(18,2) NOT NULL,
    ancho DECIMAL(18,2) NOT NULL,
    profundidad DECIMAL(18,2) NOT NULL,
    precio DECIMAL(18,2) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.sillon(
    codigoSillon BIGINT NOT NULL,
    codigoModelo BIGINT NOT NULL,
    idMedidas INT NOT NULL,
    modelo NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.material_x_sillon(
    codigoSillon BIGINT NOT NULL,
    idMaterial INT NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.cliente(
    idCliente BIGINT NOT NULL IDENTITY(1,1),
    idLocalidad SMALLINT NOT NULL,
    dni BIGINT NOT NULL,
    nombre NVARCHAR(255) NOT NULL,
    apellido NVARCHAR(255) NOT NULL,
    fechaNacimiento DATETIME2(6) NOT NULL,
    telefono NVARCHAR(255) NOT NULL,
    mail NVARCHAR(255) NOT NULL,
    direccion NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.estado(
    idEstado TINYINT NOT NULL IDENTITY(1,1),
    estado NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.pedido(
    numeroPedido DECIMAL(18,0) NOT NULL,
    numeroSucursal BIGINT NOT NULL,
    idCliente BIGINT NOT NULL,
    idEstado TINYINT NOT NULL,
    fecha DATETIME2(6) NOT NULL,
    total DECIMAL(18,2) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.cancelacion(
    idCancelacion INT NOT NULL IDENTITY(1,1),
    numeroPedido DECIMAL(18,0) NOT NULL,
    fecha DATETIME2(6) NOT NULL,
    motivo VARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.detalle_pedido(
    idDetallePedido BIGINT NOT NULL IDENTITY(1,1),
    numeroPedido DECIMAL(18,0) NOT NULL,
    codigoSillon BIGINT NOT NULL,
    precio DECIMAL(18,2) NOT NULL,
    cantidad DECIMAL(18,0) NOT NULL,
    subtotal DECIMAL(18,2) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.factura(
    numeroFactura BIGINT NOT NULL,
    numeroSucursal BIGINT NOT NULL,
    idCliente BIGINT NOT NULL,
    fecha DATETIME2(6) NOT NULL,
    total DECIMAL(38,2) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.detalle_factura(
    idDetalleFactura BIGINT NOT NULL IDENTITY(1,1),
    numeroFactura BIGINT NOT NULL,
    idDetallePedido BIGINT NOT NULL,
    precioUnitario DECIMAL(18,2) NOT NULL,
    cantidad DECIMAL(18,0) NOT NULL,
    subtotal DECIMAL(18,2) NOT NULL

);
GO

CREATE TABLE LOS_BASEADOS.envio(
    numeroEnvio DECIMAL(18,0) NOT NULL,
    numeroFactura BIGINT NOT NULL,
    fechaProgramada DATETIME2(6) NOT NULL,
    fechaEntrega DATETIME2(6) NOT NULL,
    importeTraslado DECIMAL(18,2) NOT NULL,
    importeSubida DECIMAL(18,2) NOT NULL,
    subtotal DECIMAL(18,2) NOT NULL
);
GO

-- CREACION DE CONSTRAINTS DE LAS TABLAS (PKS, FKS, ETC)


ALTER TABLE LOS_BASEADOS.provincia ADD CONSTRAINT PK_idProvincia PRIMARY KEY(idProvincia);
GO

ALTER TABLE LOS_BASEADOS.localidad ADD CONSTRAINT PK_idLocalidad PRIMARY KEY(idLocalidad);
GO
ALTER TABLE LOS_BASEADOS.localidad ADD CONSTRAINT FK_localidad_provincia FOREIGN KEY(idProvincia) REFERENCES LOS_BASEADOS.provincia(idProvincia);
GO

ALTER TABLE LOS_BASEADOS.sucursal ADD CONSTRAINT PK_numeroSucursal PRIMARY KEY(numeroSucursal);
GO
ALTER TABLE LOS_BASEADOS.sucursal ADD CONSTRAINT FK_sucursal_localidad FOREIGN KEY(idLocalidad) REFERENCES LOS_BASEADOS.localidad(idLocalidad);
GO

ALTER TABLE LOS_BASEADOS.proveedor ADD CONSTRAINT PK_idProveedor PRIMARY KEY(idProveedor);
GO
ALTER TABLE LOS_BASEADOS.proveedor ADD CONSTRAINT FK_proveedor_localidad FOREIGN KEY(idLocalidad) REFERENCES LOS_BASEADOS.localidad(idLocalidad);
GO

ALTER TABLE LOS_BASEADOS.compra ADD CONSTRAINT PK_numeroCompra PRIMARY KEY(numeroCompra);
GO
ALTER TABLE LOS_BASEADOS.compra ADD CONSTRAINT FK_compra_proveedor FOREIGN KEY(idProveedor) REFERENCES LOS_BASEADOS.proveedor(idProveedor);
GO
ALTER TABLE LOS_BASEADOS.compra ADD CONSTRAINT FK_compra_sucursal FOREIGN KEY(numeroSucursal) REFERENCES LOS_BASEADOS.sucursal(numeroSucursal);
GO

ALTER TABLE LOS_BASEADOS.tipo_material ADD CONSTRAINT PK_idTipoMaterial PRIMARY KEY(idTipoMaterial);
GO

ALTER TABLE LOS_BASEADOS.tela ADD CONSTRAINT PK_idTela PRIMARY KEY(idTela);
GO
ALTER TABLE LOS_BASEADOS.tela ADD CONSTRAINT FK_tela_tipoMaterial FOREIGN KEY(idTipoMaterial) REFERENCES LOS_BASEADOS.tipo_material(idTipoMaterial);
GO

ALTER TABLE LOS_BASEADOS.madera ADD CONSTRAINT PK_idMadera PRIMARY KEY(idMadera);
GO
ALTER TABLE LOS_BASEADOS.madera ADD CONSTRAINT FK_madera_tipoMaterial FOREIGN KEY(idTipoMaterial) REFERENCES LOS_BASEADOS.tipo_material(idTipoMaterial);
GO

ALTER TABLE LOS_BASEADOS.relleno ADD CONSTRAINT PK_idRelleno PRIMARY KEY(idRelleno);
GO
ALTER TABLE LOS_BASEADOS.relleno ADD CONSTRAINT FK_relleno_tipoMaterial FOREIGN KEY(idTipoMaterial) REFERENCES LOS_BASEADOS.tipo_material(idTipoMaterial);
GO

ALTER TABLE LOS_BASEADOS.detalle_compra ADD CONSTRAINT PK_idDetalleCompra PRIMARY KEY(idDetalleCompra);
GO
ALTER TABLE LOS_BASEADOS.detalle_compra ADD CONSTRAINT FK_detalleCompra_compra FOREIGN KEY(numeroCompra) REFERENCES LOS_BASEADOS.compra(numeroCompra);
GO
ALTER TABLE LOS_BASEADOS.detalle_compra ADD CONSTRAINT FK_detalleCompra_tipoMaterial FOREIGN KEY(idTipoMaterial) REFERENCES LOS_BASEADOS.tipo_material(idTipoMaterial);
GO

ALTER TABLE LOS_BASEADOS.material ADD CONSTRAINT PK_idMaterial PRIMARY KEY(idMaterial);
GO
ALTER TABLE LOS_BASEADOS.material ADD CONSTRAINT FK_material_tipoMaterial FOREIGN KEY(idTipoMaterial) REFERENCES LOS_BASEADOS.tipo_material(idTipoMaterial);
GO

ALTER TABLE LOS_BASEADOS.modelo_sillon ADD CONSTRAINT PK_codigoModelo PRIMARY KEY(codigoModelo);
GO

ALTER TABLE LOS_BASEADOS.medidas ADD CONSTRAINT PK_idMedidas PRIMARY KEY(idMedidas);
GO

ALTER TABLE LOS_BASEADOS.sillon ADD CONSTRAINT PK_codigoSillon PRIMARY KEY(codigoSillon);
GO
ALTER TABLE LOS_BASEADOS.sillon ADD CONSTRAINT FK_sillon_modeloSillon FOREIGN KEY(codigoModelo) REFERENCES LOS_BASEADOS.modelo_sillon(codigoModelo);
GO
ALTER TABLE LOS_BASEADOS.sillon ADD CONSTRAINT FK_sillon_medidas FOREIGN KEY(idMedidas) REFERENCES LOS_BASEADOS.medidas(idMedidas);
GO

ALTER TABLE LOS_BASEADOS.material_x_sillon ADD CONSTRAINT FK_materialXSillon_sillon FOREIGN KEY(codigoSillon) REFERENCES LOS_BASEADOS.sillon(codigoSillon);
GO
ALTER TABLE LOS_BASEADOS.material_x_sillon ADD CONSTRAINT FK_materialXSillon_material FOREIGN KEY(idMaterial) REFERENCES LOS_BASEADOS.material(idMaterial);
GO

ALTER TABLE LOS_BASEADOS.cliente ADD CONSTRAINT PK_idCliente PRIMARY KEY(idCliente);
GO
ALTER TABLE LOS_BASEADOS.cliente ADD CONSTRAINT FK_cliente_localidad FOREIGN KEY(idLocalidad) REFERENCES LOS_BASEADOS.localidad(idLocalidad);
GO

ALTER TABLE LOS_BASEADOS.estado ADD CONSTRAINT PK_idEstado PRIMARY KEY(idEstado);
GO

ALTER TABLE LOS_BASEADOS.pedido ADD CONSTRAINT PK_numeroPedido PRIMARY KEY(numeroPedido);
GO
ALTER TABLE LOS_BASEADOS.pedido ADD CONSTRAINT FK_pedido_sucursal FOREIGN KEY(numeroSucursal) REFERENCES LOS_BASEADOS.sucursal(numeroSucursal);
GO
ALTER TABLE LOS_BASEADOS.pedido ADD CONSTRAINT FK_pedido_cliente FOREIGN KEY(idCliente) REFERENCES LOS_BASEADOS.cliente(idCliente);
GO
ALTER TABLE LOS_BASEADOS.pedido ADD CONSTRAINT FK_pedido_estado FOREIGN KEY(idEstado) REFERENCES LOS_BASEADOS.estado(idEstado);
GO

ALTER TABLE LOS_BASEADOS.cancelacion ADD CONSTRAINT PK_idCancelacion PRIMARY KEY(idCancelacion);
GO
ALTER TABLE LOS_BASEADOS.cancelacion ADD CONSTRAINT FK_cancelacion_pedido FOREIGN KEY(numeroPedido) REFERENCES LOS_BASEADOS.pedido(numeroPedido);
GO

ALTER TABLE LOS_BASEADOS.detalle_pedido ADD CONSTRAINT PK_idDetallePedido PRIMARY KEY(idDetallePedido);
GO
ALTER TABLE LOS_BASEADOS.detalle_pedido ADD CONSTRAINT FK_detallePedido_pedido FOREIGN KEY(numeroPedido) REFERENCES LOS_BASEADOS.pedido(numeroPedido);
GO
ALTER TABLE LOS_BASEADOS.detalle_pedido ADD CONSTRAINT FK_detallePedido_sillon FOREIGN KEY(codigoSillon) REFERENCES LOS_BASEADOS.sillon(codigoSillon);
GO

ALTER TABLE LOS_BASEADOS.factura ADD CONSTRAINT PK_numeroFactura PRIMARY KEY(numeroFactura);
GO
ALTER TABLE LOS_BASEADOS.factura ADD CONSTRAINT FK_factura_sucursal FOREIGN KEY(numeroSucursal) REFERENCES LOS_BASEADOS.sucursal(numeroSucursal);
GO
ALTER TABLE LOS_BASEADOS.factura ADD CONSTRAINT FK_factura_cliente FOREIGN KEY(idCliente) REFERENCES LOS_BASEADOS.cliente(idCliente);
GO

ALTER TABLE LOS_BASEADOS.detalle_factura ADD CONSTRAINT PK_idDetalleFactura PRIMARY KEY(idDetalleFactura);
GO
ALTER TABLE LOS_BASEADOS.detalle_factura ADD CONSTRAINT FK_detalleFactura_factura FOREIGN KEY(numeroFactura) REFERENCES LOS_BASEADOS.factura(numeroFactura);
GO
ALTER TABLE LOS_BASEADOS.detalle_factura ADD CONSTRAINT FK_detalleFactura_detallePedido FOREIGN KEY(idDetallePedido) REFERENCES LOS_BASEADOS.detalle_pedido(idDetallePedido);
GO

ALTER TABLE LOS_BASEADOS.envio ADD CONSTRAINT PK_numeroEnvio PRIMARY KEY(numeroEnvio);
GO
ALTER TABLE LOS_BASEADOS.envio ADD CONSTRAINT FK_envio_factura FOREIGN KEY(numeroFactura) REFERENCES LOS_BASEADOS.factura(numeroFactura);
GO

-- CREACION DE PROCEDURES DE MIGRACION

/*
CREATE PROC LOS_BASEADOS.migrar_tipo_medio_pago AS
BEGIN
    INSERT INTO LOS_BASEADOS.idCliente (Cliente_apellido)
    SELECT DISTINCT Maestra.Cliente_Apellido 
    FROM Maestra 
    WHERE Maestra.Cliente_Apellido IS NOT NULL;
END
GO
*/

-- CREACION DE INDICES

/*
CREATE INDEX idx ON LOS_BASEADOS.tabla (idCliente);
*/

-- EJECUCION DE PROCEDURES

/*
EXEC LOS_PEORES.migrar_tipo_medio_pago;
*/