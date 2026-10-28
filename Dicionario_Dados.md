# Dicionário de Dados — Hortifruti União

## Entrega 2 — Modelagem de Banco de Dados

### 1. Apresentação

Este documento apresenta o dicionário de dados do banco `hortifruti_uniao_teste`, desenvolvido para o projeto acadêmico do Hortifruti União — Tatuapé.

O banco de dados foi implementado e verificado no MySQL 8.0, contendo 13 tabelas, 74 colunas, 13 chaves primárias e 17 chaves estrangeiras.

O principal objetivo da modelagem é apoiar o controle de validade e a rastreabilidade dos lotes de produtos (P1), permitindo o acompanhamento de recebimentos, estoque, vendas e perdas.

As descrições e os tipos de dados apresentados neste documento seguem a estrutura efetivamente verificada no MySQL.

### 2. Convenções utilizadas

- **PK (Primary Key):** chave primária que identifica cada registro.
- **FK (Foreign Key):** chave estrangeira que referencia outra tabela.
- **NULL:** indica se o campo pode ficar sem valor.
- **INT:** número inteiro.
- **VARCHAR(n):** texto com tamanho máximo definido.
- **DECIMAL(p,s):** número decimal com precisão e escala definidas.
- **DATE:** data.
- **DATETIME:** data e horário.

### 3. Estrutura das tabelas

#### 3.1 FORNECEDOR

**Finalidade:** armazenar os dados cadastrais dos fornecedores relacionados aos pedidos de compra.

| Coluna | Tipo de dado | Chave | Permite NULL | Descrição |
|---|---|---|---|---|
| `codigo_fornecedor` | INT | PK | Não | Identificador único do fornecedor. |
| `razao_social` | VARCHAR(150) | — | Sim | Razão social do fornecedor. |
| `cnpj` | VARCHAR(14) | — | Sim | CNPJ do fornecedor, armazenado sem pontuação. |
| `telefone` | VARCHAR(20) | — | Sim | Telefone de contato do fornecedor. |
| `email` | VARCHAR(150) | — | Sim | Endereço de e-mail do fornecedor. |

**Relacionamento:** um fornecedor pode estar associado a vários pedidos de compra por meio de `PEDIDO_COMPRA.codigo_fornecedor`.

**Restrições verificadas:** chave primária em `codigo_fornecedor`. Não há restrição `UNIQUE` adicional para CNPJ, e os campos cadastrais permitem `NULL`.

**Limitação:** a validação dos dígitos do CNPJ e a obrigatoriedade dos dados cadastrais, previstas na RN04, não são garantidas integralmente pelo banco atual.

#### 3.2 CATEGORIA_PRODUTO

**Finalidade:** armazenar as categorias utilizadas para classificar os produtos comercializados pelo Hortifruti União.

| Coluna | Tipo de dado | Chave | Permite NULL | Descrição |
|---|---|---|---|---|
| `codigo_categoria` | INT | PK | Não | Identificador único da categoria. |
| `nome_categoria` | VARCHAR(100) | — | Sim | Nome da categoria, como frutas, verduras ou laticínios. |

**Relacionamento:** uma categoria pode classificar vários produtos. A tabela PRODUTO possui a chave estrangeira `codigo_categoria`, que referencia `CATEGORIA_PRODUTO.codigo_categoria`.

**Restrições verificadas:** chave primária em `codigo_categoria`. O campo `nome_categoria` permite `NULL`.

**Limitação:** o banco atual permite cadastrar uma categoria sem nome. A obrigatoriedade do preenchimento não foi implementada por uma restrição `NOT NULL`.

#### 3.3 FUNCIONARIO

**Finalidade:** armazenar os dados cadastrais dos funcionários do Hortifruti União, permitindo identificar os responsáveis por vendas, cancelamentos e registros de perdas.

| Coluna | Tipo de dado | Chave | Permite NULL | Descrição |
|---|---|---|---|---|
| `codigo_funcionario` | INT | PK | Não | Identificador único do funcionário. |
| `cargo` | VARCHAR(80) | — | Sim | Cargo exercido pelo funcionário. |
| `data_admissao` | DATE | — | Sim | Data de admissão do funcionário. |
| `nome_funcionario` | VARCHAR(150) | — | Sim | Nome completo do funcionário. |

