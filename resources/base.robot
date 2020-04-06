*** Settings ***
Library     SeleniumLibrary

# Importamos os elementos dentro de base. Conforme o base importa os elements todos os outros arquivos que importam de base
# já pegam eles.
Resource    elements.robot

*** Variables ***
#${BASE_URL}     https://bikelov.herokuapp.com/
${BASE_URL}     https://bikelov-anunciante.herokuapp.com

*** Keywords ***
Start Session
    Open Browser                    about:blank      chrome
    Set Selenium Implicit Wait      5
    # Sempre verificar a resolução minima da tela e passar como parametro. E quando rodamos em headless precisamos e um tamanho não tem como maximizar
    Set Window Size                 1440    900

# Para não termos de colocar Dado que estou logado na aplicação, criamos esse Logged with.
# Onde ele vai logar na aplicação. Criamos um step de gancho que vai garantir que estamos no lugar certo e com o usuario que eu quero.
Logged with "${email}"
    Start Session
    Go to   ${BASE_URL}
    
    Input Text          ${INPUT_EMAIL}        ${email}
    Click Element       ${BUTTON_LOGIN}

    Page Should Contain Element     ${DIV_DASH}
End Session
    Close Browser    

End Test
    Capture Page Screenshot