COPY operadoras (
    registro_ans,
    cnpj,
    razao_social,
    modalidade,
    uf
)
FROM '/caminho/Relatorio_cadop.csv'
DELIMITER ';'
CSV HEADER
ENCODING 'UTF8';

COPY despesas_consolidadas (
    registro_ans,
    valor_despesas,
    ano,
    trimestre
)
FROM '/caminho/consolidado_despesas.csv'
DELIMITER ';'
CSV HEADER
ENCODING 'UTF8';

COPY despesas_agregadas (
    razao_social,
    uf,
    total_despesas,
    media_trimestral,
    desvio_padrao
)
FROM '/caminho/despesas_agregadas.csv'
DELIMITER ';'
CSV HEADER
ENCODING 'UTF8';
