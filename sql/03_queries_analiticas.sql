WITH despesas_por_periodo AS (
    SELECT
        registro_ans,
        MIN(trimestre + ano * 10) AS periodo_inicial,
        MAX(trimestre + ano * 10) AS periodo_final
    FROM despesas_consolidadas
    GROUP BY registro_ans
),
valores AS (
    SELECT
        d.registro_ans,
        SUM(CASE WHEN (d.trimestre + d.ano * 10) = p.periodo_inicial THEN d.valor_despesas END) AS valor_inicial,
        SUM(CASE WHEN (d.trimestre + d.ano * 10) = p.periodo_final THEN d.valor_despesas END) AS valor_final
    FROM despesas_consolidadas d
    JOIN despesas_por_periodo p ON d.registro_ans = p.registro_ans
    GROUP BY d.registro_ans
)
SELECT
    o.razao_social,
    ((valor_final - valor_inicial) / valor_inicial) * 100 AS crescimento_percentual
FROM valores v
JOIN operadoras o ON o.registro_ans = v.registro_ans
WHERE valor_inicial > 0
ORDER BY crescimento_percentual DESC
LIMIT 5;


SELECT
    o.uf,
    SUM(d.valor_despesas) AS total_despesas,
    AVG(d.valor_despesas) AS media_por_operadora
FROM despesas_consolidadas d
JOIN operadoras o ON o.registro_ans = d.registro_ans
GROUP BY o.uf
ORDER BY total_despesas DESC
LIMIT 5;


WITH media_geral AS (
    SELECT AVG(valor_despesas) AS media
    FROM despesas_consolidadas
),
acima_media AS (
    SELECT
        registro_ans,
        COUNT(*) AS qtd_trimestres
    FROM despesas_consolidadas, media_geral
    WHERE valor_despesas > media_geral.media
    GROUP BY registro_ans
)
SELECT COUNT(*) AS operadoras_acima_media
FROM acima_media
WHERE qtd_trimestres >= 2;
