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
    idMaterial INT NOT NULL,
    color NVARCHAR(255) NOT NULL,
    textura NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.madera(
    idMadera INT NOT NULL IDENTITY(1,1),
    idMaterial INT NOT NULL,
    color NVARCHAR(255) NOT NULL,
    dureza NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.relleno(
    idRelleno INT NOT NULL IDENTITY(1,1),
    idMaterial INT NOT NULL,
    densidad NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.detalle_compra(
    idDetalleCompra BIGINT NOT NULL IDENTITY(1,1),
    numeroCompra DECIMAL(18,0) NOT NULL,
    idMaterial INT NOT NULL,
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
    precio DECIMAL(18,2) NOT NULL,
	modelo NVARCHAR(255) NOT NULL
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
	idFactura BIGINT NOT NULL IDENTITY(1,1),
    numeroFactura BIGINT NOT NULL,
    numeroSucursal BIGINT NOT NULL,
    idCliente BIGINT NOT NULL,
    fecha DATETIME2(6) NOT NULL,
    total DECIMAL(38,2) NOT NULL
);
GO

CREATE TABLE LOS_BASEADOS.detalle_factura(
    idDetalleFactura BIGINT NOT NULL IDENTITY(1,1),
    idFactura BIGINT NOT NULL,
    idDetallePedido BIGINT NOT NULL,
    precioUnitario DECIMAL(18,2) NOT NULL,
    cantidad DECIMAL(18,0) NOT NULL,
    subtotal DECIMAL(18,2) NOT NULL

);
GO

CREATE TABLE LOS_BASEADOS.envio(
    idEnvio BIGINT NOT NULL IDENTITY(1,1),
	numeroEnvio DECIMAL(18,0) NOT NULL,
    idFactura BIGINT NOT NULL,
    fechaProgramada DATETIME2(6) NOT NULL,
    fechaEntrega DATETIME2(6) NOT NULL,
    importeTraslado DECIMAL(18,2) NOT NULL,
    importeSubida DECIMAL(18,2) NOT NULL,
    total DECIMAL(18,2) NOT NULL
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

ALTER TABLE LOS_BASEADOS.material ADD CONSTRAINT PK_idMaterial PRIMARY KEY(idMaterial);
GO
ALTER TABLE LOS_BASEADOS.material ADD CONSTRAINT FK_material_tipoMaterial FOREIGN KEY(idTipoMaterial) REFERENCES LOS_BASEADOS.tipo_material(idTipoMaterial);
GO

ALTER TABLE LOS_BASEADOS.tela ADD CONSTRAINT PK_idTela PRIMARY KEY(idTela);
GO
ALTER TABLE LOS_BASEADOS.tela ADD CONSTRAINT FK_tela_material FOREIGN KEY(idMaterial) REFERENCES LOS_BASEADOS.material(idMaterial);
GO

ALTER TABLE LOS_BASEADOS.madera ADD CONSTRAINT PK_idMadera PRIMARY KEY(idMadera);
GO
ALTER TABLE LOS_BASEADOS.madera ADD CONSTRAINT FK_madera_material FOREIGN KEY(idMaterial) REFERENCES LOS_BASEADOS.material(idMaterial);
GO

ALTER TABLE LOS_BASEADOS.relleno ADD CONSTRAINT PK_idRelleno PRIMARY KEY(idRelleno);
GO
ALTER TABLE LOS_BASEADOS.relleno ADD CONSTRAINT FK_relleno_material FOREIGN KEY(idMaterial) REFERENCES LOS_BASEADOS.material(idMaterial);
GO

ALTER TABLE LOS_BASEADOS.detalle_compra ADD CONSTRAINT PK_idDetalleCompra PRIMARY KEY(idDetalleCompra);
GO
ALTER TABLE LOS_BASEADOS.detalle_compra ADD CONSTRAINT FK_detalleCompra_compra FOREIGN KEY(numeroCompra) REFERENCES LOS_BASEADOS.compra(numeroCompra);
GO
ALTER TABLE LOS_BASEADOS.detalle_compra ADD CONSTRAINT FK_detalleCompra_material FOREIGN KEY(idMaterial) REFERENCES LOS_BASEADOS.material(idMaterial);
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

ALTER TABLE LOS_BASEADOS.factura ADD CONSTRAINT PK_idFactura PRIMARY KEY(idFactura);
GO
ALTER TABLE LOS_BASEADOS.factura ADD CONSTRAINT FK_factura_sucursal FOREIGN KEY(numeroSucursal) REFERENCES LOS_BASEADOS.sucursal(numeroSucursal);
GO
ALTER TABLE LOS_BASEADOS.factura ADD CONSTRAINT FK_factura_cliente FOREIGN KEY(idCliente) REFERENCES LOS_BASEADOS.cliente(idCliente);
GO

ALTER TABLE LOS_BASEADOS.detalle_factura ADD CONSTRAINT PK_idDetalleFactura PRIMARY KEY(idDetalleFactura);
GO
ALTER TABLE LOS_BASEADOS.detalle_factura ADD CONSTRAINT FK_detalleFactura_factura FOREIGN KEY(idFactura) REFERENCES LOS_BASEADOS.factura(idFactura);
GO
ALTER TABLE LOS_BASEADOS.detalle_factura ADD CONSTRAINT FK_detalleFactura_detallePedido FOREIGN KEY(idDetallePedido) REFERENCES LOS_BASEADOS.detalle_pedido(idDetallePedido);
GO

ALTER TABLE LOS_BASEADOS.envio ADD CONSTRAINT PK_idEnvio PRIMARY KEY(idEnvio);
GO
ALTER TABLE LOS_BASEADOS.envio ADD CONSTRAINT FK_envio_factura FOREIGN KEY(idFactura) REFERENCES LOS_BASEADOS.factura(idFactura);
GO

-- CREACION DE PROCEDURES DE MIGRACION


CREATE PROC LOS_BASEADOS.migrar_estados AS
BEGIN
    INSERT INTO LOS_BASEADOS.estado (estado)
    SELECT DISTINCT Maestra.Pedido_Estado 
    FROM Maestra 
    WHERE Maestra.Pedido_Estado IS NOT NULL;
END
GO


CREATE PROC LOS_BASEADOS.migrar_provincias AS
BEGIN
    INSERT INTO LOS_BASEADOS.provincia (provincia)
    SELECT DISTINCT Maestra.Cliente_Provincia 
    FROM Maestra 
    WHERE Maestra.Cliente_Provincia IS NOT NULL
    UNION
    SELECT DISTINCT Maestra.Sucursal_provincia
    FROM Maestra 
    WHERE Maestra.Sucursal_provincia IS NOT NULL
    UNION
    SELECT DISTINCT Maestra.Proveedor_provincia 
    FROM Maestra 
    WHERE Maestra.Proveedor_provincia IS NOT NULL;
END
GO

CREATE PROC LOS_BASEADOS.migrar_localidades AS
BEGIN
    INSERT INTO LOS_BASEADOS.localidad (localidad, idProvincia)
    SELECT DISTINCT m.Cliente_Localidad localidad, p.idProvincia
    FROM Maestra m JOIN LOS_BASEADOS.provincia p ON m.Cliente_Provincia = p.provincia
    WHERE m.Cliente_Localidad IS NOT NULL
    UNION
    SELECT DISTINCT m.Proveedor_Localidad localidad, p.idProvincia
    FROM Maestra m JOIN LOS_BASEADOS.provincia p ON m.Proveedor_provincia = p.provincia
    WHERE m.Proveedor_Localidad IS NOT NULL
    UNION
    SELECT DISTINCT m.Sucursal_Localidad localidad, p.idProvincia
    FROM Maestra m JOIN LOS_BASEADOS.provincia p ON m.Sucursal_provincia = p.provincia
    WHERE m.Sucursal_Localidad IS NOT NULL
    ORDER BY localidad ASC
END
GO

CREATE PROC LOS_BASEADOS.migrar_sucursales AS
BEGIN
    INSERT INTO LOS_BASEADOS.sucursal (numeroSucursal, idLocalidad, direccion, telefono, mail)
    SELECT DISTINCT m.Sucursal_NroSucursal, l.idLocalidad, m.Sucursal_Direccion, m.Sucursal_telefono, m.Sucursal_mail
    FROM Maestra m JOIN LOS_BASEADOS.provincia p ON m.Sucursal_Provincia = p.provincia
                    JOIN LOS_BASEADOS.localidad l ON m.Sucursal_Localidad = l.localidad AND l.idProvincia = p.idProvincia
    WHERE m.Sucursal_NroSucursal IS NOT NULL
END
GO

CREATE PROC LOS_BASEADOS.migrar_proveedores AS
BEGIN
    INSERT INTO LOS_BASEADOS.proveedor (idLocalidad, razonSocial, direccion, telefono, mail, cuit)
    SELECT DISTINCT l.idLocalidad, m.Proveedor_RazonSocial, m.Proveedor_Direccion, m.Proveedor_Telefono, m.Proveedor_Mail, m.Proveedor_Cuit
    FROM Maestra m JOIN LOS_BASEADOS.provincia p ON m.Proveedor_Provincia = p.provincia
                    JOIN LOS_BASEADOS.localidad l ON m.Proveedor_Localidad = l.localidad AND l.idProvincia = p.idProvincia
    WHERE m.Proveedor_Cuit IS NOT NULL
END
GO

CREATE PROC LOS_BASEADOS.migrar_tipoMaterial AS
BEGIN
    INSERT INTO LOS_BASEADOS.tipo_material (tipo)
    SElECT DISTINCT Material_tipo 
    FROM Maestra 
    WHERE Material_tipo IS NOT NULL
END
GO

CREATE PROC LOS_BASEADOS.migrar_materiales AS
BEGIN
    INSERT INTO LOS_BASEADOS.material (idTipoMaterial, nombre, descripcion, precio)
    SELECT DISTINCT t.idTipoMaterial, m.Material_Nombre, m.Material_descripcion, m.Material_Precio
    FROM Maestra m JOIN LOS_BASEADOS.tipo_material t ON m.Material_Tipo = t.tipo
    WHERE Material_tipo IS NOT NULL
END
GO

CREATE PROC LOS_BASEADOS.migrar_telas AS
BEGIN
    INSERT INTO LOS_BASEADOS.tela (idMaterial, color, textura)
    SELECT DISTINCT t.idMaterial, m.Tela_Color, m.Tela_Textura
    FROM Maestra m JOIN LOS_BASEADOS.material t ON m.Material_Nombre = t.nombre AND m.Material_Descripcion = t.descripcion
    WHERE m.Tela_Color IS NOT NULL AND m.Tela_Textura IS NOT NULL
END
GO

CREATE PROC LOS_BASEADOS.migrar_maderas AS
BEGIN
    INSERT INTO LOS_BASEADOS.madera (idMaterial, color, dureza)
    SELECT DISTINCT t.idMaterial, m.Madera_Color, m.Madera_Dureza
    FROM Maestra m JOIN LOS_BASEADOS.material t ON m.Material_Nombre = t.nombre AND m.Material_Descripcion = t.descripcion
    WHERE m.Madera_Color IS NOT NULL AND m.Madera_Dureza IS NOT NULL
END
GO

CREATE PROC LOS_BASEADOS.migrar_rellenos AS
BEGIN
    INSERT INTO LOS_BASEADOS.relleno (idMaterial, densidad)
    SELECT DISTINCT t.idMaterial, m.Relleno_Densidad
    FROM Maestra m JOIN LOS_BASEADOS.material t ON m.Material_Nombre = t.nombre AND m.Material_Descripcion = t.descripcion
    WHERE m.Relleno_Densidad IS NOT NULL
END
GO

CREATE PROC LOS_BASEADOS.migrar_compras AS
BEGIN
    INSERT INTO LOS_BASEADOS.compra (numeroCompra, numeroSucursal, idProveedor, fecha, total)
    SELECT DISTINCT m.Compra_Numero, s.numeroSucursal, p.idProveedor, m.Compra_Fecha, m.Compra_Total
    FROM Maestra m JOIN LOS_BASEADOS.sucursal s ON m.Sucursal_NroSucursal = s.numeroSucursal
                    JOIN LOS_BASEADOS.proveedor p ON m.Proveedor_Cuit = p.cuit AND m.Proveedor_RazonSocial = p.razonSocial
    WHERE m.Compra_Numero IS NOT NULL AND m.Proveedor_Cuit IS NOT NULL AND m.Proveedor_RazonSocial IS NOT NULL
END
GO

CREATE PROC LOS_BASEADOS.migrar_detalleCompra AS
BEGIN
    INSERT INTO LOS_BASEADOS.detalle_compra (numeroCompra, idMaterial, precioUnitario, cantidad, subtotal)
    SELECT c.numeroCompra, mat.idMaterial, m.Detalle_Compra_Precio, m.Detalle_Compra_Cantidad, m.Detalle_Compra_SubTotal
    FROM Maestra m JOIN LOS_BASEADOS.compra c ON m.Compra_Numero = c.numeroCompra
                    JOIN LOS_BASEADOS.material mat ON m.Material_Nombre = mat.nombre AND m.Material_Descripcion = mat.descripcion
    WHERE m.Detalle_Compra_Cantidad IS NOT NULL AND m.Detalle_Compra_Precio IS NOT NULL AND m.Detalle_Compra_SubTotal IS NOT NULL 
        AND m.Compra_Numero IS NOT NULL
    ORDER BY c.numeroCompra ASC
END
GO

CREATE PROC LOS_BASEADOS.migrar_cliente AS
BEGIN
INSERT INTO LOS_BASEADOS.cliente (idLocalidad, dni , nombre, apellido, fechaNacimiento, telefono, mail, direccion)
SELECT distinct l.idLocalidad,m.Cliente_Dni,m.Cliente_Nombre,m.Cliente_Apellido,m.Cliente_FechaNacimiento,m.Cliente_Telefono,m.Cliente_Mail,m.Cliente_Direccion 
from Maestra m 
JOIN LOS_BASEADOS.provincia p on m.Cliente_Provincia=p.provincia
JOIN LOS_BASEADOS.localidad l on m.Cliente_Localidad = l.localidad AND l.idProvincia = p.idProvincia
WHERE m.Cliente_DNI IS NOT NULL AND m.Cliente_Nombre IS NOT NULL AND m.Cliente_Apellido IS NOT NULL 
AND m.Cliente_FechaNacimiento IS NOT NULL AND m.Cliente_Telefono IS NOT NULL and m.Cliente_Mail IS NOT NULL and m.Cliente_Direccion IS NOT NULL 
END
GO

CREATE PROC LOS_BASEADOS.migrar_factura AS
BEGIN
INSERT INTO LOS_BASEADOS.factura (numeroFactura,numeroSucursal,idCliente,fecha,total)
select distinct m.Factura_Numero, s.numeroSucursal, c.idCliente, m.Factura_Fecha, m.Factura_Total from maestra m 
join LOS_BASEADOS.sucursal s on m.Sucursal_NroSucursal = s.numeroSucursal
join LOS_BASEADOS.cliente c on m.Cliente_Dni = c.dni
WHERE m.Factura_Numero IS NOT NULL AND m.Factura_Fecha is not null and m.Factura_Total is not null and m.factura_numero<>33048604 order by Factura_Numero
END
GO

CREATE PROC LOS_BASEADOS.migrar_envio AS 
BEGIN
INSERT INTO LOS_BASEADOS.envio (numeroEnvio,idFactura,fechaProgramada,fechaEntrega,importeTraslado,importeSubida,total)
SELECT DISTINCT m.Envio_Numero,f.idFactura, m.Envio_Fecha_Programada, m.Envio_Fecha, m.Envio_ImporteTraslado, m.Envio_importeSubida, m.Envio_Total
from Maestra m join LOS_BASEADOS.factura f on f.numeroFactura = m.Factura_Numero
where  m.Envio_Fecha_Programada is not null and m.Envio_Fecha is not null and m.Envio_ImporteTraslado is not null and m.Envio_importesubida is not null and m.Envio_Total is not null
ORDER BY m.Envio_Numero
END
GO


--select distinct sillon_modelo,sillon_modelo_descripcion,Sillon_Modelo_Codigo from maestra

-- CREACION DE INDICES

/*
CREATE INDEX idx ON LOS_BASEADOS.tabla (idCliente);
*/

-- EJECUCION DE PROCEDURES

EXEC LOS_BASEADOS.migrar_estados

EXEC LOS_BASEADOS.migrar_provincias

EXEC LOS_BASEADOS.migrar_localidades

EXEC LOS_BASEADOS.migrar_sucursales

EXEC LOS_BASEADOS.migrar_proveedores

EXEC LOS_BASEADOS.migrar_tipoMaterial

EXEC LOS_BASEADOS.migrar_materiales

EXEC LOS_BASEADOS.migrar_telas

EXEC LOS_BASEADOS.migrar_maderas

EXEC LOS_BASEADOS.migrar_rellenos

EXEC LOS_BASEADOS.migrar_compras

EXEC LOS_BASEADOS.migrar_detalleCompra

EXEC LOS_BASEADOS.migrar_cliente

EXEC LOS_BASEADOS.migrar_factura

EXEC LOS_BASEADOS.migrar_envio
