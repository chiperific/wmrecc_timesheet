require 'spec_helper'

describe ReportsController do

  describe "GET 'payroll'" do
    it "returns http success" do
      get 'payroll'
      response.should be_success
    end
  end

  describe "GET 'department'" do
    it "returns http success" do
      get 'department'
      response.should be_success
    end
  end

  describe "GET 'user'" do
    it "returns http success" do
      get 'user'
      response.should be_success
    end
  end

  describe "GET 'program'" do
    it "returns http success" do
      get 'program'
      response.should be_success
    end
  end

  describe "index" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end
