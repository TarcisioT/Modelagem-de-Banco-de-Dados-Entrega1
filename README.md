# Entrega 1 — Modelo Conceitual (DER)

### Nomes dos Integrantes:
- Tarcisio Santos (RGM 47913061)
- Gabriela Porfirio (RGM 48017698)
- Nicole Xavier (RGM 48329002)
- Henrique Moura (RGM 47610972)
- Henrico Saltanian (RGM 46981721)
### Modelagem de um sistema de gestão de informações para uma organização de médio porte


---

## 1. Caracterização da Organização

- **Nome e natureza da organização:** Hortifruti União - Tatuapé, empresa privada, com fins lucrativos do ramo de comércio varejista alimentício.
- **Contexto e porte:** empresa com fins lucrativos de médio porte, 110 funcionários, com um faturamento de 5 milhões/mês (aproximadamente).
- **Problemas e necessidades identificados:** o levantamento feito no Hortifruti União, notamos um problema com o controle de validade dos produtos. Como o mercado trabalha com muita quantidade e variedade de mercadorias, acompanhar as datas de vencimento acaba sendo complicado. Por isso, itens perto de vencer ou já vencidos podem ficar nas prateleiras mais tempo do que deveriam, o que gera perdas e exige mais atenção dos funcionários na hora de conferir. Com base nisso, vimos a necessidade de um sistema para registrar e acompanhar as datas de validade dos produtos. Assim, dá para consultar quais estão perto de vencer, o que ajuda a retirar ou dar prioridade a esses itens e contribui para reduzir as perdas.*
- **Justificativa da escolha:** escolhemos essa organização porque um dos integrantes do grupo tem contato com um dos responsáveis pelo estabelecimento, o que abriu caminho para acessar o local e fazer a pesquisa de campo. O Hortifruti União também tem processos que interessam à disciplina de Modelagem de Banco de Dados, como controle de estoque, acompanhamento da validade dos produtos, compras de fornecedores e registro de vendas. Esses processos oferecem dados e regras de negócio suficientes para montar um modelo conceitual consistente.
- **Evidências da organização:**  https://www.google.com/maps/@-23.5357427,-46.5791203,747a,86.7y,87.54h,101.01t/data=!3m7!1e1!3m5!1swJUlDJQ1_PRKkzMQx4lZhg!2e0!6shttps:%2F%2Fstreetviewpixels-pa.googleapis.com%2Fv1%2Fthumbnail%3Fcb_client%3Dmaps_sv.tactile%26w%3D900%26h%3D600%26pitch%3D-11.012688400441263%26panoid%3DwJUlDJQ1_PRKkzMQx4lZhg%26yaw%3D87.54143764466257!7i16384!8i8192?entry=ttu&g_ep=EgoyMDI2MDkwNi4wIKXMDSoASAFQAw%3D%3D (Google Maps)
- Endereço: Rua Filipe Camarão, 67 Tatuapé, São Paulo.
- Número de contato: (11)99317-0906
- Nome do responsável/entrevistado: Guilherme Takemoto

- Fachada do mercado: <img width="1600" height="1200" alt="fachada_mercado" src="https://github.com/user-attachments/assets/96ddf354-d13e-41de-be66-00efc5e769c5" />

- Interior do mercado: <img width="1600" height="1200" alt="interior_mercado" src="https://github.com/user-attachments/assets/b969924b-67c7-4e15-8554-971d6f0eec40" />

- Estoque do mercado: <img width="1600" height="1200" alt="estoque_mercado" src="https://github.com/user-attachments/assets/b0589bb0-c2bd-4588-b628-0f5c1cb43df1" />



---

## 2. Processos de Negócio


- **Principais processos mapeados:** Controle de estoque e vendas
  
- **Fluxogramas:**
  - (fluxograma vendas)
  <img width="565" height="857" alt="fluxograma venda" src="https://github.com/user-attachments/assets/df8b9e98-4f99-426c-a255-53805583e70a" />





  - (fluxograma estoque)
  <img width="454" height="885" alt="fluxograma estoque" src="https://github.com/user-attachments/assets/ae68a1f7-b61f-4a3c-a188-dd305fa9f004" />



