-- ==========================================================
-- SCRIPT: 03_queries_oficina.sql
-- DESCRIÇÃO: Consultas DQL e análises de KPIs do banco db_oficina
-- AUTOR: SchCodes
-- ==========================================================

USE db_oficina;

-- Recupera todos os clientes e suas informações básicas
SELECT id_cliente, nome, telefone, email
FROM Cliente
ORDER BY nome;

-- Lista os veículos e seus respectivos clientes
SELECT v.placa, v.modelo, v.marca, c.nome AS cliente
FROM Veiculo v
JOIN Cliente c ON v.id_cliente = c.id_cliente
ORDER BY c.nome;

-- Exibe ordens em aberto ou em execução
SELECT id_os, id_cliente, id_veiculo, status, data_abertura
FROM OrdemServico
WHERE status IN ('ABERTA', 'EM_EXECUCAO')
ORDER BY data_abertura DESC;

-- Calcula o total estimado de cada ordem (serviços + peças)
SELECT 
    os.id_os,
    c.nome AS cliente,
    ROUND(
        IFNULL(SUM(isv.quantidade * isv.valor_unitario), 0)
      + IFNULL(SUM(ipc.quantidade * ipc.valor_unitario), 0),
    2) AS total_estimado
FROM OrdemServico os
LEFT JOIN Cliente c ON os.id_cliente = c.id_cliente
LEFT JOIN ItemServico isv ON os.id_os = isv.id_os
LEFT JOIN ItemPeca ipc ON os.id_os = ipc.id_os
GROUP BY os.id_os, c.nome
ORDER BY total_estimado DESC;

-- Mostra detalhes das ordens concluídas
SELECT 
    os.id_os,
    c.nome AS cliente,
    v.placa,
    m.nome AS mecanico,
    os.status,
    os.data_abertura,
    os.data_fechamento
FROM OrdemServico os
JOIN Cliente c ON os.id_cliente = c.id_cliente
JOIN Veiculo v ON os.id_veiculo = v.id_veiculo
LEFT JOIN Mecanico m ON os.id_mecanico = m.id_mecanico
WHERE os.status = 'FECHADA'
ORDER BY os.data_fechamento DESC;

-- Quantidade de ordens concluídas por mecânico
SELECT 
    m.nome AS mecanico,
    COUNT(os.id_os) AS ordens_concluidas
FROM Mecanico m
LEFT JOIN OrdemServico os ON m.id_mecanico = os.id_mecanico
WHERE os.status = 'FECHADA'
GROUP BY m.nome
ORDER BY ordens_concluidas DESC;

-- Faturamento total e ticket médio
SELECT 
    ROUND(SUM(valor), 2) AS faturamento_total,
    ROUND(SUM(valor) / COUNT(DISTINCT id_os), 2) AS ticket_medio
FROM Pagamento
WHERE status = 'PAGO';

-- Valor total recebido por forma de pagamento
SELECT 
    forma_pagamento,
    COUNT(*) AS qtd_pagamentos,
    ROUND(SUM(valor), 2) AS valor_total
FROM Pagamento
WHERE status = 'PAGO'
GROUP BY forma_pagamento
ORDER BY valor_total DESC;

-- Serviços mais executados
SELECT 
    s.descricao AS servico,
    SUM(isv.quantidade) AS total_execucoes
FROM ItemServico isv
JOIN Servico s ON isv.id_servico = s.id_servico
GROUP BY s.descricao
ORDER BY total_execucoes DESC
LIMIT 5;

-- Peças mais utilizadas
SELECT 
    p.descricao AS peca,
    SUM(ipc.quantidade) AS total_utilizada
FROM ItemPeca ipc
JOIN Peca p ON ipc.id_peca = p.id_peca
GROUP BY p.descricao
ORDER BY total_utilizada DESC
LIMIT 5;

-- Clientes com maior número de ordens
SELECT 
    c.nome AS cliente,
    COUNT(os.id_os) AS total_ordens
FROM Cliente c
JOIN OrdemServico os ON c.id_cliente = os.id_cliente
GROUP BY c.nome
ORDER BY total_ordens DESC
LIMIT 5;

-- Clientes com maior valor total em ordens
SELECT 
    c.nome AS cliente,
    ROUND(SUM(isv.valor_unitario * isv.quantidade + ipc.valor_unitario * ipc.quantidade), 2) AS valor_total
FROM Cliente c
JOIN OrdemServico os ON c.id_cliente = os.id_cliente
LEFT JOIN ItemServico isv ON os.id_os = isv.id_os
LEFT JOIN ItemPeca ipc ON os.id_os = ipc.id_os
GROUP BY c.nome
ORDER BY valor_total DESC
LIMIT 5;

-- Tempo médio de execução de ordens
SELECT 
    ROUND(AVG(DATEDIFF(data_fechamento, data_abertura)), 2) AS tempo_medio_execucao
FROM OrdemServico
WHERE data_fechamento IS NOT NULL;

-- Proporção de clientes PF e PJ
SELECT 
    'Pessoa Física' AS tipo_cliente,
    COUNT(pf.id_cliente) AS total
FROM Cliente_PF pf
UNION ALL
SELECT 
    'Pessoa Jurídica',
    COUNT(pj.id_cliente)
FROM Cliente_PJ pj;

-- Total de ordens e valores estimados por status
SELECT 
    os.status,
    COUNT(os.id_os) AS total_ordens,
    ROUND(
        IFNULL(SUM(isv.valor_unitario * isv.quantidade), 0)
      + IFNULL(SUM(ipc.valor_unitario * ipc.quantidade), 0),
    2) AS valor_estimado
FROM OrdemServico os
LEFT JOIN ItemServico isv ON os.id_os = isv.id_os
LEFT JOIN ItemPeca ipc ON os.id_os = ipc.id_os
GROUP BY os.status
ORDER BY total_ordens DESC;

