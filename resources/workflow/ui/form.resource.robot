*** Settings ***
Documentation   Technical resources for form related elements and functions
Library         Collections
Library         HTMLParse
Resource        ${RESOURCE_DIR}/technical/ui/html.resource.robot


*** Keywords ***

Get Form
    [Documentation]  Return the form element matching the specified attribute and attribute value.
    [Arguments]  ${form_attribute}=None  ${form_attribute_value}=None

    ${found_form}=  Get Element if Contains  type=form  attribute=${form_attribute}  attribute_value=${form_attribute_value}

    ${found_attribute_value}=  Get Attribute Value from Raw Element  element=${found_form}  attribute=${form_attribute}

    should contain  ${found_attribute_value}  ${form_attribute_value}

    [Return]  ${found_form}


Get Form Element
    [Documentation]  Return the specified field matching the specified attribute and attribute value from the given form.
    [Arguments]  ${form_element}=None   ${field_type}=input  ${attribute}=name  ${attribute_value}=None

    ${child_form_element}=  Find Descendant by Label  parent_element=${form_element}  child_type=${field_type}  child_attribute=${attribute}  child_attribute_value=${attribute_value}
    ${number_of_elements_found}=  Get Length  ${child_form_element}

    should be equal as integers  ${number_of_elements_found}  1

    ${selected_form_element}=  Set Variable  ${child_form_element}[0]
    ${found_attribute_value}=  Get Attribute Value from Raw Element  element=${selected_form_element}  attribute=${attribute}

    should be equal as strings  ${found_attribute_value}  ${attribute_value}

    [Return]  ${selected_form_element}


Verify Text Attribute
    [Documentation]  Verify the specified attribute/attribute-value pairing exists for a given form element.
    [Arguments]  ${form_element}=None  ${field_type}=form  ${attribute}=class  ${attribute_value}=None

    ${form_attribute_value}=  Get Attribute Value from Raw Element  element=${form_element}  attribute=${attribute}

    should be equal as strings  ${form_attribute_value}  ${attribute_value}


Verify Form Field Label Text
    [Documentation]  Verify the text inside a form field label element matches the specified text.
    [Arguments]  ${form_element}=None  ${label_text}=None

    ${inner_html}=  Get Attribute Value from Raw Element  ${form_element}  attribute=innerHTML
    ${cleaned_html}=  Clean InnerHTML  ${inner_html}

    should be equal as strings  ${cleaned_html}  ${label_text}
    

Get Form Button
    [Documentation]  Return the specified button matching the specified attribute and attribute value from the given form.
    [Arguments]  ${form_element}=None  ${attribute}=name  ${attribute_value}=None

    ${child_button_element}=  Find Descendant by Label  parent_element=${form_element}  child_type=button  child_attribute=${attribute}  child_attribute_value=${attribute_value}
    ${number_of_elements_found}=  Get Length  ${child_button_element}

    should be equal as integers  ${number_of_elements_found}  1

    ${selected_button_element}=  Set Variable  ${child_button_element}[0]

    ${found_attribute_value}=  Get Attribute Value from Raw Element  element=${selected_button_element}  attribute=${attribute}

    should be equal as strings  ${found_attribute_value}  ${attribute_value}

    [Return]  ${selected_button_element}


Enter Text for Input Field
    [Documentation]  Select an input element by attribute and attribute value and enter the specified text.
    [Arguments]  ${input_attribute}=name  ${input_attribute_value}=None  ${input_text}=None

    Input Text Data to Element  type=input  attribute=${input_attribute}  attribute_value=${input_attribute_value}  text_data=${input_text}

    ${found_text}=  Get Element Text  type=input  attribute=${input_attribute}  attribute_value=${input_attribute_value}

    should be equal as strings  ${found_text}  ${input_text}


Click Submit Button
    [Documentation]  Click the submit button (selected by attribute and attribute value) to submit the form.
    [Arguments]  ${button_attribute}=name  ${button_attribute_value}=None

    Click Element via UI  type=button  attribute=${button_attribute}  attribute_value=${button_attribute_value}


Verify Next Page Loaded
    [Documentation]  Verify the next page has loaded after submitting a form by checking for the specified element.
    [Arguments]  ${element_type}=div  ${element_attribute}=class  ${elment_attribute_value}=None  ${timeout}=None

    Wait for Element to Appear via UI  type=${element_type}  attribute=${element_attribute}  attribute_value=${elment_attribute_value}  timeout=${timeout}