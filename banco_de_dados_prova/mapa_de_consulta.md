# Mapa de Consulta - Banco de Dados Prova

Este índice lista todos os assuntos do projeto, organizados por pasta, para facilitar a consulta rápida durante a prova.

---

# 01_algebra_relacional

## seleção
arquivo principal: `01_algebra_relacional/selecao.sql`
exemplos importantes:
* filtro simples (idade > 18)
* filtro composto (cidade e idade)
* exercício estilo prova (doença e idade)
arquivos relacionados: `04_operadores/where.sql`
nível: Fácil

## projeção
arquivo principal: `01_algebra_relacional/projecao.sql`
exemplos importantes:
* colunas simples com distinct
* projeção + seleção combinadas
* renomeação (alias) e estilo prova
arquivos relacionados: `03_dml/select_basico.sql`
nível: Fácil

## união
arquivo principal: `01_algebra_relacional/uniao.sql`
exemplos importantes:
* união simples (elimina duplicatas)
* union all (mantém duplicatas)
* exercício estilo prova com 3 tabelas
arquivos relacionados: `Nenhum`
nível: Fácil

## intersecção
arquivo principal: `01_algebra_relacional/interseccao.sql`
exemplos importantes:
* intersect simples
* equivalência com IN
* exercício estilo prova combinando selects
arquivos relacionados: `08_subconsultas/subquery_in.sql`
nível: Intermediário

## diferença
arquivo principal: `01_algebra_relacional/diferenca.sql`
exemplos importantes:
* except simples
* equivalência com NOT IN
* exercício estilo prova
arquivos relacionados: `04_operadores/not_in.sql`
nível: Intermediário

## produto cartesiano
arquivo principal: `01_algebra_relacional/produto_cartesiano.sql`
exemplos importantes:
* cartesiano simples (todas combinações)
* cartesiano com filtro virando junção
* exercício estilo prova (self join com alias)
arquivos relacionados: `07_joins/cross_join.sql`
nível: Intermediário

## junções
arquivo principal: `01_algebra_relacional/juncoes.sql`
exemplos importantes:
* theta join (com ON)
* equivalência produto cartesiano + where
* junção natural, left, right, full
arquivos relacionados: `Todos da pasta 07_joins`
nível: Intermediário

## divisão
arquivo principal: `01_algebra_relacional/divisao.sql`
exemplos importantes:
* divisão por dupla negação (NOT EXISTS)
* divisão com COUNT e GROUP BY
* exercício estilo prova
arquivos relacionados: `08_subconsultas/subquery_not_exists.sql`
nível: Difícil

---

# 02_ddl

## create table
arquivo principal: `02_ddl/create_table.sql`
exemplos importantes:
* tipos básicos, serial
* constraints inline e de tabela
* exercício estilo prova
arquivos relacionados: `Pasta 11_constraints`
nível: Fácil

## alter table
arquivo principal: `02_ddl/alter_table_add_column.sql` (e afins)
exemplos importantes:
* adicionar coluna
* remover coluna
* modificar tipo e constraints
arquivos relacionados: `Nenhum`
nível: Fácil

## serial e sequence
arquivo principal: `02_ddl/serial_sequence.sql`
exemplos importantes:
* auto-incremento
* manipulando o contador atual (setval)
* exercício estilo prova
arquivos relacionados: `Nenhum`
nível: Intermediário

---

# 03_dml

## insert
arquivo principal: `03_dml/insert.sql`
exemplos importantes:
* insert simples
* insert com colunas específicas
* insert retornando o valor gerado (returning)
arquivos relacionados: `Nenhum`
nível: Fácil

## update
arquivo principal: `03_dml/update.sql`
exemplos importantes:
* update simples
* update com cálculo
* update estilo prova
arquivos relacionados: `Nenhum`
nível: Fácil

