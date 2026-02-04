-- ============================
-- TABELA: Operadoras (Cadastro)
-- ============================
CREATE TABLE operadoras (
    registro_ans      INTEGER PRIMARY KEY,
    cnpj              CHAR(14) NOT NULL,
    razao_social      TEXT NOT NULL,
    modalidade        TEXT,
    uf                CHAR(2)
);

CREATE INDEX idx_operadoras_cnpj ON operadoras(cnpj);
CREATE INDEX idx_operadoras_uf ON operadoras(uf);

-- ============================
-- TABELA: Despesas Consolidadas
-- ============================
CREATE TABLE despesas_consolidadas (
    id                SERIAL PRIMARY KEY,
    registro_ans      INTEGER NOT NULL,
    ano               SMALLINT NOT NULL,
    trimestre         SMALLINT NOT NULL,
    valor_despesas    DECIMAL(18,2) NOT NULL,
    CONSTRAINT fk_operadora
        FOREIGN KEY (registro_ans)
        REFERENCES operadoras(registro_ans)
);

CREATE INDEX idx_despesas_periodo ON despesas_consolidadas(ano, trimestre);
CREATE INDEX idx_despesas_operadora ON despesas_consolidadas(registro_ans);

-- ============================
-- TABELA: Despesas Agregadas
-- ============================
CREATE TABLE despesas_agregadas (
    razao_social       TEXT NOT NULL,
    uf                 CHAR(2),
    total_despesas     DECIMAL(18,2),
    media_trimestral   DECIMAL(18,2),
    desvio_padrao      DECIMAL(18,2)
);
