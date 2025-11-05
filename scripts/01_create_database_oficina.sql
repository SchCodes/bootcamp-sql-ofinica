-- ==========================================================
-- SCRIPT: 01_create_database_oficina.sql
-- DESCRIÇÃO: Criação completa do banco de dados db_oficina
-- AUTOR: Ericson Schmidt Bicalho
-- ==========================================================

DROP DATABASE IF EXISTS db_oficina;
CREATE DATABASE db_oficina
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;

USE db_oficina;

-- ==========================================================
-- TABELA: Cliente
-- ==========================================================
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(150) UNIQUE
) ENGINE=InnoDB;

-- ==========================================================
-- TABELA: Cliente_PF
-- ==========================================================
CREATE TABLE Cliente_PF (
    id_cliente INT PRIMARY KEY,
    cpf CHAR(11) UNIQUE NOT NULL,
    data_nascimento DATE,
    CONSTRAINT fk_cliente_pf_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ==========================================================
-- TABELA: Cliente_PJ
-- ==========================================================
CREATE TABLE Cliente_PJ (
    id_cliente INT PRIMARY KEY,
    cnpj CHAR(14) UNIQUE NOT NULL,
    inscricao_estadual VARCHAR(20),
    CONSTRAINT fk_cliente_pj_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ==========================================================
-- TABELA: Veiculo
-- ==========================================================
CREATE TABLE Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    placa VARCHAR(10) UNIQUE NOT NULL,
    modelo VARCHAR(100),
    marca VARCHAR(100),
    ano YEAR,
    CONSTRAINT fk_veiculo_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente)
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ==========================================================
-- TABELA: Mecanico
-- ==========================================================
CREATE TABLE Mecanico (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    especialidade VARCHAR(100),
    telefone VARCHAR(20)
) ENGINE=InnoDB;

-- ==========================================================
-- TABELA: Servico
-- ==========================================================
CREATE TABLE Servico (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(150) NOT NULL,
    preco_base DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

-- ==========================================================
-- TABELA: Peca
-- ==========================================================
CREATE TABLE Peca (
    id_peca INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(150) NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

-- ==========================================================
-- TABELA: OrdemServico
-- ==========================================================
CREATE TABLE OrdemServico (
    id_os INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_veiculo INT NOT NULL,
    id_mecanico INT,
    data_abertura DATE NOT NULL,
    data_fechamento DATE,
    status ENUM('ABERTA','EM_EXECUCAO','FECHADA','CANCELADA') DEFAULT 'ABERTA',
    CONSTRAINT fk_ordem_cliente FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente)
        ON DELETE RESTRICT,
    CONSTRAINT fk_ordem_veiculo FOREIGN KEY (id_veiculo)
        REFERENCES Veiculo(id_veiculo)
        ON DELETE RESTRICT,
    CONSTRAINT fk_ordem_mecanico FOREIGN KEY (id_mecanico)
        REFERENCES Mecanico(id_mecanico)
        ON DELETE SET NULL
) ENGINE=InnoDB;

-- ==========================================================
-- TABELA: ItemServico
-- ==========================================================
CREATE TABLE ItemServico (
    id_os INT NOT NULL,
    id_servico INT NOT NULL,
    quantidade INT DEFAULT 1,
    valor_unitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_os, id_servico),
    CONSTRAINT fk_itemservico_os FOREIGN KEY (id_os)
        REFERENCES OrdemServico(id_os)
        ON DELETE CASCADE,
    CONSTRAINT fk_itemservico_servico FOREIGN KEY (id_servico)
        REFERENCES Servico(id_servico)
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ==========================================================
-- TABELA: ItemPeca
-- ==========================================================
CREATE TABLE ItemPeca (
    id_os INT NOT NULL,
    id_peca INT NOT NULL,
    quantidade INT DEFAULT 1,
    valor_unitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_os, id_peca),
    CONSTRAINT fk_itempeca_os FOREIGN KEY (id_os)
        REFERENCES OrdemServico(id_os)
        ON DELETE CASCADE,
    CONSTRAINT fk_itempeca_peca FOREIGN KEY (id_peca)
        REFERENCES Peca(id_peca)
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ==========================================================
-- TABELA: Pagamento
-- ==========================================================
CREATE TABLE Pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_os INT NOT NULL,
    forma_pagamento ENUM('DINHEIRO','CARTAO','PIX','OUTROS') DEFAULT 'OUTROS',
    valor DECIMAL(10,2) NOT NULL,
    status ENUM('PENDENTE','PAGO','CANCELADO') DEFAULT 'PENDENTE',
    data_pagamento DATE,
    CONSTRAINT fk_pagamento_os FOREIGN KEY (id_os)
        REFERENCES OrdemServico(id_os)
        ON DELETE CASCADE
) ENGINE=InnoDB;
