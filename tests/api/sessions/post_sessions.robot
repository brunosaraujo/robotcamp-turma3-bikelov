*** Settings ***

Resource    ../../../resources/services.robot

# Cria a sessão passado o nome da sessão e a url
Test Setup      Create Session      bikelov         ${base_url}

*** Test Cases ***
New sessions
    # Para montar o headers ok, podemos utilizar o Dictionary, mas para o payload utilizamos uma string, pois o payload pode
    # ficar muito grande.
    # &{payload}=     Create Dictionary       email=jason.toddy@dc.com
    # Vamos criar uma string do payload e transformar em um json
    # Com isso podemos colocar o target dentro de um arquivo e chamar o Convert To Json. Que vai converter todos os dados em um json
    ${payload}=     Convert To Json     {"email": "jason.toddy@dc.com"}
    ${resp}=        Post Session    ${payload}

    Should Be Equal As Strings      ${resp.status_code}     200

Wrong Email    
    ${payload}=     Convert To Json     {"email": "jason.toddy&dc.com"}
    ${resp}=        Post Session    ${payload}

    Should Be Equal As Strings       ${resp.status_code}     409

Empty Email    
    ${payload}=     Convert To Json     {"email": ""}
    ${resp}=        Post Session    ${payload}

    Should Be Equal As Strings       ${resp.status_code}     412

Without Data    
    ${payload}=     Convert To Json     {}
    ${resp}=        Post Session    ${payload}

    Should Be Equal As Strings       ${resp.status_code}     412