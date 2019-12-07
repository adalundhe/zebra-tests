*** Settings ***
Library         SeleniumLibrary
Resource        ${RESOURCE_DIR}/workflow/ui/home.resource.robot


*** Variables ***
${zipcode_field_name}  zipcode


*** Test Cases ***

Verify Homepage Form Exists
    [Documentation]  Verify that all fields and buttons on the homepage form exist.

    Verify Homepage Form Input Field Exists  input_field_name=${zipcode_field_name}
