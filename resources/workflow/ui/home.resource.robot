*** Settings ***
Documentation   Technical resources for homepage related elements and functions
Library         SeleniumLibrary
Library         Collections
Library         HTMLParse
Resource        ${RESOURCE_DIR}/technical/ui/html.resource.robot


*** Keywords ***

Verify Insurance Option Exists
    [Documentation]  Verify that the homepage allows users to select the specified insurance type.
    [Arguments]  ${insurance_type}=Car insurance

    ${label_value}=  Get Element Value by Label  element_type=label  label=track-label  value=${insurance_type}

    should be equal as strings   ${label_value}  ${insurance_type}


Verify Insurance Option Text Exists
    [Documentation]  Verify that the specified insurance type is accompanied by matching text.
    [Arguments]  ${insurance_type}=Car insurance

    ${parent_label_element}=  Get Element  type=label  label=track-label  label_value=${insurance_type}
    ${child_div_element}=  Find Children by Label  parent_element=${parent_label_element}  child_type=div  child_attribute_value=label-title
    ${number_of_elements_found}=  Get Length  ${child_div_element}

    should be equal as integers  ${number_of_elements_found}  1

    ${selected_div}=  Set Variable  ${child_div_element}[0]

    ${inner_html}=  Get Attribute Value from Raw Element  ${selected_div}  attribute=innerHTML

    ${cleaned_html}=  Clean InnerHTML  ${inner_html}

    should be equal as strings  ${cleaned_html}  ${insurance_type}


Verify Insurance Option SVG Exists
    [Documentation]  Verify that the specified insurance type is accompanied by a SVG image.
    [Arguments]  ${insurance_type}=Car insurance

    ${parent_label_element}=  Get Element  type=label  label=track-label  label_value=${insurance_type}
    ${child_div_elements}=  Find Children by Label  parent_element=${parent_label_element}  child_type=div  child_attribute_value=svg-container
    ${number_of_elements_found}=  Get Length  ${child_div_elements}

    should be equal as integers  ${number_of_elements_found}  1

    ${selected_div}=  Set Variable  ${child_div_elements}[0]

    ${child_svg_element}=  Find Descendant by Local Name  parent_element=${parent_label_element}  local_name=svg
    ${svg_element_type}=  Set Variable  ${child_svg_element.tag_name}

    should be equal as strings  ${svg_element_type}  svg
