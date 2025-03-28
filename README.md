📊 Análise de Demonstrativos Contábeis de Operadoras de Saúde

Este repositório contém scripts SQL para a estruturação, importação e análise de dados financeiros de operadoras de planos de saúde com base em informações disponibilizadas pela ANS (Agência Nacional de Saúde Suplementar).

📌 Objetivos

Criar tabelas compatíveis com PostgreSQL 10+ para armazenar dados das operadoras e demonstrações contábeis.

Importar os arquivos CSV baixados do repositório público da ANS.

Executar queries analíticas para identificar as operadoras com maiores despesas em eventos médicos e hospitalares.

📂 Estrutura do Projeto

scripts/estrutura.sql → Criação das tabelas no banco de dados.

scripts/importacao.sql → Comandos para importar os arquivos CSV.

scripts/analise.sql → Queries para responder às perguntas analíticas.

🔧 Requisitos

Banco de Dados: PostgreSQL 10+

Arquivos CSV:

📝 Notas

Certifique-se de ajustar os caminhos dos arquivos CSV antes da importação.

O encoding dos arquivos da ANS pode ser LATIN1, portanto, definimos esse formato no comando COPY.
