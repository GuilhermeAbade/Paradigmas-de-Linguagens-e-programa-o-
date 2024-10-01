# Paradigmas-de-Linguagens-e-programa-o-
#LINK VIDEOS EXPLICATIVO:https://www.youtube.com/watch?v=uCkaumKRhEY


#REQUISITOS: Compilador COBOL: GNU COBOL ou ambiente online como Online GDB.

#1 - baixar projeto: 
git clone https://github.com/usuario/crud-clientes-cobol.git
cd crud-clientes-cobol

#2 - Compilar programa:
cobc -x clientescrud.cob -o clientescrud

#3 - Executar programa:
./clientescrud

#4 - interagir com o menu:
#Escolha uma opção digitando o número correspondente e siga as instruções na tela.
=== MENU ===
1 - Criar Registro
2 - Ler Registros
3 - Atualizar Registro
4 - Deletar Registro
5 - Sair

#INSTRUÇÕES PARA USO

#1 - Criar um registro:
Ao escolher a opção 1, você será solicitado a fornecer:
Código do cliente (3 caracteres).
Nome do cliente (até 20 caracteres).
Saldo do cliente (até 9 dígitos).

#2 - Ler registro:
Ao escolher a opção 2, o programa exibirá todos os clientes cadastrados com seus respectivos códigos, nomes e saldos.

#3 - Atualizar registro:
Ao escolher a opção 3, você precisará informar o código do cliente que deseja atualizar. O programa então solicitará os novos dados.

#4 - Deletar um registro:
Ao escolher a opção 4, você precisará fornecer o código do cliente que deseja remover do arquivo.

#5 - Sair:
A opção 5 encerra o programa.

