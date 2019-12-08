*** Settings ***
Resource        ${RESOURCE_DIR}/workflow/ui/form.resource.robot


*** Variables ***
${ownership_type}  Own - paid in full
${vehicle_use}  Pleasure
${estimated_milage}  100
${milage_period}  per year

${dropdown_attribute_value}  dropdown-menu show
${milage_input_field_id}  miles-input-0
${button_attribute_value}  vehiclesDetailsSaveBtn
${next_page_element_id}  driversSelectSaveBtn
${timeout}  30


*** Test Cases ***
Complete Ownership Questions and Submit
    [Documentation]  Verify that the form accepts valid ownserhip selections and milage/year input and selections and submits correctly.

    Click Form Element Containing Text  text_data=${ownership_type}  timeout=${timeout}
    Click Form Element Containing Text  text_data=${vehicle_use}  timeout=${timeout}
    Enter Text for Input Field  input_attribute=id  input_attribute_value=${milage_input_field_id}  input_text=${estimated_milage}

    Click Form Element  attribute=id  attribute_value=${button_attribute_value}  timeout=${timeout}
    Verify Next Page Loaded  element_type=button  element_attribute=id  element_attribute_value=${next_page_element_id}  timeout=${timeout}