---

## 3. Requisitos do Sistema


### 3.1 Requisitos Funcionais
- O sistema deve permitir o cadastro de produtos com código único, nome, data de validade, categoria e descrição. A data de validade não pode ser retroativa, a categoria deve vir de lista pré-cadastrada, e o sistema deve impedir código duplicado ou produto sem categoria, permitindo ainda edição e inativação de cadastros.
  
- O sistema deve atualizar automaticamente a quantidade em estoque de cada produto após a conclusão de uma venda no caixa, dando baixa nas quantidades vendidas. A atualização deve ocorrer em tempo real, refletindo imediatamente nas consultas de estoque.
  
- O sistema deve permitir consultar a quantidade disponível de um produto em estoque, a partir do código ou nome do produto. A consulta deve exibir a quantidade atual e indicar quando o estoque estiver abaixo de um limite mínimo pré-definido.
  
- O sistema deve permitir o cadastro de fornecedores, identificados obrigatoriamente por CNPJ. O CNPJ deve ser único (sem duplicidade) e ter seus dígitos validados no momento do cadastro.
  
- O sistema deve permitir associar um ou mais produtos a um ou mais fornecedores que os fornecem. Um produto pode ter mais de um fornecedor, e um fornecedor pode fornecer mais de um produto.
  
- O sistema deve permitir registrar pedidos de compra feitos a um fornecedor, contendo fornecedor, produto, quantidade e data/hora do pedido.
  
- O sistema deve permitir registrar uma venda contendo um ou mais produtos, com suas respectivas quantidades. Cada produto vendido deve ter estoque suficiente disponível no momento do registro, com baixa automática no estoque.
  
- O sistema deve gerar automaticamente o valor total da venda, somando o valor de cada produto pela quantidade vendida. O valor total deve ser recalculado sempre que houver alteração nos itens da venda.
  
- O sistema deve permitir cancelar uma venda já registrada, devolvendo os itens vendidos ao estoque.
  
- O sistema deve permitir consultar os lotes vencidos e os lotes próximos do vencimento, apresentando o produto, o número do lote, a quantidade disponível e a data de validade.

- O sistema deve emitir um alerta quando um lote estiver próximo da data de vencimento, considerando um período previamente definido pela organização.

- O sistema deve impedir a venda de produtos pertencentes a lotes vencidos.

- O sistema deve priorizar, durante a baixa do estoque, os lotes válidos com a data de vencimento mais próxima.

### 3.2 Requisitos Não Funcionais

- Desempenho: o sistema deve suportar pelo menos 10 caixas operando simultaneamente, mantendo o tempo de resposta de consultas e registro de vendas inferior a 3 segundos em situações normais de venda.
  
- Disponibilidade: o sistema deve estar disponínvel durante todo o horário de funcionamento da loja, em caso de queda de internet, o sistema deve continuar permitindo as vendas, sincronizando tudo quando voltar.
  
- Segurança: o sistema deve exigir login e senha para acesso às funcionalidades, permitindo que apenas usuários autorizados realizem tarefas de acordo com o nível de acesso.
  
- Usabilidade: a interface do sistema do caixa deve manter uma navegação simples e objetiva, permitindo que funcionários novatos aprendam a utilizar apenas com treinamento básico sem necessidade de conhecimentos técnicos avançados

- Recuperação de dados: o sistema deve realizar cópias de segurança periódicas para permitir a recuperação das informações em caso de falha ou perda de dados.
  
---

## 4. Regras de Negócio

- **Regras operacionais:**
- Um produto não pode ser vendido após sua data de validade. O sistema deve impedir o registro da venda caso a data de validade do produto seja anterior à data atual, bloqueando o item ou a venda até que ele seja removido do estoque.
  
