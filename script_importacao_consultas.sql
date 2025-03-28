-- Criação das tabelas para armazenar os dados das operadoras e das demonstrações contábeis
CREATE TABLE operadoras (
    id SERIAL PRIMARY KEY,
    registro_ans VARCHAR(50) UNIQUE,
    cnpj VARCHAR(18),
    razao_social VARCHAR(255),
    nome_fantasia VARCHAR(255),
    modalidade VARCHAR(100),
    logradouro VARCHAR(255),
    numero VARCHAR(10),
    complemento VARCHAR(255),
    bairro VARCHAR(255),
    cidade VARCHAR(255),
    uf VARCHAR(2),
    cep VARCHAR(10),
    ddd VARCHAR(5),
    telefone VARCHAR(20),
    email VARCHAR(255),
    representante VARCHAR(255),
    cargo_representante VARCHAR(255),
    regiao_comercializacao INT,
    data_registro_ans DATE
);

CREATE TABLE demonstracoes_contabeis (
    id SERIAL PRIMARY KEY,
    registro_ans VARCHAR(50) REFERENCES operadoras(registro_ans),
    data DATE,
    cd_conta_contabil VARCHAR(20),
    descricao VARCHAR(255),
    saldo_inicial DECIMAL(18,2),
    saldo_final DECIMAL(18,2),
    data_importacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Importação de dados via comando COPY (PostgreSQL)
COPY operadoras(
    registro_ans, cnpj, razao_social, nome_fantasia, modalidade, logradouro, numero, complemento,
    bairro, cidade, uf, cep, ddd, telefone, email, representante, cargo_representante,
    regiao_comercializacao, data_registro_ans
)
FROM '/caminho/do/arquivo/Relatorio_cadop.csv'
DELIMITER ';'
CSV HEADER ENCODING 'LATIN1';

COPY demonstracoes_contabeis(registro_ans, data, cd_conta_contabil, descricao, saldo_inicial, saldo_final)
FROM '/caminho/do/arquivo/1T2023.csv'
DELIMITER ';'
CSV HEADER ENCODING 'LATIN1';

-- Query analítica para os 10 maiores gastos no último trimestre
SELECT o.cnpj, SUM(d.saldo_final) AS total_despesas
FROM demonstracoes_contabeis d
JOIN operadoras o ON d.registro_ans = o.registro_ans
WHERE d.descricao ILIKE '%sinistros conhecidos ou avisados de assistência à saúde médico hospitalar%'
  AND d.data >= (CURRENT_DATE - INTERVAL '3 months')
GROUP BY o.nome_fantasia
ORDER BY total_despesas DESC
LIMIT 10;

-- Query analítica para os 10 maiores gastos no último ano
SELECT o.cnpj, SUM(d.saldo_final) AS total_despesas
FROM demonstracoes_contabeis d
JOIN operadoras o ON d.registro_ans = o.registro_ans
WHERE d.descricao ILIKE '%sinistros conhecidos ou avisados de assistência à saúde médico hospitalar%'
  AND d.data >= (CURRENT_DATE - INTERVAL '1 year')
GROUP BY o.nome_fantasia
ORDER BY total_despesas DESC
LIMIT 10;
