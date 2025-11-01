# Banco de Dados Oficina Mecânica

Este projeto faz parte do **Bootcamp Klabin – Transforme Dados em Insights Estratégicos**, e foi desenvolvido como desafio prático de **modelagem e implementação de banco de dados relacional**.  
A proposta consiste em criar, do zero, o banco de dados de uma **oficina mecânica**, cobrindo todo o ciclo: modelagem conceitual, criação do esquema lógico, implementação física e consultas analíticas (KPIs).

---

## Contexto do Projeto

O sistema foi modelado para representar as principais operações de uma oficina:  
- cadastro de **clientes** (PF e PJ),  
- **veículos** atendidos,  
- **ordens de serviço** com múltiplos serviços e peças associadas,  
- **mecânicos** responsáveis, e  
- **pagamentos** realizados.

---

## Estrutura e Propósito

| Tipo | Nome / Caminho 
|------|----------------
| **DDL** | [`01_create_database_oficina.sql`](scripts/01_create_database_oficina.sql)
| **DML** | [`02_insert_data_oficina.sql`](scripts/02_insert_data_oficina.sql)
| **DQL** | [`03_queries_oficina.sql`](scripts/03_queries_oficina.sql)
| **Diagrama Relacional** | [`modelo_relacional_oficina.svg`](diagramas/modelo_relacional_oficina.svg)
| **Documento Técnico** | [`01_mapeamento_er_relacional.md`](docs/01_mapeamento_er_relacional.md)

---

## Estrutura Lógica e Modelagem

O banco de dados é composto por entidades centrais que refletem o fluxo de uma oficina:

- **Cliente** → entidade base, especializada em `Cliente_PF` e `Cliente_PJ`.  
- **Veiculo** → pertence a um cliente e pode ter diversas ordens associadas.  
- **Mecanico** → profissional responsável pela execução das ordens.  
- **Servico** e **Peca** → catálogos usados para composição das ordens.  
- **OrdemServico** → entidade transacional que relaciona cliente, veículo e mecânico.  
- **ItemServico** e **ItemPeca** → tabelas N:M que registram quantidades, valores e composição de cada ordem.  
- **Pagamento** → controle de valores, formas de pagamento e status financeiro das ordens.

O modelo foi projetado para refletir a realidade operacional de uma oficina, com integridade entre clientes e veículos, rastreabilidade de serviços e peças e controle de fluxo financeiro por ordem.

---

## Consultas Analíticas (KPIs)

As consultas DQL desenvolvidas exploram os dados do banco e simulam indicadores de gestão, como:

- **Taxa de conclusão de ordens** – proporção de ordens encerradas.  
- **Tempo médio de execução** – eficiência operacional entre abertura e fechamento.  
- **Faturamento total e ticket médio** – visão de desempenho financeiro.  
- **Serviços e peças mais executados** – análise de demanda e estoque.  
- **Ranking de clientes e mecânicos** – identificação de principais atores da operação.  
- **Distribuição por forma de pagamento** – controle de meios de recebimento.  
- **Participação PF x PJ** – segmentação de perfil de clientes.  

---

## Estrutura de Diretórios

```
oficina-database/
│
├── README.md
│
├── diagramas/
│   └── modelo_relacional_oficina.svg
│
├── scripts/
│   ├── 01_create_database_oficina.sql
│   ├── 02_insert_data_oficina.sql
│   └── 03_queries_oficina.sql
│
└── docs/
    └── 01_mapeamento_er_relacional.md
```