require 'spec_helper'
require 'capybara'

describe Orderly do
  let(:this) { "<p>One piece of content</p>" }
  let(:that) { "<p>Another piece of content</p>" }

  let(:page) do
    Capybara::Session.new(:rack_test, TestApp)
  end

  describe "appear_before" do
    it "asserts this is before that" do
      page.visit "/thisthenthat"
      this.should appear_before(that)
    end

    it "asserts this is not before that" do
      page.visit "/thatthenthis"
      this.should_not appear_before(that)
    end

    it "handles for this missing" do
      page.visit "/thisnothat"
      error_text = "Could not locate later content on page: #{that}"
      expect { this.should appear_before(that) }.to raise_error error_text
      expect { this.should_not appear_before(that) }.to raise_error error_text
    end

    it "handles for this missing" do
      page.visit "/thatnothis"
      error_text = "Could not locate earlier content on page: #{this}"
      expect { this.should appear_before(that) }.to raise_error error_text
      expect { this.should_not appear_before(that) }.to raise_error error_text
    end
  end

end
