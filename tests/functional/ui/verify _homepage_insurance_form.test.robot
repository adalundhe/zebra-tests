*** Settings ***
Resource        ${RESOURCE_DIR}/workflow/ui/form.resource.robot


*** Variables ***
${form_class_name}  zipcode-form
${csrf_field_name}  csrfmiddlewaretoken
${csrf_field_type}  hidden
${zipcode_label_class}  form-control-label
${zipcode_label_text}  Zip Code
${zipcode_field_name}  zipcode
${zipcode_field_type}  text
${button_attribute}  data-cy
${button_attribute_value}  zipcode-submit-button
${button_type}  submit


*** Test Cases ***

Verify Homepage Form Exists
    [Documentation]  Verify that all fields and buttons on the homepage form exist.

    ${zipcode_form}=  Get Form  form_attribute=class  form_attribute_value=${form_class_name}

    ${crsf_input_field}=  Get Form Element  form_element=${zipcode_form}  field_type=input  attribute=name  attribute_value=${csrf_field_name}
    Verify Text Attribute  form_element=${crsf_input_field}  field_type=input  attribute=type  attribute_value=${csrf_field_type}

    ${zipcode_field_label}=  Get Form Element  form_element=${zipcode_form}  field_type=label  attribute=class  attribute_value=${zipcode_label_class}
    Verify Form Field Label Text  form_element=${zipcode_field_label}  label_text=${zipcode_label_text}


    ${zipcode_input_field}=  Get Form Element  form_element=${zipcode_form}  field_type=input  attribute=name  attribute_value=${zipcode_field_name}
    Verify Text Attribute  form_element=${zipcode_input_field}  field_type=input  attribute=type  attribute_value=text

    ${zipcode_form_button}=  Get Form Button  form_element=${zipcode_form}  attribute=${button_attribute}  attribute_value=${button_attribute_value}
    Verify Text Attribute  form_element=${zipcode_form_button}  field_type=button  attribute=type  attribute_value=${button_type}