## delete
arquivo principal: `03_dml/delete.sql`
exemplos importantes:
* delete simples
* delete com filtro
* delete estilo prova com returning
arquivos relacionados: `Nenhum`
nível: Fácil

## transações acid
arquivo principal: `03_dml/transacoes_acid.sql`
exemplos importantes:
* begin e commit
* rollback simulando erro
* exercício estilo prova
arquivos relacionados: `Nenhum`
nível: Intermediário

---

# 04_operadores

## filtros básicos (where)
arquivo principal: `04_operadores/where.sql`
exemplos importantes:
* igualdade e desigualdade
* and, or, parênteses
* exercício estilo prova
arquivos relacionados: `01_algebra_relacional/selecao.sql`
nível: Fácil

## between e in
arquivo principal: `04_operadores/between.sql` e `04_operadores/in.sql`
exemplos importantes:
* intervalos de data e valor
* listas de valores
* exercício estilo prova
arquivos relacionados: `Nenhum`
nível: Fácil

## nulls
arquivo principal: `04_operadores/is_null.sql` e `is_not_null.sql`
exemplos importantes:
* encontrar registros incompletos
* tratar ausência de dados
* exercício estilo prova
arquivos relacionados: `Nenhum`
nível: Fácil

## like e ilike
arquivo principal: `04_operadores/like.sql` e `ilike.sql`
exemplos importantes:
* busca exata (case sensitive)
* busca ignorando maiúsculas (ilike)
* curingas % e _
arquivos relacionados: `Nenhum`
nível: Fácil

---

# 05_funcoes_agregacao

## funções comuns
arquivos principais: `05_funcoes_agregacao/count.sql`, `sum.sql`, `avg.sql`, `min.sql`, `max.sql`
exemplos importantes:
* totais, contagem, média, máximo, mínimo
* tratamento de nulos
* exercício estilo prova
arquivos relacionados: `06_group_by_having/*`
nível: Fácil

---

# 06_group_by_having

## agrupamento e filtro
arquivo principal: `06_group_by_having/group_by_having.sql`
exemplos importantes:
* agrupamento simples (group by)
* filtro de agregações (having)
* combinação dos dois
arquivos relacionados: `05_funcoes_agregacao/*`
nível: Intermediário

---

# 07_joins

## inner join
arquivo principal: `07_joins/inner_join.sql`
exemplos importantes:
* médico e consulta
* paciente e consulta
* exercício estilo prova
arquivos relacionados: `01_algebra_relacional/juncoes.sql`
nível: Fácil

## left join
arquivo principal: `07_joins/left_join.sql`
exemplos importantes:
* médicos com e sem consulta
* encontrar registros órfãos (anti-join)
* exercício estilo prova
arquivos relacionados: `Nenhum`
nível: Intermediário

## full join
arquivo principal: `07_joins/full_join.sql`
exemplos importantes:
* listar todos de ambos os lados
* encontrar não-relacionados nos dois lados
* exercício estilo prova
arquivos relacionados: `Nenhum`
nível: Intermediário

---

# 08_subconsultas

## exists e not exists
arquivos principais: `08_subconsultas/subquery_exists.sql` e `subquery_not_exists.sql`
exemplos importantes:
* teste de existência simples
* anti-join com NOT EXISTS
* divisão com dupla negação (NOT EXISTS(NOT EXISTS))
arquivos relacionados: `exists.sql` e `not_exists.sql` (versões alternativas da sessão 2)
nível: Difícil

## in, any, all
arquivos principais: `08_subconsultas/subquery_in.sql`, `subquery_any.sql`, `subquery_all.sql`
exemplos importantes:
* subconsulta substituindo JOIN
* comparar com máximo/mínimo do conjunto
* exercícios estilo prova
arquivos relacionados: `any_all.sql`
nível: Intermediário

## subconsulta correlacionada
arquivo principal: `08_subconsultas/subconsulta_correlacionada.sql`
exemplos importantes:
* comparar linha com grupo ao qual pertence
* maior salário do departamento
* exemplo estilo prova complexo
arquivos relacionados: `Nenhum`
nível: Difícil