- A entrada de estoque só pode ser registrada mediante nota fiscal do fornecedor. O sistema deve exigir a informação da nota fiscal correspondente para validar e concluir o registro de entrada, não sendo permitida a atualização do estoque sem essa comprovação.
  
- Um pedido de compra só pode ser realizado para um fornecedor previamente cadastrado no sistema. Não é permitido registrar pedidos de compra para fornecedores inexistentes ou não cadastrados.
  
- Um fornecedor só pode ser cadastrado mediante CNPJ válido e preenchimento completo dos dados obrigatórios. O sistema deve validar o formato/dígitos verificadores do CNPJ e impedir o cadastro caso haja campos obrigatórios em branco.
  
- Uma venda cancelada deve devolver automaticamente os itens vendidos ao estoque. A devolução deve ocorrer no momento do cancelamento, restabelecendo as quantidades correspondentes sem necessidade de ação manual do usuário.
  
- **Restrições organizacionais:**
- Emissão Obrigatória de Nota Fiscal: O sistema deve garantir a emissão de nota fiscal para toda venda realizada, em atendimento à exigência tributária vigente. Vendas não podem ser finalizadas sem a respectiva emissão fiscal.
  
- Controle de Validade de Produtos Perecíveis: Produtos perecíveis devem ter sua data de validade mantida em dia e monitorada pelo sistema, em atendimento às exigências da vigilância sanitária. Produtos vencidos não podem permanecer disponíveis para venda.
---

## 5. Dicionário de Dados Conceitual
### Modelo conceitual 
Este modelo representa um mercado no qual cada produto é fornecido por um fornecedor 
e cadastrado por categoria. Quando necessário e solicitado, os produtos são comprados 
via pedido de compra e vendidos aos clientes por meio de vendas registradas pelos 
funcionários.

| Entidade | Relaciona-se com | Cardinalidade |
|----------|------------------|---------------|
| FORNECEDOR | PEDIDO_COMPRA | 1:N - Um forncedor recebe vários pedidos. |
| PEDIDO_COMPRA | PRODUTO | N:N - Vários pedidos cadastram vários produtos. |
| PRODUTO | CATEGORIA_PRODUTO | 1:N - Vários produtos são cadastrados em uma categoria. |
| VENDA | PRODUTO | 1:1 - Uma venda contém vários produtos. |
| CLIENTE | VENDA | 1:1 - Um cliente realiza várias vendas. |
| FUNCIONARIO | VENDA | 1:N - Um funcionario registra várias vendas. |

###  Fluxo de dados (visão de DFD)
O mercado solicita o PEDIDO_COMPRA para o FORNECEDOR que fornece os 
produtos → o PEDIDO_COMPRA é cadastrado no PRODUTO que armazena a 
quantidade e o preço de custo dos produtos → o PRODUTO é cadastrado e 
classificado na CATEGORIA_PRODUTO → o CLIENTE chega ao mercado e realiza a 
compra que gera uma VENDA → a VENDA feita pelo CLIENTE é registrada pelo 
FUNCIONARIO → o CLIENTE finaliza a sua compra.

### Convenções do dicionário
SGBD: MySQL 8, mecanismo de armazenamento InnoDB — cuida da persistência dos 
arquivos de dados, do log de transações (redo/undo) e mantém o índice primário 
clusterizado por chave.  
Codificação de caracteres: utf8mb4 com collation utf8mb4_0900_ai_ci. Escolhida em vez de 
latin1 por cobrir acentuação do português sem perda em campos de nome e texto livre, e 
por ser compatível com qualquer caractere Unicode que apareça em observações 
clínicas.  
Notação formal (símbolos usados neste dicionário):

| Símbolo | Significado |
|---------|-------------|
| = | é composto de |
| + | e (conecta elementos obrigatórios) |
| () | opcional |
| { }, n{ }m | iteração, com limite mínimo n e máximo m |  
| [ \ ]  | escolha obrigatória entre alternativas | 
| // | rótulo de um grupo repetitivo |  
| @ | identificador (chave primária) |  
| ** | comentário, fora da estrutura formal | 

