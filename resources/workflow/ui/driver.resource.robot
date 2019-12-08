*** Settings ***
Documentation   Technical resources for the Driver Confirmation UI, related elements, and functions
Library         Collections
Library         HTMLParse
Library         String
Resource        ${RESOURCE_DIR}/technical/ui/html.resource.robot


*** Keywords ***

Verify Driver Info Exists
    [Documentation]  Verify the primary driver name listed in the confirmation UI matches the specified text.
    [Arguments]  ${element_type}=None  ${element_class}=None  ${driver_info}=None

    ${found_element}=  Get Element  type=${element_type}  attribute=class  attribute_value=${element_class}
    ${inner_html}=  Get Attribute Value from Raw Element  ${found_element}  attribute=innerHTML
    ${cleaned_html}=  Clean InnerHTML  ${inner_html}

    Should Contain  ${cleaned_html}  ${driver_info}