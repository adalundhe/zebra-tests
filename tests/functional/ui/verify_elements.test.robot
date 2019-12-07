*** Settings ***
Library         SeleniumLibrary
Resource        ${RESOURCE_DIR}/workflow/ui/setup.resource.robot


*** Test Cases ***
Verify Home Page Opens
    [Documentation]  Verify that the home page for TheZebra.com opens successfully.

    Open Home Page via UI