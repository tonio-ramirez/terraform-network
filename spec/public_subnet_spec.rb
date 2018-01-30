require './spec/spec_helper'
require 'json'

tfvars = JSON.parse(File.read(File.absolute_path("spec/fixtures/test.json")))
subnet_east_a = subnet("#{tfvars["vpc_name"]}-#{tfvars["availability_zones"][0]}-public-subnet")
subnet_east_b = subnet("#{tfvars["vpc_name"]}-#{tfvars["availability_zones"][1]}-public-subnet")
igw = internet_gateway("#{tfvars["vpc_name"]}-igw")
route_table = route_table("#{tfvars["vpc_name"]}-public-route-table")

describe subnet_east_a do
  it { should exist }
  it { should belong_to_vpc(tfvars["vpc_name"])}
  its(:availability_zone) { should eq tfvars["availability_zones"][0]}
  its(:cidr_block) { should eq tfvars["public_subnet_cidr_blocks"][tfvars["availability_zones"][0]]}
end

describe subnet_east_b do
  it { should exist }
  it { should belong_to_vpc(tfvars["vpc_name"])}
  its(:availability_zone) { should eq tfvars["availability_zones"][1]}
  its(:cidr_block) { should eq tfvars["public_subnet_cidr_blocks"][tfvars["availability_zones"][1]]}
end

describe igw do
  it { should exist }
  it { should be_attached_to("#{tfvars["vpc_name"]}") }
end

describe route_table do
  it { should exist }
  it { should belong_to_vpc(tfvars["vpc_name"]) }
  it { should have_subnet(subnet_east_a.id) }
  it { should have_subnet(subnet_east_b.id) }
  it { should have_route("0.0.0.0/0").target(gateway: igw.id) }
end
