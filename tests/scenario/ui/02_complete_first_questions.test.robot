*** Settings ***
Resource        ${RESOURCE_DIR}/workflow/ui/form.resource.robot


*** Variables ***
${street_number}  3800
${street_name}  Oleary Street
${apartment_number}  208
${city_state_and_zipcode_text}  Missoula, MT 59808
${country}  USA
${first_name}  Flop
${last_name}  Plopopop
${month_of_birth}  07
${day_of_birth}  20
${year_of_birth}  1991

${form_select_attribute}  data-cy
${form_name}  questions_formstart
${dropdown_attribute_value}  dropdown-menu show
${address_field_id}  garaging_addressInput
${address_div_class}  form-control-meta
${unit_field_id}  unitstart
${first_name_field_id}  first_namestart
${last_name_field_id}  last_namestart
${birthday_field_id}  date_of_birthstart
${button_attribute_value}  startSaveBtn

${next_page_element_id}  yearYear-0Input-0
${timeout}  30


*** Test Cases ***

Enter Data for First Questions and Submit
    [Documentation]  Verify that a valid customer address, first/last name, and DOB can be entered and the form successfully submits.

    ${full_street_name}=  Catenate  ${street_number}  ${street_name}
    Enter Text for Input Field  input_attribute=id  input_attribute_value=${address_field_id}  input_text=${full_street_name}

    Enter Text for Input Field  input_attribute=id  input_attribute_value=${unit_field_id}  input_text=${apartment_number}
    Enter Text for Input Field  input_attribute=id  input_attribute_value=${first_name_field_id}  input_text=${first_name}
    Enter Text for Input Field  input_attribute=id  input_attribute_value=${last_name_field_id}  input_text=${last_name}

    ${full_date_of_birth}=  Catenate  SEPARATOR=/  ${month_of_birth}  ${day_of_birth}  ${year_of_birth}
    Enter Text for Input Field  input_attribute=id  input_attribute_value=${birthday_field_id}  input_text=${full_date_of_birth}


    ${address_form}=  Get Form  form_attribute=${form_select_attribute}  form_attribute_value=${form_name}
    Verify Element Attribute Matches  field_type=input  attribute=value  attribute_value=${full_street_name} 

    ${address_div_text}=  Get Form Element  form_element=${address_form}  field_type=div  attribute=class  attribute_value=${address_div_class}
    Verify Form Element Text  form_element=${address_div_text}  text_data=${city_state_and_zipcode_text}

    Verify Element Attribute Matches  field_type=input  attribute=value  attribute_value=${first_name}
    Verify Element Attribute Matches  field_type=input  attribute=value  attribute_value=${last_name}
    Verify Element Attribute Matches  field_type=input  attribute=value  attribute_value=${full_date_of_birth}
    Click Form Element  attribute=id  attribute_value=${button_attribute_value}  timeout=${timeout}
    Verify Next Page Loaded  element_type=input  element_attribute=id  element_attribute_value=${next_page_element_id}  timeout=${timeout}
