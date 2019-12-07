*** Settings ***
Documentation   Technical resources for HTML selection and verification.
Library         SeleniumLibrary


*** Keywords ***

Get Element Value by Label
    [Documentation]   Select an element where the label value matches the specified value.
    [Arguments]  ${element_type}=div  ${label}=class  ${value}=None

    ${locator}=  Catenate  SEPARATOR=  xpath://  ${element_type}  [@  ${label}  ="  ${value}  "]

    Log  Selecting element at X-Path: ${locator}  debug

    ${label_value}=  Get Element Attribute  ${locator}  ${label}

    Log  Found: ${label_value} for element at X-Path: ${locator}  debug

    [Return]  ${label_value}


Get Element
    [Documentation]  Select an element where the label value matches the specified value and return all child elements.
    [Arguments]  ${parent_type}=div  ${parent_label}=class  ${parent_label_value}=None

    ${locator}=  Catenate  SEPARATOR=  xpath://  ${parent_type}  [@  ${parent_label}  ="  ${parent_label_value}  "]

    Log  Selecting element at X-Path: ${locator} debug

    ${found_element}=  Get WebElement    ${locator}   

    [Return]  ${found_element}


Find Children by Label
    [Documentation]  Find the specified child element that matches the specified label value.
    [Arguments]  ${parent_element}=None  ${child_type}=div  ${child_label}=class  ${child_label_value}=None

    ${locator}=  Catenate  SEPARATOR=  child::  ${child_type}  [@  ${child_label}  ="  ${child_label_value}  "]

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


Get Attribute Value from Raw Element
    [Documentation]  Return the specified attribute value for a raw Selenium element object.
    [Arguments]  ${element}=None  ${attribute}=class

    ${attribute_value}=  Call Method  ${element}  get_attribute  ${attribute}


    [Return]  ${attribute_value}