-- funcao com retorno de tabela
-- quando usar: retornar varias linhas como resultado
-- obs prova: usa returns table(...) ou returns setof
--            return next adiciona uma linha, return query retorna uma consulta inteira

-- exemplo simples
-- retorna todos os medicos de uma cidade
create or replace function medicos_da_cidade(cid varchar)
returns table(codigo int, nome_medico varchar, espec char) as $$
begin
    return query
        select codm, nome, especialidade
        from medico
        where cidade = cid;
end;
$$ language plpgsql;

select * from medicos_da_cidade('Florianopolis');

-- exemplo intermediario
-- retorna funcionarios acima de um salario minimo
create or replace function funcionarios_acima(sal_min numeric)
returns table(nome_func varchar, salario_func numeric, depto_nome varchar) as $$
begin
    return query
        select f.nome, f.salario, d.nome
        from funcionario f
        left join departamento d on d.codd = f.codd
        where f.salario >= sal_min;
end;
$$ language plpgsql;

select * from funcionarios_acima(1500);

-- exemplo estilo prova
-- retorna resumo de consultas por medico filtrado por especialidade
create or replace function consultas_por_especialidade(espec char)
returns table(medico varchar, especialidade char, total bigint) as $$
begin
    return query
        select m.nome, m.especialidade, count(*)
        from medico m
        join consulta c on c.codm = m.codm
        where m.especialidade = espec
        group by m.codm, m.nome, m.especialidade;
end;
$$ language plpgsql;

select * from consultas_por_especialidade('ortopedia');
