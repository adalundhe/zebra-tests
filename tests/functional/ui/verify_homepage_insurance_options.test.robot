*** Settings ***
Library         SeleniumLibrary
Resource        ${RESOURCE_DIR}/workflow/ui/home.resource.robot
Test Template  Verify Insurance ${Type} on Home Page
Test Timeout  15 seconds


*** Variables ***
${CAR_INSURANCE}  Car insurance
${HOME_INSURANCE}  Home insurance


*** Test Cases ***                      TYPE
Verify Car Insurance on Home Page       ${CAR_INSURANCE}
Verify Home Insurance on Home Page      ${HOME_INSURANCE}


*** Keywords ***
Verify Insurance ${Type} on Home Page
    [Documentation]  Verify that the home page for TheZebra.com opens successfully.
    
    Verify Insurance Option Exists  insurance_type=${Type}
    Verify Insurance Option SVG Exists  insurance_type=${Type}
    Verify Insurance Option Text Exists  insurance_type=${Type}