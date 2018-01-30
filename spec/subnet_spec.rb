require './spec/spec_helper'
require 'json'

tfvars = JSON.parse(File.read(File.absolute_path("spec/fixtures/test.json")))

describe subnet("#{tfvars["vpc_name"]}-subnet") do
  it { should exist }
end