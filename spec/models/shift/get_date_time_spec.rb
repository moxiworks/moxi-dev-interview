require "rails_helper"

RSpec.describe Shift::GetDateTime do
  describe ".call" do
    context "with valid date and time arguments" do
      let(:date) { "2022-12-31" }
      let(:time) { "23:59" }

      it "returns a DateTime instance" do
        expect(described_class.call(date, time)).to be_a(DateTime)
      end

      it "returns the correct DateTime object" do
        expected_datetime = DateTime.new(2022, 12, 31, 23, 59)
        expect(described_class.call(date, time)).to eq(expected_datetime)
      end
    end

    context "with invalid date argument" do
      let(:date) { "2022-02-30" }
      let(:time) { "12:00" }

      it "raises an ArgumentError" do
        expect { described_class.call(date, time) }.to raise_error(ArgumentError)
      end
    end

    context "with invalid time argument" do
      let(:date) { "2022-12-31" }
      let(:time) { "25:00" }

      it "raises an ArgumentError" do
        expect { described_class.call(date, time) }.to raise_error(ArgumentError)
      end
    end
  end
end
