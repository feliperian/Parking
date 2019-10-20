class ParkingController < ApplicationController
    # Listar todos os artigos
    # def index
    #     parkings = parking.order('created_at DESC');
    #     render json: {status: 'SUCCESS', message:'Artigos carregados', data:parkings},status: :ok
    # end

    def create
        parking = Parking.new(plate: params['plate'])
        if parking.save
            render json: {status: 'SUCCESS', message:'Created plate input', id: parking.id },status: :ok
        else
            render json: {status: 'ERROR', message: parking.errors.plate },status: :unprocessable_entity
        end
    end

end