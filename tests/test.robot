*** Settings ***
Documentation    Automates the login process on the OpenCart demo site.

Library    SeleniumLibrary
Suite Setup    Set Screenshot Directory    EMBED
Suite Teardown       Close Browser

#Documentation    To automate  Bin Flow

#Resource        resource.robot

*** Variables ***
@{products}    mac    windows    test product    tab

*** Test Cases ***
test
    GIVEN Open browser and Login to OpenCart portal
    WHEN Logged in, search and add the product and checkout
    THEN Capture screenshot and close browser

*** Keywords ***
Register To Demo OpenCart
     Click Element      xpath=/html/body/main/div[2]/div/div/div/div[1]/div/div/a
    # Fill in the register form
    Input Text         id=input-firstname    dunky
    Input Text         id=input-lastname     demo
    Input text         id=input-email        dunkydemo@demo.com
    Input Password     id=input-password     test123
    Click Element      xpath=/html/body/main/div[2]/div/div/form/div/div/input
    Click Button       xpath=/html/body/main/div[2]/div/div/form/div/button
    ${alert}    Run Keyword And Return Status    Wait Until Element Contains    id=alert        
    IF    ${alert} == True 
        Log    <h2>E-mail is already registered. Please check the credentials and run again.<h2>    ERROR    html=true    console=false
    END
    Capture Page Screenshot
    Sleep    5

Open browser and Login to OpenCart portal
    Login
Login 
    Open Browser       https://demo-opencart.com    chrome    executable_path=/usr/bin/chromedriver
    Maximize Browser Window
    Click Element      xpath=//html/body/nav/div/div[2]/ul/li[2]/div/a/span
    Click Element    xpath=/html/body/nav/div/div[2]/ul/li[2]/div/ul/li[2]/a
    Input Text    id=input-email    dunkydemo@demo.com
    Input Password    id=input-password    test123
    Click Element    xpath=//html/body/main/div[2]/div/div/div/div[2]/div/form/div[3]/button
    ${alert}    Run Keyword And Return Status    Wait Until Element Contains    id=alert    Warning
    IF    ${alert} == True 
            ${text}    Get Text    id=alert
        Log    <h2>${text} Maybe haven't registered yet so, trying to register.</h2>    WARN    html=true   console=false
        Register To Demo OpenCart
    ELSE
        Log    OK    
    END
    Sleep    2
Logged in, search and add the product and checkout
    Search for product    
    Add to cart 
    proceed to checkout
    Verify which page has opened
    Fill out checkout form

Search for product    
    FOR    ${i}    IN    @{products}
        Click Element    id=search
        Input Text    xpath://html/body/header/div/div/div[2]/div/input    ${i}
        Click Element    xpath://html/body/header/div/div/div[2]/div/button/i
        ${product_div}    Run Keyword And Return Status    Wait Until Element Is Visible    class=product-thumb    timeout=1
        IF    ${product_div} == True
            BREAK
        END
    END
    
Add to cart
    Scroll Element Into View    xpath://html/body/main/div[2]/div/div/div[5]/div/div/div[2]/form/div/button[1]
    Click Element    xpath://html/body/main/div[2]/div/div/div[5]/div/div/div[2]/form/div/button[1]
    ${alert}    Run Keyword And Return Status    Wait Until Element Contains    id=alert    Success: You have added
    IF    ${alert} == True 
            Log   Added to the cart 
    END

proceed to checkout
    Scroll Element Into View    xpath://html/body/header/div/div/div[3]/div/button
    Wait Until Element Is Not Visible    xpath://*[@id="alert"]/div     timeout=20
    Click Element    xpath://html/body/header/div/div/div[3]/div/button
    Wait Until Element Is Visible    xpath://*[@class="check_out"]
    Click Element    xpath://*[@class="check_out"]

Verify which page has opened
    ${cart-page}    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://html/body/main/div[2]/div/div/div[3]/div[2]/a
    IF    ${cart-page} == True
        Click Element    xpath://html/body/main/div[2]/div/div/div[3]/div[2]/a
        ${stock-warn}   Run Keyword And Return Status    Wait Until Page Contains     Products marked with *** are not available in the desired quantity or not in stock!
        IF    ${stock-warn} == $True
            Click Element    xpath://html/body/main/div[2]/div[2]/div/div[1]/div/table/tbody/tr/td[4]/form/div/button[2]
            Sleep    2
            Search for product    
            Add to cart
            proceed to checkout
        ELSE
            Log    ok
        END
    ELSE
        Log    Ok
    END
Fill out checkout form
    Click Element    id=input-shipping-new
    Input Text    id=input-shipping-firstname    test-firstname
    Input Text    id=input-shipping-lastname    test-lastname
    Input Text    id=input-shipping-address-1    test-address
    Input Text    id=input-shipping-city    test-city
    Input Text    id=input-shipping-postcode    000000
    Select From List By Label    id=input-shipping-country    India
    Sleep    1
    Select From List By Label    id=input-shipping-zone    Karnataka
    #Input Text    id=input-shipping-method    test-method
    #Input Text    id=input-payment-method    00998877655
    Input Text    id=input-comment    test-comment

Capture screenshot and close browser
    Capture Page Screenshot