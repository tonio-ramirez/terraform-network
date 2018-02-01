require './spec/spec_helper'
require 'json'

tfvars = JSON.parse(File.read(File.absolute_path("spec/fixtures/test.json")))
vpc_name = tfvars["vpc_name"]
azs = tfvars["availability_zones"]

environment = File.open(File.absolute_path(".terraform/environment")).read
tfstate = JSON.parse(File.read(File.absolute_path("terraform.tfstate.d/#{environment}/terraform.tfstate")))
public_subnet_ids = tfstate["modules"][0]["outputs"]["public_subnet_ids"]["value"]
private_subnet_ids = tfstate["modules"][0]["outputs"]["private_subnet_ids"]["value"]
natgw_ids = tfstate["modules"][0]["outputs"]["natgw_ids"]["value"]

private_subnet_ids.each do |subnet_id|
  describe subnet("#{subnet_id}") do
    it { should exist }
    it { should be_available }
    it { should belong_to_vpc(vpc_name)}
    its(:availability_zone) {
      should satisfy { |az| azs.include? az }
    }
  end
end

natgw_ids.each do |natgw_id|
  describe nat_gateway("#{natgw_id}") do
    it { should exist }
    it { should be_available }
    # it { should have_eip }
    it { should belong_to_vpc(vpc_name) }
    its(:subnet_id) {
      should satisfy { |subnet_id| public_subnet_ids.include? subnet_id }
    }
  end
end