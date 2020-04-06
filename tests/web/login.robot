*** Settings ***
Documentation    Login
...              Para que eu possa ter acesso a interface de gestão de anúncios
...              Sendo um uauário que possui um email
...              Quero poder iniciar uma nova sessão

Resource    ../../resources/steps_kw.robot

Suite Setup       Start Session
Suite Teardown    End Session

Test Teardown    End Test

## ATDD ???? Acceptance Test-Driven Development
# (Desenvolvimento guiado por testes de aceitação)
# Obter requisitos de forma colaborativa

# Esquer o tradicional (cenário step by step), pensar em ATDD / BDD

# BDD (Desenvolvimento guiado por comportamento)
# Foi feito em 2003 para aplicar um BDD melhor
# Gherkin


*** Test Cases ***
Usuário consegue logar
    Dado que acesso a página login
    Quando eu submeto minha credencial de login "eu@papito.io"
    Então a área logada deve ser exibida

Usuário não loga com email incorreto
    [Template]     Tentar logar
    eupapito.io    Oops. Informe um email válido!

Email com caracter inválido
    [Template]      Tentar logar
    eu&papito.io    Oops. Informe um email válido!

Email deve ser obrigatório
    [Template]    Tentar logar
    ${EMPTY}      Oops. Informe um email válido!

*** Keywords ***
Tentar logar
    [Arguments]    ${email}    ${expect_message}

    Dado que acesso a página login
    Quando eu submeto minha credencial de login "${email}"
    Então devo ver a mensagem de alerta "${expect_message}"