**Relacionamentos:** a tabela FUNCIONARIO é referenciada pelas tabelas VENDA e PERDA. Em VENDA, o campo `codigo_funcionario` identifica o funcionário responsável pela venda, enquanto `codigo_funcionario_cancelamento` identifica o responsável por seu eventual cancelamento. Em PERDA, o campo `codigo_funcionario` identifica quem registrou a perda.

#### 3.4 PRODUTO

**Finalidade:** armazenar os dados cadastrais dos produtos comercializados pelo Hortifruti União, incluindo informações de identificação, preço de venda, unidade de medida, estoque mínimo e categoria. O controle da validade e das quantidades disponíveis é realizado por meio da tabela LOTE.

| Coluna | Tipo de dado | Chave | Permite NULL | Descrição |
|---|---|---|---|---|
| `codigo_produto` | INT | PK | Não | Identificador único do produto. |
| `nome_produto` | VARCHAR(150) | — | Sim | Nome cadastral do produto. |
| `codigo_barras` | VARCHAR(30) | — | Sim | Código de barras utilizado para identificar o produto. |
| `descricao_gondola` | VARCHAR(150) | — | Sim | Descrição utilizada na identificação do produto na gôndola. |
| `descricao_reduzida` | VARCHAR(80) | — | Sim | Descrição resumida do produto. |
| `unidade_medida` | VARCHAR(10) | — | Sim | Unidade de comercialização, como unidade ou quilograma. |
| `preco_venda` | DECIMAL(12,2) | — | Sim | Preço de venda cadastrado para o produto. |
| `estoque_minimo` | DECIMAL(12,3) | — | Sim | Quantidade mínima de estoque definida para o produto. |
| `codigo_categoria` | INT | FK | Sim | Referência à categoria à qual o produto pertence. |

**Relacionamentos:** `codigo_categoria` referencia `CATEGORIA_PRODUTO.codigo_categoria`. A tabela PRODUTO também é referenciada por ITEM_PEDIDO_COMPRA, LOTE e ITEM_VENDA, permitindo relacionar os produtos aos pedidos, lotes recebidos e itens vendidos.

**Restrições verificadas:** chave primária em `codigo_produto` e chave estrangeira em `codigo_categoria`, com `ON DELETE RESTRICT`. Não existem restrições `UNIQUE` adicionais ou `CHECK` na tabela.

**Limitações:** o banco permite `NULL` nos campos cadastrais e em `codigo_categoria`, embora a RN16 estabeleça que todo produto deve pertencer a uma categoria. O campo `codigo_barras` não possui unicidade garant
**Restrições verificadas:** chave primária em `codigo_funcionario`. Os demais campos permitem `NULL`.

**Limitações:** o banco acadêmico permite cadastrar funcionários sem nome, cargo ou data de admissão. Não foram implementados campos de login, senha ou perfis de acesso, conforme a delimitação do escopo da Entrega 2.

#### 3.5 PEDIDO_COMPRA

**Finalidade:** armazenar os pedidos de compra realizados pelo Hortifruti União aos fornecedores cadastrados, registrando a data, a situação do pedido e o fornecedor responsável pelo fornecimento das mercadorias.

| Coluna | Tipo de dado | Chave | Permite NULL | Descrição |
|---|---|---|---|---|
| `codigo_pedido` | INT | PK | Não | Identificador único do pedido de compra. |
| `data_pedido` | DATE | — | Sim | Data em que o pedido de compra foi realizado. |
| `situacao_pedido` | VARCHAR(30) | — | Sim | Situação do pedido, como pendente, recebido ou cancelado. |
| `codigo_fornecedor` | INT | FK | Sim | Identificador do fornecedor ao qual o pedido está associado. |

**Relacionamentos:** `codigo_fornecedor` referencia `FORNECEDOR.codigo_fornecedor`. A tabela PEDIDO_COMPRA também é referenciada por ITEM_PEDIDO_COMPRA, que registra os produtos e quantidades solicitados, e por RECEBIMENTO, que registra as entradas de mercadorias vinculadas ao pedido.

