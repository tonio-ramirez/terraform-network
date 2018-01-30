require './spec/spec_helper'
require 'json'

tfvars = JSON.parse(File.read(File.absolute_path("spec/fixtures/test.json")))

describe subnet("#{tfvars["vpc_name"]}-#{tfvars["availability_zones"][0]}-subnet") do
  it { should exist }
  it { should belong_to_vpc(tfvars["vpc_name"])}
  its(:availability_zone) { should eq tfvars["availability_zones"][0]}

end

describe subnet("#{tfvars["vpc_name"]}-#{tfvars["availability_zones"][1]}-subnet") do
  it { should exist }
  it { should belong_to_vpc(tfvars["vpc_name"])}
  its(:availability_zone) { should eq tfvars["availability_zones"][1]}
  its(cidr_block) { should eq tfvars["subnet_cidr_blocks"][tfvars["availability_zones"][1]]}
end