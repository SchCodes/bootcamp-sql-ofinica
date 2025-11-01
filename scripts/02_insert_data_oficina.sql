-- ==========================================================
-- SCRIPT: 02_insert_data_oficina.sql
-- DESCRIÇÃO: Inserção de dados de teste para db_oficina
-- AUTOR: SchCodes
-- ==========================================================

USE db_oficina;

-- CLIENTES
INSERT INTO Cliente (nome, telefone, email) VALUES
('João Pereira', '41987654321', 'joao.pereira@email.com'),
('Maria Silva', '41999887766', 'maria.silva@email.com'),
('Carlos Oliveira', '41988776655', 'carlos.oliveira@email.com'),
('Auto Center Alfa Ltda', '41955554444', 'contato@autocenteralfa.com'),
('Mecânica Rápida Express', '41933332222', 'contato@rapidamecanica.com'),
('Fernanda Souza', '41998997788', 'fernanda.souza@email.com'),
('Pedro Lima', '41993216578', 'pedro.lima@email.com'),
('Transportes Delta S/A', '41920001234', 'logistica@transportesdelta.com'),
('Rogério Dias', '41987653456', 'rogerio.dias@email.com'),
('Construtora Orion LTDA', '41921114321', 'adm@construtoraorion.com');

-- CLIENTES PF
INSERT INTO Cliente_PF (id_cliente, cpf, data_nascimento) VALUES
(1, '12345678901', '1987-03-12'),
(2, '98765432100', '1992-06-21'),
(3, '45678912300', '1980-10-02'),
(6, '11122233344', '1995-07-15'),
(7, '55566677788', '1978-12-05'),
(9, '99988877766', '1983-11-22');

-- CLIENTES PJ
INSERT INTO Cliente_PJ (id_cliente, cnpj, inscricao_estadual) VALUES
(4, '12345678000199', 'IS12345'),
(5, '98765432000188', 'IS54321'),
(8, '55566677000122', 'IS87654'),
(10, '11223344000155', 'IS99887');

-- VEÍCULOS
INSERT INTO Veiculo (id_cliente, placa, modelo, marca, ano) VALUES
(1, 'ABC1D23', 'Civic', 'Honda', 2018),
(2, 'BCD2E34', 'Corolla', 'Toyota', 2020),
(3, 'CDE3F45', 'Onix', 'Chevrolet', 2019),
(4, 'DEF4G56', 'Strada', 'Fiat', 2021),
(5, 'EFG5H67', 'Doblo Cargo', 'Fiat', 2022),
(6, 'FGH6I78', 'HB20', 'Hyundai', 2017),
(7, 'GHI7J89', 'Kwid', 'Renault', 2020),
(8, 'HIJ8K90', 'Sprinter', 'Mercedes-Benz', 2019),
(9, 'IJK9L01', 'Fiesta', 'Ford', 2016),
(10, 'JKL0M12', 'Toro', 'Fiat', 2023);

-- MECÂNICOS
INSERT INTO Mecanico (nome, especialidade, telefone) VALUES
('Ricardo Martins', 'Motor e Injeção', '41988001122'),
('Luana Torres', 'Suspensão e Freios', '41987003344'),
('Fernando Lopes', 'Elétrica Automotiva', '41986557788'),
('Bruno Costa', 'Transmissão', '41989996655'),
('André Almeida', 'Diagnóstico e Scanner', '41985554433');

-- SERVIÇOS
INSERT INTO Servico (descricao, preco_base) VALUES
('Troca de óleo', 120.00),
('Alinhamento e balanceamento', 150.00),
('Revisão completa', 350.00),
('Substituição de pastilhas de freio', 180.00),
('Troca de embreagem', 900.00),
('Limpeza de bicos injetores', 200.00),
('Diagnóstico eletrônico', 130.00),
('Reparo de alternador', 250.00),
('Troca de correia dentada', 420.00),
('Revisão de suspensão', 280.00);

-- PEÇAS
INSERT INTO Peca (descricao, preco_unitario) VALUES
('Filtro de óleo', 35.00),
('Filtro de ar', 45.00),
('Pastilha de freio dianteira', 120.00),
('Correia dentada', 180.00),
('Jogo de velas', 90.00),
('Bateria 60Ah', 450.00),
('Óleo sintético 5W30 (1L)', 60.00),
('Amortecedor dianteiro', 320.00),
('Disco de freio ventilado', 280.00),
('Alternador 12V 90A', 980.00);

-- ORDENS DE SERVIÇO
INSERT INTO OrdemServico (id_cliente, id_veiculo, id_mecanico, data_abertura, data_fechamento, status) VALUES
(1, 1, 1, '2025-10-01', '2025-10-02', 'FECHADA'),
(2, 2, 2, '2025-10-03', NULL, 'EM_EXECUCAO'),
(3, 3, 3, '2025-10-04', '2025-10-06', 'FECHADA'),
(4, 4, 4, '2025-10-05', NULL, 'ABERTA'),
(5, 5, 2, '2025-10-06', '2025-10-07', 'FECHADA'),
(6, 6, 5, '2025-10-07', NULL, 'EM_EXECUCAO'),
(7, 7, 1, '2025-10-08', '2025-10-09', 'FECHADA'),
(8, 8, 3, '2025-10-09', NULL, 'ABERTA'),
(9, 9, 4, '2025-10-10', '2025-10-11', 'FECHADA'),
(10, 10, 5, '2025-10-11', '2025-10-12', 'FECHADA');

-- ITENS DE SERVIÇO
INSERT INTO ItemServico (id_os, id_servico, quantidade, valor_unitario) VALUES
(1, 1, 1, 120.00),
(1, 2, 1, 150.00),
(2, 3, 1, 350.00),
(3, 4, 1, 180.00),
(3, 5, 1, 900.00),
(5, 6, 1, 200.00),
(6, 7, 1, 130.00),
(7, 8, 1, 250.00),
(9, 9, 1, 420.00),
(10, 10, 1, 280.00);

-- ITENS DE PEÇA
INSERT INTO ItemPeca (id_os, id_peca, quantidade, valor_unitario) VALUES
(1, 1, 1, 35.00),
(1, 7, 4, 60.00),
(3, 3, 1, 120.00),
(3, 4, 1, 180.00),
(5, 6, 1, 450.00),
(7, 8, 2, 320.00),
(9, 9, 1, 280.00),
(10, 10, 1, 980.00);

-- PAGAMENTOS
INSERT INTO Pagamento (id_os, forma_pagamento, valor, status, data_pagamento) VALUES
(1, 'PIX', 305.00, 'PAGO', '2025-10-02'),
(2, 'CARTAO', 350.00, 'PENDENTE', NULL),
(3, 'DINHEIRO', 1200.00, 'PAGO', '2025-10-06'),
(5, 'CARTAO', 620.00, 'PAGO', '2025-10-07'),
(7, 'DINHEIRO', 280.00, 'PAGO', '2025-10-09'),
(9, 'PIX', 155.00, 'PAGO', '2025-10-11'),
(10, 'DINHEIRO', 1080.00, 'PAGO', '2025-10-12');
