*** Settings ***
Resource        ${RESOURCE_DIR}/workflow/ui/driver.resource.robot
Resource        ${RESOURCE_DIR}/workflow/ui/form.resource.robot


*** Variables ***
${driver_gender}  Male
${marital_status}  Single
${home_ownership}  Rent
${credit_score}  Average (580-679)
${education_level}  Bachelor's degree
${insured_history_length}  More than 3 years
${current_carrier}  GEICO
${recent_accidents}  No
${driver_email}  corpheus91@gmail.com
${discount_one}  Employed full time
${discount_two}  Set auto-pay from my bank account
${discount_three}  Go paperless
${referral}  TV ad

${currently_insured_attribute_value}  currently_insured-1-0
${violations_attribute_value}  violations-0-0
${current_carrier_attribute}  data-cy
${current_carrier_attribute_value}  current_carrierInput
${driver_email_attribute}  data-cy
${driver_email_attribute_value}  email
${referral_attribute}  data-cy
${referral_attribute_value}  referral_sourceInput

${button_attribute_value}  summaryShowQuotesBtn
${next_page_element_id}  content
${timeout}  180


*** Test Cases ***

Complete Driver Details Form and Submit
    [Documentation]  Verify that valid information can be entered for the driver details form and the form submits.

    Click Form Element Containing Text  text_data=${driver_gender}  timeout=${timeout}
    Click Form Element Containing Text  text_data=${marital_status}  timeout=${timeout}
    Click Form Element Containing Text  text_data=${home_ownership}  timeout=${timeout}
    Click Form Element Containing Text  text_data=${credit_score}  timeout=${timeout}
    Click Form Element Containing Text  text_data=${education_level}  timeout=${timeout}
    Select Driver Insurance Option  label_attribute=for  label_attribute_value=${currently_insured_attribute_value}
    Click Form Element Containing Text  text_data=${insured_history_length}  timeout=${timeout}
    Enter Text for Input Field  input_attribute=${current_carrier_attribute}  input_attribute_value=${current_carrier_attribute_value}  input_text=${current_carrier}
    Select Driver Insurance Option  label_attribute=for  label_attribute_value=${violations_attribute_value}
    Enter Text for Input Field  input_attribute=${driver_email_attribute}  input_attribute_value=${driver_email_attribute_value}  input_text=${driver_email}
    Click Form Element Containing Text  text_data=${discount_one}  timeout=${timeout}
    Click Form Element Containing Text  text_data=${discount_two}  timeout=${timeout}
    Click Form Element Containing Text  text_data=${discount_three}  timeout=${timeout}
    Enter Text for Input Field  input_attribute=${referral_attribute}  input_attribute_value=${referral_attribute_value}  input_text=${referral}

    Click Form Element  attribute=id  attribute_value=${button_attribute_value}  timeout=${timeout}
    Verify Next Page Loaded  element_type=div  element_attribute=id  element_attribute_value=${next_page_element_id}  timeout=${timeout}