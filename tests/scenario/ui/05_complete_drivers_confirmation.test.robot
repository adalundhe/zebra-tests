*** Settings ***
Resource        ${RESOURCE_DIR}/workflow/ui/driver.resource.robot
Resource        ${RESOURCE_DIR}/workflow/ui/form.resource.robot


*** Variables ***
${driver_name}  Flop Plopopop
${driver_age}  28 yrs
${full_street}  3800 Oleary Street 208
${button_attribute_value}  driversSelectSaveBtn
${driver_element_type}  h5
${driver_element_class}  driver-text d-inline
${address_element_type}  p
${address_class_name}  address
${button_attribute_value}  driversSelectSaveBtn
${next_page_element_id}  gender-0-0
${timeout}  30


*** Test Cases ***
Complete Drivers Selection Form and Submit
    [Documentation]  Verify that primary driver's information is correct and submit the form.

    Verify Driver Info Exists  element_type=${driver_element_type}  element_class=${driver_element_class}  driver_info=${driver_name}
    Verify Driver Info Exists  element_type=${driver_element_type}  element_class=${driver_element_class}  driver_info=${driver_age}
    Verify Driver Info Exists  element_type=${address_element_type}  element_class=${address_class_name}  driver_info=${full_street}

    Click Form Element  attribute=id  attribute_value=${button_attribute_value}  timeout=${timeout}
    Verify Next Page Loaded  element_type=input  element_attribute=id  element_attribute_value=${next_page_element_id}  timeout=${timeout}