Prefixos: NM_ nome, DT_ data, ID_ identificador (não sofre operação matemática), CD_ 
código de domínio, QT_ quantidade, TP_ tipo (categorização), IN_ indicador booleano. 
Este caso também usa DS_ (descrição/texto livre) — não está entre os sete prefixos
padrão, mas segue o mesmo princípio e já aparece no estudo de caso de referência 
(DS_OBSERVACAO).

### FORNECEDOR
FORNECEDOR = @ID_FORNECEDOR + NM_FORNECEDOR + CNPJ + TELEFONE + RAZAO_SOCIAL + ENDERECO

| Atributo | Tipo físico | Obrigatório | Significado e relevância |
|----------|-------------|-------------|--------------------------|
| ID_FORNECEDOR | integer | Sim (PK) | Código de localização do registro; não sofre operação matemática. |
| NM_FORNECEDOR | varchar(120) | Sim | Nome fantasia pelo qual o fornecedor é conhecido comercialmente. |
| CNPJ | integer | Sim | Número de identificação da pessoa jurídica do fornecedor perante a Receita Federal. |
| RAZAO_SOCIAL | varchar(120) | Sim | Nome oficial da empresa fornecedora, conforme registrado legalmente. |
| TELEFONE | integer | Sim | Número de contato do fornecedor.
| ENDERECO | varchar(120) | Sim | Localização física do fornecedor (composto por Rua, Número, Bairro, Cidade, Estado). |

### PEDIDO_COMPRA  
PEDIDO_COMPRA = @ID_PEDIDO_COMPRA + ID_FORNECEDOR + DT_HORA

| Atributo | Tipo físico | Obrigatório | Significado e relevância |
|----------|-------------|-------------|--------------------------|
| ID_ PEDIDO  | integer | Sim (PK) | Identificador único do pedido de compra realizado junto ao fornecedor. |
| ID_FORNCEDOR | integer | Sim (FK, único) | Referência ao fornecedor responsável por atender o pedido de compra. |
| DT_HORA | datetime | Sim | Data e o horário em que o pedido de compra foi realizado. |

### PRODUTO
PRODUTO = @ID_PRODUTO + ID_CATEGORIA + NM_PRODUTO + DS_GONDOLA + DS_REDUZIDA + CD_BARRAS

| Atributo | Tipo físico | Obrigatório | Significado e relevância |
|----------|-------------|-------------|--------------------------|
| ID_PRODUTO | integer | Sim (PK) | Identificador do produto. |
| ID_CATEGORIA | integer | Sim (FK) | Referência à categoria de qual produto pertence. |
| NM_PRODUTO | varchar(120) | Sim | Nome completo/comercial do produto. |
| DS_GONDOLA | varchar(120) | Sim | Descrição resumida do produto exibido na etiqueta de prateleira. |
| DS_REDUZIDA | varchar(120) | Sim | Descrição do produto utilizado na emissão de nota fiscal. |
| CD_BARRAS | integer | Sim (único) | Código numérico (EAN/GTIN) atribuído pelo fabricante, utilizado para leitura na caixa e identificação universal do produto. |

###  CATEGORIA_PRODUTO  
CATEGORIA_PRODUTO = @ID_CATEGORIA_PRODUTO + NM_CATEGORIA

| Atributo | Tipo físico | Obrigatório | Significado e relevância |
|----------|-------------|-------------|--------------------------|
| ID_CATEGORIA  | integer | Sim (PK) | Identificador único da categoria de produto cadastrado no sistema. |
| NM_CATEGORIA | varchar(120) | Sim | Nome que identifica a categoria a qual produto pertence (ex: Hortifruti, Laticínios, Bebidas). |

### VENDA
VENDA = @ID_VENDA + ID_FUNCIONARIO + ID_CLIENTE + DT_HORA + FORMA_PAGAMENTO

