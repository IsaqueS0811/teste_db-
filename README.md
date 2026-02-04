TESTE DE BANCO DE DADOS E ANÁLISE

# Sobre o projeto

Este projeto foi desenvolvido como parte do Teste Técnico – IntuitiveCare (Etapa 3).
O objetivo desta etapa é estruturar um modelo de banco de dados relacional e desenvolver queries analíticas a partir dos dados consolidados e transformados nas etapas anteriores.

# O foco principal é demonstrar:

- Capacidade de modelagem de dados

- Escolhas técnicas conscientes (trade-offs)

- Escrita de SQL claro, legível e analítico

# Objetivos

- Criar tabelas relacionais para armazenar dados consolidados, cadastrais e agregados
- Definir chaves primárias, estrangeiras e índices apropriados
- Importar dados a partir de arquivos CSV
- Desenvolver queries analíticas para responder perguntas de negócio
- Justificar decisões técnicas relacionadas à modelagem, tipos de dados e queries

# Estrutura do projeto
Etapa_3/
│
├── sql/
│   ├── 01_ddl.sql
│   ├── 02_importacao.sql
│   └── 03_queries_analiticas.sql
│
└── README.md

# Banco de dados utilizado

- Os scripts SQL foram desenvolvidos considerando PostgreSQL versão 10 ou superior.
- As queries são compatíveis com bancos relacionais modernos e podem ser adaptadas facilmente para MySQL 8.0.

A execução do banco de dados não é obrigatória para avaliação do teste, sendo suficiente a análise dos scripts SQL.

# Fontes de dados utilizadas

Os dados utilizados nesta etapa são provenientes das etapas anteriores do teste:

- consolidado_despesas.csv (Etapa 1)
- despesas_agregadas.csv (Etapa 2)
- Relatorio_cadop.csv — Dados cadastrais das operadoras (ANS)
- Decisões técnicas e trade-offs
- Normalização dos dados
- Abordagem escolhida: Opção B — Tabelas normalizadas
- Foram criadas tabelas separadas para:
- Dados cadastrais das operadoras
- Despesas consolidadas por período
- Dados agregados para análise

# Justificativa:

- Evita redundância de informações cadastrais
- Facilita manutenção e atualizações futuras
- Torna as queries analíticas mais claras
- Adequado para crescimento de volume de dados

# Tipos de dados
- Valores monetários
- Foi utilizado o tipo DECIMAL(18,2) para valores financeiros.

# Justificativa:
- Garante precisão numérica
- Evita erros de arredondamento
- Adequado para dados financeiros

## Período

- Ano → SMALLINT
- Trimestre → SMALLINT 
Como os dados são agregados por período, não foi necessário o uso de tipos DATE ou TIMESTAMP.

## Importação dos dados

- A importação dos arquivos CSV é realizada utilizando o comando COPY, com as seguintes considerações:

- Encoding UTF-8

## Delimitador ;

- Presença de cabeçalho nos arquivos
- Tratamento de inconsistências
- Situação encontrada	Estratégia adotada
- Valores nulos em campos obrigatórios	Rejeição do registro
- Strings em campos numéricos	Tratadas previamente em Python
- Datas inconsistentes	Normalizadas antes da importação

## Justificativa:

Optou-se por tratar inconsistências nas etapas anteriores para manter os scripts SQL mais simples, confiáveis e legíveis.

Queries analíticas desenvolvidas

- Query 1 — Crescimento percentual de despesas

Identifica as 5 operadoras com maior crescimento percentual entre o primeiro e o último trimestre disponível.

Tratamento de operadoras sem dados completos:
Operadoras que não possuem valores em ambos os períodos são excluídas da análise para evitar distorções estatísticas.

- Query 2 — Distribuição de despesas por UF

Calcula:

Total de despesas por estado (UF)

Média de despesas por operadora em cada UF

Retorna os 5 estados com maior volume total de despesas.

- Query 3 — Operadoras acima da média

Identifica quantas operadoras tiveram despesas acima da média geral em pelo menos 2 dos 3 trimestres analisados.

## Abordagem escolhida:
Uso de CTEs para melhorar legibilidade e manutenibilidade da query.
