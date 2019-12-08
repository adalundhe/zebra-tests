*** Settings ***
Documentation   Technical resources for HTML selection and verification.
Library         SeleniumLibrary


*** Keywords ***

Get Element Value by Attribute
    [Documentation]   Select an element where the label value matches the specified value.
    [Arguments]  ${element_type}=div  ${attribute}=class  ${attribute_value}=None

    ${locator}=  Catenate  SEPARATOR=  xpath://  ${element_type}  [@  ${attribute}  ="  ${attribute_value}  "]
    Log  Selecting element at X-Path: ${locator}  debug
    ${found_value}=  Get Element Attribute  ${locator}  ${attribute}
    Log  Found: ${found_value} for element at X-Path: ${locator}  debug

    [Return]  ${found_value}


Get Element
    [Documentation]  Select an element if the specified value occurs in the specified label.
    [Arguments]  ${type}=div  ${attribute}=class  ${attribute_value}=None

    ${locator}=  Catenate  SEPARATOR=  xpath://  ${type}  [@  ${attribute}  ="  ${attribute_value}  "]
    Log  Selecting element at X-Path: ${locator} debug
    ${found_element}=  Get WebElement  ${locator}   

    [Return]  ${found_element}


Get Element if Contains
    [Documentation]  Select and return an element if the specified value occurs in the specified label.
    [Arguments]  ${type}=div  ${attribute}=class  ${attribute_value}=None

    ${locator}=  Catenate  SEPARATOR=  xpath://  ${type}  [contains(@  ${attribute}  ,'  ${attribute_value}  ')]
    Log  Selecting element at X-Path: ${locator}  debug
    ${found_element}=  Get WebElement  ${locator}

    [Return]  ${found_element}


Find Children by Label
    [Documentation]  Find the specified child element that matches the specified label value.
    [Arguments]  ${parent_element}=None  ${child_type}=div  ${child_attribute}=class  ${child_attribute_value}=None

    ${locator}=  Catenate  SEPARATOR=  child::  ${child_type}  [@  ${child_attribute}  ="  ${child_attribute_value}  "]
    Log  Selecting element(s) at X-Path: ${locator} debug
    ${child_element}=  Call Method  ${parent_element}  find_elements  by=xpath  value=${locator}

    [Return]  ${child_element}


Find Descendant by Label
    [Documentation]  Find the specified child element that matches the specified label value.
    [Arguments]  ${parent_element}=None  ${child_type}=div  ${child_attribute}=class  ${child_attribute_value}=None

    ${locator}=  Catenate  SEPARATOR=  descendant::  ${child_type}  [@  ${child_attribute}  ="  ${child_attribute_value}  "]
    Log  Selecting element(s) at X-Path: ${locator} debug
    ${child_element}=  Call Method  ${parent_element}  find_elements  by=xpath  value=${locator}

    [Return]  ${child_element}


Find Descendant by Local Name
    [Documentation]  Find the specified children element that match the specified type.
    [Arguments]  ${parent_element}=None  ${local_name}=*


    ${locator}=  Catenate  SEPARATOR=  descendant::*[local-name() = '${local_name}']
    Log  Selecting element(s) at X-Path: ${locator}  debug
    ${children_elements}=  Call Method  ${parent_element}  find_element  by=xpath  value=${locator}

    [Return]  ${children_elements}


Find Parent by Label
    [Documentation]  Find an elements parent mathing the specified label and label value.
    [Arguments]  ${child_element}=None  ${parent_type}=div  ${parent_label}=class  ${parent_label_value}=None

    ${locator}=  Catenate  SEPARATOR=  parent::  ${child_type}  [@  ${child_attribute}  ="  ${child_attribute_value}  "]
    Log  Selecting element(s) at X-Path: ${locator} debug
    ${parent_element}=  Call Method  ${child_element}  find_element  by=xpath  value=${locator}

    [Return]  ${parent_element}


Get Attribute Value from Raw Element
    [Documentation]  Return the specified attribute value for a raw Selenium element object.
    [Arguments]  ${element}=None  ${attribute}=class

    ${attribute_value}=  Call Method  ${element}  get_attribute  ${attribute}

    [Return]  ${attribute_value}


Input Text Data to Element
    [Documentation]  Enter text data for the specified element.
    [Arguments]  ${type}=div  ${attribute}=class  ${attribute_value}=None  ${text_data}=None

    ${locator}=  Catenate  SEPARATOR=  xpath://  ${type}  [contains(@  ${attribute}  ,'  ${attribute_value}  ')]
    Log  Selecting element(s) at X-Path: ${locator} debug
    Input Text  ${locator}  ${text_data}


Get Element Text
    [Documentation]  Get text data currently in the specified element.
    [Arguments]  ${type}=div  ${attribute}=class  ${attribute_value}=None

    ${locator}=  Catenate  SEPARATOR=  xpath://  ${type}  [contains(@  ${attribute}  ,'  ${attribute_value}  ')]
    Log  Selecting element(s) at X-Path: ${locator} debug
    ${found_text}=  Get Value  ${locator}

    [Return]  ${found_text}


Click Element via UI
    [Documentation]  Select the specified element by matching attribute/attribute value and click.
    [Arguments]  ${type}=div  ${attribute}=class  ${attribute_value}=None  ${timeout}=None

    ${locator}=  Catenate  SEPARATOR=  xpath://  ${type}  [@  ${attribute}  ="  ${attribute_value}  "]
    Log  Selecting element(s) at X-Path: ${locator} debug
    Wait Until Element Is Enabled  ${locator}  timeout=${timeout}
    Click Element  ${locator}


Click Raw Element via UI
    [Documentation]  Call click on a raw Selenium element object.
    [Arguments]  ${element}

    Call Method  ${element}  click


Wait for Element to Appear via UI
    [Documentation]  Wait for an element matching the specified attribute/attribute value to appear.
    [Arguments]  ${type}=div  ${attribute}=class  ${attribute_value}=None  ${timeout}=None

    ${locator}=  Catenate  SEPARATOR=  xpath://  ${type}  [@  ${attribute}  ="  ${attribute_value}  "]
    Log  Selecting element(s) at X-Path: ${locator} debug
    Wait Until Page Contains Element  ${locator}  ${timeout}


Select Element From Dropdown by Text via UI
    [Documentation]  Traverse a dropdown list and select the element with matching text.
    [Arguments]  ${text_data}=None  ${timeout}=None

    ${locator}=  Catenate  SEPARATOR=  //*[text()[contains(., '  ${text_data}  ')]]
    Wait Until Element Is Enabled  ${locator}  ${timeout}
    Page Should Contain Element  ${locator}
    Mouse Down  ${locator}
    Sleep  ${CLICK_SLEEP}
    Click Element   ${locator}