| Atributo | Tipo físico | Obrigatório | Significado e relevância |
|----------|-------------|-------------|--------------------------|
| ID_VENDA | integer | Sim (PK) | Identificador único da venda realizada. |
| ID_FUNCIONARIO | integer | Sim (FK) | Referência ao funcionário responsável por registrar a venda. |
| ID_CLIENTE | integer | Sim (FK) | Referência ao cliente que realizou a compra. |
| DT_HORA | datetime | Sim | Data e o horário em que a venda foi realizada. |
| FORMA_PAGAMENTO | varchar(60) | Sim | Forma de pagamento utilizada pelo cliente na compra. |

### FUNCIONARIO
FUNCIONARIO = @ID_FUNCIONARIO + NM_FUNCIONARIO + CPF + ENDERECO + FUNCAO + TELEFONE + DT_ADMISSAO

| Atributo | Tipo físico | Obrigatório | Significado e relevância |
|----------|-------------|-------------|--------------------------|
| ID_FUNCIONARIO | integer | Sim (PK) | Identificador único do funcionário cadastrado no sistema. |
| NM_FUNCIONARIO | varchar(120) | Sim | Nome completo do funcionário. |
| CPF | integer | Sim (único) | Documento de identificação civil do funcionário. |
| ENDERECO | varchar(120) | Sim | Localização de residência do funcionário (composto por Número, Rua, Bairro, Cidade, Estado). |
| FUNCAO | varchar(120) | Sim | Carga/atividade exercida pelo funcionário na empresa (ex: Caixa, Repositor, Gerente). |
| TELEFONE | integer | Sim | Número de contato do funcionário. |
| DT_ADMISSAO | date | Sim | Data em que o funcionário foi contratado pela empresa. |

### CLIENTE
CLIENTE = @ID_CLIENTE + NM_CLIENTE + CPF + TELEFONE

| Atributo | Tipo físico | Obrigatório | Significado e relevância |
|----------|-------------|-------------|--------------------------|
| ID_CLIENTE | integer | Sim (PK) | Identificador único do cliente cadastrado no sistema. |
| NM_CLIENTE | varchar(120) | Sim | Nome completo do cliente. |
| CPF | integer | Sim (único) | Documento de identificação civil do cliente. |
| TELEFONE | integer | Não | Número de contato do cliente. |

### Acesso por operação e conformidade com a LGPD 

| Tabela | LER | INSERIR | ATUALIZAR | APAGAR |
|--------|-----|---------|-----------|--------|
| FORNECEDOR | Administrativo/RH | Administrativo/RH | Administrativo/RH | Nenhum papel |
| PEDIDO_COMPRA | Administrativo/ RH, Funcionário | Administrativo, Funcionário | Administrativo, Funcionário | Nenhum Papel |
| PRODUTO | Administrativo, Funcionário | Administrativo, Funcionário | Funcionário | Nenhum papel |
| CATEGORIA_ PRODUTO | Administrativo, Funcionário | Administrativo, Funcionário| Funcionário | Nenhum papel |
| VENDA | Administrativo, Funcionário | Administrativo/RH, Funcionário | Funcionário | Nenhum papel
| CLIENTE | Administrativo/RH, Funcionário | Administrativo/RH, Funcionário | Funcionário | Nenhum papel
| FUNCIONARIO | Administrativo/RH | Administrativo/RH | Administrativo/RH | Administrativo/RH (desligamento)









---

## 6. Modelagem Conceitual (Entidades, Atributos, Relacionamentos)


