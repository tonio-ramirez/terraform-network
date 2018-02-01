require './spec/spec_helper'
require 'json'

tfvars = JSON.parse(File.read(File.absolute_path("spec/fixtures/test.json")))
vpc_name = tfvars["vpc_name"]
azs = tfvars["availability_zones"]

environment = File.open(File.absolute_path(".terraform/environment")).read
tfstate = JSON.parse(File.read(File.absolute_path("terraform.tfstate.d/#{environment}/terraform.tfstate")))
subnet_ids = tfstate["modules"][0]["outputs"]["public_subnet_ids"]["value"]

igw = internet_gateway("#{tfvars["vpc_name"]}-igw")
route_table = route_table("#{tfvars["vpc_name"]}-public-route-table")

subnet_ids.each do |subnet_id|
  describe subnet("#{subnet_id}") do
    it { should exist }
    it { should be_available }
    it { should belong_to_vpc(vpc_name)}
    its(:availability_zone) {
      should satisfy { |az| azs.include? az }
    }
  end
end

describe igw do
  it { should exist }
  it { should be_attached_to("#{tfvars["vpc_name"]}") }
end

describe route_table do
  it { should exist }
  it { should belong_to_vpc(tfvars["vpc_name"]) }
  subnet_ids.each do |subnet_id|
    it { should have_subnet(subnet_id) }
  end
  it { should have_route("0.0.0.0/0").target(gateway: igw.id) }
end
