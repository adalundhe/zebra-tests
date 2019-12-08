*** Settings ***
Documentation   Technical resources for verifying browser functionality and homepage is reachable.
Resource        ${RESOURCE_DIR}/technical/ui/browser.resource.robot


*** Keywords ***

Open Home Page
    [Documentation]  Open the home page for TheZebra.com via Selenium

    Start Browser