- **Entidades reconhecidas:**
- Produto: Representa os produtos comercializados pelo mercado, sendo necessário para controlar informações como nome, categoria, código de barras e descrições de identificação (gôndola e nota fiscal).
- Categoria_Produto: Permite classificar os produtos em categorias, facilitando sua organização e identificação pelo tipo de produto
- Pedido_Compra: Representa os pedidos de produtos feitos aos fornecedores, permitindo controlar as compras realizadas pelo mercado.
- Fornecedor: Representa as empresas que fornecem produtos ao mercado, permitindo registrar e relacionar os fornecedores às compras realizadas.
- Funcionário: Representa os colaboradores do mercado responsáveis por registrar as vendas realizadas.
- Venda: Representa as vendas realizadas pelo mercado, permitindo registrar informações da transação e relacioná-la ao cliente, ao funcionário responsável e aos produtos vendidos.
- Cliente: Representa as pessoas que realizam compras no mercado, permitindo armazenar seus dados e relacioná-los às vendas realizadas.

  
  
- **Atributos e classificações:**

#### Fornecedor

- ID_Fornecedor - Chave primária
- Nome_Fornecedor, CNPJ, Razao_Social, Telefone - Simples
- Endereço - Composto (Rua, Número, Bairro, Cidade, Estado)

#### Pedido_Compra
  
- ID_Pedido - Chave primária
- ID_Fornecedor - Chave estrangeira
- Data, Hora - Simples

 #### Categoria_Produto
- ID_Categoria - Chave primária
- Nome_Categoria - Simples

 #### Produto
- ID_Produto - Chave primária
- ID_Categoria - Chave estrangeira
- Nome_Produto, Descricao_Gondola, Descricao_Reduzida, Codigo_Barras - Simples

 #### Venda
- ID_Venda - Chave primária
- ID_Cliente, ID_Funcionário - Chave estrangeira
- Data, Hora, Forma_Pagamento - Simples

 #### Cliente
- ID_Cliente - Chave primária
- Nome_Cliente, CPF, Telefone - Simples

 #### Funcionario
- ID_Funcionario - Chave primária
- Nome_Funcionario, CPF, Função, Telefone, Data_Admissao - simples
- Endereço - Composto (Rua, Número, Bairro, Cidade, Estado)

- Observação: não foram identificados atributos multivalorados no modelo, uma vez que não houve confirmação, durante o levantamento de requisitos, de campos que admitissem múltiplos valores simultâneos (ex: mais de um telefone nas entidades fornecedor/cliente/funcionário).
  
- **Relacionamentos pertinentes:**

- Fornecedor(1) - Vende - (N) Pedido_Compra: um fornecedor pode atender vários pedidos de compra, mas cada pedido é feito a um único fornecedor.
- Categoria_Produto (1) — Cadastra — (N) Produto: uma categoria pode conter vários produtos, mas cada produto pertence a uma única categoria.
- Pedido_Compra (N) — Cadastra — (N) Produto: um pedido de compra pode conter vários produtos, e um mesmo produto pode estar presente em vários pedidos diferentes. Esse relacionamento possui os atributos Qntd_Produto e Valor_Unitario, que registram a quantidade e o preço praticado naquele pedido específico.
- Cliente (1) — Realiza — (N) Venda: um cliente pode realizar várias vendas, mas cada venda é realizada por um único cliente.
- Funcionario (1) — Registra — (N) Venda: um funcionário pode registrar várias vendas, mas cada venda é registrada por um único funcionário.
- Produto (N) — Contém — (N) Venda: uma venda pode conter vários produtos, e um mesmo produto pode estar presente em várias vendas diferentes. Esse relacionamento possui os atributos Qntd_Produto e Valor_Unitario, que registram a quantidade e o preço praticado naquela venda específica.

  
- **Restrições e políticas organizacionais aplicadas ao modelo.**

- Um produto não pode ser vendido após sua data de validade.
- Um pedido de compra só deve ser realizado para um fornecedor previamente cadastrado
- um fornecedor só pode ser cadastrado com CNPJ válido e dados completos
- O valor total de uma venda ou pedido de compra pode ser obtido através da soma (quantidade x valor unitário) de todos os produtos relacionados àquela transação, já que o preço praticado é registrado individualmente em cada relação entre venda/pedido e produto, permitindo manter o histórico de valores, mesmo que o preço de um produto mude ao longo do tempo.
- A empresa não aceita a forma de pagamento PIX, aceitando apenas Dinheiro, Cartão de Débito e Cartão de Crédito.

