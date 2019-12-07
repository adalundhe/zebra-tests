*** Settings ***
Resource        ${RESOURCE_DIR}/workflow/ui/form.resource.robot


*** Variables ***
${input_field_name}  zipcode
${input_zipcode}  59808
${button_attribute}  data-cy
${button_attribute_value}  zipcode-submit-button
${address_input_attribute}  id
${address_input_attribute_value}  garaging_addressInput
${unit_input_attribute}  id
${unit_input_attribute_value}  unitstart
${first_name_input_attribute}  id
${first_name_input_attribute_value}  first_namestart
${last_name_input_attribute}  id
${last_name_input_attribute_value}  last_namestart
${birthday_input_attribute}  id
${birthday_input_attribute_value}  date_of_birthstart
${timeout}  30


*** Test Cases ***
Complete Zipcode Form via UI
    [Documentation]  Verify a valid zipcode can be entered into the zipcode form and the form can be submitted.
    
    Enter Text for Input Field  input_attribute=name  input_attribute_value=${input_field_name}  input_text=${input_zipcode}
    Click Submit Button  button_attribute=${button_attribute}  button_attribute_value=${button_attribute_value}
    Verify Next Page Loaded  element_type=input  element_attribute=${address_input_attribute}  elment_attribute_value=${address_input_attribute_value}  timeout=${timeout}
    Verify Next Page Loaded  element_type=input  element_attribute=${unit_input_attribute}  elment_attribute_value=${unit_input_attribute_value}  timeout=${timeout}
    Verify Next Page Loaded  element_type=input  element_attribute=${first_name_input_attribute}  elment_attribute_value=${first_name_input_attribute_value}  timeout=${timeout}
    Verify Next Page Loaded  element_type=input  element_attribute=${last_name_input_attribute}  elment_attribute_value=${last_name_input_attribute_value}  timeout=${timeout}
    Verify Next Page Loaded  element_type=input  element_attribute=${birthday_input_attribute}  elment_attribute_value=${birthday_input_attribute_value}  timeout=${timeout}
