-- create index
-- quando usar: acelerar buscas em colunas muito consultadas
-- obs prova: pk e unique ja criam indice automaticamente
--            indice nao muda o resultado, so a performance

-- exemplo simples
create index idx_medico_cidade on medico (cidade);

-- exemplo intermediario (indice composto)
-- util quando a busca filtra por duas colunas juntas
create index idx_consulta_data_hora on consulta (data, hora);

-- exemplo estilo prova
-- indice unico (garante unicidade sem ser pk)
create unique index idx_funcionario_cpf on funcionario (cpf);

-- indice parcial (so para linhas que satisfazem a condicao)
create index idx_medico_floripa on medico (nome)
where cidade = 'Florianopolis';

-- limpeza
drop index if exists idx_medico_cidade;
drop index if exists idx_consulta_data_hora;
drop index if exists idx_funcionario_cpf;
drop index if exists idx_medico_floripa;
