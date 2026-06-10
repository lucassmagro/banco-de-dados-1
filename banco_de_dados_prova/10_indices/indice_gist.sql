-- indice gist (generalized search tree)
-- quando usar: dados multidimensionais, espaciais ou buscas full-text
-- obs prova: btree otimiza (>, <, =), hash otimiza (=)
--            gist otimiza sobreposicao, contencao (ex: dados espaciais postgis)
--            tambem usado para arrays e buscas lexicais

-- exemplo simples
-- obs: requer extensao btree_gist para usar gist em tipos comuns
create extension if not exists btree_gist;

-- criar indice gist na idade do paciente
create index idx_paciente_idade_gist on paciente using gist (idade);

-- exemplo intermediario
-- usando indice gist (o postgres usa automaticamente se achar benefico)
explain select * from paciente where idade between 20 and 40;

-- exemplo estilo prova
-- indice gist com multiplas colunas
create index idx_medico_cid_esp_gist on medico using gist (cidade, especialidade);

-- limpeza
drop index if exists idx_paciente_idade_gist;
drop index if exists idx_medico_cid_esp_gist;
drop extension if exists btree_gist;