---

# 09_views

## views atualizáveis e materializadas
arquivos principais: `09_views/view_atualizavel.sql` e `materialized_view.sql`
exemplos importantes:
* views que aceitam insert/update
* uso do WITH CHECK OPTION
* refresh em view materializada (cache)
arquivos relacionados: `view_simples.sql`
nível: Intermediário

---

# 10_indices

## tipos de índice
arquivos principais: `10_indices/indice_btree.sql` e `indice_hash.sql`
exemplos importantes:
* btree para >, <, between, order by
* hash APENAS para igualdade (=)
* índices compostos e impacto da ordem das colunas
arquivos relacionados: `create_index.sql`
nível: Intermediário

---

# 11_constraints

## integridade
arquivos principais: `11_constraints/primary_key.sql`, `foreign_key.sql`, `check.sql`
exemplos importantes:
* chaves primárias e estrangeiras
* validação customizada (check)
* on delete cascade / on update set null
arquivos relacionados: `02_ddl/create_table.sql`
nível: Fácil

---

# 12_plpgsql

## controle e repetição
arquivos principais: `12_plpgsql/if_else.sql`, `case.sql`, `loop.sql`, `while.sql`, `for.sql`
exemplos importantes:
* lógicas condicionais complexas
* laços de repetição numéricos e em queries
* fibonacci, fatorial
arquivos relacionados: `variaveis_e_controle.sql`, `loops.sql`
nível: Intermediário

## cursores e sql dinâmico
arquivos principais: `12_plpgsql/cursor.sql` e `sql_dinamico.sql`
exemplos importantes:
* navegação linha a linha com open/fetch/close
* execute format para queries flexíveis
* cursores parametrizados
arquivos relacionados: `cursores.sql`
nível: Difícil

---

# 13_triggers

## operações e tempo
arquivos principais: `13_triggers/trigger_before_insert.sql` e variações
exemplos importantes:
* validar/impedir BEFORE
* log e auditoria AFTER
* operações complexas em views (INSTEAD OF)
arquivos relacionados: `trigger_before.sql`, `trigger_after.sql`
nível: Intermediário

## contexto do trigger
arquivos principais: `13_triggers/new_old.sql` e `tg_op.sql`
exemplos importantes:
* comparar NEW e OLD no update
* trigger genérico com TG_OP, TG_TABLE_NAME
* tratamento condicional por operação
arquivos relacionados: `Nenhum`
nível: Difícil

---

# 14_exercicios_resolvidos

## compilado de questões
arquivo principal: `Qualquer arquivo da pasta 14_exercicios_resolvidos`
exemplos importantes:
* questões combinadas
* revisões completas por tema
arquivos relacionados: `Todos os anteriores`
nível: Misto

---
---

# CONSULTA RÁPIDA PARA PROVA

Se você precisar de:

* **exists**: abra `08_subconsultas/subquery_exists.sql` (ou `08_subconsultas/exists.sql`)
* **not exists**: abra `08_subconsultas/subquery_not_exists.sql` (ou `08_subconsultas/not_exists.sql`)
* **any**: abra `08_subconsultas/subquery_any.sql`
* **all**: abra `08_subconsultas/subquery_all.sql`
* **group by**: abra `06_group_by_having/group_by.sql`
* **having**: abra `06_group_by_having/group_by_having.sql` (ou `06_group_by_having/having.sql`)
* **trigger before update**: abra `13_triggers/trigger_before_update.sql`
* **tg_op**: abra `13_triggers/tg_op.sql`
* **cursor**: abra `12_plpgsql/cursor.sql`
* **sql dinâmico**: abra `12_plpgsql/sql_dinamico.sql`
* **materialized view**: abra `09_views/materialized_view.sql`
* **índice hash**: abra `10_indices/indice_hash.sql`
