-- transacoes (propriedades acid)
-- quando usar: agrupar comandos que devem valer tudo ou nada
-- obs prova: acid = atomicidade (tudo ou nada), consistencia (regras validas),
--            isolamento (transacoes nao interferem), durabilidade (commit persiste)

-- exemplo simples
begin;
update funcionario set salario = salario + 100 where codf = 1;
commit;

-- exemplo intermediario (desfazer com rollback)
begin;
delete from consulta;
select count(*) from consulta; -- ja aparece vazio dentro da transacao
rollback;
select count(*) from consulta; -- voltou tudo

-- exemplo estilo prova
-- transferencia de orcamento entre departamentos (atomicidade)
begin;
update departamento set orcamento = orcamento - 5000 where codd = 3;
update departamento set orcamento = orcamento + 5000 where codd = 2;
commit;
