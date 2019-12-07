*** Settings ***
Resource        ${RESOURCE_DIR}/workflow/ui/form.resource.robot


*** Variables ***
${input_field_name}  zipcode
${input_zipcode}  59808
${button_attribute}  data-cy
${button_attribute_value}  zipcode-submit-button
${next_page_input_attribute}  id
${next_page_input_attribute_value}  garaging_addressInput
${next_page_input_placeholder}
${timeout}  30


*** Test Cases ***
Complete Zipcode Form via UI
    [Documentation]  Verify a valid zipcode can be entered into the zipcode form and the form can be submitted.
    
    Enter Text for Input Field  input_attribute=name  input_attribute_value=${input_field_name}  input_text=${input_zipcode}
    Click Submit Button  button_attribute=${button_attribute}  button_attribute_value=${button_attribute_value}
    Verify Next Page Loaded  element_type=input  element_attribute=${next_page_input_attribute}  elment_attribute_value=${next_page_input_attribute_value}  timeout=${timeout}
