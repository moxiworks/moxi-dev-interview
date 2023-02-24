require "rails_helper"

RSpec.describe VolunteersController, type: :request do
  let!(:volunteer) { create(:volunteer) }

  describe "GET /volunteers" do
    it "returns a 200 response" do
      get "/volunteers"
      expect(response).to have_http_status(:ok)
    end

    it "returns all volunteers" do
      get "/volunteers"
      expect(JSON.parse(response.body).size).to eq(Volunteer.count)
    end
  end

  describe "GET /volunteers/:id" do
    it "returns a 200 response" do
      get "/volunteers/#{volunteer.id}"
      expect(response).to have_http_status(:ok)
    end

    it "returns the volunteer with the given id" do
      get "/volunteers/#{volunteer.id}"
      expect(JSON.parse(response.body)["id"]).to eq(volunteer.id)
    end
  end

  describe "POST /volunteers" do
    let(:valid_params) { {volunteer: {email: "test@test.com"}} }
    let(:invalid_params) { {volunteer: {email: nil}} }

    context "with valid params" do
      it "creates a new volunteer" do
        expect {
          post "/volunteers", params: valid_params
        }.to change(Volunteer, :count).by(1)
      end

      it "returns a 201 response" do
        post "/volunteers", params: valid_params
        expect(response).to have_http_status(:created)
      end

      it "returns the newly created volunteer" do
        post "/volunteers", params: valid_params
        expect(JSON.parse(response.body)["email"]).to eq("test@test.com")
      end
    end

    context "with invalid params" do
      it "does not create a new volunteer" do
        expect {
          post "/volunteers", params: invalid_params
        }.to_not change(Volunteer, :count)
      end

      it "returns a 422 response" do
        post "/volunteers", params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns errors" do
        post "/volunteers", params: invalid_params
        expect(JSON.parse(response.body)).to_not be_empty
      end
    end
  end

  describe "PATCH /volunteers/:id" do
    let(:valid_params) { {volunteer: {email: "test@test.com"}} }
    let(:invalid_params) { {volunteer: {email: nil}} }

    context "with valid params" do
      it "updates the volunteer" do
        patch "/volunteers/#{volunteer.id}", params: valid_params
        volunteer.reload
        expect(volunteer.email).to eq("test@test.com")
      end

      it "returns a 200 response" do
        patch "/volunteers/#{volunteer.id}", params: valid_params
        expect(response).to have_http_status(:ok)
      end

      it "returns the updated volunteer" do
        patch "/volunteers/#{volunteer.id}", params: valid_params
        expect(JSON.parse(response.body)["email"]).to eq("test@test.com")
      end
    end

    context "with invalid params" do
      it "does not update the volunteer" do
        patch "/volunteers/#{volunteer.id}", params: invalid_params
        volunteer.reload
        expect(volunteer.email).to_not eq(nil)
      end

      it "returns a 422 response" do
        patch "/volunteers/#{volunteer.id}", params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /volunteers/:id" do
    it "deletes the volunteer" do
      expect {
        delete "/volunteers/#{volunteer.id}"
      }.to change(Volunteer, :count).by(-1)
    end

    it "returns a 204 response" do
      delete "/volunteers/#{volunteer.id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end
