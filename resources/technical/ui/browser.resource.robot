*** Settings ***
Documentation   Technical resources for browser functionality, etc.
Library         SeleniumLibrary


*** Keywords ***

Start Browser
    [Documentation]  Start the browser and open to default specified TheZebra address.

    Open Browser  ${ZEBRA_URL}  ${BROWSER}
    Set Browser Implicit Wait  10  # Wait up to 10 seconds for browser to open.

    Log  Browser: ${BROWSER} successfully opened at URL: ${ZEBRA_URL}  debug
