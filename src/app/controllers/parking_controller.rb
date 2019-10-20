module ParkingHelper
  include ActionView::Helpers::DateHelper

  def serialize(parking)
    end_time = parking.output
    if end_time == nil
      end_time = Time.now
    end
    {
      id: parking.id,
      time: distance_of_time_in_words(
        parking.input, end_time),
      paid: parking.paid?,
      left: parking.output?
    }
  end
end

class ParkingController < ApplicationController
  include ParkingHelper

  def index
    results = Parking.all.order(:output).map {|parking| 
      serlialized = serialize(parking)
      serlialized['plate'] = parking.plate
      serlialized
    }
    render json: results, status: :ok
  end

  def create
    if Parking.where(plate: params['plate'], output: nil).exists?
      render json: { detail: 'This plate is already in parking' }, status: :forbidden
    else
      parking = Parking.new(plate: params['plate'])
      parking.input = Time.now
      if parking.save
          render json: serialize(parking), status: :created
      else
          render json: parking.errors, status: :unprocessable_entity
      end
    end
  end

  def pay
    parking = Parking.find(params[:parking_id])
    if parking.paid
      render json: { detail: 'Payment was made previously'}, status: :forbidden
    else
      parking.paid = true
      parking.save
      render json: serialize(parking), status: :ok
    end
  end

  def out
    parking = Parking.find(params[:parking_id])
    if parking.paid
      parking.output = Time.now
      parking.save
      render json: serialize(parking), status: :ok
    else
      render json: { detail: 'Payment is pending'}, status: :payment_required
    end
  end

  def show
    parkings = Parking.where(plate: params[:id]).order('input DESC')
    if parkings.exists?
      render json: parkings.map { |parking| serialize(parking) }, status: :ok
    else
      render json: params, status: :not_found
    end
  end
end
