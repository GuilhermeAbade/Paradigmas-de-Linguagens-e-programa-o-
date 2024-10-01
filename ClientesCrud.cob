       IDENTIFICATION DIVISION.
       PROGRAM-ID. CLIENTESCRUD.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CLIENTES ASSIGN TO "clientes.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

           SELECT TEMPFILE ASSIGN TO "tempfile.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  CLIENTES.
       01  CLIENTE-REGISTRO.
           05 CLIENTE-COD       PIC X(3).
           05 CLIENTE-NOME      PIC X(20).
           05 CLIENTE-SALDO     PIC 9(7)V99.

       FD  TEMPFILE.
       01  TEMP-REGISTRO        PIC X(30).

       WORKING-STORAGE SECTION.
       01  OPCOES        PIC 9 VALUE 0.
       01  COD-PROCURA   PIC X(3).
       01  NOVO-NOME     PIC X(20).
       01  NOVO-SALDO    PIC 9(7)V99.
       01  END-OF-FILE   PIC X VALUE 'N'.  *> Indicador de fim de arquivo

       PROCEDURE DIVISION.
       MAIN-LOGIC.
           PERFORM UNTIL OPCOES = 5
               DISPLAY "=== MENU ==="
               DISPLAY "1 - Criar Registro"
               DISPLAY "2 - Ler Registros"
               DISPLAY "3 - Atualizar Registro"
               DISPLAY "4 - Deletar Registro"
               DISPLAY "5 - Sair"
               ACCEPT OPCOES

               EVALUATE OPCOES
                   WHEN 1
                       PERFORM CRIAR-REGISTRO
                   WHEN 2
                       PERFORM LER-REGISTROS
                   WHEN 3
                       PERFORM ATUALIZAR-REGISTRO
                   WHEN 4
                       PERFORM DELETAR-REGISTRO
                   WHEN 5
                       DISPLAY "Saindo do programa..."
                   WHEN OTHER
                       DISPLAY "Opcao invalida!"
               END-EVALUATE
           END-PERFORM
           STOP RUN.

       CRIAR-REGISTRO.
           OPEN OUTPUT CLIENTES
           DISPLAY "Informe o Codigo (3 caracteres):"
           ACCEPT CLIENTE-COD
           DISPLAY "Informe o Nome (max 20 caracteres):"
           ACCEPT CLIENTE-NOME
           DISPLAY "Informe o Saldo (9 digitos):"
           ACCEPT CLIENTE-SALDO
           WRITE CLIENTE-REGISTRO
           CLOSE CLIENTES
           DISPLAY "Registro criado com sucesso.".

       LER-REGISTROS.
           OPEN INPUT CLIENTES
           DISPLAY "=== Lista de Clientes ==="
           PERFORM UNTIL END-OF-FILE = 'Y'
               READ CLIENTES
                   AT END
                       MOVE 'Y' TO END-OF-FILE
                   NOT AT END
                       DISPLAY "Codigo: " CLIENTE-COD
                       DISPLAY "Nome: " CLIENTE-NOME
                       DISPLAY "Saldo: " CLIENTE-SALDO
               END-READ
           END-PERFORM
           CLOSE CLIENTES
           DISPLAY "Fim da leitura.".

       ATUALIZAR-REGISTRO.
           OPEN INPUT CLIENTES
           OPEN OUTPUT TEMPFILE
           DISPLAY "Informe o Codigo do cliente a atualizar:"
           ACCEPT COD-PROCURA
           PERFORM UNTIL END-OF-FILE = 'Y'
               READ CLIENTES
                   AT END
                       MOVE 'Y' TO END-OF-FILE
                   NOT AT END
                       IF CLIENTE-COD = COD-PROCURA
                           DISPLAY "Novo Nome:"
                           ACCEPT NOVO-NOME
                           DISPLAY "Novo Saldo:"
                           ACCEPT NOVO-SALDO
                           MOVE NOVO-NOME TO CLIENTE-NOME
                           MOVE NOVO-SALDO TO CLIENTE-SALDO
                           DISPLAY "Registro atualizado."
                       END-IF
                       STRING CLIENTE-COD DELIMITED BY SIZE
                              CLIENTE-NOME DELIMITED BY SIZE
                              CLIENTE-SALDO DELIMITED BY SIZE
                              INTO TEMP-REGISTRO
                       WRITE TEMP-REGISTRO
               END-READ
           END-PERFORM
           CLOSE CLIENTES
           CLOSE TEMPFILE
           CALL 'SYSTEM' USING 'mv tempfile.dat clientes.dat'.

       DELETAR-REGISTRO.
           OPEN INPUT CLIENTES
           OPEN OUTPUT TEMPFILE
           DISPLAY "Informe o Codigo do cliente a deletar:"
           ACCEPT COD-PROCURA
           PERFORM UNTIL END-OF-FILE = 'Y'
               READ CLIENTES
                   AT END
                       MOVE 'Y' TO END-OF-FILE
                   NOT AT END
                       IF CLIENTE-COD NOT = COD-PROCURA
                           STRING CLIENTE-COD DELIMITED BY SIZE
                                  CLIENTE-NOME DELIMITED BY SIZE
                                  CLIENTE-SALDO DELIMITED BY SIZE
                                  INTO TEMP-REGISTRO
                           WRITE TEMP-REGISTRO
                       ELSE
                           DISPLAY "Registro deletado."
                       END-IF
               END-READ
           END-PERFORM
           CLOSE CLIENTES
           CLOSE TEMPFILE
           CALL 'SYSTEM' USING 'mv tempfile.dat clientes.dat'.
