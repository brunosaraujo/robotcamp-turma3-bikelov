# Pq trabalhamos com as variavei em caixa alta.
# Sempre q vermos uma variavel com vcaixa alta é pq é uma variavel de elemento da tela
# Colocamos toda a estrategia de localização dos elementos em um unico lugar

# representação do padrão page object para robot framework

*** Variables ***
### Login page
${INPUT_EMAIL}      id:email
${BUTTON_LOGIN}     xpath://button[contains(text(), 'Quero Anúnciar')]
${ALERT_DARK}       class:alert-dark

### dashboard page
${DIV_DASH}         class:dashboard
${BIKE_ITEM}        css:.bike-list li
${BIKE_LIST}        class:bike-list

### Form page
${INPUT_THUMB}      css:#thumbnail input
${INPUT_NAME}       id:name
${INPUT_BRAND}      id:brand
${INPUT_PRICE}      css:input[placeholder$='dia']
${BUTTON_SUBMIT}    class:btn-red
${ALERT_ERROR}      class:alert-error
