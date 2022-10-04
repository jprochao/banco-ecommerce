insert into clients (fname,minit,lname,cpf,address) values ('maria','m','silva', '11111111111','rua araguaia, 1339, xxe, sc'),
                                                           ('joão','pr','fulano','11111111112','rua sem nome, 171, ubatuba, sp'),
                                                           ('jorge','pr','souza','11111111113','rua sem nome, 172, pia, sp'),
                                                           ('paulo','pr','ramos','11111111114','rua sem nome, 173, xaxim, sc'),
                                                           ('jaime','pr','shiffer','11111111115','rua sem nome, 2371, boraceia, sp'),
                                                           ('marcelo','pr','veruta','11111111116','rua sem nome, 1441, santos, sp'),
                                                           ('carlos','pr','frus','11111111117','rua sem nome, 1712, mogi, sp'),
                                                           ('mara','ap','vrio','11111111118','rua sem nome, 1715, bora, sp'),
                                                           ('sopie','pr','verstapen','11111111119','rua sem nome, 2171, pinda, sp'),
                                                           ('manu','de','messi','11111111110','rua sem nome, 1971, mococa, sp');

-- select * from clients;

insert into payments (idPClient,typePayment,limitAvailable) values (9,'cartão',10000);
 -- select * from payments;



insert into product (pname,classification_kids,category,avaliacao,size) values ('fone de ouvido',false,'eletronico','4',null),
																			   ('barbie sereia',true,'brinquedos','3',null),
                                                                               ('carinho bebe',true,'brinquedos','3',null),
                                                                               ('fralda',true,'vestimenta','3',null),
                                                                               ('camiseta gg',false,'vestimenta','3',null),
                                                                               ('tv 65 polegadas',false,'eletrônico','3',null),
                                                                               ('mucilon',true,'alimentos','3',null),
                                                                               ('leite sem lactose',true,'alimentos','3',null),
                                                                               ('cerveja spaten',false,'alimentos','3',null);

-- select * from product;

insert into orders (idOrderClient,orderStatus,orderDescription,valueOrder,paymentCash,idPpayment) values (1,default,'marketplace',1000,true,null),
																									     (10,'confirmado','marketplace',100,true,null),
                                                                                                         (9,'cancelado','marketplace',1001,false,1),
                                                                                                         (5,default,'marketplace',5000,true,null),
                                                                                                         (3,default,'marketplace',2000,true,null),
                                                                                                         (7,default,'marketplace',3000,true,null);
                                                                                                         
-- select * from orders

insert into productorder (idPOproduct,idPOrder,poQuantity,poStatus) values (1,1,2,null),
                                                                           (2,1,1,null),
                                                                           (3,2,1,null);
 -- select * from productstorage;
 
insert into productStorage (storageLocation,quantity) values ('rj',1000),
                                                              ('rj',10000),
                                                              ('sp',10),
                                                              ('sc',100),
                                                              ('sc',60);
                                                                           
                                                                           
insert into storageLocation (idLproduct, idLstorage, location) values (1,2,'RJ'),
																	  (2,5,'GO'),
                                                                      (3,3,'SC');


insert into supplier (socialname,cnpj,contact) values ('Almeida e Filhos','99888777000123',4999955544),
                                                      ('Eletrixan','99888777000789',4999115544),
                                                      ('Farmaecia','99888777000111',4999951313),
                                                      ('Alimentare','99888777004274',4998951111);
                                                      
insert into productsupplier (idpssupplier,idpsproduct,quantity) values (1,1,500),
                                                                       (1,2,400),
                                                                       (2,4,633),
                                                                       (3,3,5),
                                                                       (2,5,10);
-- select * from seller;                                                                       
insert into seller (socialname,abstname,cnpj,cpf,location,contact) values ('Eletronica Avenida', null, '74154534000100',null,'RJ',4934330101), 
                                                                          ('Centro Comercial Brasil',null,null,'11111111199','SC',4934410024),
                                                                          ('Pedritra Moda Infantil',null,'7896098900208',null,'SP',4934310660);

-- select * from productseller;
                                                                          
insert into productSeller (idpseller,idproduct,prodquantity) values (7,6,80), (8,7,10);

select * from clients;

select * from product;

select * from orders;

select * from productorder;

select *  
from clients a, orders b, productorder c, product d
where a.idclient=b.idorderclient
  and b.idorder=c.idporder
  and c.idpoproduct=d.idproduct;
  
select * 
from clients a
left join orders b on a.idclient=b.idorderclient
left join productorder c on b.idorder=c.idporder
left join product d on c.idpoproduct=d.idproduct
left join payments e on a.idclient=e.idpclient;

select concat(fname, ' ', minit, ' ', lname) from clients;

select * from clients where idclient in (select idorderclient from orders);

select storageLocation, sum(quantity) from productstorage group by storageLocation;

select storageLocation, sum(quantity) from productstorage group by storageLocation having sum(quantity) >=100;

select * from orders order by 2,1;

select * from orders order by idOrderClient desc, idOrder;

-- considerando quem pagou em dinheiro tem um desconto de 10%

select concat(fname, ' ', minit, ' ', lname),
       sum(valueorder - (valueorder * 0.10))
from orders a
inner join clients b on a.idorderclient=b.idclient
where a.paymentcash = 1;