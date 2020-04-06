*** Settings ***

Resource    ../../../resources/services.robot


Test Setup      Create Session      bikelov         ${base_url}

*** Test Cases ***
Create a new Bike Ad
    ${user_id}=     Get User Id         brunosaraujo@io.com
    ${payload}=     Convert To Json     {"name": "Elleven Rocker", "brand": "Shimano", "price": "15"}
    Remove Bike     ${payload['name']}
    
    ${resp}=        Post Bike Ad    ${user_id}      ${payload}      elleven.jpg

    Should Be Equal As Strings      ${resp.status_code}     200

Empty Name
    [Template]      Required Fields
    {"name": "", "brand": "Shimano", "price": "15"}     1001        Bike name is required

Empty BRand
    [Template]      Required Fields
    {"name": "Elleven Rocker", "brand": "", "price": "15"}     1002        Brand is required
    

*** Keywords ***
Required Fields
    [Arguments]     ${json}     ${expect_bcode}        ${expect_message}

    ${user_id}=     Get User Id         brunosaraujo@io.com
    ${payload}=     Convert To Json     ${json}
    Remove Bike     ${payload['name']}
    
    ${resp}=        Post Bike Ad    ${user_id}      ${payload}      elleven.jpg
    Log             ${resp}

    ${expect_bcode}=        Convert To Integer     ${expect_bcode}

    Should Be Equal As Strings          ${resp.status_code}         412
    Should Be Equal                     ${resp.json()['code']}      ${expect_bcode}
    Dictionary Should Contain Value     ${resp.json()}              ${expect_message}