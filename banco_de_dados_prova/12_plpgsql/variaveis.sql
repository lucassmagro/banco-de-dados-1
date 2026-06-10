-- variaveis em plpgsql
-- quando usar: armazenar valores temporarios dentro de funcoes
-- obs prova: declarar no bloco declare antes do begin
--            tipos: int, varchar, numeric, boolean, record, rowtype
--            atribuicao com := ou com select into

-- exemplo simples
-- variavel com tipo basico
create or replace function exemplo_variaveis()
returns varchar as $$
declare
    nome_med varchar;
    idade_med int;
begin
    select nome, idade into nome_med, idade_med
    from medico where codm = 1;
    return nome_med || ' tem ' || idade_med || ' anos';
end;
$$ language plpgsql;

select exemplo_variaveis();

-- exemplo intermediario
-- variavel com tipo da coluna (%type) e da linha (%rowtype)
create or replace function dados_paciente(cod int)
returns text as $$
declare
    p paciente%rowtype;
    nome_var paciente.nome%type;
begin
    select * into p from paciente where codp = cod;
    nome_var := p.nome;
    return 'nome: ' || nome_var || ' idade: ' || p.idade || ' doenca: ' || p.doenca;
end;
$$ language plpgsql;

select dados_paciente(1);

-- exemplo estilo prova
-- variavel com atribuicao direta, calculo e constante
create or replace function calculo_salarial(cod int)
returns text as $$
declare
    sal numeric;
    bonus constant numeric := 500;
    total numeric;
    resultado text;
begin
    select salario into sal from funcionario where codf = cod;
    total := sal + bonus;
    resultado := 'salario: ' || sal || ' + bonus: ' || bonus || ' = ' || total;
    return resultado;
end;
$$ language plpgsql;

select calculo_salarial(1);
