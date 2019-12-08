*** Settings ***
Resource        ${RESOURCE_DIR}/workflow/ui/form.resource.robot


*** Variables ***
${vehicle_year}  2008
${vehicle_make}  Volkswagen
${vehicle_model}  Rabbit
${submodel}  S 2dr Hatchback 6A

${dropdown_attribute_value}  dropdown-menu show
${vehicle_year_field_id}  yearYear-0Input-0
${vehicle_make_field_id}  makeMake-0Input-0
${vehicle_model_field_id}  modelModel-0Input-0
${vehicle_submodel_field_id}  submodelSubmodel-0Input-0
${button_attribute_value}  vehiclesSelectSaveBtn

${ownership_field_id}  ownership-0-0
${timeout}  120


*** Test Cases ***

Complete Vehicle Questions and Submit
    [Documentation]  Verify that a valid year, make, model, and submodel can be input and the vehicle data form can be submitted.

    Traverse and Select  dropdown_attribute_value=${dropdown_attribute_value}  dropdown_select_value=${vehicle_year}  timeout=${timeout}
    ${current_input_value}=  Get Element Value by Attribute  element_type=input  attribute=placeholder  attribute_value=${vehicle_year}

    Traverse and Select  dropdown_attribute_value=${dropdown_attribute_value}  dropdown_select_value=${vehicle_make}  timeout=${timeout}
    ${current_input_value}=  Get Element Value by Attribute  element_type=input  attribute=placeholder  attribute_value=${vehicle_make}

    Traverse and Select  dropdown_attribute_value=${dropdown_attribute_value}  dropdown_select_value=${vehicle_model}  timeout=${timeout}
    ${current_input_value}=  Get Element Value by Attribute  element_type=input  attribute=placeholder  attribute_value=${vehicle_model}

    Traverse and Select  dropdown_attribute_value=${dropdown_attribute_value}  dropdown_select_value=${submodel}
    ${current_input_value}=  Get Element Value by Attribute  element_type=input  attribute=placeholder  attribute_value=${submodel}

    Click Form Element  attribute=id  attribute_value=${button_attribute_value}  timeout=${timeout}
    Verify Next Page Loaded  element_type=input  element_attribute=id  element_attribute_value=${ownership_field_id}  timeout=${timeout}