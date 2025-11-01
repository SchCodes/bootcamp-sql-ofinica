# Mapeamento ER para Relacional — Oficina Mecânica

Este documento descreve o mapeamento do modelo conceitual (ER) da oficina mecânica para o modelo lógico relacional implementado no banco **db_oficina**.

---

## 1. Entidades e Tabelas

| Entidade ER | Tabela Relacional | Chave Primária | Observações |
|--------------|------------------|----------------|--------------|
| Cliente | `Cliente` | id_cliente | Entidade genérica, base para PF e PJ |
| Pessoa Física | `Cliente_PF` | id_cliente (FK→Cliente) | Subtipo exclusivo |
| Pessoa Jurídica | `Cliente_PJ` | id_cliente (FK→Cliente) | Subtipo exclusivo |
| Veículo | `Veiculo` | id_veiculo | FK → Cliente |
| Mecânico | `Mecanico` | id_mecanico | — |
| Serviço | `Servico` | id_servico | Catálogo de serviços |
| Peça | `Peca` | id_peca | Catálogo de peças |
| Ordem de Serviço | `OrdemServico` | id_os | FK → Cliente, Veiculo, Mecanico |
| Item de Serviço | `ItemServico` | (id_os, id_servico) | Tabela associativa N:M |
| Item de Peça | `ItemPeca` | (id_os, id_peca) | Tabela associativa N:M |
| Pagamento | `Pagamento` | id_pagamento | FK → OrdemServico |

---

## 2. Relacionamentos e Cardinalidades

| Relacionamento | Tipo | Implementação
|----------------|------|--------------
| Cliente–Veículo | 1:N | FK em `Veiculo(id_cliente)` 
| Cliente–Ordem | 1:N | FK em `OrdemServico(id_cliente)` 
| Veículo–Ordem | 1:N | FK em `OrdemServico(id_veiculo)` 
| Mecânico–Ordem | 1:N | FK em `OrdemServico(id_mecanico)` 
| OS–Serviço | N:M | Tabela `ItemServico`
| OS–Peça | N:M | Tabela `ItemPeca`
| OS–Pagamento | 1:N | FK em `Pagamento(id_os)`

---

## 3. Atributos Principais

| Tabela | Campos Relevantes |
|---------|------------------|
| Cliente | nome, telefone, email |
| Cliente_PF | cpf, data_nascimento |
| Cliente_PJ | cnpj, inscricao_estadual |
| Veiculo | placa, modelo, marca, ano |
| Mecanico | nome, especialidade, telefone |
| Servico | descricao, preco_base |
| Peca | descricao, preco_unitario |
| OrdemServico | data_abertura, data_fechamento, status |
| ItemServico | quantidade, valor_unitario |
| ItemPeca | quantidade, valor_unitario |
| Pagamento | forma_pagamento, valor, status, data_pagamento |

---

## 4. Regras de Integridade

- Todas as tabelas utilizam `InnoDB` e seguem o padrão `utf8mb4`.  
- Todas as chaves primárias usam `INT AUTO_INCREMENT`.  
- Atributos monetários usam `DECIMAL(10,2)`.   
- Relacionamentos configurados com restrições lógicas de exclusão (`CASCADE`, `RESTRICT`, `SET NULL`).
- Unicidade garantida em `cpf`, `cnpj`, `email` e `placa`.

---
