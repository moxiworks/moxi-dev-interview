require "rails_helper"

RSpec.describe ShiftsController, type: :request do
  let!(:job) { create(:job) }
  let!(:shift) { create(:shift, job:) }

  describe "GET /shifts" do
    it "returns a 200 response" do
      get "/jobs/#{job.id}/shifts"
      expect(response).to have_http_status(:ok)
    end

    it "returns all shifts" do
      get "/jobs/#{job.id}/shifts"
      expect(JSON.parse(response.body).size).to eq(Shift.count)
    end
  end

  describe "GET /shifts/:id" do
    it "returns a 200 response" do
      get "/shifts/#{shift.id}"
      expect(response).to have_http_status(:ok)
    end

    it "returns the shift with the given id" do
      get "/shifts/#{shift.id}"
      expect(JSON.parse(response.body)["id"]).to eq(shift.id)
    end
  end

  describe "POST /shifts" do
    let(:valid_params) { {shift: {start_time: "10:00", end_time: "18:00"}} }
    let(:invalid_params) { {shift: {start_time: "25:00", end_time: "26:00"}} }

    context "with valid params" do
      it "creates a new shift" do
        expect {
          post "/jobs/#{job.id}/shifts", params: valid_params
        }.to change(Shift, :count).by(1)
      end

      it "returns a 201 response" do
        post "/jobs/#{job.id}/shifts", params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      it "does not create a new shift" do
        expect {
          post "/jobs/#{job.id}/shifts", params: invalid_params
        }.to_not change(Shift, :count)
      end

      it "returns a 422 response" do
        post "/jobs/#{job.id}/shifts", params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns errors" do
        post "/jobs/#{job.id}/shifts", params: invalid_params
        expect(JSON.parse(response.body)).to_not be_empty
      end
    end
  end

  describe "PATCH /shifts/:id" do
    let(:valid_params) { {shift: {start_time: "10:00"}} }
    let(:invalid_params) { {shift: {start_time: nil}} }

    context "with valid params" do
      it "updates the shift" do
        patch "/shifts/#{shift.id}", params: valid_params
        shift.reload
        expect(shift.start_time).to eq("10:00")
      end

      it "returns a 200 response" do
        patch "/shifts/#{shift.id}", params: valid_params
        expect(response).to have_http_status(:ok)
      end

      it "returns the updated shift" do
        patch "/shifts/#{shift.id}", params: valid_params
        expect(JSON.parse(response.body)["start_time"]).to eq("10:00")
      end
    end

    context "with invalid params" do
      it "does not update the shift" do
        patch "/shifts/#{shift.id}", params: invalid_params
        shift.reload
        expect(shift.start_time).to_not eq(nil)
      end

      it "returns a 422 response" do
        patch "/shifts/#{shift.id}", params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /shifts/:id" do
    it "deletes the shift" do
      expect {
        delete "/shifts/#{shift.id}"
      }.to change(Shift, :count).by(-1)
    end

    it "returns a 204 response" do
      delete "/shifts/#{shift.id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end
