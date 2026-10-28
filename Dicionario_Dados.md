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
