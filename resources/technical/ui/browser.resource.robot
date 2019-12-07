*** Settings ***
Documentation   Technical resources for launcher page related elements and functions
Library         SeleniumLibrary


*** Keywords ***

Start Browser
    [Documentation]  use local webdriver by default, and browserstack if specified in BROWSER_PROVIDER

    Open Browser  ${ZEBRA_URL}  ${BROWSER}
