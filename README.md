# Entrega 2 — Modelo Lógico, Implementação SQL e Apresentação Final

### Modelagem de um sistema de gestão de informações para uma organização de médio porte

---

## 1. Relatório Técnico Final

### Integrantes

| Nome completo do aluno | RGM | Usuário do GitHub |
| :---- | :---- | :---- |
| Tarcisio Santos de Oliveira | 47913061 | TarcisioT |
| Gabriela Porfírio da Silva | 48017698 | porfiriogabis |
| Henrique Moura de Oliveira | 47610972 | Bkrusher666 |
| Victor Hugo dos Santos Maciel | 48037630 | vhugosm |
| Guilherme Damasceno dos Santos | 48491683 | damascenogs |

&nbsp;

### 1.1 Revisão do Modelo Conceitual

#### Caracterização da Organização

- **Nome e natureza da organização:** Hortifruti União – Tatuapé, empresa privada com fins lucrativos, pertencente ao ramo de comércio varejista alimentício.

- **Contexto e porte:** o Hortifruti União – Tatuapé é uma empresa privada com fins lucrativos, de médio porte, que funciona todos os dias. Os números abaixo foram informados pelo responsável, Guilherme Takemoto:

  - **Pessoas:** aproximadamente 110 funcionários e 7 caixas.
  - **Vendas:** média de 2.400 transações por dia (cerca de 72.000 por mês), com ticket médio de R$ 70 e faturamento de aproximadamente R$ 5,04 milhões por mês.
  - **Produtos:** 28 mil SKUs cadastrados, entre produtos ativos e inativos.
  - **Fornecedores:** 650 cadastrados, dos quais cerca de 350 tiveram movimentação nos últimos 90 dias.
  - **Recebimento:** cerca de 1.200 lotes recebidos por semana, considerando como lote a combinação de produto, fornecedor e identificação de lote no recebimento.
  - **Perdas:** cerca de R$ 75 mil por mês, equivalentes a aproximadamente 1,5% do faturamento, incluindo vencimentos, avarias, quebras e deterioração.

- **Problemas e necessidades identificados:**

 - **P1 — Controle de validade e rastreabilidade dos lotes:** durante o levantamento realizado no Hortifruti União, foi identificado que o sistema utilizado pela empresa permite registrar datas de validade, mas essa funcionalidade não é utilizada sistematicamente. Segundo o responsável consultado, diferentes lotes de um mesmo produto utilizam o mesmo código de barras, dificultando sua identificação individual. Além disso, a organização física das mercadorias pode prejudicar a prioridade de venda dos produtos próximos do vencimento.

  - **Como o modelo resolve:** registra cada lote com identificação própria, produto, data de validade e quantidade disponível. Permite consultar os lotes próximos do vencimento e registrar perdas, apoiando decisões de reposição e redução de desperdícios. A solução complementa os procedimentos físicos de organização das mercadorias.

- **Escopo do sistema:** o projeto propõe um banco de dados relacional para organizar informações sobre produtos, categorias, fornecedores, pedidos de compra, recebimento de mercadorias, lotes, datas de validade, estoque, vendas, pagamentos e perdas. Também contempla o cadastro de funcionários, usuários, perfis de acesso e o registro de operações relevantes, como alterações de preços e cancelamentos. O fechamento de caixa será representado de forma simplificada. O banco permitirá consultar as informações necessárias à geração de etiquetas e registrar dados fiscais básicos associados às vendas, sem implementar a impressão física de etiquetas nem a emissão fiscal real. A integração com o ERP utilizado pelo estabelecimento e o desenvolvimento de interfaces completas permanecerão fora do escopo desta entrega.

- **Justificativa da escolha:** a empresa foi selecionada porque Tarcisio Santos de Oliveira tem contato próximo com Guilherme Takemoto, um dos proprietários do estabelecimento. Esse vínculo permitiu a realização da entrevista e da visita ao local para observação, mas não substitui a comprovação da entrevista, apresentada neste relatório. Além disso, a empresa possui processos de vendas, controle de estoque, validade de produtos, emissão de notas fiscais e controle de acesso que são adequados ao projeto de modelagem de banco de dados.

