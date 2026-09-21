# Entrega 1 — Modelo Conceitual (DER)

### Nomes dos Integrantes:
- Tarcisio Santos (RGM 47913061)
- Gabriela Porfirio (RGM 48017698)
- Nicole Xavier (RGM 48329002)
- Henrique Moura (RGM 47610972)
- Henrico Saltanian (RGM 46981721)
### Modelagem de um sistema de gestão de informações para uma organização de pequeno porte


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

- Inteiror do mercado: <img width="1600" height="1200" alt="interior_mercado" src="https://github.com/user-attachments/assets/b969924b-67c7-4e15-8554-971d6f0eec40" />

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
- O sistema deve permitir o cadastro de produtos com código único, nome, data de validade, categoria e descrição. A data de validade não pode ser retroativa, a categoria deve vir de lista pré-cadastrado, e o sistema deve impedir código duplicado ou produto sem categoria, permitindo ainda edição e inativação de cadastros.
  
- O sistema deve atualizar automaticamente a quantidade em estoque de cada produto após a conclusão de uma venda no caixa, dando baixa nas quantidades vendidas. A atualização deve ocorrer em tempo real, refletindo imediatamente nas consultas de estoque.
  
- O sistema deve permitir consultar a quantidade disponível de um produto em estoque, a partir do código ou nome do produto. A consulta deve exibir a quantidade atual e indicar quando o estoque estiver abaixo de um limite mínimo pré-definido.
  
- O sistema deve permitir o cadastro de fornecedores, identificados obrigatoriamente por CNPJ. O CNPJ deve ser único (sem duplicidade) e ter seus dígitos validados no momento do cadastro.
  
- O sistema deve permitir associar um ou mais produtos a um ou mais fornecedores que os fornecem. Um produto pode ter mais de um fornecedor, e um fornecedor pode fornecer mais de um produto.
  
- O sistema deve permitir registrar pedidos de compra feitos a um fornecedor, contendo fornecedor, produto, quantidade e data/hora do pedido.
  
- O sistema deve permitir registrar uma venda contendo um ou mais produtos, com suas respectivas quantidades. Cada produto vendido deve ter estoque suficiente disponível no momento do registro, com baixa automática no estoque.
  
- O sistema deve gerar automaticamente o valor total da venda, somando o valor de cada produto pela quantidade vendida. O valor total deve ser recalculado sempre que houver alteração nos itens da venda.
  
- O sistema deve permitir cancelar uma venda já registrada, devolvendo os itens vendidos ao estoque. 

### 3.2 Requisitos Não Funcionais

- Desempenho: o sistema deve suportar pelo menos 10 caixas operando simultaneamente, mantendo o tempo de respostas de consultas e registro de vendas inferior a 3 segundos em situações normais de venda.
  
- Disponibilidade: o sistema deve estar dispoínvel durante todo o horário de funcionamento da loja, em caso de queda de internet, o sistema deve continuar permitindo as vendas, sincronizando tudo quando volta.
  
- Segurança: o sistema deve exigir login e senha para acesso as funcionalidades, permitindo que apenas usuários autorizados realizem tarefas de acordo com o nível acesso.
  
- Usabilidade: a interface do sistema do caixa deve manter uma navegação simples e objetiva, permitindo que funcionários novatos aprendam a ultilizar apenas com treinamento básico sem necessidade de conhecimentos técnicos avançados
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


Para cada entidade identificada, liste:

### Fornecedor

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_Fornecedor | Identificador único do fornecedor adastrado no sistema | Gerada automaticamente pelo sistema |
| Nome_Fornecedor | Nome fantasia pelo qual o fornecedor é conhecido comercialmente |  |
| CNPJ | Número de identificação da pessoa jurídica do fornecedor perante a Receita Federal | Obrigatório, único, deve conter 14 dígitos válidos |
| Razão_Social | Nome jurídico oficial da empresa fornecedora, conforme registrado legalmente |  |
| Telefone | Número de contato do fornecedor |  |
| Endereço | Localização física do fornecedor (composto por Rua, Número, Bairro, Cidade, Estado) |  |

### Pedido_Compra

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_Pedido | Identificador único do pedido compra realizado junto ao fornecedor | Gerada automaticamente pelo sistema |
| ID_Fornecedor | Referência ao fornecedor responsável por atender o pedido de compra | Deve referenciar um fornecedor cadastrado no sistema |
| Data | Data em que o pedido de compra foi realizado |  |
| Hora | Horário em que o pedido de compra foi realizado |  |


