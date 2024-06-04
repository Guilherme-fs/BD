CREATE DATABASE ex05
GO
USE ex05
GO
CREATE TABLE fornecedor (
codigo			INT				NOT NULL,
nome			VARCHAR(50)		NOT NULL,
atividade		VARCHAR(80)		NOT NULL,
telefone		CHAR(8)			NOT NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE cliente (
codigo			INT				NOT NULL,
nome			VARCHAR(50)		NOT NULL,
logradouro		VARCHAR(80)		NOT NULL,
numero			INT				NOT NULL,
telefone		CHAR(8)			NOT NULL,
data_nasc		DATE			NOT NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE produto (
codigo			INT				NOT NULL,
nome			VARCHAR(50)		NOT NULL,
valor_unitario	DECIMAL(7,2)	NOT NULL,
qtd_estoque		INT				NOT NULL,
descricao		VARCHAR(80)		NOT NULL,
cod_forn		INT				NOT NULL
PRIMARY KEY(codigo)
FOREIGN KEY(cod_forn) REFERENCES fornecedor(codigo)
)
GO
CREATE TABLE pedido (
codigo			INT			NOT NULL,
cod_cli			INT			NOT NULL,
cod_prod		INT			NOT NULL,
quantidade		INT			NOT NULL,
previsao_ent	DATE		NOT NULL
PRIMARY KEY(codigo, cod_cli, cod_prod, previsao_ent)
FOREIGN KEY(cod_cli) REFERENCES cliente(codigo),
FOREIGN KEY(cod_prod) REFERENCES produto(codigo)
)
GO
INSERT INTO fornecedor VALUES (1001,'Estrela','Brinquedo','41525898')
INSERT INTO fornecedor VALUES (1002,'Lacta','Chocolate','42698596')
INSERT INTO fornecedor VALUES (1003,'Asus','Informática','52014596')
INSERT INTO fornecedor VALUES (1004,'Tramontina','Utensílios Domésticos','50563985')
INSERT INTO fornecedor VALUES (1005,'Grow','Brinquedos','47896325')
INSERT INTO fornecedor VALUES (1006,'Mattel','Bonecos','59865898')
INSERT INTO cliente VALUES (33601,'Maria Clara','R. 1° de Abril',870,'96325874','15/08/2000')
INSERT INTO cliente VALUES (33602,'Alberto Souza','R. XV de Novembro',987,'95873625','02/02/1985')
INSERT INTO cliente VALUES (33603,'Sonia Silva','R. Voluntários da Pátria',1151,'75418596','23/08/1957')
INSERT INTO cliente VALUES (33604,'José Sobrinho','Av. Paulista',250,'85236547','09/12/1986')
INSERT INTO cliente VALUES (33605,'Carlos Camargo','Av. Tiquatira',9652,'75896325','25/03/1971')
INSERT INTO produto VALUES (1,'Banco Imobiliário',65.00,15,'Versão Super Luxo',1001)
INSERT INTO produto VALUES (2,'Puzzle 5000 peças',50.00,5,'Mapas Mundo',1005)
INSERT INTO produto VALUES (3,'Faqueiro',350.00,0,'120 peças',1004)
INSERT INTO produto VALUES (4,'Jogo para churrasco',75.00,3,'7 peças',1004)
INSERT INTO produto VALUES (5,'Tablet',750.00,29,'Tablet',1003)
INSERT INTO produto VALUES (6,'Detetive',49.00,0,'Nova Versão do Jogo',1001)
INSERT INTO produto VALUES (7,'Chocolate com Paçoquinha',6.00,0,'Barra',1002)
INSERT INTO produto VALUES (8,'Galak',5.00,65,'Barra',1002)
INSERT INTO pedido VALUES (99001,33601,1,1,'07/03/2023')
INSERT INTO pedido VALUES (99001,33601,2,1,'07/03/2023')
INSERT INTO pedido VALUES (99001,33601,8,3,'07/03/2023')
INSERT INTO pedido VALUES (99002,33602,2,1,'09/03/2023')
INSERT INTO pedido VALUES (99002,33602,4,3,'09/03/2023')
INSERT INTO pedido VALUES (99003,33605,5,1,'15/03/2023')
GO
SELECT * FROM fornecedor
SELECT * FROM cliente
SELECT * FROM produto
SELECT * FROM pedido

--Exercicio 1
SELECT pedido.quantidade, produto.valor_unitario * pedido.quantidade as valor_total, (produto.valor_unitario * pedido.quantidade)*0.25 as total_com_desconto
FROM pedido
JOIN produto ON pedido.cod_prod = produto.codigo
JOIN cliente ON pedido.cod_cli = cliente.codigo
WHERE cliente.nome = 'Maria Clara'

--Exercício 2 (Arrumar depois)
SELECT produto.nome
FROM produto
LEFT JOIN fornecedor ON produto.cod_forn = fornecedor.codigo
WHERE qtd_estoque = 0 and fornecedor.atividade = 'Brinquedo' OR fornecedor.atividade = 'Brinquedos'

--Exercício 3
SELECT produto.nome, produto.descricao
FROM produto
LEFT JOIN pedido ON pedido.cod_prod = produto.codigo
WHERE pedido.cod_prod IS NULL

--Exercicio 4
UPDATE produto
SET qtd_estoque = 10
where nome = 'Faqueiro'

--Exercicio 5
SELECT COUNT(*) AS num_clients_over_40
FROM cliente
WHERE DATEDIFF(YEAR, data_nasc, GETDATE()) > 40

--Exercicio 6
SELECT nome, STUFF(telefone, 5, 8, '-')+STUFF(telefone, 1, 4, '') as telefone
FROM fornecedor
WHERE atividade = 'Chocolate' or atividade = 'Brinquedo' or atividade = 'Brinquedos'
