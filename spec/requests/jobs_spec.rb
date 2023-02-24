require "rails_helper"

RSpec.describe JobsController, type: :request do
  let!(:event) { create(:event) }
  let!(:job) { create(:job, event:) }

  describe "GET /jobs" do
    it "returns a 200 response" do
      get "/events/#{event.id}/jobs"
      expect(response).to have_http_status(:ok)
    end

    it "returns all jobs" do
      get "/events/#{event.id}/jobs"
      expect(JSON.parse(response.body).size).to eq(Job.count)
    end
  end

  describe "GET /jobs/:id" do
    it "returns a 200 response" do
      get "/jobs/#{job.id}"
      expect(response).to have_http_status(:ok)
    end

    it "returns the job with the given id" do
      get "/jobs/#{job.id}"
      expect(JSON.parse(response.body)["id"]).to eq(job.id)
    end
  end

  describe "POST /jobs" do
    let(:valid_params) { {job: {name: "New Job"}} }
    let(:invalid_params) { {job: {name: nil}} }

    context "with valid params" do
      it "creates a new job" do
        expect {
          post "/events/#{event.id}/jobs", params: valid_params
        }.to change(Job, :count).by(1)
      end

      it "returns a 201 response" do
        post "/events/#{event.id}/jobs", params: valid_params
        expect(response).to have_http_status(:created)
      end

      it "returns the newly created job" do
        post "/events/#{event.id}/jobs", params: valid_params
        expect(JSON.parse(response.body)["name"]).to eq("New Job")
      end
    end

    context "with invalid params" do
      it "does not create a new job" do
        expect {
          post "/events/#{event.id}/jobs", params: invalid_params
        }.to_not change(Job, :count)
      end

      it "returns a 422 response" do
        post "/events/#{event.id}/jobs", params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns errors" do
        post "/events/#{event.id}/jobs", params: invalid_params
        expect(JSON.parse(response.body)).to_not be_empty
      end
    end
  end

  describe "PATCH /jobs/:id" do
    let(:valid_params) { {job: {name: "Updated Job"}} }
    let(:invalid_params) { {job: {name: nil}} }

    context "with valid params" do
      it "updates the job" do
        patch "/jobs/#{job.id}", params: valid_params
        job.reload
        expect(job.name).to eq("Updated Job")
      end

      it "returns a 200 response" do
        patch "/jobs/#{job.id}", params: valid_params
        expect(response).to have_http_status(:ok)
      end

      it "returns the updated job" do
        patch "/jobs/#{job.id}", params: valid_params
        expect(JSON.parse(response.body)["name"]).to eq("Updated Job")
      end
    end

    context "with invalid params" do
      it "does not update the job" do
        patch "/jobs/#{job.id}", params: invalid_params
        job.reload
        expect(job.name).to_not eq(nil)
      end

      it "returns a 422 response" do
        patch "/jobs/#{job.id}", params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /jobs/:id" do
    it "deletes the job" do
      expect {
        delete "/jobs/#{job.id}"
      }.to change(Job, :count).by(-1)
    end

    it "returns a 204 response" do
      delete "/jobs/#{job.id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end