### Produto

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_Produto | Identificador único interno do produto | Gerada automaticamente pelo sistema |
| Nome_Produto | Nome completo/comercial do produto |  |
| ID_Categoria | Referência à categoria à qual o produto pertence | Deve referenciar uma categoria registrada |
| Descricao_Gondola | Descrição resumida do produto exibida na etiqueta de prateleira |  |
| Descricao_Reduzida | Descrição do produto utilizada na emissão de nota fiscal | Deve respeitar o limite de caracteres exigido pela legislação fiscal |
| Codigo_Barras | Código numérico (EAN/GTIN) atribuído pelo fabricante, utilizado para leitura no caixa e identificação universal do produto | Único |

### Categoria_Produto

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_Categoria | Identificador único da categoria de produto cadastrada no sistema | Gerada automaticamente pelo sistema |
| Nome_Categoria | Nome que identifica a categoria à qual produtos pertencem (ex: Hortifruti, Laticínios, Bebidas) |

### Funcionário 

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_Funcionario | Identificador único do funcionário cadastrado no sistema | Gerada automaticamente pelo sistema |
| Nome_Funcionario | Nome completo do funcionário |  |
| CPF | Documento de identificação civil do funcionário | Obrigatório, único, deve conter 11 dígitos válidos |
| Endereço | Localização de residência do funcionário (composto por Número, Rua, Bairro, Cidade, Estado) |
| Função | Cargo/atividade exercida pelo funcionário na empresa (ex: Caixa, Repositor, Gerente) |
| Telefone | Número de contato do funcionário |  |
| Data_Admissao | Data em que o funcionário foi contratado pela empresa |  |

### Venda

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_Venda | Identificador único da venda realizada | Gerada automaticamente pelo sistema |
| ID_Funcionario | Referência ao funcionário responsável por registrar a venda | Deve referenciar um funcionário cadastrado |
| ID_Cliente | Referência ao cliente que realizou a compra | Deve referenciar um cliente cadastrado |
| Data | Data em que a venda foi realizada
| Hora | Horário em que a venda foi realizada
| Forma_Pagamento | Forma de pagamento utilizada pelo cliente na compra | Valores possíveis: Dinheiro, Cartão de Débito, Cartão de Crédito |

### Cliente

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_Cliente | Identificador único do cliente cadastrado no sistema | Gerada automaticamente |
| Nome_Cliente | Nome completo do cliente |  |
| CPF | Documento de identificação civil do cliente | Único, deve conter 11 dígitos válidos |
| Telefone | Número de contato do cliente |  |







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

- Fornecedor(1) - Vende - (N) Pedido_Compra: um fornecedor pode antender vários pedidos de compra, mas cada pedido é feito a um único fornecedor.
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

| Item | O que registrar |
|------|------------------|
| **Ferramenta e etapa** |  Claude: Usado para auxiliar no aprendizado do github, porque ninguém do grupo era familiarizado com essa ferramenta. Gemini: Usado na criação do DER.  |
| **Motivação** | Claude: porque de acordo com as nossas pesquisas, concluímos que seria a melhor opção dentre as outras IA's, por ser mais técnico. Gemini: foi apenas uma escolha por preferência. |
| **Prompt(s) utilizados** |  Claude: sucessivas perguntas de como funciona o github. Por exemplo: "como adicionar um colaborador ao github", "como salvar as alterações feitas dentro do arquivo Readme". |
| **Resposta recebida** | Resposta do Claude: Vá até o repositório no GitHub onde você quer adicionar o colaborador. Clique na aba Settings no menu superior — você precisa ser dono do repositório ou ter permissão de administrador para ver essa opção. No menu lateral esquerdo, clique em Collaborators and teams (ou apenas Collaborators). Clique no botão Add people (pode pedir para confirmar sua senha). Digite o nome de usuário do GitHub, nome completo ou e-mail da pessoa que você quer convidar, e escolha o nível de permissão dela: Read, Triage, Write, Maintain ou Admin. Por fim, clique em Add [nome] to this repository. A pessoa vai receber um convite por e-mail ou notificação no GitHub, que ela precisa aceitar para ter acesso.  |
| **Fontes consultadas e verificadas** |  |
| **Trechos rejeitados ou corrigidos** |  |
| **Justificativa da escolha final** | Decidimos manter as IA's escolhidas por atingir um nível bom de satisfação e coerência nas respostas geradas por elas. |
| **Reflexão crítica** |  |



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
