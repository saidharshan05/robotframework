*** Settings ***
Documentation      .... Assignment 2 - Searching for wrist watches.
Library            SeleniumLibrary
Suite Setup        Set Screenshot Directory    EMBED
Suite Teardown     Close Browser

*** Variables ***
${PRODUCT}         Wrist Watches
${URL}             https://amazon.in
${SEARCH_BAR}      id:twotabsearchtextbox
${5TH_PRODUCT}     xpath://*[@data-index="7"]
${SEARCH_BUTTON}   id:nav-search-submit-button
${BRAND}           xpath://*[@id="p_123/230208"]/span/a
${MATERIAL}        xpath://*[@id="p_n_material_browse/1480907031"]/span/a
${DISCOUNT}        xpath://*[@id="p_n_pct-off-with-tax/2665400031"]/span/a
${ANALOG}          xpath://*[@id="p_n_feature_seven_browse-bin/1480900031"]/span/a/span

*** Test Cases ***
Search product in Amazon 
    GIVEN Open browser and go to URL
    WHEN Page is Loaded, search the product and apply filters
    THEN Capture screenshot and close browser

*** Keywords ***

Open browser and go to URL
    Open Browser       ${URL}   chrome    executable_path=/usr/bin/chromedriver
    Maximize Browser Window

Page is Loaded, search the product and apply filters
    Search for product 
    Apply filters

Apply filters
    Wait Until Element Is Visible    ${ANALOG}
    Click Element    ${ANALOG}
    Wait Until Element Is Visible    ${MATERIAL}
    Click Element    ${MATERIAL}
    Wait Until Element Is Visible    ${BRAND}
    Click Element    ${BRAND}
    Wait Until Element Is Visible    ${DISCOUNT}
    Click Element    ${DISCOUNT}
   
    
Search for product    
    Click Element      ${SEARCH_BAR}
    Input Text    ${SEARCH_BAR}    ${PRODUCT}
    Click Element    ${SEARCH_BUTTON}

Capture screenshot and close browser
    Sleep    2
    Capture Page Screenshot
    Wait Until Element Is Visible    ${5TH_PRODUCT}
    Click Element    ${5TH_PRODUCT}
    Sleep   2
    Switch Window     NEW
    Capture Page Screenshot