---

## 7. Diagrama Entidade-Relacionamento (DER)
<img width="1372" height="1622" alt="DER_Mercado2 drawio" src="https://github.com/user-attachments/assets/8981e419-cbcc-4f57-b08d-447698a92c91" />




---

## 8. Justificativa Técnica


Usamos essas entidades e atributos porque foram os dados que nos apresentaram durante a visita/entrevista, usufruímos dessas informações também pois acreditamos que é o que faz mais sentido dentro de um ecossistema de supermercado, por exemplo: o mercado não possui cadastro de clientes, porém decidimos colocar a entidade "cliente" por partirmos da premissa de "fazer sentido" por ser a entidade que efetua a compra de um produto. Apontamos esses relacionamentos e cardinalidades de acordo com o nível de entendimento sobre o conteúdo disponível em slides acadêmicos.

---

## 9. Uso de Inteligência Artificial


Se o grupo usou alguma ferramenta de IA (ChatGPT, Claude, Gemini, Perplexity etc.) em qualquer parte do trabalho, registre **para cada uso relevante**:

- Registro 1

| Item | O que registrar |
|------|------------------|
| **Ferramenta e etapa** |  Claude - Auxílio no aprendizado do GitHub.  |
| **Motivação** | Como ninguém do grupo era familiarizado com a rede social/ferramenta, optamos usar o Claude por saber que ele poderia ser mais técnico e direto ao mesmo tempo. |
| **Prompt(s) utilizados** | "Preciso criar um arquivo readme dentro do github, aprender a editar e adicionar colaboradores para que o meu grupo também tenha acesso, como eu faço isso?" |
| **Resposta recebida** | Resumo de 7 tópicos na sequência de como usar o GitHub -  1) Crie (ou acesse) o repositório, 2) Crie o arquivo README, 3) Escreve e formate o conteúdo, 4) Salve as alterações (commit), 5) Edite o README depois de criado, 6) Adicione colaboradores ao grupo, 7) Defina permissões (opcional). |
| **Fontes consultadas e verificadas** | O Claude apenas mandou o conhecimento que ele sabia sobre o GitHub no momento. |
| **Trechos rejeitados ou corrigidos** | Não houve necessidade de ajuste. |
| **Justificativa da escolha final** | Decidimos manter o uso do Claude nessa etapa por atender todas as nossas dúvidas sobre o github. |
| **Reflexão crítica** | Um pequeno erro foi identificado por algumas informações estarem desatualizadas, na primeira vez o claude estava ensinando a usar o github na versão anterior, mas depois de explicarmos que o GitHub poderia estar numa versão mais atual no momento. |

- Registro 2

| Item | O que registrar |
|------|------------------|
| **Ferramenta e etapa** | Gemini - Usado no nosso primeiro DER.|
| **Motivação** | Preferência geral do grupo.|
| **Prompt(s) utilizados** | "Crie um DER de supermercado de acordo com as informações que eu irei fornecer" |
| **Resposta recebida** | <img width="956" height="810" alt="DER_GEMINI" src="https://github.com/user-attachments/assets/9d7f158a-0c4b-453b-87c3-7e557162456b" /> |
| **Fontes consultadas e verificadas** | Não houve fontes consultadas pelo Gemini. |
| **Trechos rejeitados ou corrigidos** | O primeiro modelo inteiro foi rejeitado por nós, porque depois do feedback do professor, estudamos melhor nosso DER e vimos que apresentava muitas inconsistências. |
| **Justificativa da escolha final** | Não aproveitamos nada do que o Gemini nos retornou e optamos por refazer do zero por ela não atender corretamente aos critérios do trabalho, então construímos um DER na mão pelo draw.io. |
| **Reflexão crítica** | O Gemini apresentou um limite de excesso de detalhamento, o DER gerado incluía atributos desnecessários dentro de cada entidade, que não agregavam ao nosso projeto. |

