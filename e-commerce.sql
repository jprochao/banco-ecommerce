-- Banco de dados E-commerce (script DIO) 

create database ecommerce;

-- drop database ecommerce;

use ecommerce;

/*Create tables*/

-- desc clients;

-- Clients (clientes)
create table clients(
	idClient int auto_increment,
	fName varchar(10),
	Minit char(03),
	lName varchar(20),
	cpf char(11),
	Address varchar(255),
	primary key(idClient),
    constraint pk_client unique (cpf)
);

alter table clients auto_increment = 1;

-- Product (produto)
create table product(
	idProduct int auto_increment,
	pName varchar(255),
	classification_kids bool default false,
	category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
	avaliacao float default 0,
	size varchar(10),
	primary key(idProduct)
);

alter table product auto_increment = 1;

-- payment

create table payments(
	idPayment int auto_increment,
    idPClient int,
    typePayment enum('Boleto','Cartão','Dois cartões'),
    limitAvailable float,
    primary key(idPayment),
    constraint fk_payment_clients foreign key(idPclient) references clients(idClient)
);

alter table payments auto_increment = 1;

-- desc orders
-- Order (pedido)
create table orders(
	idOrder int auto_increment,
    idOrderClient int,
	orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
	orderDescription varchar(255),
	valueOrder float not null,
    paymentCash boolean default false,
    idPpayment int,
	primary key(idOrder),
	constraint fk_orders_client foreign key(idOrderClient) references clients(idClient),
    constraint fk_orders_payments foreign key(idPpayment) references payments(idPayment)
);

alter table orders auto_increment = 1;

-- delivery (entrega)
create table delivery(
	idDelivery int auto_increment,
    idOorder int,
    sendValue float default 10,
    status enum('Em separação','Enviado','Entregue') default 'Em separação',
    trackingNumber varchar(25),
    primary key(idDelivery),
    constraint fk_order_delivery_orders foreign key(idOorder) references orders(idOrder)
);

alter table delivery auto_increment = 1;

-- productStorage (estoque)
create table productStorage(
	idProductStorage int auto_increment,
    storageLocation varchar(255),
    quantity float default 0,
    primary key(idProductStorage)
);

alter table productStorage auto_increment = 1;

-- supplier (fornecedor)
create table supplier(
	idSupplier int auto_increment,
    socialName varchar(255), 
    CNPJ char(15),
    contact char(11) not null,
    primary key(idSupplier),
    constraint pk_supplier unique (CNPJ)
);

alter table supplier auto_increment = 1;

-- seller (vendedor)
create table seller(
	idSeller int auto_increment,
    socialName varchar(255) not null,
    abstName varchar(255),
    CNPJ char(15),
    CPF char(09),
    location varchar(255),
    contact char(11) not null,
    primary key(idSeller),
    constraint pk_saller unique(CNPJ,CPF)
);

alter table seller auto_increment = 1;
alter table seller modify cpf char(11);

-- productSeller (produto vendedor)
create table productSeller(
	idPseller int,
    idProduct int,
    prodQuantity float default 1,
    primary key(idPSeller,idProduct),
    constraint fk_productSeller foreign key(idPSeller) references seller(idSeller),
    constraint fk_product foreign key(idProduct) references product(idProduct)
);

-- productOrder (produtoPedido)
create table productOrder(
	idPOProduct int,
    idPOrder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key(idPOproduct,idPorder),
    constraint fk_product_seller foreign key (idPOProduct) references product(idProduct),
    constraint fk_product_product foreign key (idPOrder) references orders(idOrder)
);

-- storageLocation (Local Estoque)
create table storagelocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key(idLproduct,idLstorage),
    constraint fk_storage_location_product foreign key(idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key(idLstorage) references productStorage(idProductStorage)
);

-- productSupplier(produto fornecedor)
create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key(idPsSupplier,idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

show tables;