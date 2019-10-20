require 'rails_helper'

RSpec.describe 'Parking API', type: :request do
  # Test suite for POST /parking
  describe 'POST /parking' do
    let(:valid_attributes) { { plate: 'FAA-1234' } }

    context 'when the request is valid' do
      before { post '/parking', params: valid_attributes }

      it 'creates a registry' do
        expect(json['id']).to be_a(Integer)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/parking', params: { plate: 'MIAMI' } }

      it 'not creates a registry' do
        expect(json['detail']).to eq('It must be like AAA-9999')
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end

  end

  # Test suite for PUT /parking/:id/out
  describe 'PUT /parking/:id/out' do    
    context 'when the plate has paid' do
      let(:parking_paid) { create(:parking, paid: true) }

      before { put "/parking/#{parking_paid.id}/out" }

      it 'registry the exit' do
        expect(json['output']).to be_a(String)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the plate payment is pending' do
      let(:parking_pending) { create(:parking, paid: false) }

      before { put "/parking/#{parking_pending.id}/out" }

      it 'not registry the exit' do
        expect(json['detail']).to eq('Payment is pending')
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end

  end

  # Test suite for PUT /parking/:id/pay
  describe 'PUT /parking/:id/pay' do
    context 'when the plate payment is pending' do
      let(:parking_pending) { create(:parking, paid: false) }

      before { put "/parking/#{parking_pending.id}/pay" }

      it 'registry the payment' do
        expect(json['paid']).to eq(true)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the plate has paid' do
      let(:parking_paid) { create(:parking, paid: true) }

      before { put "/parking/#{parking_paid.id}/pay" }

      it 'not registry the payment' do
        expect(json['detail']).to eq('Payment was made previously')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for GET /parking/:plate
  describe 'GET /parking/:plate' do
    context 'when the plate has registry' do
      let(:parking) { create(:parking) }

      for i in 0..5
        let(:history) { create(:parking, plate: parking.plate) }
      end

      before { get "/parking/#{parking.plate}" }

      it 'returns registry' do
        expect(json).not_to be_empty
        expect(json.size).to eq(5)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the plate has not registry' do
      let(:plate) { 'ZZZ-0000' }

      before { get "/parking/#{plate}" }

      it 'returns empty' do
        expect(json).to be_empty
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end