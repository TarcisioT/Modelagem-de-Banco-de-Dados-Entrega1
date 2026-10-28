# Entrega 2 — Modelo Lógico, Implementação SQL e Apresentação Final

### Modelagem de um sistema de gestão de informações — Hortifruti União (Tatuapé)

**Relatório Técnico Final — Entrega 2.** Continuamos com o Hortifruti União (Tatuapé), a mesma organização da Entrega 1. Os números de movimento vieram da entrevista; não conferimos porte jurídico nem fiscal. O esqueleto fala em “organização de pequeno porte”, mas o mercado tem cerca de 110 funcionários e um volume alto de vendas. Se o professor pedir, ajustamos essa classificação com ele.

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

- **Nome e natureza da organização:** Hortifruti União – Tatuapé, empresa privada com fins lucrativos, do comércio varejista alimentício.

- **Contexto e dimensão operacional:** o mercado abre todos os dias. Os números abaixo são o que o responsável nos passou na conversa; não saíram de relatório do ERP nem de auditoria:

  - **Pessoas:** uns 110 funcionários e 7 caixas.
  - **Vendas:** em média 2.400 transações por dia (cerca de 72.000 no mês), ticket médio de R$ 70 e faturamento perto de R$ 5,04 milhões por mês.
  - **Produtos:** 28 mil SKUs no cadastro, entre ativos e inativos.
  - **Fornecedores:** 650 cadastrados; uns 350 tiveram movimentação nos últimos 90 dias.
  - **Recebimento:** cerca de 1.200 lotes por semana (lote = produto + fornecedor + identificação no recebimento).
  - **Perdas:** cerca de R$ 75 mil por mês (em torno de 1,5% do faturamento), somando vencimento, avaria, quebra e produto estragado.

- **Problemas e necessidades identificados:**

  - **P1 — Controle de validade e rastreabilidade dos lotes:** no VR Software dá para cadastrar validade, mas esse registro não é usado de forma sistemática no dia a dia. Lotes diferentes do mesmo produto compartilham o mesmo código de barras, então esse código, sozinho, não distingue um lote do outro. A organização da gôndola e do estoque também pode dificultar que o que vence primeiro saia antes.

  - **O que o modelo faz com o P1:** cada lote tem código próprio, produto, validade e saldo (`LOTE`). A venda liga a quantidade ao lote em `SAIDA_LOTE`, e o descarte vai para `PERDA`. G01 e G02 mostram o que está para vencer ou já venceu; G03 mostra o custo da perda. **O que o banco sozinho não resolve:** o código de barras continua sendo do produto, não do lote. Sem um jeito de marcar o lote na hora de separar a mercadoria, a rastreabilidade no papel não vira prática no salão. Consulta também não substitui FEFO, bloqueio no caixa nem a organização física.

- **Escopo do sistema:** o banco cobre o que de fato levantamos — não só estoque e também não “toda a administração” do hortifruti. O que ficou de fora está justificado mais abaixo.

  Entram:
  - categorias, produtos, fornecedores e funcionários;
  - pedidos de compra e itens;
  - recebimento e dados da NF de entrada;
  - lotes, validade, saldo, saída por lote e perda;
  - vendas, itens, pagamentos e, em `VENDA`, campos para cancelamento.

  As consultas e a demonstração SQL giram em torno do **P1** (validade e lote). Compra, venda, pagamento e responsável entram para o modelo fazer sentido. FEFO automático, permissão por cargo, baixa automática do saldo e fechamento de caixa **não** têm módulo nesta entrega.

  **O que existe no mercado e o que fizemos com isso:**

  - **Cancelamento de venda:** campos em `VENDA` (`situacao_venda`, `motivo_cancelamento`, `data_hora_cancelamento`, `codigo_funcionario_cancelamento`). O script **não** mostra um `UPDATE` de cancelamento.
  - **Preço e histórico:** o VR já guarda horário e usuário. Aqui só fica o preço atual em `PRODUTO.preco_venda`.
  - **Fechamento de caixa:** o responsável confirmou o processo. Não criamos tabela de fundo, contagem e diferença. Dá para consultar venda e pagamento; não substitui o caixa do ERP.
  - **NF de saída e integração com o VR:** fora do trabalho prático. A obrigação fiscal continua com eles.
  - **Tela de caixa, etiqueta e senha:** fora desta entrega.

  **Processos comuns de varejo que não modelamos porque o levantamento não deu base** (não estamos dizendo que não existem): contas a pagar, escala e ponto.

- **Justificativa da escolha:** é um comércio real, com compra, recebimento, estoque e venda. O Tarcisio conhece um dos responsáveis, e por isso conseguimos a entrevista, a visita e os números. Isso **não** tira a obrigação de comprovar entrevista e visita. O caso serve para a disciplina porque a dificuldade no controle das informações de lote e validade aparece na operação e pode ser trabalhada num banco relacional.