- **Evidências da organização:**

   - [Localização no Google Maps](https://www.google.com/maps/search/?api=1&query=Rua+Filipe+Camar%C3%A3o%2C+67%2C+Tatuap%C3%A9%2C+S%C3%A3o+Paulo)
  - **Perfil comercial no Google:** o vínculo com um perfil específico no Google Business Profile ainda deverá ser confirmado pelo grupo.
  - **Endereço:** Rua Filipe Camarão, nº 67, Tatuapé, São Paulo, CEP 03065-000.
  - **Número de contato:** (11) 99317-0906.
  - **Responsável entrevistado:** Guilherme Takemoto, um dos proprietários.

![Fotografia da fachada](imagens/evidencias/fachada_mercado.jpeg)

![Fotografia do interior](imagens/evidencias/interior_mercado.jpeg)

![Fotografia do estoque](imagens/evidencias/estoque_mercado.jpeg)

#### Relato da entrevista

- **Quem:** Guilherme Takemoto, um dos proprietários do Hortifruti União – Tatuapé, foi entrevistado por Tarcisio Santos de Oliveira. Tarcisio também foi responsável pela observação presencial do estabelecimento e pelo registro das evidências.

- **Quando e onde:** a entrevista foi realizada por videochamada pelo WhatsApp em 22/09/2026, com duração aproximada de uma hora. Posteriormente, Tarcisio realizou uma visita presencial ao estabelecimento em 30/09/2026, na Rua Filipe Camarão, nº 67, Tatuapé, São Paulo, para observar o local e sua rotina.

- **Limitação do levantamento:** não foi possível realizar uma nova entrevista presencial com o responsável. Por esse motivo, o grupo separou as informações fornecidas durante a videochamada dos achados obtidos durante a observação presencial. Pontos complementares (pedidos por e-mail, nota fiscal nas entradas, pagamento dividido e fechamento de caixa) foram confirmados com o responsável em contato posterior.

- **Comprovação da entrevista:** a entrevista por videochamada foi registrada por meio de uma captura de tela com o entrevistado.

<img src="imagens/evidencias/entrevista_videochamada.jpeg" alt="Entrevista por videochamada com Guilherme Takemoto" width="400">

- **Comprovação da visita:** a visita presencial foi documentada por meio das fotografias da fachada, do interior e do estoque apresentadas na seção de evidências da organização.

**O que foi levantado:** [Levantamento completo](levantamento/levantamento.md)

---

#### Processos de Negócio

Os processos apresentados a seguir foram identificados com base na entrevista com o responsável pelo Hortifruti União, na observação presencial e nas melhorias propostas pelo grupo. Para diferenciar o funcionamento atual da solução que estamos desenvolvendo, as funcionalidades propostas são indicadas ao longo das descrições.

##### 1. Processo de venda no caixa

O processo de venda começa quando o cliente apresenta os produtos no caixa. O funcionário identifica cada produto por meio da leitura do código de barras, permitindo a consulta de suas informações cadastrais, como nome e preço.

Para cada item da venda, devem ser registrados o produto, a quantidade e o preço unitário praticado. Após a inclusão dos itens, é calculado o valor total da compra e registrada a forma de pagamento utilizada pelo cliente.

Na solução proposta, os dados da venda serão armazenados no banco de dados, incluindo seus itens, valores, responsável e informações fiscais. A integração com o controle de estoque permitirá que as quantidades correspondentes aos produtos vendidos sejam baixadas após a conclusão da venda, evitando divergências entre as vendas registradas e o estoque disponível.

A emissão e o registro da nota fiscal deverão seguir o procedimento fiscal utilizado pela organização, cuja operação atual deverá ser confirmada durante o levantamento.

**Dados envolvidos:** identificação da venda, caixa, data e horário, funcionário responsável, produtos vendidos, quantidades, preços unitários, valor total, informações da nota fiscal, formas de pagamento e situação da venda.

##### 2. Processo de pedido e recebimento de mercadorias

Atualmente, os pedidos aos fornecedores são realizados por e-mail, conforme informado no levantamento. Na solução proposta, cada pedido de compra deverá ser registrado no sistema e vinculado a um fornecedor previamente cadastrado.

O pedido deverá conter sua identificação, data, fornecedor e os itens solicitados. Para cada item, serão registrados o produto, a quantidade solicitada e o valor unitário previsto.

No recebimento, as mercadorias são acompanhadas de nota fiscal e devem ser conferidas em relação ao pedido e ao documento fiscal. A conferência deverá considerar os produtos recebidos, as quantidades, as condições das mercadorias, os lotes e as respectivas datas de validade.

Caso sejam identificadas divergências, como quantidades diferentes das solicitadas ou produtos em condições inadequadas, a ocorrência deverá ser registrada. Após a conferência e a validação das informações, os produtos aceitos poderão ser liberados para entrada no estoque.

O tratamento de recebimentos parciais e de mercadorias recusadas deverá seguir as regras confirmadas com a organização.

**Dados envolvidos:** pedido de compra, fornecedor, razão social, CNPJ, e-mail, data e horário do pedido, produtos, quantidades solicitadas e recebidas, valores unitários, nota fiscal do fornecedor, lote, data de validade, divergências identificadas e situação do recebimento.

##### 3. Processo de controle de estoque, lotes e validade

O controle de estoque deverá manter as quantidades disponíveis de cada produto atualizadas conforme as entradas, vendas, perdas e demais movimentações registradas.

Na solução proposta, um mesmo produto poderá estar associado a diferentes lotes, cada um com identificação própria, data de entrada, data de validade e quantidade disponível. O sistema deverá permitir a consulta do estoque pelo código de barras ou pelo nome do produto, além de identificar produtos abaixo da quantidade mínima definida e lotes próximos do vencimento.

Para reduzir perdas, propõe-se a utilização da estratégia FEFO (*First Expire, First Out*), priorizando a saída dos lotes válidos cuja data de vencimento esteja mais próxima. Produtos pertencentes a lotes vencidos não poderão ser disponibilizados para venda.

Quando ocorrer uma perda, o sistema deverá registrar o produto, o lote afetado, a quantidade, a data, o motivo e o funcionário responsável. A quantidade perdida deverá ser descontada do estoque disponível, mantendo o histórico da movimentação.

**Dados envolvidos:** produto, código de barras, lote, número do lote, data de entrada, data de validade, quantidade recebida, quantidade disponível, estoque mínimo, movimentações de entrada e saída, quantidade perdida, motivo da perda e funcionário responsável.

##### 4. Processo de pagamento

Após o registro dos produtos, o cliente realiza o pagamento da compra. Conforme informado no levantamento, o Hortifruti União aceita dinheiro, cartão de débito e cartão de crédito, mas não aceita Pix. Uma mesma venda pode ser paga utilizando mais de uma dessas formas de pagamento.

Na solução proposta, cada pagamento será registrado com a respectiva forma e o valor pago. Quando uma venda utilizar mais de um meio de pagamento, a soma dos valores registrados deverá corresponder ao valor total da venda para que o pagamento seja considerado completo.

O registro deverá permitir a consulta dos valores recebidos por forma de pagamento e apoiar a conferência do caixa.

**Dados envolvidos:** venda, forma de pagamento, valor pago, data e horário, situação do pagamento e identificação do registro de pagamento.

##### 5. Processo de cancelamento

Quando o cliente desistir de um produto antes da conclusão da venda, o item deverá ser retirado da operação. Como a venda ainda não foi concluída, essa ação não deverá provocar uma baixa definitiva no estoque.

O cancelamento de uma venda já concluída deverá ser realizado somente por usuários autorizados, conforme informado: gerente ou fiscal de caixa. O sistema proposto deverá preservar o histórico da venda e registrar o motivo do cancelamento, a data, o horário e o funcionário responsável.

Quando os produtos cancelados forem devolvidos e estiverem em condições de comercialização, as respectivas quantidades deverão retornar ao estoque, preferencialmente aos lotes de origem, mantendo a rastreabilidade. Produtos danificados ou impróprios para venda deverão receber o tratamento correspondente, sem retorno automático ao estoque disponível.

**Dados envolvidos:** venda, itens cancelados, produtos, lotes de origem, quantidades, motivo do cancelamento, data e horário, funcionário responsável e situação da venda.

##### 6. Processo de alteração de preços e emissão de etiquetas

Conforme informado pelo entrevistado, a alteração do preço de um produto é permitida somente aos líderes de setor, ao gerente e aos proprietários.

Na solução proposta, cada alteração deverá registrar o produto, o preço anterior, o novo preço, a data, o horário e o funcionário responsável. O histórico deverá ser preservado para permitir a consulta das alterações realizadas e a identificação dos responsáveis.

A consulta dos códigos dos produtos e a emissão de novas etiquetas poderão ser disponibilizadas aos funcionários autorizados a utilizar os computadores destinados a essa atividade, respeitando as permissões definidas pela organização.

**Dados envolvidos:** produto, código de barras, preço anterior, novo preço, data e horário da alteração, funcionário responsável e informações utilizadas na emissão da etiqueta.

##### 7. Processo de controle de acesso

O sistema proposto deverá permitir a identificação dos usuários por meio de login e senha, associando cada funcionário a um perfil de acesso compatível com suas responsabilidades.

As alterações de preços serão permitidas aos líderes de setor, ao gerente e aos proprietários. As informações financeiras ficarão disponíveis somente ao setor administrativo, ao gerente e aos proprietários. O cancelamento de vendas e a validação do fechamento de caixa serão permitidos ao gerente e ao fiscal de caixa, conforme as permissões informadas no levantamento.

As operações relevantes deverão manter registros de auditoria contendo o usuário responsável, a data, o horário e a operação realizada. As senhas deverão ser armazenadas de forma segura, sem exposição em texto puro.

**Dados envolvidos:** funcionário, cargo, usuário, senha protegida, perfil de acesso, permissões por funcionalidade, data e horário da operação e registro de auditoria.

##### 8. Processo de fechamento de caixa

Ao final do dia, é realizado o fechamento do caixa. O operador faz a conferência inicial, contando o dinheiro físico e comparando o valor encontrado com o saldo esperado em dinheiro calculado pelo sistema. O fiscal de caixa ou o gerente valida o fechamento.

A conferência deverá considerar somente as movimentações em dinheiro, e não o total geral das vendas, pois parte dos pagamentos é realizada com cartão de débito ou crédito.

Na solução proposta, cada caixa começará o período com um fundo de caixa, correspondente ao valor inicial em dinheiro destinado principalmente ao troco. Esse valor não será contabilizado como receita de vendas.

O saldo esperado em dinheiro será calculado a partir do fundo inicial e das entradas e saídas em dinheiro registradas durante o período. A diferença de caixa será calculada pela subtração do saldo esperado do valor efetivamente contado. O fechamento deverá registrar o resultado da conferência e a validação realizada pelo responsável autorizado.

**Dados envolvidos:** caixa, data, operador responsável, validador, fundo de caixa, entradas e saídas em dinheiro, saldo esperado, valor contado, diferença e situação do fechamento.

##### Processos não incluídos no escopo atual

Durante o levantamento, alguns processos comuns em estabelecimentos varejistas não foram detalhados suficientemente para serem modelados com segurança. Por esse motivo, não serão tratados como procedimentos confirmados nem implementados no escopo atual sem validação adicional com a organização.

- **Contas a pagar aos fornecedores:** não foram obtidas informações suficientes sobre o controle de vencimentos, parcelas, pagamentos e situação financeira das obrigações.
- **Elaboração da escala de funcionários:** não foram detalhados os procedimentos de definição, alteração e consulta das escalas de trabalho.
- **Controle de jornada e ponto:** não foram levantadas informações suficientes sobre os registros de entrada, saída, intervalos e apuração da jornada.

Esses processos poderão ser incorporados em uma etapa futura, caso sua existência, suas regras e os dados necessários sejam confirmados com o responsável pela organização. A ausência desses processos no escopo atual decorre da insuficiência de informações levantadas, e não de uma afirmação de que eles não existem.


##### Fluxogramas

**Fluxograma do processo de venda:**

<img src="fluxograma_vendas.png" alt="Fluxograma do processo de venda" width="450">

**Fluxograma do processo de estoque:**

<img src="fluxograma_estoque.png" alt="Fluxograma do processo de estoque" width="450">

---

#### Requisitos do Sistema

##### Requisitos Funcionais

- **RF01 — Cadastro de produtos:** o sistema deve permitir cadastrar produtos com código único, nome, código de barras, descrição de gôndola, descrição reduzida (nota fiscal), categoria, unidade de medida (unidade ou quilo), preço de venda e estoque mínimo. Deve impedir código duplicado e produto sem categoria, e permitir edição e inativação.

- **RF02 — Cadastro de categorias:** o sistema deve permitir cadastrar categorias de produto com nome (por exemplo, fruta, verdura, laticínios). A categoria deve ser cadastrada antes dos produtos que a utilizam (RN16).

- **RF03 — Cadastro de fornecedores:** o sistema deve permitir cadastrar fornecedores com razão social, CNPJ, telefone e e-mail (obrigatório). O CNPJ deve ser único e ter os dígitos validados (RN04).

- **RF04 — Produtos por fornecedor:** o sistema deve permitir associar um ou mais produtos a um ou mais fornecedores, vinculando o código do produto ao CNPJ do fornecedor, sem repetir a mesma dupla.

- **RF05 — Pedido de compra:** o sistema deve permitir registrar pedidos a um fornecedor cadastrado (RN03), com um ou mais itens (produto, quantidade e preço de compra), data e situação do pedido (RN13). O pedido é enviado ao fornecedor por e-mail, por isso o e-mail é obrigatório no cadastro do fornecedor (RF03).

- **RF06 — Recebimento de mercadorias:** o sistema deve permitir registrar a entrada de mercadorias com número da nota fiscal, produto, lote, quantidade recebida e data de validade, vinculando o recebimento ao pedido de compra e registrando divergências encontradas na conferência (RN02).

- **RF07 — Consulta de estoque:** o sistema deve permitir consultar a quantidade disponível por produto e por lote, a partir do código, do nome ou do código de barras, e indicar quando o estoque estiver abaixo do mínimo (RN06).

- **RF08 — Registro de venda:** o sistema deve permitir registrar uma venda com um ou mais produtos, identificados por leitura de código de barras, com quantidade (em quilos para produtos a granel, RN11), caixa utilizado, funcionário responsável, data e hora. A venda não exige cadastro de cliente.

- **RF09 — Valor da venda:** o sistema deve calcular automaticamente o subtotal de cada item (quantidade × preço praticado) e o valor total da venda, recalculando a cada alteração dos itens.

- **RF10 — Cancelamento de item:** o sistema deve permitir retirar um item da venda antes de sua conclusão, informando o produto e a quantidade retirada, sem gerar baixa no estoque. O item retirado não faz parte do total da venda.

- **RF11 — Cancelamento de venda:** o sistema deve permitir cancelar uma venda concluída, restrito ao gerente ou fiscal de caixa, registrando data, hora, motivo e responsável e devolvendo os itens ao lote de origem. Lote vencido não volta a ficar disponível (RN05, RN10).

- **RF12 — Pagamento:** o sistema deve permitir registrar o pagamento da venda em uma ou mais formas (dinheiro, débito ou crédito), com valor, data e hora de cada pagamento, e soma igual ao total da venda (RN15).

- **RF13 — Registro de informações fiscais (implementação limitada):** o banco de dados deverá permitir o registro de informações fiscais básicas associadas às vendas, como número da nota fiscal, data e horário de emissão, quando disponibilizadas. A emissão, autorização e transmissão de documentos fiscais aos órgãos competentes não fazem parte da implementação prática desta entrega, pois dependem de integração com serviços fiscais externos. A obrigatoriedade fiscal continua sendo reconhecida como uma necessidade operacional do estabelecimento.
  
- **RF14 — Baixa automática por lote:** No sistema proposto, ao concluir uma venda, a quantidade vendida deverá ser descontada dos lotes válidos com vencimento mais próximo, seguindo o método FEFO. O sistema deverá registrar qual lote foi utilizado e a quantidade retirada de cada um, mantendo o histórico da movimentação (RN14, RN19).
  
- **RF15 — Bloqueio de vencidos:** o sistema deve impedir a venda de produtos de lotes com data de validade anterior à data da venda (RN01) e de quantidade maior que a soma disponível nos lotes válidos do produto (RN18), informando ao operador o motivo do bloqueio.

- **RF16 — Consulta de validade:** o sistema deve permitir consultar lotes vencidos e próximos do vencimento, com produto, lote, quantidade disponível e data de validade.

- **RF17 — Alerta de vencimento:** o sistema deve alertar, por produto e lote, quando a data de validade estiver dentro do prazo de alerta definido pelo mercado, exibindo produto, lote, quantidade disponível e dias restantes (RN09).

- **RF18 — Registro de perdas:** o sistema deve permitir registrar perdas (vencimento, dano ou estrago) com lote, quantidade, data, motivo e funcionário, descontando a quantidade do lote (RN07, RN17).

- **RF19 — Alteração de preço:** o sistema deve permitir alterar o preço de um produto apenas a líderes de setor, gerente e dono, registrando o preço anterior, o novo preço, a data e hora e o funcionário (RN10).

- **RF20 — Consulta de produtos e informações para etiquetas (implementação limitada):** o banco de dados deverá permitir consultar o código do produto, código de barras, nome utilizado na gôndola e preço de venda atualizado. Essas informações poderão ser utilizadas futuramente para gerar etiquetas. A criação de interfaces de impressão e a comunicação com impressoras não fazem parte da implementação prática desta entrega.
  
- **RF21 — Funcionários e usuários:** o sistema deve permitir cadastrar funcionários com nome, CPF, telefone, cargo e data de admissão, e criar o usuário de acesso (login e senha) com o perfil correspondente. Dados financeiros ficam restritos ao administrativo, gerente e dono (RN10).

- **RF22 — Fechamento de caixa:** o sistema deve permitir o fechamento do caixa ao final do dia em duas etapas. No início do dia, o sistema registra o fundo de caixa, que é o valor inicial em dinheiro usado para dar troco. Ao final do dia, o operador do caixa registra a conferência inicial, informando o valor em dinheiro contado. O sistema calcula o saldo esperado em dinheiro, somando o fundo de caixa aos pagamentos em dinheiro registrados no dia, e mostra a diferença entre o valor contado e o esperado. Em seguida, o fiscal de caixa ou o gerente valida o fechamento. O registro guarda a data, o caixa, o operador, o validador, o fundo de caixa, o saldo esperado, o valor contado, a diferença e a situação (conferido ou validado). As vendas pagas em cartão não entram nesse saldo (RN21).

##### Requisitos Não Funcionais

- **RNF01 — Desempenho (implementação limitada):** considerando que o Hortifruti União possui 7 caixas e realiza aproximadamente 2.400 transações por dia, o banco de dados deverá ser estruturado para permitir consultas eficientes de produtos, vendas, lotes e estoque. Nesta entrega, serão considerados tipos de dados adequados, chaves primárias, chaves estrangeiras e índices para apoiar o desempenho das consultas SQL. A meta de resposta inferior a 3 segundos e o funcionamento simultâneo dos 7 caixas não serão validados nesta etapa, pois dependem de testes de carga e de uma aplicação integrada.
  
- **RNF02 — Disponibilidade (implementação limitada):** o sistema proposto deverá buscar disponibilidade durante o horário de funcionamento do Hortifruti União. Nesta entrega, o grupo desenvolverá e testará a estrutura do banco de dados em MySQL, sem implementar mecanismos de alta disponibilidade, funcionamento dos caixas sem internet ou sincronização automática após quedas de conexão. Essas funcionalidades ficam previstas como melhorias futuras.
  
- **RNF03 — Segurança e controle de acesso (implementação limitada):** o banco de dados deverá permitir o cadastro de usuários vinculados aos funcionários e a associação desses usuários a perfis de acesso, conforme as responsabilidades definidas para cada função (RN10). As credenciais deverão ser representadas por identificadores de login e senhas protegidas por hash com sal, utilizando algoritmo apropriado, sem armazenamento de senhas em texto puro. A estrutura também deverá permitir identificar quais perfis possuem autorização para operações relevantes. Nesta entrega, serão implementadas e testadas as estruturas de dados e as consultas SQL relacionadas ao controle de acesso. A criação de uma interface de login e de um serviço completo de autenticação ficará fora do escopo prático.
    
- **RNF04 — Usabilidade e organização dos dados (implementação limitada):** o banco de dados deverá utilizar nomes claros e padronizados para tabelas e colunas, facilitando a compreensão, a manutenção e a elaboração de consultas SQL. O projeto também deverá apresentar um dicionário de dados com a descrição das estruturas implementadas. A criação e a avaliação de uma interface gráfica para operadores de caixa não fazem parte do escopo prático desta entrega, podendo ser realizadas em uma evolução futura do sistema.
  
- **RNF05 — Recuperação de dados (implementação limitada):** o projeto deverá considerar a importância de realizar cópias de segurança para evitar a perda de informações sobre produtos, vendas, lotes, estoque e operações registradas. Nesta entrega, o grupo poderá demonstrar o procedimento de exportação e restauração do banco de dados MySQL como medida básica de recuperação. A configuração de backups automáticos diários, armazenamento externo e planos de recuperação em ambiente de produção ficará como evolução futura do sistema.
  
- **RNF06 — Integridade:** o registro da venda e a baixa do estoque devem ocorrer na mesma transação, de forma que ou ambos são gravados ou nenhum, e o estoque de um lote não pode ficar negativo.

- **RNF07 — Auditoria e rastreabilidade das operações (implementação limitada):** o banco de dados deverá permitir registrar operações relevantes, como alterações de preços, cancelamentos de vendas, registros de perdas e validações de fechamento de caixa, identificando o usuário responsável, a data, o horário e o tipo de operação realizada. Para isso, serão previstas estruturas de histórico e auditoria relacionadas às entidades do sistema. Nesta entrega, o grupo deverá demonstrar o armazenamento e a consulta desses registros por meio de comandos SQL. A implementação de um sistema completo de monitoramento, alertas de segurança e auditoria automática de todas as ações ficará fora do escopo prático.
  
- **RNF08 — Conformidade legal (implementação limitada):** o projeto deverá considerar a proteção dos dados pessoais de funcionários e fornecedores, conforme os princípios aplicáveis da Lei Geral de Proteção de Dados (LGPD), incluindo controle de acesso às informações. A obrigatoriedade de emissão de documentos fiscais será reconhecida e documentada, mas a emissão, autorização e transmissão de notas fiscais não serão implementadas nesta entrega. O banco de dados poderá armazenar informações fiscais básicas associadas às vendas, sem substituir o sistema fiscal utilizado pelo estabelecimento.
  
- **RNF09 — Integração e centralização dos dados (implementação limitada):** o banco de dados proposto deverá organizar de forma centralizada as informações de produtos, fornecedores, compras, lotes, estoque, vendas e pagamentos, mantendo os relacionamentos necessários para garantir a integridade dos registros. Embora o Hortifruti União utilize atualmente o ERP VR Software, a integração automática com esse sistema não será desenvolvida nesta entrega. A possibilidade de comunicação entre os sistemas ficará prevista como evolução futura, dependendo de análise técnica e disponibilidade de mecanismos de integração.

**Requisitos típicos não incluídos:** cadastro de clientes e programa de fidelidade (o mercado não cadastra clientes) e pagamento por Pix (não aceito). Contas a pagar e escala de funcionários não foram levantados na entrevista e não estão ligados aos problemas declarados (P1 e P2). Ficam como evolução futura, a confirmar com o responsável.

---

#### Regras de Negócio

**Origem das regras:** as marcadas com **[Entrevista]** foram informadas pelo responsável, Guilherme Takemoto. As marcadas com **[Proposta]** foram elaboradas pelo grupo a partir dos processos mapeados e de regras típicas de supermercados e hortifrutis, levantadas com apoio de IA (ver a seção 6, Uso de Inteligência Artificial), e ainda não foram validadas individualmente com o responsável.

**Regras operacionais**

- **RN01 — Bloqueio de venda de produtos vencidos [Entrevista]:** o sistema não deve permitir a venda de produto cujo lote tenha data de validade anterior à data da venda. Segundo o responsável, vender produto vencido é crime.

- **RN02 — Entrada de estoque com nota fiscal [Entrevista]:** toda entrada de mercadoria deve ser registrada com a nota fiscal do fornecedor, informando também lote, quantidade recebida e data de validade. Sem a nota fiscal, o sistema não permite registrar a entrada.

- **RN03 — Pedido só a fornecedor cadastrado [Proposta]:** um pedido de compra só pode ser feito a um fornecedor previamente cadastrado.

- **RN04 — Fornecedor com CNPJ válido [Proposta]:** o fornecedor só pode ser cadastrado com CNPJ válido e único, razão social, telefone e e-mail preenchidos.

- **RN05 — Cancelamento de venda [Proposta]:** o cancelamento de uma venda concluída deverá ser realizado somente pelo gerente ou fiscal de caixa, conforme as permissões estabelecidas na RN10. O registro deverá preservar a venda original e armazenar o motivo do cancelamento, a data, o horário e o usuário responsável. As quantidades dos produtos cancelados poderão retornar aos respectivos lotes de origem somente quando estiverem em condições adequadas para comercialização e dentro do prazo de validade. Produtos vencidos, danificados ou impróprios para venda não deverão retornar ao estoque disponível. O sistema deverá impedir que a mesma quantidade seja devolvida mais de uma vez, mantendo a rastreabilidade das movimentações.
  
- **RN06 — Estoque mínimo [Entrevista]:** cada produto tem uma quantidade mínima de estoque. Quando a quantidade disponível fica abaixo dela, o sistema alerta para avaliar a reposição. O comprador é o principal responsável por definir (parametrizar) o estoque mínimo, com apoio do ERP e supervisão do gerente de compras.

- **RN07 — Perdas por vencimento [Proposta]:** quando um lote vence, ele não pode mais ser vendido. A perda é registrada com lote, quantidade, data, motivo "vencimento" e funcionário responsável, e descontada do estoque do lote.

- **RN09 — Alerta de vencimento [Proposta]:** o sistema avisa quando um lote está próximo do vencimento. O prazo de antecedência é um parâmetro configurável por produto ou categoria; o valor ainda não foi informado pelo responsável e deve ser confirmado.

- **RN13 — Pedido de compra com itens [Proposta]:** todo pedido de compra contém ao menos um item. Cada item representa um produto e pertence a um único pedido.

- **RN14 — Saída por lote, FEFO [Proposta]:** cada produto vendido tem sua quantidade retirada de um ou mais lotes válidos, com prioridade para o vencimento mais próximo (primeiro que vence, primeiro que sai), registrando lote e quantidade retirada.

- **RN15 — Formas de pagamento [Entrevista]:** o mercado aceita dinheiro, cartão de débito e cartão de crédito, mas não aceita Pix. O pagamento de uma venda pode ser dividido entre essas formas, desde que a soma seja igual ao total da venda.

- **RN16 — Categoria do produto [Proposta]:** todo produto pertence a uma única categoria, que deve estar cadastrada antes do produto. Uma categoria pode ter vários produtos (por exemplo, a categoria fruta com banana e pera).

- **RN17 — Perdas por outros motivos [Proposta]:** perdas por dano, estrago ou outros motivos também são registradas com lote, quantidade, data, motivo e funcionário responsável, e descontadas do estoque do lote. A proposta é registrar todas as perdas digitalmente.

- **RN18 — Quantidade vendida [Proposta]:** não é permitido vender quantidade maior que a disponível nos lotes válidos do produto.

- **RN19 — Baixa automática de estoque [Entrevista]:** o estoque é integrado ao caixa. Ao concluir uma venda, o sistema dá baixa automática nas quantidades vendidas.

- **RN20 — Histórico preservado [Proposta]:** vendas, cancelamentos, pagamentos e perdas não são apagados. Ficam registrados no histórico, com a situação atualizada.

- **RN21 — Fechamento de caixa simplificado [Entrevista / Proposta]:** conforme informado pelo responsável, o operador realiza a conferência inicial do dinheiro físico ao final do período, e o fiscal de caixa ou gerente valida o fechamento. Para representar esse processo no banco de dados, o grupo propõe registrar a identificação do caixa, a data, o operador responsável, o funcionário validador, o fundo inicial, o saldo esperado em dinheiro, o valor contado, a diferença apurada e a situação do fechamento.

  - **Cálculo dos valores [Proposta]:** o saldo esperado será calculado a partir do fundo inicial, somado aos pagamentos em dinheiro e ajustado por outras entradas e saídas em espécie que tenham sido efetivamente registradas. Os pagamentos por cartão não serão considerados nesse cálculo. A diferença será obtida subtraindo o saldo esperado do valor contado.

  - **Validação e rastreabilidade [Proposta]:** somente o fiscal de caixa ou gerente poderá validar o fechamento, conforme a RN10. O registro deverá preservar a identificação de quem realizou a conferência e de quem efetuou a validação, além da data e do horário dessas operações.

  - **Limite da implementação:** nesta entrega, o fechamento será representado por estruturas de dados e exemplos de consultas SQL. Não será desenvolvida uma interface operacional de caixa nem integração com equipamentos de pagamento. O registro de outras movimentações em dinheiro dependerá das estruturas efetivamente incluídas no modelo.

**Restrições organizacionais e legais**

- **RN08 — Obrigatoriedade fiscal e registro de informações da nota [Entrevista / Implementação limitada]:** o Hortifruti União deve cumprir as obrigações fiscais aplicáveis às suas vendas, conforme informado pelo responsável. Na solução proposta, o banco de dados deverá permitir o armazenamento de informações fiscais básicas associadas às vendas, como número da nota, data e horário de emissão, quando disponibilizadas. A emissão, autorização e transmissão de documentos fiscais aos órgãos competentes não serão implementadas nesta entrega, permanecendo como atividades realizadas pelo sistema fiscal utilizado pelo estabelecimento. O banco de dados desenvolvido para o projeto não substituirá esse sistema.
  
- **RN10 — Permissões por função [Entrevista]:** o acesso ao sistema depende do cargo do funcionário. Os cargos do mercado são dono, gerente, administrativo, fiscal de caixa, caixa, repositor, líderes de setor (mercearia, hortifruti, açougue, padaria e confeitaria), padeiro, confeiteiro, açougueiro, segurança, serviços gerais e limpeza.
   - Alterar o preço de um produto: líderes de setor, gerente e dono.
  - Acessar dados financeiros: administrativo, gerente e dono.
  - Consultar o código, o código de barras, o nome e o preço de um produto: qualquer funcionário. A geração e a impressão de etiquetas ficarão fora da implementação prática desta entrega.
  - Cancelar uma venda: gerente ou fiscal de caixa.
  - Validar o fechamento de caixa: fiscal de caixa ou gerente. A conferência inicial é realizada pelo operador do caixa.
  - Registrar o responsável por cancelamentos e alterações de preço: o sistema proposto deverá armazenar o usuário responsável, a data e o horário de cada operação [Proposta].
    
- **RN11 — Produtos a granel [Proposta]:** produtos vendidos por peso têm a quantidade registrada em quilos e o valor calculado pelo preço por quilo. As balanças devem atender às exigências do Inmetro.

- **RN12 — Proteção de dados pessoais, LGPD [Proposta]:** o sistema deve proteger os dados pessoais de funcionários e de contatos de fornecedores, como nome, CPF e telefone. Só funcionários autorizados podem acessá-los, e o armazenamento deve seguir a Lei Geral de Proteção de Dados.

**Regras comuns não incluídas**

- Cadastro de clientes e programa de fidelidade: o mercado não cadastra clientes.
- Pagamento por Pix: o mercado não o aceita.
- Normas sanitárias, contas a pagar e escala de funcionários: não foram levantadas na entrevista e não estão ligadas aos problemas declarados (P1 e P2). Ficam como evolução futura, a confirmar com o responsável.

---

#### Delimitação do Escopo da Implementação

A implementação do banco de dados do Hortifruti União terá como prioridade atender aos dois problemas principais identificados durante o levantamento:

- **P1 — Controle da validade dos lotes:** permitir o registro dos lotes, suas datas de validade, quantidades disponíveis, movimentações de estoque e perdas, possibilitando a identificação de produtos vencidos ou próximos do vencimento.
- **P2 — Controle de acesso e rastreabilidade:** permitir a identificação dos usuários, a associação de funcionários a perfis de acesso e o registro de operações relevantes, como alterações de preços e cancelamentos de vendas.

#### Ampliação do Modelo Conceitual para o Problema P2

Para atender ao problema P2 — Controle de acesso às funções do sistema, o grupo definiu a necessidade de ampliar o modelo conceitual com entidades relacionadas à identificação de usuários e à rastreabilidade de operações.

As novas entidades planejadas são:

- **USUARIO:** representa as credenciais de acesso vinculadas a um funcionário.
- **PERFIL_ACESSO:** identifica o perfil atribuído ao usuário, como operador de caixa, fiscal de caixa ou gerente.
- **AUDITORIA:** registra operações relevantes, incluindo o usuário responsável, a data, o horário e o tipo de ação realizada.
- **ALTERACAO_PRECO:** registra o produto alterado, o preço anterior, o novo preço e o responsável pela alteração.

Essas entidades complementarão o modelo existente, que já contempla produtos, fornecedores, compras, vendas, pagamentos, lotes e perdas.

A ampliação ainda será representada e validada no DER conceitual e posteriormente convertida para o modelo lógico relacional. As permissões específicas de cada perfil também deverão ser definidas para que o controle de acesso esteja coerente com as regras de negócio do projeto.

**Funcionalidades incluídas no escopo:**

- Cadastro de produtos, categorias, fornecedores e funcionários.
- Registro de pedidos de compra e seus itens.
- Controle de lotes, estoque, validade e perdas.
- Registro de vendas, itens vendidos e pagamentos.
- Registro das saídas de produtos por lote, considerando a estratégia FEFO.
- Cadastro de usuários e perfis de acesso.
- Histórico de alterações de preços e cancelamentos.
- Registro simplificado do fechamento de caixa, com valores conferidos e identificação dos responsáveis.
- Consultas SQL para demonstrar as operações do banco de dados e gerar indicadores gerenciais.

**Funcionalidades fora do escopo da implementação prática:**

- Emissão e autorização fiscal de notas fiscais junto aos órgãos competentes.
- Impressão física de etiquetas de preços.
- Integração automática com o ERP VR Software utilizado pelo estabelecimento.
- Operação dos caixas sem internet e sincronização posterior.
- Desenvolvimento de interfaces completas para operadores e gestores.
- Implementação de modelos preditivos de inteligência artificial.

Essas funcionalidades poderão ser consideradas em evoluções futuras do projeto. A emissão fiscal continuará sendo reconhecida como uma necessidade operacional e legal do estabelecimento, mas sua integração técnica não será desenvolvida nesta entrega.

**Limites da implementação:** o projeto será demonstrado por meio do modelo lógico relacional, scripts SQL, dados fictícios e consultas realizadas no MySQL. As regras de autorização, a estratégia FEFO e as operações de estoque serão representadas e testadas na medida em que forem implementadas no banco de dados, sem pressupor a existência de uma aplicação completa.

A delimitação busca concentrar o desenvolvimento nas funcionalidades essenciais para os problemas P1 e P2, mantendo a coerência entre o levantamento de requisitos, os diagramas e a implementação SQL.

#### DER Conceitual Revisado

**Software utilizado:** brModelo 3.2.0. O DER conceitual foi elaborado utilizando a notação de entidades, atributos, relacionamentos e cardinalidades mínimas e máximas do brModelo. As chaves estrangeiras serão representadas no modelo lógico.

![DER conceitual revisado](diagramas/der_conceitual.png)

**Situação do DER conceitual:** o modelo foi elaborado no brModelo e está em processo de ampliação para contemplar o controle de acesso e a rastreabilidade das operações (P2). Após a conclusão das alterações, a imagem revisada será disponibilizada na pasta `diagramas/` do repositório, com o nome `der_conceitual.png`.
**Resumo das entidades e relacionamentos do DER revisado:**

| Entidade 1 | Relacionamento | Entidade 2 | Cardinalidade |
|---|---|---|---|
| PRODUTO | POSSUI | LOTE | (0,N) / (1,1) |
| CATEGORIA_PRODUTO | CLASSIFICA | PRODUTO | (0,N) / (1,1) |
| FORNECEDOR | FORNECE | PRODUTO | (0,N) / (0,N) |
| FORNECEDOR | RECEBE | PEDIDO_COMPRA | (0,N) / (1,1) |
| PEDIDO_COMPRA | CONTÉM | ITEM_PEDIDO_COMPRA | (1,N) / (1,1) |
| PRODUTO | SOLICITADO | ITEM_PEDIDO_COMPRA | (0,N) / (1,1) |
| FUNCIONARIO | REGISTRA | VENDA | (0,N) / (1,1) |
| VENDA | CONTÉM | ITEM_VENDA | (1,N) / (1,1) |
| PRODUTO | VENDIDO | ITEM_VENDA | (0,N) / (1,1) |
| VENDA | POSSUI | PAGAMENTO | (1,N) / (1,1) |
| LOTE | REGISTRA | PERDA | (0,N) / (1,1) |
| FUNCIONARIO | REGISTRA | PERDA | (0,N) / (1,1) |
| ITEM_VENDA | POSSUI | SAIDA_LOTE | (1,N) / (1,1) |
| LOTE | ORIGINA | SAIDA_LOTE | (0,N) / (1,1) |

*As cardinalidades estão apresentadas na ordem das entidades indicadas em cada linha.*

**Apontamentos da correção da Entrega 1:**

| Apontamento da correção da E1 | O que mudou no trabalho | Por quê |
|---|---|---|
| Processos de negócio incompletos | Foram detalhados os processos de vendas, compras, recebimento, estoque, pagamentos, cancelamentos, alterações de preços, controle de acesso e fechamento de caixa. | Para apresentar melhor o funcionamento do mercado e as melhorias propostas. |
| Fluxogramas apenas como anexos do GitHub | Os fluxogramas foram organizados como arquivos do repositório. | Para permitir que o professor visualize os arquivos diretamente pelo projeto. |
| Regras de negócio incompletas | Foram acrescentadas regras sobre validade, estoque mínimo, FEFO, perdas, pagamentos, permissões, produtos a granel e LGPD. | Para deixar o modelo mais completo e coerente com os processos. |
| Inconsistência no cadastro de clientes | A entidade CLIENTE foi retirada do modelo proposto. | O mercado não realiza cadastro de clientes para registrar as vendas. |
| Cardinalidades e relacionamentos incorretos | Foram revisadas as cardinalidades e criadas entidades para representar itens de compra, itens de venda, lotes, pagamentos e perdas. | Para representar corretamente as relações entre os dados. |
| DER não disponível como arquivo do repositório | O DER foi reconstruído no brModelo e será disponibilizado como arquivo do projeto. | Para corrigir o problema de entrega apontado pelo professor. |
| Dicionário de dados incompleto | O dicionário será atualizado com base no modelo lógico revisado, incluindo chaves, tipos de dados, restrições e índices. | Para corrigir as inconsistências e completar a documentação técnica. |
| Justificativas técnicas superficiais | Serão apresentadas justificativas para as entidades, os relacionamentos, as cardinalidades e as decisões de implementação. | Para demonstrar o entendimento do grupo sobre o modelo desenvolvido. |

### 1.2 Conversão do Modelo Conceitual para o Modelo Lógico

**Entidades → Tabelas:** As 12 entidades identificadas no modelo conceitual foram convertidas em tabelas no modelo lógico: PRODUTO, CATEGORIA_PRODUTO, FORNECEDOR, PEDIDO_COMPRA, ITEM_PEDIDO_COMPRA, LOTE, FUNCIONARIO, VENDA, ITEM_VENDA, PAGAMENTO, PERDA e SAIDA_LOTE.

**Atributos → Colunas:** Os atributos de cada entidade foram transformados em colunas das respectivas tabelas. Por exemplo, os atributos codigo_produto, nome_produto, preco_unitario e unidade_medida passaram a compor a tabela PRODUTO. Os atributos identificadores deram origem às chaves primárias.

**Relacionamentos → Chaves:** Os relacionamentos entre as entidades foram analisados para definir as chaves estrangeiras. Por exemplo, cada lote pertence a um produto, por isso a tabela LOTE deve conter a chave estrangeira codigo_produto, referenciando a tabela PRODUTO.

**Cardinalidades:** nos relacionamentos 1:N, a chave estrangeira é inserida na tabela do lado N. Nos relacionamentos N:N, é necessária uma tabela associativa. No modelo conceitual, o relacionamento FORNECE liga as entidades FORNECEDOR e PRODUTO, ambas com cardinalidade (0,N). Na conversão para o modelo lógico, esse relacionamento é representado pela tabela associativa FORNECEDOR_PRODUTO, cuja chave primária é composta por `codigo_fornecedor` e `codigo_produto`. As tabelas ITEM_PEDIDO_COMPRA, ITEM_VENDA e SAIDA_LOTE também permitem representar os itens e as movimentações relacionados às operações do mercado.

**Generalização/especialização:** Não foram utilizados relacionamentos de generalização ou especialização no modelo conceitual, pois as entidades identificadas não exigiram esse tipo de estrutura para representar o escopo definido pelo grupo.

### 1.3 Definição de Chaves Primárias e Estrangeiras

| Tabela | Chave primária (PK) | Chaves estrangeiras (FK) |
|---|---|---|
| PRODUTO | codigo_produto | codigo_categoria → CATEGORIA_PRODUTO |
| CATEGORIA_PRODUTO | codigo_categoria | Não possui |
| FORNECEDOR | codigo_fornecedor | Não possui |
| FORNECEDOR_PRODUTO | codigo_fornecedor + codigo_produto (PK composta) | codigo_fornecedor → FORNECEDOR; codigo_produto → PRODUTO |
| PEDIDO_COMPRA | codigo_pedido | codigo_fornecedor → FORNECEDOR |
| ITEM_PEDIDO_COMPRA | codigo_item_pedido | codigo_pedido → PEDIDO_COMPRA; codigo_produto → PRODUTO |
| LOTE | codigo_lote | codigo_produto → PRODUTO |
| FUNCIONARIO | codigo_funcionario | Não possui |
| VENDA | codigo_venda | codigo_funcionario → FUNCIONARIO |
| ITEM_VENDA | codigo_item_venda | codigo_venda → VENDA; codigo_produto → PRODUTO |
| PAGAMENTO | codigo_pagamento | codigo_venda → VENDA |
| PERDA | codigo_perda | codigo_lote → LOTE; codigo_funcionario → FUNCIONARIO |
| SAIDA_LOTE | codigo_saida_lote | codigo_item_venda → ITEM_VENDA; codigo_lote → LOTE |

### 1.4 Processo de Normalização (1FN, 2FN e 3FN)

**1FN — Primeira Forma Normal:** As tabelas foram organizadas para que cada coluna contenha um único valor, sem listas de informações ou grupos repetidos. Por exemplo, os produtos de uma venda são registrados separadamente na tabela ITEM_VENDA, e os produtos de um pedido de compra ficam na tabela ITEM_PEDIDO_COMPRA. Isso permite armazenar vários itens sem repetir as informações gerais da venda ou do pedido.

**2FN — Segunda Forma Normal:** Os atributos não-chave devem depender da chave primária completa. Na tabela associativa FORNECEDOR_PRODUTO, a combinação de codigo_fornecedor e codigo_produto identifica cada associação. Informações como razão social e nome do produto permanecem nas tabelas FORNECEDOR e PRODUTO, evitando dependências de apenas uma parte dessa chave composta.

**3FN — Terceira Forma Normal:** As tabelas foram organizadas para evitar dependências transitivas entre atributos não-chave. Por exemplo, PEDIDO_COMPRA armazena codigo_fornecedor como chave estrangeira, enquanto a razão social, o CNPJ e o telefone permanecem na tabela FORNECEDOR. Da mesma forma, PRODUTO guarda codigo_categoria, e o nome da categoria permanece em CATEGORIA_PRODUTO.

**Justificativa do processo:** A normalização foi considerada para reduzir a repetição de informações, evitar inconsistências durante cadastros e atualizações e facilitar a manutenção do banco de dados. No Hortifruti União, essa organização permite relacionar produtos, fornecedores, compras, vendas e lotes sem duplicar desnecessariamente seus dados. O atendimento às três formas normais será confirmado na revisão final do modelo lógico e do script SQL.

### 1.5 Justificativas Técnicas das Decisões

**Chaves primárias:** Cada tabela possui uma chave primária para identificar seus registros de maneira única. Foram utilizados códigos identificadores, como `codigo_produto`, `codigo_lote` e `codigo_venda`. Na tabela associativa `FORNECEDOR_PRODUTO`, foi definida uma chave primária composta por `codigo_fornecedor` e `codigo_produto`, impedindo que a mesma associação seja cadastrada duas vezes.

**Chaves estrangeiras e relacionamentos:** As chaves estrangeiras representam as ligações entre as tabelas e ajudam a manter a integridade dos dados. Por exemplo, `PEDIDO_COMPRA` utiliza `codigo_fornecedor` para identificar o fornecedor responsável, enquanto `ITEM_PEDIDO_COMPRA` utiliza `codigo_pedido` e `codigo_produto` para relacionar cada item ao pedido e ao produto solicitado. Já `SAIDA_LOTE` utiliza `codigo_item_venda` e `codigo_lote` para registrar de quais lotes saíram as quantidades vendidas.

**Restrições aplicadas:** O modelo prevê códigos únicos e campos obrigatórios, além de restrições relacionadas às regras de negócio. O CNPJ dos fornecedores deverá ser único e válido (RN04). Cada produto deverá pertencer a uma categoria cadastrada (RN16). Os pedidos de compra deverão possuir pelo menos um item (RN13). O sistema deverá impedir vendas de produtos vencidos (RN01), bloquear quantidades superiores ao estoque disponível (RN18) e registrar as saídas dos lotes pelo método FEFO (RN14). Nos pagamentos, a soma dos valores deverá corresponder ao total da venda (RN15). Algumas dessas regras exigirão validações na aplicação ou operações transacionais, além das restrições do banco de dados.

**Decisões arquiteturais gerais:** O grupo optou por um banco de dados relacional em MySQL, utilizando tabelas separadas para produtos, fornecedores, compras, vendas, lotes, pagamentos e perdas. Essa estrutura permite organizar as informações, reduzir duplicações e relacionar as movimentações de estoque às operações realizadas. O controle por lote foi proposto como melhoria para acompanhar a validade das mercadorias e reduzir desperdícios. O modelo também prevê rastreabilidade das saídas e histórico das perdas, apoiando futuras consultas e análises gerenciais.

### 1.6 Proposta de Arquitetura Analítica para BI e IA

**Informações estratégicas que podem ser extraídas dos dados:** O banco de dados proposto permitirá acompanhar o volume de vendas, os produtos mais vendidos, as perdas por vencimento, os lotes próximos da validade, os níveis de estoque e os pagamentos por forma de recebimento. Essas informações poderão ajudar o Hortifruti União a identificar desperdícios e planejar melhor suas compras.

**Indicadores e métricas gerenciais (KPIs):**

| Indicador | Como calcular | Período |
|---|---|---|
| Valor das perdas por vencimento | Soma da quantidade perdida por vencimento multiplicada pelo custo unitário correspondente | Mensal |
| Percentual de perdas sobre as vendas | (Valor total das perdas ÷ valor total das vendas) × 100 | Mensal |
| Quantidade de lotes próximos do vencimento | Contagem dos lotes com estoque disponível e validade dentro do prazo de alerta | Diário |
| Produtos abaixo do estoque mínimo | Contagem dos produtos cuja quantidade disponível está abaixo do estoque mínimo cadastrado | Diário |
| Faturamento por período | Soma dos valores das vendas concluídas, descontando os cancelamentos conforme o tratamento definido | Diário e mensal |

**Potencial dos dados para BI:** Os dados poderão ser utilizados para construir painéis com gráficos de vendas, evolução das perdas, produtos mais vendidos e situação dos estoques. O gerente poderá consultar esses indicadores para acompanhar o desempenho do mercado e identificar produtos que precisam de maior atenção.

**Aplicações analíticas e de IA:** Futuramente, técnicas de inteligência artificial poderão ser utilizadas para prever a demanda de produtos, identificar mercadorias com maior risco de vencimento e sugerir quantidades de reposição. Essas análises dependerão da existência de dados históricos suficientes e de registros confiáveis de vendas, estoque e perdas.

**Rastreabilidade:**

| Problema ou indicador | Tabelas envolvidas | Consulta SQL planejada |
|---|---|---|
| P1 — Controle da validade dos lotes | PRODUTO, LOTE, PERDA | G01 — Lotes próximos do vencimento |
| P2 — Controle de acesso às funções do sistema | FUNCIONARIO e tabelas de usuários, permissões e auditoria a definir | G02 — Operações por funcionário |
| Valor das perdas por vencimento | LOTE, PRODUTO, PERDA e dados de custo | G03 — Perdas por vencimento |
| Produtos abaixo do estoque mínimo | PRODUTO, LOTE | G04 — Estoque abaixo do mínimo |
| Faturamento por período | VENDA | G05 — Faturamento por período |

*As consultas apresentadas serão desenvolvidas e testadas na etapa de implementação SQL. O indicador financeiro de perdas dependerá do registro do custo dos produtos, e a análise de controle de acesso dependerá das estruturas de usuários e auditoria previstas para o sistema.*

---

## 2. Modelo Lógico Relacional

**Software utilizado:** brModelo. O modelo lógico foi gerado a partir do DER conceitual e está em processo de revisão, especialmente das chaves estrangeiras e dos relacionamentos entre as tabelas.

![Modelo lógico](diagramas/modelo_logico.png)

O modelo lógico relacional está em processo de revisão para representar todas as entidades, colunas, tipos de dados, chaves primárias, chaves estrangeiras e cardinalidades do sistema proposto. As demais restrições de integridade, como `NOT NULL`, `UNIQUE`, `CHECK` e `DEFAULT`, serão documentadas no arquivo `Dicionario_Dados.md` e implementadas no script `docs/script.sql` após a conclusão e validação do modelo lógico.

---

## 3. Script SQL Completo

**SGBD escolhido:** MySQL.

**Arquivo previsto:** `docs/script.sql`

O script SQL será desenvolvido a partir do modelo lógico revisado. Ele deverá conter a criação do banco de dados e das tabelas, incluindo chaves primárias, chaves estrangeiras e restrições necessárias para manter a integridade das informações.

A implementação também incluirá comandos para inserir, consultar, atualizar e excluir dados, além de consultas gerenciais relacionadas aos problemas identificados no Hortifruti União.

**Comandos previstos:**
- `CREATE DATABASE` e `CREATE TABLE`: criação do banco e das tabelas.
- `INSERT INTO`: inserção de dados fictícios.
- `SELECT` e `JOIN`: consultas entre tabelas.
- `UPDATE` e `DELETE`: atualização e exclusão controlada de dados.
- **G01 a G05:** consultas gerenciais propostas na seção 1.6.
- **A01 e A02:** consultas de auditoria, caso as estruturas necessárias sejam implementadas.

Os comandos serão testados no MySQL, e os resultados relevantes serão documentados antes da entrega final.
---

## 4. Massa de Dados

**Arquivo previsto:** `docs/massa_de_dados.sql`, podendo ser integrado ao arquivo `docs/script.sql`.

A massa de dados será composta por registros fictícios, criados exclusivamente para testar o funcionamento do banco de dados. Não serão utilizados dados pessoais reais de funcionários, fornecedores ou clientes do Hortifruti União.

**Justificativa do volume:** considerando o porte informado da organização, com aproximadamente 110 funcionários, 7 caixas e 2.400 transações diárias, os testes deverão utilizar uma quantidade de registros suficiente para representar diferentes situações do funcionamento do mercado. Não será necessário reproduzir todo o volume real de movimentações.

**Variedade dos dados:** serão incluídos produtos de diferentes categorias, fornecedores, pedidos de compra, lotes com datas de validade distintas, vendas com vários itens, pagamentos divididos e perdas por diferentes motivos. Também serão considerados exemplos de produtos abaixo do estoque mínimo, lotes vencidos ou próximos do vencimento, alterações de preços, operações de usuários com perfis diferentes e vendas canceladas.

**Objetivo dos testes:** verificar os relacionamentos entre as tabelas, o funcionamento das chaves estrangeiras, as restrições de integridade e os resultados das consultas SQL. Os dados também servirão para demonstrar indicadores gerenciais relacionados ao controle de estoque, vendas, perdas e rastreabilidade das operações.

**Situação atual:** a massa de dados ainda será criada e validada após a conclusão do modelo lógico e do script SQL. A quantidade final de registros e os resultados dos testes serão documentados antes da entrega.

---

### 5. Repositório GitHub

O projeto da Entrega 2 do Hortifruti União está sendo organizado no GitHub, na branch `main`, para reunir a documentação, os diagramas e os arquivos necessários à implementação do banco de dados.

**Organização prevista dos arquivos:**

| Arquivo ou pasta | Conteúdo |
|---|---|
| `README.md` | Relatório técnico da Entrega 2 |
| `Dicionario_Dados.md` | Definição das tabelas, colunas, tipos de dados, chaves e restrições |
| `diagramas/` | DER conceitual revisado e modelo lógico relacional |
| `imagens/evidencias/` | Fotografias e outras evidências do levantamento |
| `docs/script.sql` | Criação do banco de dados, operações e consultas SQL |
| `docs/massa_de_dados.sql` | Dados fictícios para testar o banco, caso sejam mantidos em arquivo separado |
| `apresentacao/` | Slides da apresentação final |

O repositório também permitirá acompanhar as contribuições do grupo por meio do histórico de commits. Cada integrante deverá utilizar sua própria conta do GitHub para registrar as alterações realizadas.

Os diagramas, scripts e demais arquivos serão adicionados conforme sua conclusão. Antes da entrega, o grupo deverá conferir se todos os links do README funcionam e se os arquivos estão acessíveis diretamente pelo repositório.

**Situação dos arquivos:** o README está em processo de atualização. O DER conceitual, o modelo lógico, o dicionário de dados, os scripts SQL e os materiais da apresentação serão conferidos e atualizados conforme a conclusão de cada etapa.

**Observação:** a estrutura apresentada na tabela representa a organização planejada do repositório. A existência dos arquivos e o funcionamento dos links deverão ser verificados antes da entrega final.


---

## 6. Uso de Inteligência Artificial

Se o grupo usou alguma ferramenta de IA (ChatGPT, Claude, Gemini, Perplexity etc.) em qualquer parte do trabalho, registre **para cada uso relevante**:

- Registro 1

| Item | O que registrar |
|------|------------------|
| **Ferramenta e etapa** |  Claude - Auxílio no aprendizado do GitHub.  |
| **Motivação** | Como ninguém do grupo era familiarizado com a rede social/ferramenta, optamos usar o Claude por saber que ele poderia ser mais técnico e direto ao mesmo tempo. |
| **Prompt(s) utilizados** | "Preciso criar um arquivo readme dentro do github, aprender a editar e adicionar colaboradores para que o meu grupo também tenha acesso, como eu faço isso?" 2) "Aparentemente você está passando informações da versão anterior do github, fale as informações da versão atual" |
| **Resposta recebida** | Resposta do segundo prompt: Resumo de 7 tópicos na sequência de como usar o GitHub -  1) Crie (ou acesse) o repositório, 2) Crie o arquivo README, 3) Escreva e formate o conteúdo, 4) Salve as alterações (commit), 5) Edite o README depois de criado, 6) Adicione colaboradores ao grupo, 7) Defina permissões (opcional). |
| **Fontes consultadas e verificadas** | O Claude apenas mandou o conhecimento que ele sabia sobre o GitHub no momento. |
| **Trechos rejeitados ou corrigidos** | Primeira sugestão da IA corrigida, pois os passos da primeira versão eram da versão anterior do GitHub. Avisamos a IA, que atualizou as instruções para a versão atual.|
| **Justificativa da escolha final** | Decidimos manter o uso do Claude nessa etapa por atender todas as nossas dúvidas sobre o github. |
| **Reflexão crítica** | Um pequeno erro foi identificado por algumas informações estarem desatualizadas, na primeira vez o claude estava ensinando a usar o github na versão anterior, mas depois de explicarmos que o GitHub poderia estar numa versão mais atual no momento, a IA atualizou as informações. |

