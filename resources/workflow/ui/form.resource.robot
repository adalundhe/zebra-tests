*** Settings ***
Documentation   Technical resources for form related elements and functions
Library         Collections
Library         HTMLParse
Resource        ${RESOURCE_DIR}/technical/ui/html.resource.robot


*** Keywords ***

Get Form
    [Documentation]  Return the form element matching the specified attribute and attribute value.
    [Arguments]  ${form_attribute}=None  ${form_attribute_value}=None

    ${found_form}=  Get Element if Contains Attribute  type=form  attribute=${form_attribute}  attribute_value=${form_attribute_value}

    ${found_attribute_value}=  Get Attribute Value from Raw Element  element=${found_form}  attribute=${form_attribute}

    should contain  ${found_attribute_value}  ${form_attribute_value}

    [Return]  ${found_form}


Get Form Element
    [Documentation]  Return the specified field matching the specified attribute and attribute value from the given form.
    [Arguments]  ${form_element}=None   ${field_type}=input  ${attribute}=name  ${attribute_value}=None

    ${child_form_element}=  Find Descendant by Attribute  parent_element=${form_element}  child_type=${field_type}  child_attribute=${attribute}  child_attribute_value=${attribute_value}
    ${number_of_elements_found}=  Get Length  ${child_form_element}

    should be equal as integers  ${number_of_elements_found}  1

    ${selected_form_element}=  Set Variable  ${child_form_element}[0]
    ${found_attribute_value}=  Get Attribute Value from Raw Element  element=${selected_form_element}  attribute=${attribute}

    should be equal as strings  ${found_attribute_value}  ${attribute_value}

    [Return]  ${selected_form_element}


Verify Text Attribute
    [Documentation]  Verify the specified attribute/attribute-value pairing exists for a given form element.
    [Arguments]  ${form_element}=None  ${field_type}=form  ${attribute}=class  ${attribute_value}=None

    ${form_attribute_value}=  Run Keyword If  ${form_element}
    ...  Get Attribute Value from Raw Element  element=${form_element}  attribute=${attribute}
    ...  ELSE  Get Element Value by Attribute  element_type=${field_type}  attribute=${attribute}  attribute_value=${attribute_value}

    should be equal as strings  ${form_attribute_value}  ${attribute_value}


Verify Form Element Text
    [Documentation]  Verify the text inside a form field label element matches the specified text.
    [Arguments]  ${form_element}=None  ${text_data}=None

    ${inner_html}=  Get Attribute Value from Raw Element  ${form_element}  attribute=innerHTML
    ${cleaned_html}=  Clean InnerHTML  ${inner_html}

    should be equal as strings  ${cleaned_html}  ${text_data}
    

Get Form Button
    [Documentation]  Return the specified button matching the specified attribute and attribute value from the given form.
    [Arguments]  ${form_element}=None  ${attribute}=name  ${attribute_value}=None

    ${child_button_element}=  Find Descendant by Attribute  parent_element=${form_element}  child_type=button  child_attribute=${attribute}  child_attribute_value=${attribute_value}
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

    ${found_text}=  Get Element Value Attribute  type=input  attribute=${input_attribute}  attribute_value=${input_attribute_value}

    should be equal as strings  ${found_text}  ${input_text}


Click Form Element
    [Documentation]  Click on the specified form element.
    [Arguments]  ${element_type}=button  ${attribute}=class  ${attribute_value}=None  ${text_data}=None  ${timeout}=None
    
    Click Element Matching Attribute  type=${element_type}  attribute=${attribute}  attribute_value=${attribute_value}  timeout=${timeout}


Click Form Element Containing Text
    [Documentation]  Click on the form element containing the specified text.
    [Arguments]  ${text_data}=None  ${timeout}=None

    Click Element Containing Text  text_data=${text_data}  timeout=${timeout}


Verify Next Page Loaded
    [Documentation]  Verify the next page has loaded after submitting a form by checking for the specified element.
    [Arguments]  ${element_type}=div  ${element_attribute}=class  ${element_attribute_value}=None  ${timeout}=None

    Wait for Element to Appear  type=${element_type}  attribute=${element_attribute}  attribute_value=${element_attribute_value}  timeout=${timeout}


Traverse and Select
    [Documentation]  Select, traverse, and click on a dropdown matching input criteria.
    [Arguments]  ${element_type}=div  ${dropdown_attribute}=class  ${dropdown_attribute_value}=None  ${dropdown_select_value}=None  ${timeout}=None

    Click Element Containing Text  text_data=${dropdown_select_value}  timeout=${timeout}