*** Settings ***
Resource    base.robot
Library     ./lib/mongo.py

*** Keywords ***
## Login
Dado que acesso a página login
    Go To    ${BASE_URL}

Quando eu submeto minha credencial de login "${email}"
    Input Text       ${INPUT_EMAIL}     ${email}
    Click Element    ${BUTTON_LOGIN} 

Então a área logada deve ser exibida
    Page Should Contain Element    ${DIV_DASH} 

Então devo ver a mensagem de alerta "${expect_message}"
    Element Text Should Be      ${ALERT_DARK}        ${expect_message}

## Anúncios
Dado que eu tenho uma "${bike_string}" muito bonita
    # pega a massa de teste e converte de string para json de verdade
    ${bike_json}         evaluate                json.loads($bike_string)    json
    Log                  ${bike_json}
    # Para podermos utilizar a variavel ${bike_json} em todo o caso de teste(Test Cases). Utilizamos uma um recurso do python, o garbage collection.
    Set Test Variable    ${bike_json}
    # Quando queremos ver a variavel no console utilizamos o Log to Console e pra logar no report utilizamos somente o log
    # Log to Console      ${bike_json}
    Remove Bike          ${bike_json['name']}
    # Quando importamos o remove_bike de mongo.py o robot entende que é um keyword e ele troca o _ por espaço. Por isso que quando chamamos o remove
    # passamos Remove Bike

E eu acesso o formulário de cadastro de anúncio
    Click Link    /new

Quando eu faço o anúncio dessa bike

    # Verifica se o campo thumb esta com o campo vazio. Caso esteja não entra na validação, caso tenha ele enra no choose File
    Run Keyword If      '${bike_json['thumb']}'
    # Para montar o caminho para pegar a imagem utilizamos o CURDIR (current directory), seria o diretorio onde esse arquivo esta sendo executado.
    ...                 Choose File     ${INPUT_THUMB}        ${CURDIR}/images/${bike_json['thumb']}

    Clear Element Text      ${INPUT_NAME}      
    Input Text              ${INPUT_NAME}         ${bike_json['name']}
    Clear Element Text      ${INPUT_BRAND}  
    Input Text              ${INPUT_BRAND}        ${bike_json['brand']}
    # No css utilizamos o $ no final de placeholder para pegar o input que termina com dia. Caso queira pegar quando começa com um valor utilizamos ^. E caso queira pegar
    # por um valor que contenha utilizamos o *. Estamos utilizando o regex
    Input Text            ${INPUT_PRICE}        ${bike_json['price']}
    Click Element         ${BUTTON_SUBMIT}

Então devo ver minha bike na lista de anúncios
    Wait Until Element Is Visible       ${BIKE_ITEM}    
    Element Should Contain              ${BIKE_LIST}        ${bike_json['name']}

E o valor da para locação deve ser igual a "${expect_price}"
    Element Should Contain      ${BIKE_LIST}        ${expect_price}

Então devo ver uma mensagem de alerta "${expect_message}"
    Element Text Should Be      ${ALERT_ERROR}      ${expect_message}
