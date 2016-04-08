Given(/the following JSON schema:$/) do |schema|
  @schema = schema.to_json
end

When(/^I run the JSON data generator$/) do
  @output = JsonTestData.generate!(@schema)
end

Then(/^the JSON output should be:$/) do |json|
  expect(@output).to eq json
end
