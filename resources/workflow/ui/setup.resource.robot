*** Settings ***
Documentation   Technical resources for launcher page related elements and functions
Library         SeleniumLibrary
Resource        ${RESOURCE_DIR}/technical/ui/browser.resource.robot


*** Keywords ***

Open Home Page via UI
    [Documentation]  Open the home page for TheZebra.com via Selenium

    Start Browser