**Restrições verificadas:** chave primária em `codigo_pedido` e chave estrangeira em `codigo_fornecedor`, com `ON DELETE RESTRICT`. Não existem restrições `UNIQUE` adicionais ou `CHECK` na tabela.

**Limitações:** o banco permite `NULL` nos campos `data_pedido`, `situacao_pedido` e `codigo_fornecedor`. Embora a RN03 determine que todo pedido pertença a um fornecedor cadastrado, a estrutura atual não impede pedidos com a referência ao fornecedor vazia. A obrigatoriedade de pelo menos um item por pedido, prevista na RN13, também não é garantida automaticamente apenas pelas chaves estrangeiras.

#### 3.6 ITEM_PEDIDO_COMPRA

**Finalidade:** armazenar os itens de cada pedido de compra do Hortifruti União, identificando os produtos solicitados, suas quantidades e os preços de compra praticados.

| Coluna | Tipo de dado | Chave | Permite NULL | Descrição |
|---|---|---|---|---|
| `codigo_item_pedido` | INT | PK | Não | Identificador único do item de pedido de compra. |
| `quantidade_solicitada` | DECIMAL(12,3) | — | Sim | Quantidade do produto solicitada ao fornecedor, permitindo valores fracionários para mercadorias comercializadas por peso. |
| `preco_compra` | DECIMAL(12,2) | — | Sim | Preço unitário de compra do produto solicitado. |
| `codigo_pedido` | INT | FK | Sim | Identificador do pedido de compra ao qual o item pertence. |
| `codigo_produto` | INT | FK | Sim | Identificador do produto solicitado. |

**Relacionamentos:**
- `codigo_pedido` referencia `PEDIDO_COMPRA.codigo_pedido`.
- `codigo_produto` referencia `PRODUTO.codigo_produto`.
- A tabela ITEM_PEDIDO_COMPRA também é referenciada por `LOTE.codigo_item_pedido`, permitindo identificar de qual item de compra cada lote recebido se originou.

**Restrições verificadas:** chave primária em `codigo_item_pedido` e duas chaves estrangeiras, ambas com `ON DELETE RESTRICT`. Não foram identificadas restrições `UNIQUE` adicionais ou `CHECK`.

**Limitações:** os campos `quantidade_solicitada`, `preco_compra`, `codigo_pedido` e `codigo_produto` permitem `NULL`. Portanto, o banco não impede automaticamente o cadastro de itens sem pedido, sem produto ou sem quantidade informada. Também não existem restrições `CHECK` para garantir quantidades e preços positivos. A obrigatoriedade prevista na RN13 não é integralmente garantida pela estrutura SQL atual.

#### 3.7 RECEBIMENTO

**Finalidade:** armazenar as informações dos recebimentos de mercadorias do Hortifruti União, incluindo a data de entrada, os dados da nota fiscal do fornecedor, a situação do recebimento e eventuais divergências identificadas durante a conferência.

| Coluna | Tipo de dado | Chave | Permite NULL | Descrição |
|---|---|---|---|---|
| `codigo_recebimento` | INT | PK | Não | Identificador único do recebimento. |
| `data_recebimento` | DATE | — | Sim | Data em que as mercadorias foram recebidas. |
| `numero_nota_fiscal` | VARCHAR(20) | — | Sim | Número da nota fiscal de entrada emitida pelo fornecedor. |
| `serie_nota_fiscal` | VARCHAR(10) | — | Sim | Série da nota fiscal de entrada. |
| `situacao_recebimento` | VARCHAR(30) | — | Sim | Situação do recebimento, como registrado, conferido ou concluído. |
| `observacao_divergencia` | VARCHAR(255) | — | Sim | Observações sobre diferenças identificadas na conferência das mercadorias. |
| `codigo_pedido` | INT | FK | Sim | Identificador do pedido de compra relacionado ao recebimento. |

**Relacionamentos:**
- `codigo_pedido` referencia `PEDIDO_COMPRA.codigo_pedido`.
- A tabela RECEBIMENTO é referenciada por `LOTE.codigo_recebimento`, permitindo identificar em qual recebimento cada lote foi registrado.

**Restrições verificadas:** chave primária em `codigo_recebimento` e chave estrangeira em `codigo_pedido`, com `ON DELETE RESTRICT`. Não foram identificadas restrições `UNIQUE` adicionais nem `CHECK`.

