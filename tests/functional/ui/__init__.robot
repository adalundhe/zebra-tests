*** Settings ***
Library         SeleniumLibrary
Resource        ${RESOURCE_DIR}/workflow/ui/setup.resource.robot
Suite Setup     Open Browser at The Zebra


*** Keywords  ***

Open Browser at The Zebra
    [Documentation]  Verify that the specified browser can successfully open and navigate to TheZebra homepage.
    [Timeout]  30 seconds

    Open Home Page