- Registro 2

| Item | O que registrar |
|------|------------------|
| **Ferramenta e etapa** | Claude - Revisão ortográfica no documento README.|
| **Motivação** | Preferência geral do grupo ao uso do Claude.|
| **Prompt(s) utilizados** | 1) "Revise pra mim todos os erros de ortográfia dentro desse arquivo README e me passe para eu corrigir manualmente." 2) "Se existem erros de menor impacto, me informe todos que estão presentes. |
| **Resposta recebida** | 1) 2 pequenos erros de inconsistência no trabalho apresentado, e alguns erros de digitação. 2) Lista com todos os 21 erros de digitação presentes no documento. |
| **Fontes consultadas e verificadas** |  A IA não citou fontes. O grupo conferiu a inconsistência apontada comparando com a documentação do trabalho. |
| **Trechos rejeitados ou corrigidos** | Não houve trechos rejeitados ou corrigidos. |
| **Justificativa da escolha final** | O grupo decidiu manter as correções do Claude porque ele identificou a inconsistência principal: o título dizia "informação de uma empresa de pequeno porte", mas a documentação deixa claro que é uma empresa de médio porte. Os erros de ortografia também foram aceitos, pois eram apenas erros de digitação. |
| **Reflexão crítica** | A IA trouxe apenas os erros mais relevantes inicialmente, sendo necessário pedir novamente para que ela listasse todos os erros encontrados no documento, incluindo os de menor destaque. |

