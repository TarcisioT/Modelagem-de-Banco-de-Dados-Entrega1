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
