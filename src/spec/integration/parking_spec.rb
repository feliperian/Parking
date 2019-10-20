# spec/integration/Parking_spec.rb
require 'swagger_helper'

describe 'Parking API' do
  path '/parking' do
    get 'List all registry of the parking' do
			tags 'Parking'
      produces 'application/json'
      response '200', 'found' do
        let(:parkings) { [{ id: 1, plate: 'OZY-0666', time: '5 minutes', paid: false, left: false }] }
        run_test!
      end
    end
    post 'Creates a registry' do
      tags 'Parking'
      consumes 'application/json'
      parameter name: :parking, in: :body, schema: {
        type: :object,
        properties: {
          plate: { type: :string },
        },
        required: [ 'plate' ]
      }

      response '201', 'created' do
        let(:parking) { { id: 1, time: 'less than a minute', paid: false, left: false } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:parking) { { plate: [ 'It must be like AAA-9999.' ] } }
        run_test!
      end
    end
  end

  path '/parking/{id}/pay' do
    put 'Pay off parking' do
      tags 'Parking'
      produces 'application/json'
      parameter name: :id, :in => :path, :type => :string
      response '200', 'found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            time: { type: :string },
						paid: { type: :boolean },
						left: { type: :boolean }
          },
          required: [ 'id',  'time', 'paid', 'left' ]

        let(:id) { Parking.create(paid: true).id }
        run_test!
      end

      response '404', 'not found' do
        let(:id) { 'invalid' }
        run_test!
      end

			response '403', 'unsupported accept header' do
				let(:detail) { 'Payment was made previously' }
        run_test!
      end
    end
	end

  path '/parking/{id}/out' do
    put 'Get out of the parking' do
      tags 'Parking'
      produces 'application/json'
      parameter name: :id, :in => :path, :type => :string
      response '200', 'found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            time: { type: :string },
						paid: { type: :boolean },
						left: { type: :boolean }
          },
          required: [ 'id',  'time', 'paid', 'left' ]

        let(:id) { Parking.create(paid: true).id }
        run_test!
      end

      response '404', 'not found' do
        let(:id) { 'invalid' }
        run_test!
      end

			response '403', 'unsupported accept header' do
				let(:detail) { 'Payment is pending' }
        run_test!
      end
    end
	end
	path '/parking/{plate}' do
    get 'History of the plate' do
			tags 'Parking'
			produces 'application/json'
			parameter name: :plate, :in => :path, :type => :string
      response '200', 'found' do
        let(:parkings) { [{ id: 1, time: '5 minutes', paid: false, left: false }] }
        run_test!
			end

      response '404', 'not found' do
        run_test!
      end
		end
	end
end
