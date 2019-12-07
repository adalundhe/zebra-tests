*** Settings ***
Documentation   Technical resources for verifying browser functionality and homepage is reachable.
Library         SeleniumLibrary
Resource        ${RESOURCE_DIR}/technical/ui/browser.resource.robot


*** Keywords ***

Open Home Page via UI
    [Documentation]  Open the home page for TheZebra.com via Selenium

    Start Browser