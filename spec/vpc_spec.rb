require './spec/spec_helper'
require 'json'

tfvars = JSON.parse(File.read(File.absolute_path("test.json")))

describe vpc(tfvars["vpc_name"]) do
  it { should exist }
  its(:cidr_block) { should eq tfvars["cidr_block"] }
end