- Registro 3

| Item | O que registrar |
|------|------------------|
| **Ferramenta e etapa** | Claude - Auxílio na organização e redação da documentação do modelo conceitual (item 6 do esqueleto de entrega). |
| **Motivação** | Preferência do grupo. |
| **Prompt(s) utilizados** | [Enviamos um print mostrando os 4 tópicos do item 6 que o esqueleto pedia e enviei a imagem do nosso DER] - "de acordo com essas instruções do esqueleto de entrega, como eu posso colocar as informações de uma maneira organizada?" |
| **Resposta recebida** | Dicas de como estruturar os 4 tópicos do que o item 6 do esqueleto pedia, exemplo: 1. Entidades reconhecidas — não basta listar o nome, tem que justificar por que ela existe no modelo. Para cada entidade (Fornecedor, Pedido_Compra, Categoria_Produto, Produto, Cliente, Venda, Funcionário), explique em 1-2 frases: o que ela representa no negócio e por que era necessário capturar esses dados. Você já tem isso relativamente bem no README — o ponto de atenção é sempre conectar com a necessidade real levantada na entrevista, não só descrever o óbvio. |
| **Fontes consultadas e verificadas** | Não houve fontes citadas pela IA. |
| **Trechos rejeitados ou corrigidos** | Foi corrigida apenas a ordem da estrutura sugerida pela IA, mantendo a sequência que estava dentro do esqueleto de entrega. |
| **Justificativa da escolha final** | Mantivemos a estrutura sugeridada pela IA porque batia com o que estava presente nos slides fornecidos na matéria. |
| **Reflexão crítica** | Observamos apenas um erro de ordem: a IA sugeriu os tópicos numa sequência diferente da que pedimos, e ajustamos manualmente. |

