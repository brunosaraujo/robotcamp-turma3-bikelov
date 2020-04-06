*** Settings ***
Library     Collections
Library     RequestsLibrary
Library     OperatingSystem

Library     lib/mongo.py

Resource    helpers.robot

*** Variables ***
${base_url}     http://bikelov-api.herokuapp.com

*** Keywords ***
### /sessions
Post Session
    [Arguments]     ${payload}
    # Aqui eh onde passamos o payload da requisição. Como estamos fazendo um post temos de ter um payload.
    # Para criar uma variavel de dictionary passamod o & em vez de $. Utilizamos o & somente quando criamos a varivavel dictionary.
    # Quando vamos consumir a variavel utilizamos o $
    &{headers}=     Create Dictionary       Content-Type=application/json

    ${resp}=        Post Request       bikelov     /sessions       data=${payload}     headers=${headers}
    [return]        ${resp}

Get User Id
    [Arguments]     ${email}
    # Retorna o Id do usuario logado
    ${payload}      Convert To Json     {"email": "${email}"}
    Log             ${payload}
    ${resp}=        Post Session        ${payload}
    ${user_id}=     Convert to String   ${resp.json()['_id']}
    [return]        ${user_id}

### /bike
Post Bike Ad
    [Arguments]     ${user_id}      ${payload}      ${thumb}

    &{headers}=     Create Dictionary   user_id=${user_id}

    ${files_bin}=   Get Binary File     ${CURDIR}/images/${thumb}
    &{files}=       Create Dictionary   thumbnail=${files_bin}         

    ${resp}=        Post Request       bikelov     /bikes       data=${payload}     headers=${headers}      files=${files}
    [return]        ${resp}

Get Bike Ad By Id
    [Arguments]     ${bike_id}      ${user_id}

    &{headers}=	    Create Dictionary	Content-Type=application/json   user_id=${user_id}

    ${resp}=        Get Request     bikelov     /bikes/${bike_id}       headers=${headers}
    [return]        ${resp}

Delete Bike Ad By Id
    [Arguments]     ${bike_id}      ${user_id}

    &{headers}=	    Create Dictionary	Content-Type=application/json   user_id=${user_id}

    ${resp}=        Delete Request     bikelov     /bikes/${bike_id}       headers=${headers}
    [return]        ${resp}