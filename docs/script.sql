-- ENTREGA 2 - HORTIFRUTI UNIAO
-- MySQL 8.0 | Script academico autocontido
-- ATENCAO: usa uma base de testes independente. Nao execute em producao.
-- A massa ficticia abaixo foi reconstruida para entrega: nao representa
-- necessariamente os mesmos valores dos testes manuais anteriores.

CREATE DATABASE IF NOT EXISTS hortifruti_uniao_entrega2
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE hortifruti_uniao_entrega2;

-- Permite reexecutar este script na base EXCLUSIVA de demonstracao.
DROP TABLE IF EXISTS saida_lote;
DROP TABLE IF EXISTS pagamento;
DROP TABLE IF EXISTS item_venda;
DROP TABLE IF EXISTS perda;
DROP TABLE IF EXISTS lote;
DROP TABLE IF EXISTS recebimento;
DROP TABLE IF EXISTS item_pedido_compra;
DROP TABLE IF EXISTS venda;
DROP TABLE IF EXISTS pedido_compra;
DROP TABLE IF EXISTS produto;
DROP TABLE IF EXISTS funcionario;
DROP TABLE IF EXISTS fornecedor;
DROP TABLE IF EXISTS categoria_produto;

CREATE TABLE categoria_produto (
 codigo_categoria INT NOT NULL,
 nome_categoria VARCHAR(100) DEFAULT NULL,
 PRIMARY KEY (codigo_categoria)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE fornecedor (
 codigo_fornecedor INT NOT NULL,
 razao_social VARCHAR(150) DEFAULT NULL,
 cnpj VARCHAR(14) DEFAULT NULL,
 telefone VARCHAR(20) DEFAULT NULL,
 email VARCHAR(150) DEFAULT NULL,
 PRIMARY KEY (codigo_fornecedor)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE funcionario (
 codigo_funcionario INT NOT NULL,
 cargo VARCHAR(80) DEFAULT NULL,
 data_admissao DATE DEFAULT NULL,
 nome_funcionario VARCHAR(150) DEFAULT NULL,
 PRIMARY KEY (codigo_funcionario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE produto (
 codigo_produto INT NOT NULL,
 nome_produto VARCHAR(150) DEFAULT NULL,
 codigo_barras VARCHAR(30) DEFAULT NULL,
 descricao_gondola VARCHAR(150) DEFAULT NULL,
 descricao_reduzida VARCHAR(80) DEFAULT NULL,
 unidade_medida VARCHAR(10) DEFAULT NULL,
 preco_venda DECIMAL(12,2) DEFAULT NULL,
 estoque_minimo DECIMAL(12,3) DEFAULT NULL,
 codigo_categoria INT DEFAULT NULL,
 PRIMARY KEY (codigo_produto),
 CONSTRAINT fk_produto_categoria FOREIGN KEY (codigo_categoria)
  REFERENCES categoria_produto(codigo_categoria) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE pedido_compra (
 codigo_pedido INT NOT NULL,
 data_pedido DATE DEFAULT NULL,
 situacao_pedido VARCHAR(30) DEFAULT NULL,
 codigo_fornecedor INT DEFAULT NULL,
 PRIMARY KEY (codigo_pedido),
 CONSTRAINT fk_pedido_fornecedor FOREIGN KEY (codigo_fornecedor)
  REFERENCES fornecedor(codigo_fornecedor) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE item_pedido_compra (
 codigo_item_pedido INT NOT NULL,
 quantidade_solicitada DECIMAL(12,3) DEFAULT NULL,
 preco_compra DECIMAL(12,2) DEFAULT NULL,
 codigo_pedido INT DEFAULT NULL,
 codigo_produto INT DEFAULT NULL,
 PRIMARY KEY (codigo_item_pedido),
 CONSTRAINT fk_item_pedido_pedido FOREIGN KEY (codigo_pedido)
  REFERENCES pedido_compra(codigo_pedido) ON DELETE RESTRICT,
 CONSTRAINT fk_item_pedido_produto FOREIGN KEY (codigo_produto)
  REFERENCES produto(codigo_produto) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE recebimento (
 codigo_recebimento INT NOT NULL,
 data_recebimento DATE DEFAULT NULL,
 numero_nota_fiscal VARCHAR(20) DEFAULT NULL,
 serie_nota_fiscal VARCHAR(10) DEFAULT NULL,
 situacao_recebimento VARCHAR(30) DEFAULT NULL,
 observacao_divergencia VARCHAR(255) DEFAULT NULL,
 codigo_pedido INT DEFAULT NULL,
 PRIMARY KEY (codigo_recebimento),
 CONSTRAINT fk_recebimento_pedido FOREIGN KEY (codigo_pedido)
  REFERENCES pedido_compra(codigo_pedido) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE lote (
 codigo_lote INT NOT NULL,
 quantidade_recebida DECIMAL(12,3) DEFAULT NULL,
 custo_unitario DECIMAL(12,2) DEFAULT NULL,
 data_validade DATE DEFAULT NULL,
 numero_lote VARCHAR(50) DEFAULT NULL,
 quantidade_disponivel DECIMAL(12,3) DEFAULT NULL,
 codigo_item_pedido INT DEFAULT NULL,
 codigo_recebimento INT DEFAULT NULL,
 codigo_produto INT DEFAULT NULL,
 PRIMARY KEY (codigo_lote),
 CONSTRAINT fk_lote_item_pedido FOREIGN KEY (codigo_item_pedido)
  REFERENCES item_pedido_compra(codigo_item_pedido) ON DELETE RESTRICT,
 CONSTRAINT fk_lote_recebimento FOREIGN KEY (codigo_recebimento)
  REFERENCES recebimento(codigo_recebimento) ON DELETE RESTRICT,
 CONSTRAINT fk_lote_produto FOREIGN KEY (codigo_produto)
  REFERENCES produto(codigo_produto) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE perda (
 codigo_perda INT NOT NULL,
 data_perda DATE DEFAULT NULL,
 motivo_perda VARCHAR(100) DEFAULT NULL,
 quantidade_perdida DECIMAL(12,3) DEFAULT NULL,
 codigo_lote INT DEFAULT NULL,
 codigo_funcionario INT DEFAULT NULL,
 PRIMARY KEY (codigo_perda),
 CONSTRAINT fk_perda_lote FOREIGN KEY (codigo_lote)
  REFERENCES lote(codigo_lote) ON DELETE RESTRICT,
 CONSTRAINT fk_perda_funcionario FOREIGN KEY (codigo_funcionario)
  REFERENCES funcionario(codigo_funcionario) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE venda (
 codigo_venda INT NOT NULL,
 data_hora_venda DATETIME DEFAULT NULL,
 valor_total DECIMAL(12,2) DEFAULT NULL,
 situacao_venda VARCHAR(30) DEFAULT NULL,
 motivo_cancelamento VARCHAR(255) DEFAULT NULL,
 data_hora_cancelamento DATETIME DEFAULT NULL,
 codigo_funcionario INT DEFAULT NULL,
 codigo_funcionario_cancelamento INT DEFAULT NULL,
 PRIMARY KEY (codigo_venda),
 CONSTRAINT fk_venda_funcionario FOREIGN KEY (codigo_funcionario)
  REFERENCES funcionario(codigo_funcionario) ON DELETE RESTRICT,
 CONSTRAINT fk_venda_funcionario_cancelamento FOREIGN KEY (codigo_funcionario_cancelamento)
  REFERENCES funcionario(codigo_funcionario) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE item_venda (
 codigo_item_venda INT NOT NULL,
 quantidade_vendida DECIMAL(12,3) DEFAULT NULL,
 preco_unitario_venda DECIMAL(12,2) DEFAULT NULL,
 subtotal DECIMAL(12,2) DEFAULT NULL,
 codigo_produto INT DEFAULT NULL,
 codigo_venda INT DEFAULT NULL,
 PRIMARY KEY (codigo_item_venda),
 CONSTRAINT fk_item_venda_produto FOREIGN KEY (codigo_produto)
  REFERENCES produto(codigo_produto) ON DELETE RESTRICT,
 CONSTRAINT fk_item_venda_venda FOREIGN KEY (codigo_venda)
  REFERENCES venda(codigo_venda) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE pagamento (
 codigo_pagamento INT NOT NULL,
 forma_pagamento VARCHAR(30) DEFAULT NULL,
 valor_pagamento DECIMAL(12,2) DEFAULT NULL,
 data_hora_pagamento DATETIME DEFAULT NULL,
 codigo_venda INT DEFAULT NULL,
 PRIMARY KEY (codigo_pagamento),
 CONSTRAINT fk_pagamento_venda FOREIGN KEY (codigo_venda)
  REFERENCES venda(codigo_venda) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE saida_lote (
 codigo_saida_lote INT NOT NULL,
 quantidade_retirada DECIMAL(12,3) DEFAULT NULL,
 codigo_lote INT DEFAULT NULL,
 codigo_item_venda INT DEFAULT NULL,
 PRIMARY KEY (codigo_saida_lote),
 CONSTRAINT fk_saida_lote_lote FOREIGN KEY (codigo_lote)
  REFERENCES lote(codigo_lote) ON DELETE RESTRICT,
 CONSTRAINT fk_saida_lote_item_venda FOREIGN KEY (codigo_item_venda)
  REFERENCES item_venda(codigo_item_venda) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- MASSA DE DADOS: 51 registros ficticios, referencia temporal 28/10/2026
INSERT INTO categoria_produto VALUES
 (1,'Frutas'),(2,'Verduras'),(3,'Mercearia'),(4,'Legumes');
INSERT INTO fornecedor VALUES
 (1,'Fornecedor Ficticio Frutas Ltda','10000000000001','11999990001','frutas@exemplo.invalid'),
 (2,'Distribuidora Ficticia Verde','10000000000002','11999990002','verde@exemplo.invalid'),
 (3,'Atacado Ficticio Mercearia','10000000000003','11999990003','atacado@exemplo.invalid'),
 (4,'Comercial Ficticia Legumes','10000000000004','11999990004','legumes@exemplo.invalid');
INSERT INTO funcionario VALUES
 (1,'Operador de caixa','2024-02-01','Funcionario Exemplo 1'),
 (2,'Estoquista','2023-03-02','Funcionario Exemplo 2'),
 (3,'Gerente','2022-04-03','Funcionario Exemplo 3'),
 (4,'Comprador','2024-05-04','Funcionario Exemplo 4'),
 (5,'Fiscal de caixa','2025-06-05','Funcionario Exemplo 5');
INSERT INTO produto VALUES
 (1,'Banana prata','7890000000001','Banana prata','BANANA PRATA','KG',7.99,20.000,1),
 (2,'Alface crespa','7890000000002','Alface crespa','ALFACE CRESPA','UN',3.50,10.000,2),
 (3,'Arroz 5 kg','7890000000003','Arroz branco 5 kg','ARROZ 5KG','UN',25.00,10.000,3),
 (4,'Tomate','7890000000004','Tomate kg','TOMATE','KG',8.50,15.000,4),
 (5,'Maca','7890000000005','Maca kg','MACA','KG',9.00,10.000,1),
 (6,'Cenoura','7890000000006','Cenoura kg','CENOURA','KG',5.20,10.000,4),
 (7,'Leite integral','7890000000007','Leite 1 litro','LEITE 1L','UN',6.00,10.000,3),
 (8,'Laranja','7890000000008','Laranja kg','LARANJA','KG',4.75,10.000,1);
INSERT INTO pedido_compra VALUES
 (1,'2026-10-20','Recebido',1), (2,'2026-10-21','Recebido',2),
 (3,'2026-10-22','Recebido',3), (4,'2026-10-27','Pendente',4);
INSERT INTO item_pedido_compra VALUES
 (1,100.000,4.00,1,1),(2,80.000,4.30,1,5),
 (3,40.000,1.50,2,2),(4,70.000,4.00,2,4),
 (5,5.000,17.00,3,3),(6,40.000,3.00,3,7),
 (7,30.000,2.50,4,6),(8,50.000,2.40,1,8);
INSERT INTO recebimento VALUES
 (1,'2026-10-23','NF-00001','1','Concluido',NULL,1),
 (2,'2026-10-24','NF-00002','1','Concluido',NULL,2),
 (3,'2026-10-25','NF-00003','1','Concluido',NULL,3);
INSERT INTO lote VALUES
 (1,40.000,4.00,'2026-10-30','BAN-001',38.000,1,1,1),
 (2,60.000,4.00,'2026-11-10','BAN-002',60.000,1,1,1),
 (3,40.000,2.00,'2026-10-25','ALF-001',30.000,3,2,2),
 (4,69.000,4.00,'2026-10-31','TOM-001',70.000,4,2,4),
 (5,5.000,17.00,'2027-05-01','ARR-001',5.000,5,3,3),
 (6,40.000,3.00,'2026-11-20','LEI-001',40.000,6,3,7),
 (7,80.000,4.30,'2026-10-29','MAC-001',80.000,2,1,5),
 (8,50.000,2.40,'2026-11-08','LAR-001',50.000,8,1,8);
INSERT INTO perda VALUES
 (1,'2026-10-27','Vencimento',10.000,3,2);
INSERT INTO venda VALUES
 (1,'2026-10-28 10:30:00',19.47,'Concluida',NULL,NULL,1,NULL);
INSERT INTO item_venda VALUES
 (1,2.000,7.99,15.98,1,1),
 (2,1.000,3.49,3.49,4,1);
INSERT INTO pagamento VALUES
 (1,'Debito',19.47,'2026-10-28 10:31:00',1);
INSERT INTO saida_lote VALUES
 (1,2.000,1,1),
 (2,1.000,4,2);
-- A venda ficticia usa lotes validos; o lote de alface vencido permanece
-- com saldo para demonstrar o indicador G02.

-- VERIFICACAO DE TABELAS, COLUNAS, CHAVES E MASSA
SELECT COUNT(*) AS quantidade_tabelas FROM information_schema.TABLES
 WHERE TABLE_SCHEMA=DATABASE() AND TABLE_TYPE='BASE TABLE';
SELECT COUNT(*) AS quantidade_colunas FROM information_schema.COLUMNS
 WHERE TABLE_SCHEMA=DATABASE();
SELECT COUNT(*) AS quantidade_fks FROM information_schema.REFERENTIAL_CONSTRAINTS
 WHERE CONSTRAINT_SCHEMA=DATABASE();
SELECT 'categoria_produto' AS tabela, COUNT(*) AS registros FROM categoria_produto
UNION ALL SELECT 'fornecedor',COUNT(*) FROM fornecedor
UNION ALL SELECT 'funcionario',COUNT(*) FROM funcionario
UNION ALL SELECT 'produto',COUNT(*) FROM produto
UNION ALL SELECT 'pedido_compra',COUNT(*) FROM pedido_compra
UNION ALL SELECT 'item_pedido_compra',COUNT(*) FROM item_pedido_compra
UNION ALL SELECT 'recebimento',COUNT(*) FROM recebimento
UNION ALL SELECT 'lote',COUNT(*) FROM lote
UNION ALL SELECT 'perda',COUNT(*) FROM perda
UNION ALL SELECT 'venda',COUNT(*) FROM venda
UNION ALL SELECT 'item_venda',COUNT(*) FROM item_venda
UNION ALL SELECT 'pagamento',COUNT(*) FROM pagamento
UNION ALL SELECT 'saida_lote',COUNT(*) FROM saida_lote;

-- CONSULTAS GERENCIAIS (G01-G05)
-- G01: validade nos proximos 7 dias; use data fixa para reproducibilidade.
SELECT l.codigo_lote, p.nome_produto, l.numero_lote, l.data_validade,
 l.quantidade_disponivel
FROM lote l JOIN produto p ON p.codigo_produto=l.codigo_produto
WHERE l.quantidade_disponivel>0
 AND l.data_validade BETWEEN DATE('2026-10-28') AND DATE_ADD(DATE('2026-10-28'),INTERVAL 7 DAY)
ORDER BY l.data_validade;

-- G02: lotes vencidos com saldo
SELECT l.codigo_lote,p.nome_produto,l.numero_lote,l.data_validade,l.quantidade_disponivel
FROM lote l JOIN produto p ON p.codigo_produto=l.codigo_produto
WHERE l.data_validade<DATE('2026-10-28') AND l.quantidade_disponivel>0
ORDER BY l.data_validade;

-- G03: perdas financeiras ao custo unitario do lote
SELECT p.nome_produto,pe.motivo_perda,pe.data_perda,pe.quantidade_perdida,
 l.custo_unitario,(pe.quantidade_perdida*l.custo_unitario) AS valor_perda
FROM perda pe JOIN lote l ON l.codigo_lote=pe.codigo_lote
JOIN produto p ON p.codigo_produto=l.codigo_produto;

-- G04: saldo de todos os lotes comparado ao estoque minimo
SELECT p.codigo_produto,p.nome_produto,p.estoque_minimo,
 COALESCE(SUM(l.quantidade_disponivel),0) AS estoque_disponivel
FROM produto p LEFT JOIN lote l ON l.codigo_produto=p.codigo_produto
GROUP BY p.codigo_produto,p.nome_produto,p.estoque_minimo
HAVING estoque_disponivel<p.estoque_minimo;

-- G05: faturamento por dia de vendas concluidas (pagamentos registrados)
SELECT DATE(v.data_hora_venda) AS dia, SUM(pg.valor_pagamento) AS faturamento
FROM venda v JOIN pagamento pg ON pg.codigo_venda=v.codigo_venda
WHERE v.situacao_venda='Concluida'
GROUP BY DATE(v.data_hora_venda)
ORDER BY dia;

-- AUDITORIAS (A01-A05): 0 linhas = nenhuma divergencia encontrada
-- A01: lotes sem produto existente (FK nao nula)
SELECT l.codigo_lote FROM lote l LEFT JOIN produto p ON p.codigo_produto=l.codigo_produto
WHERE l.codigo_produto IS NOT NULL AND p.codigo_produto IS NULL;

-- A02: divergencia entre produto/pedido do lote e o item/recebimento
SELECT l.codigo_lote FROM lote l
JOIN item_pedido_compra i ON i.codigo_item_pedido=l.codigo_item_pedido
JOIN recebimento r ON r.codigo_recebimento=l.codigo_recebimento
WHERE l.codigo_produto<>i.codigo_produto OR i.codigo_pedido<>r.codigo_pedido;

-- A03: saidas vinculadas a produtos diferentes do item vendido
SELECT s.codigo_saida_lote FROM saida_lote s
JOIN lote l ON l.codigo_lote=s.codigo_lote
JOIN item_venda iv ON iv.codigo_item_venda=s.codigo_item_venda
WHERE l.codigo_produto<>iv.codigo_produto;

-- A04: quantidade retirada divergente da vendida, por item
SELECT iv.codigo_item_venda,iv.quantidade_vendida,
 COALESCE(SUM(s.quantidade_retirada),0) AS retirada
FROM item_venda iv LEFT JOIN saida_lote s ON s.codigo_item_venda=iv.codigo_item_venda
GROUP BY iv.codigo_item_venda,iv.quantidade_vendida
HAVING retirada<>iv.quantidade_vendida;

-- Consulta complementar: data de validade na data da venda (esperado: 0 linhas)
SELECT s.codigo_saida_lote,l.numero_lote,l.data_validade,v.data_hora_venda
FROM saida_lote s
JOIN lote l ON l.codigo_lote=s.codigo_lote
JOIN item_venda iv ON iv.codigo_item_venda=s.codigo_item_venda
JOIN venda v ON v.codigo_venda=iv.codigo_venda
WHERE l.data_validade<DATE(v.data_hora_venda);

-- A05: teste de FK, com erro tratado (nao interrompe o script).
-- Deve retornar 'OK: chave estrangeira rejeitou funcionario inexistente'.
DELIMITER $$
DROP PROCEDURE IF EXISTS teste_fk_funcionario$$
CREATE PROCEDURE teste_fk_funcionario()
BEGIN
 DECLARE fk_rejeitada BOOLEAN DEFAULT FALSE;
 BEGIN
   DECLARE CONTINUE HANDLER FOR 1452 SET fk_rejeitada=TRUE;
   INSERT INTO venda(codigo_venda,codigo_funcionario)
   VALUES(9999,999999);
 END;
 IF fk_rejeitada THEN
   SELECT 'OK: chave estrangeira rejeitou funcionario inexistente' AS resultado_A05;
 ELSE
   DELETE FROM venda WHERE codigo_venda=9999;
   SELECT 'ATENCAO: teste de FK nao foi rejeitado' AS resultado_A05;
 END IF;
END$$
DELIMITER ;
CALL teste_fk_funcionario();
DROP PROCEDURE IF EXISTS teste_fk_funcionario;

-- Teste seguro de UPDATE e DELETE em transacao revertida.
START TRANSACTION;
UPDATE produto SET preco_venda=preco_venda+1 WHERE codigo_produto=1;
DELETE FROM pagamento WHERE codigo_pagamento=1;
ROLLBACK;
-- Nenhum registro e alterado permanentemente pela demonstracao acima.
