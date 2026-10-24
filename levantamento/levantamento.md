##### Informações fornecidas pelo entrevistado

Durante a entrevista, foram levantadas as seguintes informações:

- O estabelecimento utiliza um banco de dados para armazenar as informações de suas operações, por meio de um sistema ERP em nuvem (VR Software).
- Quando um produto passa pelo caixa, os dados da venda são enviados ao servidor e armazenados no banco de dados.
- O estoque é integrado ao sistema de vendas. Quando uma venda é concluída, a quantidade correspondente é automaticamente baixada do estoque.
- O estabelecimento possui 7 caixas.
- Os pedidos aos fornecedores são feitos por e-mail, e toda entrada de mercadoria vem acompanhada de nota fiscal.
- O estabelecimento aceita dinheiro, cartão de débito e cartão de crédito, não aceita Pix, e o pagamento de uma compra pode ser dividido entre essas formas.
- A alteração do preço de um produto pode ser realizada somente pelos líderes de setor, pelo gerente ou pelos proprietários.
- As informações financeiras podem ser acessadas somente pelos funcionários do setor administrativo, pelo gerente e pelos proprietários.
- A consulta de códigos de produtos e a geração de etiquetas podem ser realizadas pelos funcionários que utilizam os computadores disponíveis para essa atividade.
- O cancelamento de uma venda é feito pelo gerente ou pelo fiscal de caixa.
- Ao final do dia, é feito o fechamento do caixa: o operador faz a conferência inicial, contando o dinheiro físico e comparando com o saldo esperado em dinheiro pelo sistema, e o fiscal de caixa ou o gerente valida o fechamento. A comparação não usa o total vendido, porque parte das vendas é paga com cartão.
- Os cargos do estabelecimento são: dono, gerente, administrativo, fiscal de caixa, caixa, repositor, líderes de setor (mercearia, hortifruti, açougue, padaria e confeitaria), padeiro, confeiteiro, açougueiro, segurança, serviços gerais e limpeza.
- O estabelecimento realiza o lançamento de notas fiscais em razão de suas obrigações fiscais.
- Produtos vencidos não podem ser disponibilizados para venda, pois isso é considerado crime.

##### Achados da observação presencial

Durante a visita ao Hortifruti União – Tatuapé, Tarcisio observou a estrutura física do estabelecimento, incluindo a área de vendas e o estoque. A visita permitiu confirmar que a organização trabalha com quantidade e variedade significativas de mercadorias, tornando necessário o controle organizado dos produtos, do estoque e das datas de validade.

A observação presencial foi utilizada em conjunto com as respostas fornecidas pelo entrevistado. Informações que não foram confirmadas pelo entrevistado nem observadas no local foram tratadas como propostas de melhoria do grupo.

##### Propostas de melhoria elaboradas pelo grupo

Com base nos problemas identificados, o grupo propõe que o sistema:

- registre os diferentes lotes de cada produto;
- armazene a data de validade e a quantidade disponível de cada lote;
- emita alertas sobre lotes próximos do vencimento;
- impeça a venda de lotes vencidos;
- priorize a saída dos lotes válidos com vencimento mais próximo;
- mantenha o histórico das alterações de preços;
- registre o funcionário responsável pelas operações relevantes;
- controle as permissões conforme o cargo do funcionário;
- registre as perdas de estoque e seus respectivos motivos;
- registre o fundo de caixa e a diferença apurada no fechamento do caixa;
- faça cópia de segurança diária dos dados.

Essas funcionalidades são propostas técnicas do grupo e não são apresentadas como procedimentos atualmente realizados pela organização.

##### Mudanças em relação à Entrega 1

| Apontamento da correção | O que mudou | Por quê |
| :---- | :---- | :---- |
| Fotos da entrevista e das evidências hospedadas fora do repositório | As fotos passaram a ser arquivos JPEG dentro do repositório, em imagens/evidencias | Só são consideradas as imagens que estão no repositório |
| Entrevista sem relato do levantamento | Relato com quem, quando, onde e comprovação, separando as respostas do entrevistado da observação presencial | Permite distinguir o que foi dito do que foi observado |
| Porte descrito sem números | Informados 110 funcionários, 7 caixas e faturamento mensal estimado | Os números justificam o tamanho do modelo e da massa de dados |
| Problema declarado sem solução no modelo | Problemas numerados (P1 e P2), cada um ligado a requisitos e regras | Todo problema declarado precisa ser resolvido pelo modelo |
| Processos com cobertura parcial | Oito processos, com os dados envolvidos em cada um, e lista dos não incluídos | Os processos sustentam os requisitos e as regras |
| Requisitos incompletos e genéricos | RF01 a RF22 e RNF01 a RNF09, com os dados envolvidos e a ligação com as regras | Cobrem os processos e os problemas declarados |
| Regras de negócio com cobertura parcial | RN01 a RN21, indicando a origem (entrevista ou proposta do grupo) | Evita apresentar propostas como procedimentos da organização |
| Validade ligada ao produto | A data de validade passou a pertencer ao lote | Um mesmo produto tem lotes com validades diferentes |