- Registro 4

| Item | O que registrar |
|------|------------------|
| **Ferramenta e etapa** | Claude - Revisão geral do DER criado. |
| **Motivação** | Preferência geral do grupo no uso do Claude para revisar cardinalidades antes da entrega. |
| **Prompt(s) utilizados** | 1) "Revise para mim as informações dentro desse DER, e veja se está coerente com tudo que apresentei, e dê uma atenção maior às cardinalidades." 2) Sequência de perguntas referente ao DER, como por exemplo "por que a relação de produtos - contém - vendas é de N:N?". |
| **Resposta recebida** | Texto explicando as correções sugeridas nas cardinalidades do DER (a IA não alterou o DER diretamente). |
| **Fontes consultadas e verificadas** | A IA não consultou fontes. |
| **Trechos rejeitados ou corrigidos** | Nenhum trecho da resposta foi descartado. O grupo aplicou manualmente no DER as correções de cardinalidade sugeridas: Categoria_Produto (1) – Cadastra – (N) Produto, Produto (N) – Contém – (N) Venda, Pedido_Compra (N) – Cadastra – (N) Produto. |
| **Justificativa da escolha final** | A IA apenas enviou as informações por texto, a nosso pedido, e o grupo fez as alterações no DER manualmente, adaptando as sugestões ao nosso modelo. Aceitamos as correções porque identificamos coerência na resposta. |
| **Reflexão crítica** | Não identificamos erros nas sugestões da IA. Precisamos fazer uma série de perguntas para esclarecer as dúvidas do grupo, e aprendemos que quanto mais específico e detalhado o prompt, maior a probabilidade de a IA devolver o que realmente buscamos.  |