- Registro 3

| Item | O que registrar |
|------|------------------|
| **Ferramenta e etapa** | Claude - Revisão ortográfica no documento README.|
| **Motivação** | Preferência geral do grupo |
| **Prompt(s) utilizados** | "Revise pra mim todos os erros de ortográfia dentro desse arquivo README e me passe para eu corrigir manualmente." |
| **Resposta recebida** | Lista com 21 erros de ortografia e pequenos 2 erros de inconsistência no trabalho apresentado.|
| **Fontes consultadas e verificadas** | Não houve fontes citadas. |
| **Trechos rejeitados ou corrigidos** | Não houve trechos rejeitados ou corrigidos. |
| **Justificativa da escolha final** | O grupo decidiu manter o uso por ela atender às nossas necessidades. |
| **Reflexão crítica** | A IA trouxe apenas os erros mais relevantes inicialmente, sendo necessário pedir novamente para que ela listasse todos os erros encontrados no documento, os incluindo os de menor destaque. |

- Resgistro 4

| Item | O que registrar |
|------|------------------|
| **Ferramenta e etapa** | Claude - Auxílio na organização e redação da documentação do modelo conceitual (item 6 do esqueleto de entrega). |
| **Motivação** | Preferência do grupo. |
| **Prompt(s) utilizados** | *Mandei uma print mostrando as 4 coisas que o tópico do item 6 do esqueleto pedia e enviei a imagem do nosso DER* - "de acordo com essas instruções do esqueleto de entrega, como eu posso colocar as informações de uma maneira organizada?" |
| **Resposta recebida** | Dicas de como estruturar os 4 tópicos do que o item 6 do esqueleto pedia, exemplo: 1. Entidades reconhecidas — não basta listar o nome, tem que justificar por que ela existe no modelo. Para cada entidade (Fornecedor, Pedido_Compra, Categoria_Produto, Produto, Cliente, Venda, Funcionário), explique em 1-2 frases: o que ela representa no negócio e por que era necessária capturar esses dados. Você já tem isso relativamente bem no README — o ponto de atenção é sempre conectar com a necessidade real levantada na entrevista, não só descrever o óbvio. |
| **Fontes consultadas e verificadas** | Não houve fontes consultadas. |
| **Trechos rejeitados ou corrigidos** | Foi corrigido apenas a ordem da estrutura sugerida pela IA, mantendo a sequência que estava dentro do esqueleto de entrega. |
| **Justificativa da escolha final** | Mantivemos a estrutura sugeridada pela IA porque batia com o que estava presente nos slides fornecidos na matéria. |
| **Reflexão crítica** | Não houve limites, vieses ou erros identificados. |






---

## Critérios Atitudinais (20%)
**Estes critérios NÃO constam explicitamente como item de entrega no README.** Eles são avaliados por meio de **Avaliação 360º entre os integrantes do grupo** (cada membro avalia os colegas de equipe) e, no caso da Colaboração, também pela **colaboração equilibrada no histórico de commits** do repositório GitHub — não pela leitura do restante do repositório nem pela apresentação:

- **Participação (5%):** envolvimento nas discussões técnicas e nas decisões do grupo.
- **Comprometimento (5%):** cumprimento de prazos e responsabilidades assumidas.
- **Colaboração (5%):** respeito às contribuições dos colegas, cooperação na construção do projeto e colaboração equilibrada no histórico de commits do repositório GitHub.
- **Autonomia (5%):** busca independente de soluções e proposta de melhorias.

---

## Resumo dos Pesos

| Dimensão | Peso total |
|----------|-----------|
| Conceitual (contexto, requisitos/regras, modelagem, justificativa técnica) | 30% |
| Procedimental (requisitos, fluxogramas, dicionário de dados, DER) | 50% |
| Atitudinal (participação, comprometimento, colaboração, autonomia) | 20% |

**Entrega final:** README.md completo + DER anexado no repositório GitHub do grupo.
