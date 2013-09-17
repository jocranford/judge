require "spec_helper"

describe Judge::ValidatorCollection do
  
  let(:vc) { Judge::ValidatorCollection.new(FactoryGirl.build(:user), :name) }

  it "contains validators" do
    vc.validators.should be_an Array
    vc.validators.first.should be_a Judge::Validator
  end

  it "converts to json correctly" do
    vc.to_json.should be_a String
  end

  it "is enumerable" do
    vc.should be_an Enumerable
    vc.should respond_to :each
  end
  
  it "respects the ignore_unsupported_validators configuration option" do
    vc.validators.length.should eq 2
    Judge::ValidatorCollection.new(FactoryGirl.build(:user), :country).validators.length.should eq 2
    Judge::ValidatorCollection.new(FactoryGirl.build(:user), :bio).validators.length.should eq 2
    Judge::ValidatorCollection.new(FactoryGirl.build(:user), :dob).validators.length.should eq 2
    Judge.config.ignore_unsupported_validators = true
    Judge::ValidatorCollection.new(FactoryGirl.build(:user), :name).validators.length.should eq 1
    Judge::ValidatorCollection.new(FactoryGirl.build(:user), :country).validators.length.should eq 1
    Judge::ValidatorCollection.new(FactoryGirl.build(:user), :bio).validators.length.should eq 2
    Judge::ValidatorCollection.new(FactoryGirl.build(:user), :dob).validators.length.should eq 1
  end

end