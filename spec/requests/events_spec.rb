require "rails_helper"

RSpec.describe EventsController, type: :request do
  let!(:event) { create(:event) }

  describe "GET /events" do
    it "returns a 200 response" do
      get "/events"
      expect(response).to have_http_status(:ok)
    end

    it "returns all events" do
      get "/events"
      expect(JSON.parse(response.body).size).to eq(Event.count)
    end
  end

  describe "GET /events/:id" do
    it "returns a 200 response" do
      get "/events/#{event.id}"
      expect(response).to have_http_status(:ok)
    end

    it "returns the event with the given id" do
      get "/events/#{event.id}"
      expect(JSON.parse(response.body)["id"]).to eq(event.id)
    end
  end

  describe "POST /events" do
    let(:valid_params) { {event: {name: "New Event", date: "2022-01-01"}} }
    let(:invalid_params) { {event: {name: nil, date: nil}} }

    context "with valid params" do
      it "creates a new event" do
        expect {
          post "/events", params: valid_params
        }.to change(Event, :count).by(1)
      end

      it "returns a 201 response" do
        post "/events", params: valid_params
        expect(response).to have_http_status(:created)
      end

      it "returns the newly created event" do
        post "/events", params: valid_params
        expect(JSON.parse(response.body)["name"]).to eq("New Event")
      end
    end

    context "with invalid params" do
      it "does not create a new event" do
        expect {
          post "/events", params: invalid_params
        }.to_not change(Event, :count)
      end

      it "returns a 422 response" do
        post "/events", params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns errors" do
        post "/events", params: invalid_params
        expect(JSON.parse(response.body)).to_not be_empty
      end
    end
  end

  describe "PATCH /events/:id" do
    let(:valid_params) { {event: {name: "Updated Event"}} }
    let(:invalid_params) { {event: {name: nil}} }

    context "with valid params" do
      it "updates the event" do
        patch "/events/#{event.id}", params: valid_params
        event.reload
        expect(event.name).to eq("Updated Event")
      end

      it "returns a 200 response" do
        patch "/events/#{event.id}", params: valid_params
        expect(response).to have_http_status(:ok)
      end

      it "returns the updated event" do
        patch "/events/#{event.id}", params: valid_params
        expect(JSON.parse(response.body)["name"]).to eq("Updated Event")
      end
    end

    context "with invalid params" do
      it "does not update the event" do
        patch "/events/#{event.id}", params: invalid_params
        event.reload
        expect(event.name).to_not eq(nil)
      end

      it "returns a 422 response" do
        patch "/events/#{event.id}", params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /events/:id" do
    it "deletes the event" do
      expect {
        delete "/events/#{event.id}"
      }.to change(Event, :count).by(-1)
    end

    it "returns a 204 response" do
      delete "/events/#{event.id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end
