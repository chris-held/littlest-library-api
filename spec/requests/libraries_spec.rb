# spec/requests/todos_spec.rb
require 'rails_helper'

RSpec.describe 'Libraries API', type: :request do
  # initialize test data 
  let!(:libraries) { create_list(:library, 10) }
  let(:library_id) { libraries.first.id }

  # Test suite for GET /todos
  describe 'GET /libraries' do
    # make HTTP get request before each example
    before { get '/libraries' }

    it 'returns libraries' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /libraries/:id
  describe 'GET /libraries/:id' do
    before { get "/libraries/#{library_id}" }

    context 'when the record exists' do
      it 'returns the library' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(library_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:library_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Library/)
      end
    end
  end

  # Test suite for POST /todos
  describe 'POST /libraries' do
    # valid payload
    let(:valid_attributes) { { lat: 43.765285, lon: -87.7015775, name: 'Testbrary' } }

    context 'when the request is valid' do
      before { post '/libraries', params: valid_attributes }

      it 'creates a library' do
        expect(json['name']).to eq('Testbrary')
        expect(json['address']).to eq('1900-1998 North 1st Street')
        expect(json['city']).to eq('Sheboygan')
        expect(json['state']).to eq('WI')
        expect(json['zip']).to eq('53081')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/libraries', params: { name: 'missing required stuff', lat: 43.3 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Lon can't be blank/)
      end
    end

    context 'when the request is a potential duplicate' do
      before { post '/libraries', params: { name: 'too close', lat: 37.791821, lon: -122.394679 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/A similar library exists nearby/)
      end
    end
  end

  # Test suite for PUT /libraries/:id
  # this will eventually only support updating images
  describe 'PUT /libraries/:id' do
    let(:valid_attributes) { { name: 'Testing Updates' } }

    context 'when the record exists' do
      before { put "/libraries/#{library_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
end