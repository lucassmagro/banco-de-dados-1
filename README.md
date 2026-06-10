# Banco de Dados 1

Este repositório reúne todo o material prático desenvolvido para acompanhar a disciplina de Banco de Dados. O objetivo principal é ter uma base de consulta rápida e confiável para provas e trabalhos, cobrindo todos os tópicos exigidos nas aulas teóricas e nos slides fornecidos.

## Como o material está organizado

Todo o código foi escrito com foco no PostgreSQL e segue um padrão rigoroso de formatação: apenas minúsculas, com comentários diretos ao ponto e exemplos gradativos.

A base de dados utilizada como exemplo central é a de uma clínica médica, contendo tabelas de paciente, médico, consulta, funcionário, ambulatório e departamento. Todos os exemplos práticos rodam em cima dessa mesma estrutura estrutural.

A navegação foi dividida em pastas numeradas, que representam a ordem lógica do aprendizado:

* 00_base: Contém o script completo para recriar o banco da clínica do zero, além do mapa de consulta geral com dicas.
* 01_algebra_relacional: Exemplos de seleção, projeção, junções e conjuntos mapeados para SQL.
* 02_ddl: Comandos de definição de dados, como criação e alteração de tabelas e sequences.
* 03_dml a 08_subconsultas: Operadores, funções de agregação, agrupamentos e consultas complexas.
* 09_views a 11_constraints: Abstrações de leitura, criação de índices de performance e regras de integridade.
* 12_plpgsql e 13_triggers: Programação no banco de dados, funções CRUD encapsuladas e gatilhos de auditoria.
* 14_exercicios_resolvidos: Baterias de exercícios passados em aula, devidamente resolvidos e testados.

## Como utilizar

Para testar os scripts no seu próprio computador, basta ter o PostgreSQL instalado (via psql ou interface gráfica como o pgAdmin).

1. Conecte-se ao seu servidor de banco de dados.
2. Crie um banco novo exclusivo para os testes.
3. Abra a pasta 00_base e rode o arquivo base_completa.sql de uma vez só. Isso vai criar todas as tabelas e inserir os registros necessários.
4. Navegue pelos assuntos nas outras pastas. Cada arquivo traz um exemplo simples, um intermediário e um nível de prova para o comando específico que você quer entender.

## Cobertura do conteúdo

Todo o código do repositório passou por uma auditoria técnica rigorosa contra os PDFs reais das aulas. Todas as operações listadas nos slides estão refletidas em código executável aqui, cobrindo desde os filtros mais básicos até estruturas complexas com triggers e índices espaciais.

Caso você encontre erros de sintaxe nos seus estudos, use este repositório como guia de referência técnica. O código contido nas pastas foi plenamente validado.
