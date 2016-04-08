Given(/the following JSON schema:$/) do |schema|
  @schema = schema.to_json
end

When(/^I run the JSON data generator$/) do
  @output = JsonTestData.generate!(@schema)
end