- **Evidências da organização:**

  - [Localização no Google Maps](https://www.google.com/maps/search/?api=1&query=Rua+Filipe+Camar%C3%A3o%2C+67%2C+Tatuap%C3%A9%2C+S%C3%A3o+Paulo)
  - **Perfil comercial no Google:** [Consultar perfil do Hortifruti União no Google](https://share.google/LWFseN2UxnhQwKsNh)
  - **Endereço:** Rua Filipe Camarão, nº 67, Tatuapé, São Paulo, CEP 03065-000
  - **Contato da organização:** perfil comercial público no Google
  - **Responsável entrevistado:** Guilherme Takemoto
  - **Função:** um dos proprietários do Hortifruti União – Tatuapé
  - **Telefone de contato autorizado:** (11) 99317-0906

![Fotografia da fachada](imagens/evidencias/fachada_mercado.jpeg)

![Fotografia do interior](imagens/evidencias/interior_mercado.jpeg)

![Fotografia do estoque](imagens/evidencias/estoque_mercado.jpeg)

#### Relato da entrevista

- **Quem:** Guilherme Takemoto, um dos proprietários do Hortifruti União – Tatuapé. Quem entrevistou, visitou e tirou as fotos foi o Tarcisio Santos de Oliveira. Os outros integrantes não foram à entrevista nem à visita.

- **Quando e onde:**
  - Conversa de cerca de uma hora por videochamada (WhatsApp) em **22/09/2026**. Não foi no mercado.
  - Observação no salão e no estoque em **30/09/2026**, Rua Filipe Camarão, 67, Tatuapé.
  - Depois o grupo confirmou com o responsável: pedido por e-mail, NF na entrada, pagamento dividido e fechamento de caixa. **Ainda precisamos conferir a data e o canal dessa conversa no registro original.**

- **O que ele nos disse:** volumes; uso do VR Software; validade existe no sistema, mas seu registro não é usado de forma sistemática; mesmo código de barras para lotes diferentes; pedido por e-mail; entrada com NF; pagamento em dinheiro, débito e crédito (sem Pix), podendo dividir; permissão por cargo; cancelamento de venda já fechada só com gerente ou fiscal; fechamento de caixa no fim do dia, conferindo o dinheiro.

- **O que Tarcisio observou no local:** movimento do salão e do estoque e organização das mercadorias. A visita levantou o risco de não priorizar o que vence primeiro. Ele também registrou as fotos da fachada, do interior e do estoque.

- **Comprovação da visita:** fotos JPG/JPEG em `imagens/evidencias/`.

- **Visita e comprovação da entrevista:** o Tarcisio foi ao Hortifruti União em **30/09/2026** (Rua Filipe Camarão, 67). Esteve no local, observou o salão e o estoque e tirou as fotos da fachada, do interior e do estoque (`imagens/evidencias/`). **Não ficou foto junto com o responsável** — esqueceu de registrar. A conversa longa de levantamento foi por videochamada (WhatsApp) em **22/09/2026**. Combinamos com o professor que a comprovação da entrevista pode ser pelo telefone, sem exigir a foto dos dois no estabelecimento.

**Levantamento completo:** [levantamento/levantamento.md](levantamento/levantamento.md)

**Resumo:** o Hortifruti União usa o VR Software, tem 7 caixas e cerca de 2.400 transações por dia. Produto, fornecedor e preço já estão no ERP. O que falha na prática é o acompanhamento dos lotes e das validades: o código de barras não diferencia os lotes, e o registro da validade não é usado de forma sistemática. Compra vai por e-mail; entrada exige NF. Venda não cadastra cliente. Dá para pagar com mais de uma forma (dinheiro, débito, crédito); Pix não entra. Cancelamento e fechamento de caixa existem, com gerente ou fiscal. Contas a pagar, escala e ponto não foram explicados o bastante para virar tabela. Em relação à Entrega 1, retiramos a entidade CLIENTE (eles não cadastram cliente na venda), deixamos o problema declarado só no P1 e passamos a modelar lote, recebimento, perda e saída por lote.

---

#### Processos de Negócio

Os processos abaixo saíram da entrevista, da visita e, quando estiver escrito, de melhoria que o **grupo** propôs. Processos típicos de hortifruti foram checados com o responsável ou justificados quando ficaram de fora. O uso de IA para listar o que é comum no ramo está na seção 6. **Proposta nossa não é a mesma coisa que o responsável confirmou.**

##### 1. Processo de venda no caixa

O cliente apresenta os produtos no caixa. O funcionário identifica cada produto pelo código de barras e consulta nome e preço.

Para cada item registram-se produto, quantidade e preço unitário praticado. Calcula-se o total e registra-se a forma (ou as formas) de pagamento.

No banco acadêmico: `VENDA` (data/hora, funcionário, valor total, situação), `ITEM_VENDA` (produto, quantidade, preço praticado, subtotal), `PAGAMENTO` e `SAIDA_LOTE` (lotes e quantidades retiradas). O saldo disponível fica em `LOTE`. O script **não demonstra** `UPDATE` automático desse saldo após a venda. Identificação do caixa físico, leitura de código de barras em interface e documento fiscal oficial ficam no sistema do estabelecimento.

**Dados:** identificação da venda, data e horário, funcionário, produtos, quantidades, preços unitários, subtotais, valor total, formas de pagamento e situação da venda.

##### 2. Processo de pedido e recebimento de mercadorias

Pedidos aos fornecedores são feitos por e-mail. Na solução proposta, cada pedido é registrado e vinculado a um fornecedor cadastrado (`PEDIDO_COMPRA`, `ITEM_PEDIDO_COMPRA`: produto, quantidade solicitada, valor unitário previsto).

No recebimento, as mercadorias vêm com nota fiscal e são conferidas (produtos, quantidades, condições, lotes e validades). Divergências ficam em `RECEBIMENTO.observacao_divergencia`. Lotes aceitos entram em `LOTE`. Recebimento parcial e recusa detalhada não foram especificados o bastante na entrevista e não têm fluxo próprio nesta entrega.

**Dados:** pedido, fornecedor (razão social, CNPJ, e-mail), data, produtos, quantidades solicitadas e recebidas, valores unitários, número e série da NF, lote, validade, divergência e situação do recebimento.

##### 3. Processo de controle de estoque, lotes e validade

O estoque considera quantidades por produto e movimentações de entrada, venda e perda. Um produto pode ter vários lotes, cada um com número, validade e quantidade disponível. A data de recebimento está em `RECEBIMENTO.data_recebimento`, não em coluna `data_entrada` de `LOTE`.

Consulta-se estoque por código, nome ou código de barras; identificam-se produtos abaixo do mínimo (`PRODUTO.estoque_minimo`, consulta G04) e lotes próximos do vencimento (G01) ou vencidos (G02). A estratégia FEFO é regra proposta (RN14); a seleção automática do lote **não** está no script. Perdas (`PERDA`) registram lote, quantidade, data, motivo e funcionário; a baixa automática do saldo **não** é executada pelo script.

**Dados:** produto, código de barras, lote, número do lote, data de recebimento, validade, quantidade recebida, quantidade disponível, estoque mínimo, saídas, quantidade perdida, motivo e funcionário.

##### 4. Processo de pagamento

Aceita-se dinheiro, débito e crédito; não se aceita Pix. Uma venda pode ter mais de um pagamento; a soma deve igualar o total (RN15). O banco não tem campo de situação do pagamento; a situação da operação está em `VENDA`. A massa atual tem **um** pagamento; pagamento dividido **não** foi demonstrado no script.

**Dados:** identificação do pagamento, venda, forma, valor, data e horário.

##### 5. Processo de cancelamento

Retirada de item antes de concluir a venda não deve baixar estoque em definitivo. Cancelamento de venda já concluída depende de gerente ou fiscal de caixa (RN10). O banco tem campos para situação, motivo, data/hora e funcionário do cancelamento; o script **não executa** um cancelamento. Devolução ao lote de origem não foi demonstrada.

**Dados:** venda, itens, produtos, lotes, quantidades, motivo, data/hora, funcionário e situação.

##### 6. Processo de alteração de preços e emissão de etiquetas

Alteração de preço: líderes de setor, gerente e proprietários. O ERP já guarda histórico (horário e usuário). O banco acadêmico mantém só o preço atual. Etiquetas e impressão ficam fora da implementação prática.

**Dados consultáveis:** código do produto, código de barras, nome de gôndola e preço atual (`PRODUTO`).

##### 7. Processo de controle de acesso

O ERP aplica permissão por função. `FUNCIONARIO` identifica quem realizou venda ou perda. Não há login, senha, perfil nem auditoria de usuário neste banco. Identificar o funcionário na operação **não prova** que ele tinha permissão.

**Dados (propostos para evolução, não implementados):** usuário, senha protegida, perfil, permissão e log de auditoria.

##### 8. Processo de fechamento de caixa

Ao final do dia, o operador confere o dinheiro físico com o saldo esperado em espécie (fundo + entradas − saídas em dinheiro). Fiscal de caixa ou gerente valida. Cartões não entram na contagem física.

Não há módulo de abertura, fundo, contagem, diferença e validação. O banco guarda vendas e pagamentos para consulta, sem substituir o caixa do ERP.

**Dados (processo real, sem tabelas próprias):** caixa, data, operador, validador, fundo, entradas e saídas em dinheiro, saldo esperado, valor contado, diferença e situação.

##### Processos não incluídos no escopo atual

- **Contas a pagar:** vencimentos, parcelas e situação financeira não foram levantados com segurança.
- **Escala de funcionários:** não detalhada.
- **Jornada e ponto:** não detalhados.

Poderão entrar depois se o responsável confirmar regras e dados. Ficaram de fora por **falta de levantamento**, não porque o grupo diga que esses processos não existem.

Também ficam de fora: cadastro de cliente e fidelidade (o mercado não cadastra cliente na venda) e Pix (não aceito).

##### Fluxogramas

**Fluxograma do processo de venda:**

<img src="fluxograma_vendas.png" alt="Fluxograma do processo de venda" width="450">

**Fluxograma do processo de estoque:**

<img src="fluxograma_estoque.png" alt="Fluxograma do processo de estoque" width="450">

---

#### Requisitos do Sistema

**Sobre o que está implementado:** RFs e RNFs descrevem o sistema que propomos a partir do levantamento. A parte demonstrada até aqui é o banco MySQL, a massa fictícia e as consultas G01–G05 e A01–A05. Alerta, FEFO, permissão, baixa automática de saldo, tela e fiscal continuam como proposta (seção 1.5 e o [Dicionário de Dados](Dicionario_Dados.md)). As limitações do SQL descritas neste texto se referem à cópia usada na conferência; ainda falta alinhá-la com o arquivo final na `main`, como explicado nas seções 1.5 e 1.6.

##### Requisitos Funcionais

- **RF01 — Cadastro de produtos:** cadastrar produto com código identificador único, nome, código de barras, descrição de gôndola, descrição reduzida, categoria, unidade de medida, preço de venda e estoque mínimo (`PRODUTO`).

- **RF02 — Cadastro de categorias:** cadastrar categoria (ex.: frutas, verduras, mercearia, legumes) antes dos produtos que a utilizam (RN16).

- **RF03 — Cadastro de fornecedores:** cadastrar fornecedor com código, razão social, CNPJ, telefone e e-mail (`FORNECEDOR`). RN04 exige CNPJ válido e único e dados obrigatórios; a validação de dígitos do CNPJ não está no DDL.

- **RF04 — Consulta de produtos por fornecedor:** identificar produtos já pedidos a cada fornecedor via `FORNECEDOR`, `PEDIDO_COMPRA` e `ITEM_PEDIDO_COMPRA`. Não há tabela `FORNECEDOR_PRODUTO`; fornecedor sem pedido não tem lista de produtos.

- **RF05 — Pedido de compra:** registrar pedido vinculado a fornecedor cadastrado, com data, situação e itens (`PEDIDO_COMPRA`, `ITEM_PEDIDO_COMPRA`). Pela RN13, um pedido completo tem ao menos um item; a FK sozinha não garante isso.

- **RF06 — Recebimento de mercadorias:** registrar entrada com número da NF, produto, lote, quantidade recebida e validade, vinculado ao pedido, com divergência de conferência (RN02).

- **RF07 — Consulta de estoque:** consultar quantidade disponível por produto e por lote (código, nome ou código de barras) e indicar estoque abaixo do mínimo (RN06, G04).

- **RF08 — Registro de venda:** registrar venda com um ou mais produtos, quantidades, preços praticados, data e horário, situação e funcionário. Sem cadastro de cliente. Sem identificação do caixa físico nesta entrega.

- **RF09 — Valor da venda:** subtotal = quantidade × preço praticado; total = soma dos subtotais. Valores gravados em `ITEM_VENDA.subtotal` e `VENDA.valor_total`. Sem coluna calculada nem trigger nesta entrega.

- **RF10 — Retirada de item antes da conclusão:** requisito de aplicação de caixa; não demonstrado no script.

- **RF11 — Cancelamento de venda:** preservar histórico da venda concluída cancelada (situação, motivo, data/hora, funcionário). Autorização operacional: RN10. Devolução ao estoque: evolução futura. Script atual **não demonstra** cancelamento.

- **RF12 — Pagamento:** registrar pagamentos da venda (`PAGAMENTO`: forma, valor, data/hora). Vários pagamentos por venda (RN15). O SQL usado na conferência não garante que a soma dos pagamentos seja igual ao total da venda.

- **RF13 — Informações fiscais das vendas:** necessidade legal do estabelecimento; **fora da implementação**. Sem campos de NF de saída em `VENDA`. Emissão permanece no sistema fiscal da empresa.

- **RF14 — Registro de saída por lote:** `SAIDA_LOTE` associa item vendido ao lote e à quantidade retirada. FEFO automático e baixa automática do saldo: evolução futura.

- **RF15 — Lotes vencidos e saldo:** consultar validade e quantidade para achar vencidos e saldo insuficiente. Sem bloqueio automático universal de venda.

- **RF16 — Consulta de validade:** listar lotes vencidos e próximos do vencimento, com produto, lote, quantidade e validade.

- **RF17 — Lotes próximos do vencimento:** G01 lista os lotes com saldo positivo e validade no intervalo acadêmico de 7 dias a partir de `2026-10-28`. O script usa data fixa para o teste dar o mesmo resultado sempre; em produção o período seria configurável. Sem notificação automática.

- **RF18 — Registro de perdas:** `PERDA` com lote, quantidade, data, motivo e funcionário (RN07, RN17). Baixa automática do saldo: não demonstrada no script.

- **RF19 — Alteração de preços:** processo do ERP (histórico e login). Neste banco: apenas preço atual.

- **RF20 — Dados para etiquetas:** consultar código, código de barras, nome de gôndola e preço. Impressão fora do escopo.

- **RF21 — Cadastro de funcionários:** código, nome, cargo e data de admissão, para associar a vendas e perdas. Sem login/senha neste banco.

- **RF22 — Fechamento de caixa:** processo real do Hortifruti União; **sem módulo** nesta entrega.

##### Requisitos Não Funcionais

- **RNF01 — Desempenho:** estrutura com PK/FK para consultas de produto, venda, lote e estoque. Sem índices extras (código de barras, validade, situação) e sem teste de concorrência dos 7 caixas. Meta de resposta &lt; 3 s **não comprovada**.

- **RNF02 — Disponibilidade:** testes em MySQL de laboratório. Sem alta disponibilidade nem caixa offline.

- **RNF03 — Segurança:** integridade por PK/FK; acesso limitado ao ambiente MySQL. Sem tela de login de funcionário.

- **RNF04 — Usabilidade dos dados:** nomes padronizados e dicionário de dados. Sem avaliação de interface gráfica.

- **RNF05 — Recuperação:** o script recria estrutura e massa fictícia; isso **não** substitui backup. Sem teste documentado de dump/restore.

- **RNF06 — Integridade das movimentações:** auditorias A01–A04 na massa fictícia. Sem transação completa de venda com baixa automática de estoque.

- **RNF07 — Rastreabilidade:** caminho recebimento → lote → saída por item de venda. As perdas também ficam ligadas ao lote. Sem módulo de auditoria de usuários nem histórico de preços.

- **RNF08 — Conformidade (LGPD e fiscal):** testes só com dados fictícios. Fiscal de saída permanece no sistema da empresa.

- **RNF09 — Integração:** dados centralizados no modelo relacional. Sem integração automática com o VR Software.

**Requisitos típicos não incluídos:** cadastro de cliente e fidelidade (não usados na venda); Pix (não aceito); contas a pagar, escala e ponto (levantamento insuficiente). Ver seção 6 (IA para requisitos típicos).

---

#### Regras de Negócio

**De onde veio cada regra:** **[Entrevista]** = o responsável falou. **[Proposta]** = o grupo montou, em parte com IA (seção 6), e **ainda não passou regra por regra com ele**.

O texto da regra fala do negócio ou do sistema inteiro. O que o MySQL realmente impede está na seção 1.5 e no dicionário.

**Regras operacionais**

- **RN01 — Bloqueio de venda de produtos vencidos [Entrevista / mecanismo a confirmar]:** o responsável falou de um bloqueio de produto vencido no ERP. Como lotes diferentes usam o mesmo código de barras e o registro da validade não é usado de forma sistemática, **não dá para afirmar que o ERP trava um lote específico no caixa**. No nosso banco, G02 lista vencido com saldo, mas não existe bloqueio na hora de vender. Precisamos confirmar com ele até onde vai o bloqueio de hoje.

- **RN02 — Entrada de estoque com nota fiscal [Entrevista]:** segundo o responsável, a mercadoria deve chegar acompanhada de NF, com produtos, lotes, quantidades e validades. `RECEBIMENTO` tem campos para número e série da NF, mas o SQL usado na conferência ainda permite deixá-los vazios. A obrigação existe no processo; o que falta é o banco exigir o preenchimento desses campos (ver 1.5).

- **RN03 — Pedido só a fornecedor cadastrado [Proposta]:** pedido de compra somente para fornecedor já cadastrado.

- **RN04 — Fornecedor com CNPJ válido [Proposta]:** cadastro com CNPJ válido e único, razão social, telefone e e-mail. No SQL que estávamos olhando, não há `NOT NULL`, `UNIQUE` nem checagem dos dígitos do CNPJ; os CNPJs da massa são fictícios.

- **RN05 — Cancelamento de venda [Proposta]:** venda concluída pode ser cancelada com autorização (RN10), preservando o registro (situação, motivo, data/hora, funcionário). Não demonstrado no script.

- **RN06 — Estoque mínimo [Entrevista]:** cada produto tem mínimo (comprador, com apoio do ERP e gerência). G04 lista produtos abaixo do mínimo. Sem alerta automático.

- **RN07 — Perdas por vencimento [Proposta]:** lote vencido não deve ser vendido; perda registrada com lote, quantidade, data, motivo e funcionário, com baixa de saldo. A massa tem um exemplo; o script não baixa o saldo sozinho.

- **RN08 — Obrigatoriedade fiscal [Entrevista]:** emissão e autorização fiscal continuam no sistema da organização. Fora desta implementação.

- **RN09 — Lotes próximos do vencimento [Proposta]:** consulta G01 com intervalo de 7 dias e data fixa `2026-10-28`. Prazo acadêmico, não confirmado pelo responsável. Sem notificação.

- **RN10 — Permissões por função [Entrevista]:** preço: líder de setor, gerente, proprietários. Cancelamento e fechamento de caixa: gerente ou fiscal. Financeiro: administração e gestão. Sem autenticação neste banco.

- **RN11 — Produtos a granel [Proposta]:** quantidade em quilos e preço por quilo. Balanças devem atender ao Inmetro (exigência operacional, não modelada em tabela).

- **RN12 — LGPD [Proposta]:** proteger dados de funcionários e contatos de fornecedores. Testes só fictícios. Sem CPF e sem autenticação neste banco.

- **RN13 — Pedido de compra com itens [Proposta]:** todo pedido tem ao menos um item; cada item é de um pedido.

- **RN14 — Saída por lote e FEFO [Proposta]:** item vendido associado a um ou mais lotes (`SAIDA_LOTE`). FEFO prioriza o lote válido que vence primeiro. Rastreio demonstrado; FEFO automático não implementado.

- **RN15 — Formas de pagamento [Entrevista]:** dinheiro, débito e crédito; sem Pix. Pagamento pode ser dividido; a soma deve igualar o total. Massa atual: um pagamento.

- **RN16 — Categoria do produto [Proposta]:** todo produto pertence a uma categoria já cadastrada; uma categoria pode ter vários produtos.

- **RN17 — Perdas por outros motivos [Proposta]:** dano, deterioração etc. com lote, quantidade, data, motivo e funcionário, atualizando o saldo.

- **RN18 — Quantidade vendida [Proposta]:** retiradas não podem gerar saldo negativo nem usar lote vencido. As auditorias conferem alguns pontos da massa; o script não bloqueia todas as operações futuras.

- **RN19 — Baixa de estoque e rastreabilidade [Entrevista / Proposta]:** o ERP atual baixa estoque na venda concluída. A proposta acadêmica associa a quantidade ao lote via `SAIDA_LOTE`. Atualização consistente do saldo depende da aplicação ou de procedimentos ainda não automatizados.

- **RN20 — Preservação dos registros [Proposta]:** vendas canceladas, pagamentos e perdas permanecem no banco. Sem histórico completo de todas as alterações.

- **RN21 — Fechamento de caixa [Entrevista]:** conferência de dinheiro físico; validação por fiscal ou gerente. Sem módulo nesta entrega.

- **RN22 — Consistência pedido, recebimento e lote [Proposta]:** lote associado a recebimento e a item de pedido do mesmo pedido; produto do lote = produto do item. A auditoria A02 compara essas referências nos registros vinculados da massa; FKs isoladas não garantem sozinhas todas as condições.

**Regras comuns não incluídas:** cliente/fidelidade (não há cadastro na venda); Pix (não aceito); normas sanitárias detalhadas, contas a pagar e escala (não ligadas a P1 e sem levantamento suficiente).

---

#### Delimitação do Escopo da Implementação

Prioridade: **P1 — validade e rastreabilidade de lotes.** Também entram os dados essenciais de cadastro, compra, recebimento e venda.

Depois de falar de novo com o responsável, o grupo deixou o antigo “segundo problema” (histórico de preço e acesso) como coisa do ERP, não como P2.

**Incluído na implementação prática:** cadastros; pedidos e itens; recebimento e NF de entrada; lotes, validade, saldos e perdas; vendas, itens, pagamentos e saídas por lote; consultas G01–G05 e auditorias A01–A05.

**Fora da implementação prática:** NF de saída junto ao Fisco; impressão de etiquetas; integração com VR Software; caixa offline; interfaces completas; modelos preditivos de IA; FEFO automático; permissão por perfil; baixa automática de estoque em todas as operações.

#### DER Conceitual Revisado

**Software utilizado:** brModelo 3.2.0. Notação de entidades, atributos, relacionamentos e cardinalidades (mín, máx). **Chaves estrangeiras não aparecem no DER conceitual**; estão no modelo lógico (seção 2) e no dicionário.

![DER conceitual revisado](diagramas/der_conceitual.png)

**Situação:** 13 entidades e 17 relacionamentos; exportado em PNG em `diagramas/der_conceitual.png`.

**Resumo das entidades e relacionamentos:**

| Entidade 1 | Relacionamento | Entidade 2 | Cardinalidade |
|---|---|---|---|
| PRODUTO | POSSUI | LOTE | (0,N) / (1,1) |
| CATEGORIA_PRODUTO | CLASSIFICA | PRODUTO | (0,N) / (1,1) |
| FORNECEDOR | RECEBE | PEDIDO_COMPRA | (0,N) / (1,1) |
| PEDIDO_COMPRA | CONTÉM | ITEM_PEDIDO_COMPRA | (1,N) / (1,1) |
| PRODUTO | APARECE_EM | ITEM_PEDIDO_COMPRA | (0,N) / (1,1) |
| FUNCIONARIO | REALIZA | VENDA | (0,N) / (1,1) |
| FUNCIONARIO | CANCELA | VENDA | (0,N) / (0,1) |
| VENDA | CONTÉM | ITEM_VENDA | (1,N) / (1,1) |
| PRODUTO | APARECE | ITEM_VENDA | (0,N) / (1,1) |
| VENDA | POSSUI | PAGAMENTO | (1,N) / (1,1) |
| LOTE | APRESENTA | PERDA | (0,N) / (1,1) |
| FUNCIONARIO | REGISTRA | PERDA | (0,N) / (1,1) |
| ITEM_VENDA | UTILIZA | SAIDA_LOTE | (1,N) / (1,1) |
| LOTE | ORIGINA | SAIDA_LOTE | (0,N) / (1,1) |
| PEDIDO_COMPRA | GERA | RECEBIMENTO | (0,N) / (1,1) |
| RECEBIMENTO | REGISTRA | LOTE | (0,N) / (1,1) |
| ITEM_PEDIDO_COMPRA | ORIGINA | LOTE | (0,N) / (1,1) |

*Cardinalidades na ordem das entidades de cada linha. A participação mínima é regra do modelo conceitual, não garantia do SQL: no script que conferimos, as FKs aceitam `NULL` (até nas relações que no desenho são obrigatórias). A FK no item, por exemplo, não impede uma venda sem nenhum item. Ver seção 1.5.*

**Caso A — mesma organização da Entrega 1. Apontamentos da correção:**

| Apontamento da correção da E1 | O que mudou no trabalho | Por quê |
|---|---|---|
| Processos de negócio incompletos | Detalhados vendas, compras, recebimento, estoque, pagamentos, cancelamentos, preços, acesso e fechamento de caixa | Mostrar o mercado e o que o banco cobre |
| Fluxogramas só como anexo | Imagens no README, na seção de processos | O professor vê o fluxo sem abrir outro arquivo |
| Regras de negócio incompletas | Incluídas validade, estoque mínimo, FEFO, perdas, pagamentos, permissões, granel e LGPD | Coerência com os processos |
| Inconsistência no cadastro de clientes | Entidade CLIENTE retirada | O mercado não cadastra cliente para registrar a venda |
| Cardinalidades e relacionamentos incorretos | Revisadas; criados itens de compra/venda, lote, pagamento e perda | Representar N:N com dados de quantidade e preço |
| Dicionário incompleto | `Dicionario_Dados.md` com 13 tabelas e 74 colunas | Turma GTI: Markdown separado do README |
| Justificativas técnicas superficiais | Seções 1.2 a 1.5 | Demonstrar conversão, chaves, normalização e restrições |

### 1.2 Conversão do Modelo Conceitual para o Modelo Lógico

Passamos as 13 entidades para 13 tabelas no MySQL 8.0: `PRODUTO`, `CATEGORIA_PRODUTO`, `FORNECEDOR`, `PEDIDO_COMPRA`, `ITEM_PEDIDO_COMPRA`, `RECEBIMENTO`, `LOTE`, `FUNCIONARIO`, `VENDA`, `ITEM_VENDA`, `PAGAMENTO`, `PERDA` e `SAIDA_LOTE`. São 13 PKs e 17 FKs.

Os atributos viraram colunas (`codigo_produto`, `nome_produto`, `preco_venda`, `unidade_medida` etc.). Identificador virou PK; referência virou FK.

No 1:N a FK ficou no lado N (exemplo: `LOTE.codigo_produto` aponta para `PRODUTO`). Onde era N:N, criamos tabela no meio:

- `ITEM_VENDA`: venda × produto (quantidade, preço praticado, subtotal);
- `ITEM_PEDIDO_COMPRA`: pedido × produto (quantidade, preço de compra);
- `SAIDA_LOTE`: item vendido × lote (quantidade retirada).

Não fizemos tabela `FORNECEDOR_PRODUTO`. A lista de produtos por fornecedor sai do histórico de pedidos (RF04).

Não usamos generalização/especialização: no escopo não apareceu hierarquia do tipo pessoa física/jurídica.

### 1.3 Definição de Chaves Primárias e Estrangeiras

| Tabela | Chave primária (PK) | Chaves estrangeiras (FK) |
|---|---|---|
| FORNECEDOR | `codigo_fornecedor` | Não possui |
| CATEGORIA_PRODUTO | `codigo_categoria` | Não possui |
| FUNCIONARIO | `codigo_funcionario` | Não possui |
| PRODUTO | `codigo_produto` | `codigo_categoria` → CATEGORIA_PRODUTO |
| PEDIDO_COMPRA | `codigo_pedido` | `codigo_fornecedor` → FORNECEDOR |
| ITEM_PEDIDO_COMPRA | `codigo_item_pedido` | `codigo_pedido` → PEDIDO_COMPRA; `codigo_produto` → PRODUTO |
| RECEBIMENTO | `codigo_recebimento` | `codigo_pedido` → PEDIDO_COMPRA |
| LOTE | `codigo_lote` | `codigo_produto` → PRODUTO; `codigo_item_pedido` → ITEM_PEDIDO_COMPRA; `codigo_recebimento` → RECEBIMENTO |
| PERDA | `codigo_perda` | `codigo_lote` → LOTE; `codigo_funcionario` → FUNCIONARIO |
| VENDA | `codigo_venda` | `codigo_funcionario` → FUNCIONARIO; `codigo_funcionario_cancelamento` → FUNCIONARIO |
| ITEM_VENDA | `codigo_item_venda` | `codigo_venda` → VENDA; `codigo_produto` → PRODUTO |
| PAGAMENTO | `codigo_pagamento` | `codigo_venda` → VENDA |
| SAIDA_LOTE | `codigo_saida_lote` | `codigo_lote` → LOTE; `codigo_item_venda` → ITEM_VENDA |

**Cardinalidade conceitual × SQL:** as mínimas (1,1) e (1,N) são regra de negócio. Na cópia usada na conferência (`script(2).sql`), as 17 FKs **aceitam NULL**. A FK, sozinha, também não exige que cada pedido ou venda tenha pelo menos um item, nem que cada venda tenha um pagamento. Quando a FK está preenchida, ela impede uma referência a registro inexistente (teste A05).

**Observação:** o modelo implementado não possui uma tabela associativa direta entre FORNECEDOR e PRODUTO. A identificação dos produtos solicitados a cada fornecedor é realizada por meio das tabelas PEDIDO_COMPRA e ITEM_PEDIDO_COMPRA. Essa simplificação foi adotada para manter o foco nos processos de compra e recebimento incluídos no escopo acadêmico. O DER conceitual foi revisado e exportado, e sua representação contempla os relacionamentos definidos para as 13 entidades do projeto. As diferenças entre a obrigatoriedade indicada pelas cardinalidades conceituais e as restrições efetivamente aplicadas no MySQL estão documentadas como limitações da implementação.

### 1.4 Processo de Normalização (1FN, 2FN e 3FN)

- **1FN — Primeira Forma Normal:** cada coluna tem um valor só. Os produtos de uma venda e de um pedido não vão numa lista dentro de `VENDA` ou `PEDIDO_COMPRA`; são linhas de `ITEM_VENDA` e `ITEM_PEDIDO_COMPRA`. No pagamento dividido, cada pagamento fica em uma linha de `PAGAMENTO`.

- **2FN — Segunda Forma Normal:** as PKs são simples, então não há dependência parcial **em relação a essas PKs**. Quantidade e preço de compra dependem de `codigo_item_pedido`; nome do produto e dados do fornecedor ficam nos cadastros. **PK simples sozinha não encerra a análise da 2FN**: também precisamos considerar outras combinações de atributos que possam identificar um item, as chamadas chaves candidatas.

- **3FN — Terceira Forma Normal:** `PEDIDO_COMPRA` guarda `codigo_fornecedor`; razão social, telefone e CNPJ ficam em `FORNECEDOR`. `PRODUTO` guarda `codigo_categoria`; o nome da categoria fica em `CATEGORIA_PRODUTO`. Assim não repetimos descrição em cada movimento.

- **O que ainda é redundante e precisa de cuidado:**
  - `LOTE.codigo_produto` repete o produto que já dá para achar pelo item do pedido. A auditoria A02 compara os dois; não há FK composta. Se alguém atualizar um lado e esquecer o outro, os dados divergem — por isso **não dizemos que o esquema está 3FN sem ressalva**.
  - `ITEM_VENDA.subtotal`, `VENDA.valor_total` e `LOTE.quantidade_disponivel` são valores gravados para facilitar consulta. Sem um mecanismo que os mantenha consistentes com as movimentações, podem surgir diferenças entre o saldo, os itens e o total da venda.

Em resumo: separamos as listas (1FN) e os dados dos itens dos cadastros. Ter PK própria ajuda a identificar cada item, mas não basta para provar a 2FN. Também evitamos repetir dados de fornecedor e categoria em cada movimento. **Não fechamos 3FN em tudo.** A redundância do lote ainda precisa ser resolvida ou justificada no dicionário, mostrando no SQL como os dados ficam consistentes. Conferir os valores por uma consulta, por si só, não elimina essa redundância.

### 1.5 Justificativas Técnicas das Decisões

**Chaves primárias:** cada uma das 13 tabelas tem identificador simples (`codigo_produto`, `codigo_lote`, `codigo_venda` etc.). Itens de compra/venda e saídas por lote também têm PK própria, para individualizar a linha e rastrear.

**Chaves estrangeiras:** 17 FKs no SQL que analisamos, inclusive `PEDIDO_COMPRA.codigo_fornecedor` → `FORNECEDOR` (RN03), `LOTE.codigo_item_pedido` → `ITEM_PEDIDO_COMPRA` (RN22) e `SAIDA_LOTE.codigo_lote`/`codigo_item_venda` → `LOTE`/`ITEM_VENDA` (RN14). Funcionário da venda e funcionário do cancelamento são duas FKs diferentes de `VENDA` para `FUNCIONARIO`.

**O que está na cópia usada na conferência (`script(2).sql`):**

Esse foi o nome da cópia usada na revisão. O arquivo de entrega é `docs/script.sql`. Os pontos abaixo se referem a essa cópia; não são uma nova verificação do arquivo publicado na `main`.

| Regra SQL | O que garante | Limitação |
|---|---|---|
| 13 chaves primárias (`PRIMARY KEY`) | Identificação única pela PK | Não torna obrigatório o resto dos campos |
| 17 FKs, com `ON DELETE RESTRICT` | Impedem referência *preenchida* a registro inexistente; travam exclusão de quem ainda é usado | As 17 FKs permitem `NULL` |
| Tipos `INT`, `VARCHAR`, `DECIMAL`, `DATE`, `DATETIME` | Cabem no conteúdo | O tipo não impede valor negativo nem fecha regra de negócio |

**Restrições previstas que ainda não aparecem nessa cópia:**

| Restrição necessária | Exemplo de implementação | Requisito/regra |
|---|---|---|
| Obrigatoriedade de fornecedor e categoria | `PEDIDO_COMPRA.codigo_fornecedor NOT NULL`, `PRODUTO.codigo_categoria NOT NULL` | RN03, RN16 |
| Obrigatoriedade dos dados essenciais | `NOT NULL` em FKs e atributos essenciais de item, recebimento, lote, venda e pagamento; deixar nulo só o que for mesmo opcional | RN02, RN13, RN14, RN22 |
| Unicidade de identificadores naturais | `UNIQUE` em `FORNECEDOR.cnpj` e `PRODUTO.codigo_barras` (reavaliar política para produtos de peso variável) | RN04, RF01 |
| Positividade e domínio de valores | `CHECK (quantidade_vendida > 0)`, checagens de preço, perda e saldo, e domínio de `forma_pagamento` | RN15, RN18 |
| Lote compatível com pedido, recebimento e produto | Validação na transação ou integridade composta bem desenhada | RN22 |
| Pedido/venda com itens e pagamentos correspondentes | Validação na transação ou procedimento de fechamento | RN13, RN15 |
| Venda com saídas por lote e saldo coerente | Procedimento atômico, validade e saldo, eventual `SELECT ... FOR UPDATE` | RN01, RN14, RN18, RN19 |

**Decisões de arquitetura:** MySQL 8.0 e dados separados em cadastro, movimento e lote. `SAIDA_LOTE` existe para dizer de qual lote saiu a quantidade vendida; o ERP deles continua com a parte fiscal. Este banco acadêmico não tem login por cargo, FEFO automático, cancelamento completo, fechamento de caixa nem baixa automática de todo saldo.

O `docs/script.sql` e o `Dicionario_Dados.md` precisam descrever **a mesma estrutura**: mesmas tabelas, colunas, nome do banco e restrições. Não adianta prometer `NOT NULL`/`UNIQUE`/`CHECK` só no README.


### 1.6 Proposta de Arquitetura Analítica para BI e IA

Com esses dados o gerente consegue ver o que está para vencer, quanto já se perdeu, o que está abaixo do mínimo, como andam os recebimentos e o que entrou de pagamento. Só faz sentido no painel se o saldo do lote acompanhar a movimentação.

**KPIs e consultas — o que a gente quer medir e o que a cópia conferida do SQL já faz:**

| Indicador | Fórmula para o KPI | Período | Referência/meta | SQL usado na conferência |
|---|---|---|---|---|
| Lotes a vencer | `COUNT(*)` de lotes válidos com saldo positivo e validade até 7 dias | Diário, data de referência fixa de 28/10/2026 na demonstração | Acompanhar diariamente; meta quantitativa a definir | G01 lista os lotes; ainda falta devolver a quantidade total no SQL |
| Lotes vencidos com saldo | `COUNT(*)` de lotes vencidos com saldo positivo | Diário | Meta proposta: 0 | G02 lista os lotes; ainda falta a contagem no SQL |
| Valor das perdas | `SUM(quantidade_perdida × custo_unitario)` | Por dia/mês, conforme `PERDA.data_perda` | Histórico informado ≈ 1,5% do faturamento; não é meta formal confirmada | G03 mostra o custo de cada perda; ainda falta somar os valores e filtrar pelo período definido |
| Produtos abaixo do mínimo | `COUNT(*)` de produtos cuja soma dos saldos por lote é inferior ao mínimo | Diário | Meta proposta: 0 produtos | G04 lista os produtos; ainda falta devolver a quantidade total no SQL |
| Pagamentos de vendas concluídas | `SUM(valor_pagamento)` associado às vendas concluídas | Por dia da venda | Monitoramento, sem meta de faturamento fixada | G05 soma os pagamentos por dia da venda; não confere se eles batem com `VENDA.valor_total` |

**Resultados da massa nos testes já relatados pelo grupo, com data de referência `2026-10-28`:**

| Consulta | Resultado registrado | Observação |
|---|---|---|
| G01 | 3 linhas: Maçã (MAC-001), Banana prata (BAN-001) e Tomate (TOM-001) | A consulta detalha os lotes; o indicador de quantidade ainda precisa de cálculo no SQL |
| G02 | 1 linha: Alface crespa (ALF-001), saldo 30,000 | Lote propositalmente vencido com saldo para testar alerta |
| G03 | 1 registro de perda, R$ 20,00 (10,000 × R$ 2,00, Alface crespa) | É resultado unitário; o custo de R$ 2,00 do lote difere do preço de compra de R$ 1,50 no pedido, sem justificativa documentada |
| G04 | 2 linhas: Arroz 5 kg (5,000 / mínimo 10,000) e Cenoura (0,000 / mínimo 10,000) | Soma saldos de lotes vencidos: ao excluir o lote de alface, o resultado demonstrativo passaria de 2 para 3 produtos abaixo do mínimo (considerando a mesma massa) |
| G05 | R$ 19,47 em uma venda concluída em 28/10/2026 | Valor de pagamento registrado, coincidente com o total da venda fictícia |

O grupo já tinha relatado testes no MySQL 8.0 com 13 tabelas, 74 colunas, 17 FKs e 51 registros fictícios. **Nesta revisão do texto, não rodamos o MySQL de novo.** Há duas informações nos registros: a cópia `script(2).sql` usada na conferência ainda trazia `TOM-001` com saldo 70,000, e o grupo relatou ter corrigido esse saldo para 69,000. Pelos movimentos descritos — 70,000 recebidos e 1,000 vendido —, o esperado é 69,000. **Ainda falta confirmar que o `docs/script.sql` publicado na `main` é a mesma versão corrigida e registrar os resultados dessa versão.** Os resultados acima não são uma nova validação do arquivo publicado.

**Auditorias e o que elas não cobrem:**

| Auditoria | O que verifica | Limitação |
|---|---|---|
| A01 | Referência não nula de lote a produto inexistente | Não acha `LOTE.codigo_produto IS NULL`; a FK já impede referência preenchida inválida |
| A02 | Divergência entre produto e pedido nas linhas vinculadas | `INNER JOIN` ignora registro com FK nula; não fecha a RN22 inteira |
| A03 | Produto da saída diferente do produto do item vendido | `INNER JOIN` ignora associação incompleta |
| A04 | Soma de retiradas diferente da quantidade de cada item | Não testa saldo negativo nem venda de lote vencido |
| A05 | Rejeição de FK para funcionário inexistente | O procedimento trata o erro; não prova autorização por função |

**Rastreabilidade: problemas e indicadores até a implementação SQL**

| Problema ou indicador | Tabelas | Consulta | Situação da comprovação |
|---|---|---|---|
| P1 — risco de vencimento | `PRODUTO`, `LOTE` | G01 | Atendido como lista gerencial |
| P1 — lote vencido ainda com saldo | `PRODUTO`, `LOTE` | G02 | Atendido como lista gerencial |
| P1 — custo das perdas | `PERDA`, `LOTE`, `PRODUTO` | G03 | Custo por registro; agregação pendente |
| KPI — produtos abaixo do mínimo | `PRODUTO`, `LOTE` | G04 | Lista de produtos; contagem agregada pendente |
| KPI — valor de pagamentos por dia | `VENDA`, `PAGAMENTO` | G05 | Soma por dia disponível |

**Custo da alface:** na cópia conferida, o item de compra tem `preco_compra = 1,50` e o lote tem `custo_unitario = 2,00`. Precisamos conferir de onde veio a diferença. Só vamos dizer que entrou despesa adicional se isso estiver previsto e explicado na massa de teste; não basta criar uma justificativa para os valores baterem. Se for erro de preenchimento, corrigimos o valor e recalculamos o G03.

**BI:** painéis de validade, perda, ruptura e recebimento. Giro e desempenho comercial pedem mais histórico e saldo estável. Para o % de perda, numerador e denominador têm que ser **do mesmo período**.

**IA (não implementamos):** previsão de demanda, risco de vencimento e sugestão de compra. Isso pede lote bem cadastrado, histórico suficiente e conversa com o gestor. As 51 linhas fictícias servem para testar o banco e as consultas; essa massa não demonstra histórico suficiente para validar previsões úteis ao hortifruti.

---

## 2. Modelo Lógico Relacional

**Software utilizado:** brModelo 3.2.0.

![Modelo lógico relacional do Hortifruti União](diagramas/modelo_logico.png)

O diagrama tem 13 tabelas, com colunas, tipos, PKs, FKs e cardinalidades já convertidas. Na cópia do SQL usada na conferência há 17 FKs, todas anuláveis. Obrigatoriedade, unicidade e valores permitidos vão no [Dicionário de Dados](Dicionario_Dados.md) e no [script SQL](docs/script.sql); nessa cópia as restrições a mais ainda não estão. A conferência final precisa comparar o PNG, o dicionário e o SQL que será publicado.

Arquivos: `diagramas/der_conceitual.png`, `diagramas/modelo_logico.png`, `Dicionario_Dados.md` (74 colunas), `docs/script.sql` (base `hortifruti_uniao_entrega2`).

---

## 3. Script SQL Completo

**SGBD:** MySQL 8.0. **Arquivo exigido na branch `main`:** [docs/script.sql](docs/script.sql).

O esqueleto pede um `.sql` que rode numa base vazia, nesta ordem: `CREATE DATABASE`, `CREATE TABLE` e restrições, `INSERT`, `SELECT` com `JOIN`, `UPDATE`, `DELETE`, consultas gerenciais e auditoria. Vale usar transação com `ROLLBACK` no `UPDATE`/`DELETE` para não estragar a massa. **No SQL que vimos, `UPDATE` e `DELETE` estavam depois das auditorias;** o certo, pela ordem do esqueleto, é colocá-los antes das G/A.

**Consultas identificadas na cópia usada na conferência:**

| Código | Pergunta da consulta | O que atende |
|---|---|---|
| G01 | Quais lotes têm saldo e vencem nos próximos 7 dias? | P1 — prevenção de vencimento |
| G02 | Quais lotes vencidos ainda têm saldo? | P1 — identificação de risco |
| G03 | Qual o custo de cada perda registrada? | P1 — registro financeiro de perdas; falta totalização no SQL |
| G04 | Quais produtos estão abaixo do estoque mínimo? | RN06 — risco de ruptura |
| G05 | Quanto foi registrado em pagamentos de vendas concluídas por dia? | Indicador de recebimentos vinculados a vendas |
| A01 | Existe referência não nula de lote a produto inexistente? | Integridade referencial, com a limitação de FKs nulas |
| A02 | O produto e o pedido vinculados ao lote coincidem? | RN22, parcialmente |
| A03 | A saída por lote corresponde ao produto do item vendido? | RN14/RN19, parcialmente |
| A04 | A soma das retiradas por lote é igual à quantidade vendida? | RN18, parcialmente |
| A05 | O banco rejeita venda vinculada a funcionário inexistente? | FK de `VENDA.codigo_funcionario` |

Cada consulta precisa ter, no próprio `.sql`, um cabeçalho com código, pergunta em português e RN/KPI atendido. As listas de G01, G02 e G04 e o detalhamento de perdas de G03 são úteis para a gestão. **Para atender aos KPIs definidos na seção 1.6, ainda precisamos acrescentar as contagens e totalizações correspondentes**, sem retirar essas listas. As auditorias ainda não cobrem venda sem pagamento, pagamento diferente do total, quantidade inválida e lote vencido vendido. Regras que envolvem várias linhas precisam de validações nas operações, não apenas de um `CHECK`.

A cópia conferida do SQL **não** faz sozinha: FEFO, baixa de saldo, cancelamento, permissão por cargo e conferência da soma dos pagamentos com o total da venda. Também não vimos `NOT NULL` nas FKs obrigatórias, `UNIQUE` além das PKs nem `CHECK` de quantidade e forma de pagamento.

Para fechar esta parte, falta alinhar README, dicionário e `docs/script.sql`, confirmar no arquivo final o saldo de `TOM-001` descrito na seção 1.6 e testar essa mesma versão numa base vazia. Mudar o texto do README não substitui executar o script no banco.

---

## 4. Massa de Dados

**Arquivo:** massa fictícia em [docs/script.sql](docs/script.sql), por `INSERT`. **Não são dados internos reais** do hortifruti.

| Tipo de registro | Quantidade na versão analisada |
|---|---:|
| Categorias de produtos | 4 |
| Fornecedores | 4 |
| Funcionários | 5 |
| Produtos | 8 |
| Pedidos de compra | 4 |
| Itens de pedido de compra | 8 |
| Recebimentos | 3 |
| Lotes | 8 |
| Perdas | 1 |
| Vendas | 1 |
| Itens de venda | 2 |
| Pagamentos | 1 |
| Saídas de lote | 2 |
| **Total** | **51** |

Os `INSERT` são **fictícios**. Em relação ao tamanho real (28 mil SKUs, ~2.400 vendas/dia), 8 produtos e 1 venda são **massa de teste**, não amostra estatística. Dá para G01–G05 não voltarem vazios, mas não “representa o movimento”. A exigência de volume e variedade do esqueleto fica **parcial**.

O que a massa já tem: pedidos recebidos e um pendente; dois lotes de banana com validades diferentes; lote vencido com saldo; uma perda por vencimento; produtos abaixo do mínimo; uma venda com dois itens.

O que ainda falta demonstrar: mais de uma venda (datas diferentes), as três formas de pagamento, pagamento dividido, venda cancelada com motivo e responsável, perda por avaria, e, se couber, item saindo de mais de um lote. Tudo fictício. **Esses cenários ainda não aparecem na massa usada nesta conferência.**

Saldo: `BAN-001` (38 depois de vender 2) e `ALF-001` (30 depois de perder 10) fecham na massa descrita. No caso de `TOM-001`, 70,000 recebidos menos 1,000 vendido dão **69,000**. A cópia conferida ainda tinha 70,000, enquanto o grupo relatou a correção para 69,000. A conferência da versão final continua pendente, como explicado na seção 1.6.

O uso de IA na massa está na seção 6. A descrição dessa ajuda ainda precisa ser conferida com os pedidos realmente feitos, principalmente para esclarecer a participação na escrita dos `INSERTs` e em uma possível ampliação da massa.

---

## 5. Repositório GitHub

Turma **GTI:** o Dicionário de Dados vai em **um único Markdown separado do README**, no formato da disciplina, com PK, FK, obrigatoriedade, unicidade, domínio e valor-padrão de cada coluna quando se aplicar. Relatório no `README.md` da raiz da branch `main`; arquivo em outra branch não é corrigido.

Correção **somente da branch `main`**.

| Arquivo ou pasta | Conteúdo |
|---|---|
| `README.md` | Este relatório (Entrega 2) |
| `Dicionario_Dados.md` | 13 tabelas, 74 colunas, PK/FK, tipos e as restrições realmente implementadas |
| `diagramas/` | DER conceitual e modelo lógico (brModelo 3.2.0) |
| `imagens/evidencias/` | Fotos JPG/JPEG da organização (e da entrevista, quando incluída) |
| `docs/script.sql` | DDL, massa, G01–G05, A01–A05, UPDATE/DELETE com ROLLBACK |
| `apresentacao/` | Slides da apresentação final |
| `levantamento/levantamento.md` | Levantamento escrito pelo grupo |
| `fluxograma_vendas.png` | Fluxo de venda |
| `fluxograma_estoque.png` | Fluxo de estoque |

Cada um commita na **própria conta** GitHub, com o usuário da tabela de Integrantes. Evitar um único commit no final.

Antes de mandar o link: fotos da visita na `main`; comprovação da entrevista pelo telefone, conforme combinado com o professor (não há foto do Tarcisio com o responsável); dados do responsável; slides em `apresentacao/`; dicionário em um `.md` só; nome do banco igual ao do SQL; cada um commitando na própria conta.

---

## 6. Uso de Inteligência Artificial

Uso de IA **não declarado é penalizado**. Abaixo, os usos relevantes. Entrega 1 (Registros 1–4) ficou como histórico e pode citar entidade que depois saiu (ex.: CLIENTE).

### Registro 1 — Claude: Aprendizado do GitHub

| Item | Descrição |
|------|------------------|
| **Ferramenta e etapa** | Claude — auxílio no aprendizado do GitHub. |
| **Motivação** | Ninguém do grupo era familiarizado com a ferramenta. |
| **Prompt(s) utilizados** | "Preciso criar um arquivo readme dentro do github, aprender a editar e adicionar colaboradores para que o meu grupo também tenha acesso, como eu faço isso?" / "Aparentemente você está passando informações da versão anterior do github, fale as informações da versão atual" |
| **Resposta recebida** | Sequência: criar repositório, README, formatação, commit, edição, colaboradores, permissões. |
| **Fontes consultadas e verificadas** | Conhecimento geral da ferramenta; conferido na prática pelo grupo. |
| **Trechos rejeitados ou corrigidos** | Primeira resposta parecia da interface antiga; o grupo pediu a versão atual. |
| **Justificativa da escolha final** | Resolveu as dúvidas de publicação. |
| **Reflexão crítica** | Foi preciso exigir atualização; a IA pode descrever tela antiga. |

### Registro 2 — Claude: Revisão ortográfica do README

| Item | Descrição |
|------|------------------|
| **Ferramenta e etapa** | Claude — revisão ortográfica do README. |
| **Motivação** | Preferência do grupo. |
| **Prompt(s) utilizados** | Revisar erros de ortografia; listar também os de menor impacto. |
| **Resposta recebida** | Inconsistência de porte (título “pequeno” × texto “médio”) e lista de digitação. |
| **Fontes consultadas e verificadas** | Comparação com o próprio relatório. |
| **Trechos rejeitados ou corrigidos** | Nenhum trecho da lista foi descartado sem leitura. |
| **Justificativa da escolha final** | Correção do porte e da digitação. |
| **Reflexão crítica** | A primeira passagem só destacou o principal; foi preciso pedir a lista completa. |

### Registro 3 — Claude: Organização da documentação

| Item | Descrição |
|------|------------------|
| **Ferramenta e etapa** | Claude — organização do item 6 do esqueleto da Entrega 1. |
| **Motivação** | Preferência do grupo. |
| **Prompt(s) utilizados** | Print dos tópicos do esqueleto + imagem do DER: como organizar. |
| **Resposta recebida** | Justificar cada entidade com o negócio, não só listar nomes. |
| **Fontes consultadas e verificadas** | Esqueleto e slides da disciplina. |
| **Trechos rejeitados ou corrigidos** | Ordem dos tópicos ajustada à ordem do esqueleto. |
| **Justificativa da escolha final** | Estrutura útil depois de reordenada. |
| **Reflexão crítica** | A IA invertia a ordem pedida. |

### Registro 4 — Claude: Revisão do DER conceitual

| Item | Descrição |
|------|------------------|
| **Ferramenta e etapa** | Claude — revisão de cardinalidades do DER (Entrega 1). |
| **Motivação** | Revisar antes da entrega. |
| **Prompt(s) utilizados** | Revisar o DER com ênfase em cardinalidade; perguntas do tipo “por que produto–venda é N:N?”. |
| **Resposta recebida** | Sugestões textuais de cardinalidade (a IA não editou o arquivo do brModelo). |
| **Fontes consultadas e verificadas** | Nenhuma fonte externa citada pela IA. |
| **Trechos rejeitados ou corrigidos** | Aplicação manual no DER; depois o modelo foi de novo revisado com ITEM_VENDA e ITEM_PEDIDO_COMPRA. |
| **Justificativa da escolha final** | Ajuda para discutir N:N. |
| **Reflexão crítica** | Relacionamentos deste registro são de **versão antiga** do DER. |

### Registro 5 — ChatGPT: Revisão da documentação e apoio à modelagem

| Item | Descrição |
|---|---|
| **Ferramenta e etapa** | ChatGPT — README, regras, DER e modelo lógico da Entrega 2. |
| **Motivação** | Organizar conceitos e achar inconsistência entre requisito e diagrama. |
| **Prompts utilizados** | "O que é uma chave primária?"; "Estamos fazendo com base nas regras?"; "Me mande uma tabela para eu fazer sozinha o DER"; "Se eu terminar o modelo lógico, ele gera o SQL automático?" |
| **Respostas recebidas** | Explicações de entidade, PK/FK, cardinalidade; sugestões de texto. |
| **Fontes consultadas e verificadas** | Levantamento, RNs e correção da Entrega 1. |
| **Trechos rejeitados ou corrigidos** | Orientações de cardinalidade e de FK gerada pelo brModelo que não batiam com o projeto. |
| **Justificativa da escolha final** | Alterações feitas à mão no README e nos diagramas. |
| **Reflexão crítica** | Nem toda sugestão estava correta na primeira resposta. |

### Registro 6 — ChatGPT: Apoio à implementação SQL

| Item | Descrição |
|---|---|
| **Ferramenta e etapa** | ChatGPT — organização do `script.sql`, massa e interpretação dos testes MySQL. |
| **Motivação** | Entender a criação das tabelas, a execução das consultas e se os dados batiam. |
| **Prompt(s) utilizados — resumo dos pedidos** | Pedimos ajuda para montar o `docs/script.sql` (criar a pasta `docs` se não existisse), entender o `CREATE TABLE` e ler o resultado de G01–G05 e A01–A05. Não foi um único prompt do tipo “gere o banco inteiro”. |
| **Resposta recebida** | Orientações sobre estrutura do SQL, inserções fictícias e interpretação de G01–G05 e A01–A05. |
| **Fontes consultadas e verificadas** | O `script.sql` do grupo e os testes que relatamos no MySQL 8.0; nesta versão do texto não rodamos o MySQL de novo. |
| **Trechos rejeitados ou corrigidos** | Falas de baixa automática e de cancelamento demonstrado que não estão no SQL. |
| **Justificativa da escolha final** | Deixar no relatório só o que o esquema, a massa e as consultas deixam conferir. |
| **Reflexão crítica** | Ter PK, FK e insert que roda não significa que venda, saldo e validade estejam travados como no caixa real. |

### Registro 7 — Claude: Fluxogramas e consistência SQL × documentação

| Item | Descrição |
|---|---|
| **Ferramenta e etapa** | Claude — revisão de fluxogramas e comparação de script, README e dicionário. |
| **Motivação** | Achar divergência sem inventar passo que a entrevista não confirmou. |
| **Prompt(s) utilizados — resumo dos pedidos** | Pedimos: (1) comparar o fluxograma com os processos de venda e estoque; (2) comparar colunas, tipos e contagens de SQL e dicionário. |
| **Resposta recebida** | Sugestão de data fixa nos testes; conferir `TOM-001`; contagem de 13 tabelas, 74 colunas e 17 FKs. |
| **Fontes consultadas e verificadas** | Fluxogramas, SQL, README, Dicionário de Dados e resultados que o grupo relatou. |
| **Trechos rejeitados ou corrigidos** | O grupo relatou ter mudado o saldo de 70,000 para 69,000, mas a cópia usada na conferência ainda tinha 70,000. A comparação com o arquivo final na `main` continua pendente. |
| **Justificativa da escolha final** | Manter a data fixa no teste para todo mundo reproduzir, e deixar o saldo bater com o movimento. |
| **Reflexão crítica** | Dá para acertar o número de tabelas e ainda assim deixar o saldo do tomate ou o custo da alface errados. O que vale é conferir o `SELECT`. |

### Registro 8 — ChatGPT: Consolidação da revisão final do README

| Item | Descrição |
|---|---|
| **Ferramenta e etapa** | ChatGPT — redação e consolidação da documentação da Entrega 2. |
| **Motivação** | Organizar apontamentos da Entrega 1 e alinhar escopo com o que o banco faz. |
| **Prompt(s) utilizados — resumo do pedido** | Pedimos para organizar os apontamentos e devolver o documento completo com as correções. |
| **Resposta recebida** | Separar o que está implementado, o que é proposta e o que foi testado, e organizar evidências. |
| **Fontes consultadas e verificadas** | Esqueleto da disciplina, correção da Entrega 1, script e dicionário do grupo. |
| **Trechos rejeitados ou corrigidos** | Texto que misturava recurso proposto com comando SQL que de fato roda. |
| **Justificativa da escolha final** | Deixar claro o limite do projeto e manter o foco no P1. |
| **Reflexão crítica** | Texto bem escrito não prova que o MySQL rodou, que a regra está no DDL ou que a foto da entrevista existe. |

### Registro 9 — IA: KPIs típicos de hortifruti (esqueleto seção 1.6)

| Item | Descrição |
|---|---|
| **Ferramenta e etapa** | ChatGPT / Claude — indicadores típicos de varejo alimentar / hortifruti. |
| **Motivação** | Atender o esqueleto: levantar KPIs do tipo de organização e filtrar pelo que o banco calcula. |
| **Prompt(s) utilizados — resumo do pedido** | Pedimos sugestões dos principais KPIs de um hortifruti ou supermercado de perecíveis, com foco em validade, perda, ruptura e faturamento. |
| **Resposta recebida** | Lista ampla (giro, margem, ruptura, validade, ticket, perda %). |
| **Fontes consultadas e verificadas** | Confrontado com o levantamento (perdas ≈ 1,5% do faturamento) e com as tabelas existentes. |
| **Trechos rejeitados** | Preferimos não incluir ticket médio nesta massa de uma venda só. Margem e giro também ficaram de fora porque não detalhamos os dados necessários para essas análises. Tempo de fila e NPS: não há dados. |
| **Justificativa da escolha final** | Mantivemos G01–G05 como consultas gerenciais. As contagens e somas que ainda faltam para os KPIs estão indicadas na seção 1.6. |
| **Reflexão crítica** | KPI sem consulta no SQL não entra. |

### Registro 10 — Massa de dados e LLM (esqueleto seção 4)

| Item | Descrição |
|---|---|
| **Ferramenta e etapa** | ChatGPT — apoio na interpretação da massa e das consultas. A participação na escrita dos `INSERTs` ainda precisa ser conferida no histórico do grupo. |
| **Motivação** | Esqueleto exige declarar se LLM gerou a massa. |
| **Prompt(s) utilizados — resumo dos pedidos** | Pedimos ajuda para entender os resultados de G01–G05 e o saldo de `TOM-001`. Esse resumo não esclarece toda a participação da IA na elaboração da massa; essa parte ainda precisa ser conferida. |
| **Resposta recebida** | Leituras de consulta; alerta de inconsistência de saldo. |
| **Fontes consultadas e verificadas** | Testes que o grupo relatou no MySQL 8.0 em 28/10/2026. Não houve nova execução nesta revisão do texto; a diferença entre as cópias do SQL está explicada na seção 1.6. |
| **Trechos rejeitados ou corrigidos** | Foi apontada a diferença entre saldo 70,000 e 69,000 no tomate. O grupo relatou a correção, mas ainda falta confirmar que ela está na mesma versão publicada do SQL. |
| **Justificativa da escolha final** | Massa pequena, controlada, fictícia, alinhada a P1. |
| **Reflexão crítica** | LLM não substitui rodar o script do zero. |

### Registro 11 — ChatGPT: Conferência do README e revisão da escrita (28/10/2026)

| Item | Descrição |
|---|---|
| **Ferramenta e etapa** | ChatGPT — comparação do README com o arquivo `00-d_Esqueleto_Entrega_2.md` e revisão dos trechos incompletos ou contraditórios. Depois, ajustes na escrita sem trocar o jeito do grupo de explicar. |
| **Motivação** | Conferir os itens do esqueleto e corrigir as imprecisões sem deixar o texto com cara de resposta pronta de IA. |
| **Prompt(s) utilizados** | Resumo dos pedidos anteriores: comparar o relatório com o esqueleto, apontar inconsistências e devolver o README corrigido. Pedido desta revisão: “corrija, mas sem mudar meu tom de fala, você deixa muito IA sabe muito robotico e tem partes q tem q ficar mais humano entender”. |
| **Resposta recebida** | Correções pontuais nas frases sobre validade, observação presencial, normalização, KPIs e uso de IA. A diferença entre as versões do SQL foi mantida como pendência de conferência, não como um teste novo. |
| **Fontes consultadas e verificadas** | Na comparação anterior, o esqueleto, o README, o dicionário e as cópias do SQL descritas no trabalho. Nesta revisão da escrita, a versão completa do README e as informações já fornecidas na conversa; sem nova consulta ao repositório ou execução do MySQL. |
| **Trechos rejeitados ou corrigidos** | Não mantivemos a ideia de que uma lista gerencial é inválida só por não trazer uma contagem. Separamos a utilidade da lista do cálculo do KPI. Também retiramos a afirmação de que esta revisão comprovava a versão publicada do SQL, porque o texto trazia informações diferentes sobre o saldo do tomate. |
| **Justificativa da escolha final** | Manter a nossa forma de escrever, os dados do levantamento e os limites do trabalho. O que depende de conferir o arquivo final ou de rodar o SQL continua indicado como pendência. |
| **Reflexão crítica** | Uma resposta sobre uma cópia antiga não comprova o que está no arquivo publicado. Precisamos conferir a mesma versão do SQL que vai junto com o README. Deixar a escrita mais natural também não pode mudar o sentido do que foi levantado ou testado. |

---

## 7. Apresentação Corporativa Final

O roteiro está pronto. **Falta confirmar na `main` os slides e a evidência do SQL rodando.** São 8 minutos, slide limpo, sem ler parágrafo.

**Pitch de 8 minutos (ordem obrigatória):**

| # | Tempo | Conteúdo do esqueleto |
|---|---|---|
| 1 | 1 min | Contextualização do problema P1 (validade/lote) no Hortifruti União |
| 2 | 1 min | Solução: `LOTE`, `SAIDA_LOTE`, `PERDA`; dizer o que **não** está automatizado (FEFO, baixa de saldo) |
| 3 | 1 min 30 s | Modelo lógico (13 tabelas, chaves, rastreio do lote) |
| 4 | 1 min | Demonstração do SQL rodando (criar/usar a base) |
| 5 | 1 min 30 s | Consultas G01–G05 e uma auditoria (A02 ou A05) |
| 6 | 1 min | Potencial de BI/IA e KPIs |
| 7 | 30 s | Benefícios para decisão: menos perda, reposição, o que o gerente passa a ver |

**Defesa:** depois do pitch, fora dos 8 minutos. **Só responde quem foi perguntado.**

**Participação:** não precisa todo mundo falar no pitch; **é obrigatório** todo mundo estar na defesa. Falta reduz nota, salvo justificativa legal.

**Proposta de falas (confirmar no grupo):** Tarcisio — itens 1 e 2; Gabriela e Henrique — item 3; Victor Hugo — itens 4 e 5; Guilherme — itens 6 e 7.

**Ensaio:** usar uma base de testes separada e vazia, rodar `docs/script.sql` do zero e anotar G01–G05 e A01–A05. Cada um tem que saber responder, sozinho, sobre a redundância em `LOTE`, FK nula, FEFO, soma dos pagamentos e o tamanho pequeno da massa. Roupa de apresentação: sem boné, bermuda, chinelo ou camisa de time.