**Limitações:** os campos `data_recebimento`, `numero_nota_fiscal`, `serie_nota_fiscal`, `situacao_recebimento` e `codigo_pedido` permitem `NULL`. Portanto, embora a RN02 estabeleça a necessidade de nota fiscal e a vinculação dos recebimentos aos pedidos, o banco atual não impede automaticamente registros sem essas informações. O campo `observacao_divergencia` é opcional, pois nem todo recebimento apresenta divergências. A correspondência entre recebimento, item de compra e produto do lote depende das verificações adicionais descritas na RN22.

#### 3.8 LOTE

**Finalidade:** armazenar os lotes de mercadorias recebidas pelo Hortifruti União, permitindo identificar o produto, o recebimento de origem, o item do pedido de compra, a data de validade, o custo unitário e as quantidades recebidas e disponíveis. Essa tabela é central para o problema P1 — Controle de validade e rastreabilidade dos lotes.

| Coluna | Tipo de dado | Chave | Permite NULL | Descrição |
|---|---|---|---|---|
| `codigo_lote` | INT | PK | Não | Identificador único do registro de lote. |
| `quantidade_recebida` | DECIMAL(12,3) | — | Sim | Quantidade inicialmente recebida do lote. |
| `custo_unitario` | DECIMAL(12,2) | — | Sim | Custo unitário da mercadoria no lote, utilizado no cálculo financeiro das perdas. |
| `data_validade` | DATE | — | Sim | Data de vencimento dos produtos pertencentes ao lote. |
| `numero_lote` | VARCHAR(50) | — | Sim | Número ou identificação comercial do lote. |
| `quantidade_disponivel` | DECIMAL(12,3) | — | Sim | Saldo disponível do lote após movimentações de estoque. |
| `codigo_item_pedido` | INT | FK | Sim | Identifica o item de compra que originou o lote. |
| `codigo_recebimento` | INT | FK | Sim | Identifica o recebimento em que o lote foi registrado. |
| `codigo_produto` | INT | FK | Sim | Identifica o produto ao qual o lote pertence. |

**Relacionamentos:**
- `codigo_item_pedido` referencia `ITEM_PEDIDO_COMPRA.codigo_item_pedido`.
- `codigo_recebimento` referencia `RECEBIMENTO.codigo_recebimento`.
- `codigo_produto` referencia `PRODUTO.codigo_produto`.
- A tabela LOTE é referenciada por PERDA e SAIDA_LOTE, permitindo identificar perdas e quantidades retiradas de cada lote.

**Restrições verificadas:** chave primária em `codigo_lote` e três chaves estrangeiras, todas com `ON DELETE RESTRICT`. Não foram identificadas restrições `UNIQUE` adicionais ou `CHECK`.

**Limitações:** os campos de validade, quantidades, custo e referências permitem `NULL`. O banco não impede automaticamente o registro de um lote sem validade nem garante que a quantidade disponível nunca seja negativa. A estrutura também mantém `codigo_produto` e `codigo_item_pedido`, criando uma redundância potencial, pois o item de compra já identifica um produto.

Conforme a RN22, o produto do lote deve corresponder ao produto do item de compra, e o recebimento deve pertencer ao mesmo pedido de compra. Essas correspondências foram verificadas por consultas SQL de auditoria com dados fictícios, mas não são garantidas integralmente pelas chaves estrangeiras individuais.

A seleção automática de lotes pelo método FEFO e o bloqueio universal de movimentações com lotes vencidos não foram implementados integralmente nesta entrega acadêmica.

#### 3.9 PERDA

**Finalidade:** armazenar os registros de perdas de mercadorias do Hortifruti União, identificando o lote afetado, a quantidade perdida, a data, o motivo e o funcionário responsável. Essa tabela apoia o problema P1 — Controle de validade e rastreabilidade dos lotes.

