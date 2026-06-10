-- drop database
-- quando usar: apagar o banco inteiro
-- obs prova: nao pode estar conectado no banco que vai apagar
--            conectar no banco postgres antes

-- exemplo simples
drop database clinica2;

-- exemplo intermediario (sem erro se nao existir)
drop database if exists clinica2;

-- exemplo estilo prova
-- para excluir o banco 'clinica', voce precisa fechar todas as conexoes nele.
-- em um script de prova, voce acessa o banco padrao 'postgres' antes:
-- \c postgres
-- drop database clinica;