### Registro 5 — ChatGPT: Revisão da documentação e apoio à modelagem

| Item | Descrição |
|---|---|
| **Ferramenta e etapa** | ChatGPT — revisão do README, regras de negócio, DER conceitual e modelo lógico da Entrega 2. |
| **Motivação** | O grupo utilizou a ferramenta como apoio para compreender os conceitos de modelagem de banco de dados, organizar a documentação e identificar possíveis inconsistências entre os requisitos e os diagramas. |
| **Prompts utilizados** | Exemplos: "O que é uma chave primária?", "Estamos fazendo com base nas regras?", "Me mande uma tabela para eu fazer sozinha o DER" e "Se eu terminar o modelo lógico, ele gera o SQL automático?". |
| **Respostas recebidas** | Explicações sobre entidades, atributos, chaves primárias e estrangeiras, cardinalidades e relacionamentos. A ferramenta também sugeriu ajustes nas regras de negócio e textos para organizar as seções do README. |
| **Fontes consultadas e verificadas** | As sugestões foram comparadas com as informações levantadas sobre o Hortifruti União, as regras de negócio registradas no README e as observações feitas pelo professor na correção da Entrega 1. |
| **Trechos rejeitados ou corrigidos** | Algumas sugestões precisaram ser revistas após novas informações do estabelecimento. Também foram identificadas dúvidas e inconsistências na orientação sobre cardinalidades e no posicionamento das chaves estrangeiras geradas pelo brModelo. |
| **Justificativa da escolha final** | O grupo aproveitou as explicações e sugestões consideradas coerentes com o projeto, realizando as alterações manualmente no README e nos diagramas. |
| **Reflexão crítica** | O uso do ChatGPT ajudou na compreensão dos conceitos e na organização da Entrega 2, mas mostrou a importância de conferir as respostas. Nem todas as sugestões estavam corretas inicialmente, sendo necessário comparar as orientações com as regras do projeto e revisar algumas decisões. 

