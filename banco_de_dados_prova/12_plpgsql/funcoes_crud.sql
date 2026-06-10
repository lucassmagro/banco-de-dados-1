-- funcoes crud (create, read, update, delete) encapsuladas
-- quando usar: padronizar o acesso aos dados em sistemas complexos
-- obs prova: funcoes de inclusao devem retornar a pk gerada
--            alteracoes recebem a pk e retornam nulo (void)
--            exclusoes recebem a pk e retornam nulo (void)

-- exemplo simples (create)
-- inclui paciente e retorna a chave
create or replace function inserir_paciente(
    p_codp int, 
    p_nome varchar(40), 
    p_idade smallint, 
    p_cidade char(30), 
    p_cpf numeric(11), 
    p_doenca varchar(40)
)
returns int as $$
begin
    insert into paciente (codp, nome, idade, cidade, cpf, doenca)
    values (p_codp, p_nome, p_idade, p_cidade, p_cpf, p_doenca);
    return p_codp;
end;
$$ language plpgsql;

-- teste create
select inserir_paciente(55, 'Teste CRUD', 20::smallint, 'Florianopolis', 98765432100, 'gripe');

-- exemplo intermediario (read)
-- busca paciente recebendo pk
create or replace function buscar_paciente(p_codp int)
returns table (
    codp int,
    nome varchar(40),
    idade smallint,
    cidade char(30),
    cpf numeric(11),
    doenca varchar(40)
) as $$
begin
    return query
    select paciente.codp, paciente.nome, paciente.idade, paciente.cidade, paciente.cpf, paciente.doenca
    from paciente
    where paciente.codp = p_codp;
end;
$$ language plpgsql;

-- teste read
select * from buscar_paciente(55);

-- exemplo intermediario (update)
-- altera paciente recebendo pk
create or replace function alterar_paciente(p_codp int, p_doenca varchar(40))
returns void as $$
begin
    update paciente set doenca = p_doenca where paciente.codp = p_codp;
end;
$$ language plpgsql;

-- teste update
select alterar_paciente(55, 'curado');
select * from paciente where paciente.codp = 55;

-- exemplo estilo prova (delete)
-- exclui paciente recebendo pk
create or replace function excluir_paciente(p_codp int)
returns void as $$
begin
    delete from paciente where paciente.codp = p_codp;
end;
$$ language plpgsql;

-- teste delete
select excluir_paciente(55);

-- limpeza
drop function if exists inserir_paciente(int, varchar(40), smallint, char(30), numeric(11), varchar(40));
drop function if exists buscar_paciente(int);
drop function if exists alterar_paciente(int, varchar(40));
drop function if exists excluir_paciente(int);
