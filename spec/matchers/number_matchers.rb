require "rspec/expectations"

RSpec::Matchers.define :be_a_multiple_of do |expected|
  match do |actual|
    actual % expected == 0
  end
end

RSpec::Matchers.define :be_less_than do |expected|
  match do |actual|
    actual < expected
  end
end

RSpec::Matchers.define :be_greater_than do |expected|
  match do |actual|
    actual > expected
  end
end

RSpec::Matchers.define :be_less_than_or_equal_to do |expected|
  match do |actual|
    actual <= expected
  end
end

RSpec::Matchers.define :be_greater_than_or_equal_to do |expected|
  match do |actual|
    actual >= expected
  end
end