**Registro complementar de uso de IA:** As ferramentas de inteligência artificial também foram utilizadas como apoio à análise dos processos de negócio, à elaboração de propostas de regras para o Hortifruti União e à organização da documentação da Entrega 2. As sugestões não foram consideradas automaticamente corretas: foram comparadas com as informações obtidas no levantamento e com os requisitos definidos pelo grupo.

Os usos posteriores de IA na elaboração da massa de dados, das consultas SQL e dos indicadores gerenciais deverão ser documentados conforme essas atividades forem realizadas, incluindo os prompts utilizados, os resultados aproveitados, as correções e as decisões do grupo.

*Uso de IA observado e não declarado será penalizado.*

---

### 7. Apresentação Corporativa Final

**Situação:** apresentação em preparação.

**Slides:** o arquivo da apresentação será adicionado à pasta `apresentacao/` do repositório após sua conclusão.

**Roteiro previsto para a apresentação de 8 minutos:**

| Etapa | Tempo | Conteúdo |
|---|---|---|
| 1. Apresentação da organização | 1 minuto | Caracterização do Hortifruti União e problemas identificados |
| 2. Solução proposta | 1 minuto | Controle de validade por lote, redução de perdas e controle de acesso |
| 3. Modelagem do banco de dados | 2 minutos | DER conceitual, modelo lógico, entidades, chaves e relacionamentos |
| 4. Implementação SQL | 2 minutos | Demonstração do banco de dados e das consultas no MySQL |
| 5. BI e Inteligência Artificial | 1 minuto | Indicadores gerenciais e possibilidades de análise |
| 6. Conclusão | 1 minuto | Benefícios esperados e considerações finais |

**Demonstração prática:** após a implementação, o grupo deverá selecionar consultas SQL que demonstrem o controle de validade, as movimentações de estoque e outras funcionalidades efetivamente implementadas.

**Divisão entre os integrantes:** será definida pelo grupo antes da apresentação.

O roteiro poderá ser ajustado conforme a conclusão do modelo lógico, dos scripts SQL e dos testes.
