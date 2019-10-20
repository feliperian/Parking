class ParkingController < ApplicationController
    # Listar todos os artigos
    # def index
    #     parkings = parking.order('created_at DESC');
    #     render json: {status: 'SUCCESS', message:'Artigos carregados', data:parkings},status: :ok
    # end

    def create
        if Parking.where(plate: params['plate'], output: nil).exists?
            render json: { detail: 'This plate is already in' }, status: :forbidden
        else
            parking = Parking.new(plate: params['plate'])
            parking.input = Time.now
            if parking.save
                render json: parking, status: :created
            else
                render json: parking.errors, status: :unprocessable_entity
            end
        end
    end
end