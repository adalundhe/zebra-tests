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


Select Driver Insurance Option
    [Documentation]  Select whether or not the driver is currently insured.
    [Arguments]  ${is_insured}=True  ${label_attribute}=None    ${label_attribute_value}=None

    ${selected_label}=  Get Element  type=label  attribute=${label_attribute}  attribute_value=${label_attribute_value}
    ${option_span}=  Find Descendant by Attribute  parent_element=${selected_label}  descendant_type=span  descendant_attribute=class  descendant_attribute_value=custom-control-description
    ${number_of_elements_found}=  Get Length  ${option_span}

    should be equal as integers  ${number_of_elements_found}  1

    ${selected_span}=  Set Variable  ${option_span}[0]

    Force Click  ${selected_span}
