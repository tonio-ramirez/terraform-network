require './spec/spec_helper'
require 'json'

tfvars = JSON.parse(File.read(File.absolute_path("spec/fixtures/test.json")))
subnet_east_a = subnet("#{tfvars["vpc_name"]}-#{tfvars["availability_zones"][0]}-private-subnet")
subnet_east_b = subnet("#{tfvars["vpc_name"]}-#{tfvars["availability_zones"][1]}-private-subnet")

describe subnet_east_a do
  it { should exist }
  it { should belong_to_vpc(tfvars["vpc_name"])}
  its(:availability_zone) { should eq tfvars["availability_zones"][0]}
end

describe subnet_east_b do
  it { should exist }
  it { should belong_to_vpc(tfvars["vpc_name"])}
  its(:availability_zone) { should eq tfvars["availability_zones"][1]}
  its(:cidr_block) { should eq tfvars["private_subnet_cidr_blocks"][tfvars["availability_zones"][1]]}
end