| Coluna | Tipo de dado | Chave | Permite NULL | Descrição |
|---|---|---|---|---|
| `codigo_perda` | INT | PK | Não | Identificador único do registro de perda. |
| `data_perda` | DATE | — | Sim | Data em que a perda foi registrada. |
| `motivo_perda` | VARCHAR(100) | — | Sim | Motivo da perda, como vencimento, dano ou deterioração. |
| `quantidade_perdida` | DECIMAL(12,3) | — | Sim | Quantidade de mercadoria perdida. |
| `codigo_lote` | INT | FK | Sim | Identifica o lote ao qual a perda está associada. |
| `codigo_funcionario` | INT | FK | Sim | Identifica o funcionário responsável pelo registro da perda. |

**Relacionamentos:**
- `codigo_lote` referencia `LOTE.codigo_lote`.
- `codigo_funcionario` referencia `FUNCIONARIO.codigo_funcionario`.

**Restrições verificadas:** chave primária em `codigo_perda` e duas chaves estrangeiras, ambas com `ON DELETE RESTRICT`. Não foram identificadas restrições `UNIQUE` adicionais ou `CHECK`.

**Limitações:** os campos `data_perda`, `motivo_perda`, `quantidade_perdida`, `codigo_lote` e `codigo_funcionario` permitem `NULL`. Portanto, o banco não impede automaticamente registros de perda sem motivo, quantidade, lote ou funcionário. Também não existem restrições `CHECK` que garantam quantidades positivas.

A atualização do saldo disponível do lote após uma perda foi demonstrada por operações SQL com dados fictícios, mas não é realizada automaticamente em todas as situações. Essa limitação está relacionada às regras RN07, RN17 e RNF06.

**Relação com os indicadores:** os dados da tabela PERDA, associados ao custo unitário armazenado em LOTE, permitem calcular o valor financeiro das perdas por meio da consulta gerencial G03.

#### 3.10 VENDA

**Finalidade:** armazenar as informações das vendas realizadas pelo Hortifruti União, incluindo data e horário, valor total, situação da venda, funcionário responsável e dados relacionados a eventuais cancelamentos.

| Coluna | Tipo de dado | Chave | Permite NULL | Descrição |
|---|---|---|---|---|
| `codigo_venda` | INT | PK | Não | Identificador único da venda. |
| `data_hora_venda` | DATETIME | — | Sim | Data e horário em que a venda foi registrada. |
| `valor_total` | DECIMAL(12,2) | — | Sim | Valor total registrado para a venda. |
| `situacao_venda` | VARCHAR(30) | — | Sim | Situação da venda, como concluída ou cancelada. |
| `motivo_cancelamento` | VARCHAR(255) | — | Sim | Justificativa registrada quando ocorre o cancelamento da venda. |
| `data_hora_cancelamento` | DATETIME | — | Sim | Data e horário do cancelamento, quando aplicável. |
| `codigo_funcionario` | INT | FK | Sim | Identifica o funcionário responsável pelo registro da venda. |
| `codigo_funcionario_cancelamento` | INT | FK | Sim | Identifica o funcionário responsável pelo cancelamento, quando houver. |

**Relacionamentos:**
- `codigo_funcionario` referencia `FUNCIONARIO.codigo_funcionario`.
- `codigo_funcionario_cancelamento` também referencia `FUNCIONARIO.codigo_funcionario`.
- A tabela VENDA é referenciada por ITEM_VENDA, que armazena os produtos e as quantidades vendidos, e por PAGAMENTO, que registra os valores e as formas de pagamento.

**Restrições verificadas:** chave primária em `codigo_venda` e duas chaves estrangeiras, ambas com `ON DELETE RESTRICT`. Não foram identificadas restrições `UNIQUE` adicionais ou `CHECK`.

**Limitações:** os campos de data, valor, situação e funcionário responsável permitem `NULL`, embora uma venda concluída deva possuir essas informações. Os campos relacionados ao cancelamento também são opcionais, o que é adequado para vendas não canceladas; entretanto, o banco não exige automaticamente motivo, data e responsável quando a situação é alterada para cancelada.

A estrutura não possui campo para identificar o caixa físico, conforme a delimitação da RF08. A autorização de cancelamentos por função e a devolução automática de produtos aos lotes de origem não foram implementadas integralmente.

**Relação com os indicadores:** VENDA, associada a PAGAMENTO, permite realizar consultas gerenciais de faturamento por período, conforme a consulta G05.
