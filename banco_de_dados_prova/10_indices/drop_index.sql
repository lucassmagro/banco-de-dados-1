-- drop index
-- quando usar: remover indice que nao e mais necessario
-- obs prova: indice de pk e unique nao podem ser removidos com drop index
--            precisa remover a constraint antes

-- exemplo simples
create index idx_teste on medico (nome);
drop index idx_teste;

-- exemplo intermediario (sem erro se nao existir)
drop index if exists idx_teste;

-- exemplo estilo prova
-- recriar indice (util quando esta fragmentado)
create index idx_func_cidade on funcionario (cidade);
drop index idx_func_cidade;
create index idx_func_cidade on funcionario (cidade);

-- limpeza
drop index if exists idx_func_cidade;
