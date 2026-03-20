class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.where(user_id: session[:user_id])
  end


  def new
    @reservation =Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = session[:user_id]

    if @reservation.save
      redirect_to reservations_path, notice: "予約が完了しました"
    else
      render :confirm, status: :unprocessable_entity
    end
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @room = Room.find(@reservation.room_id)
     @reservation.user_id = session[:user_id]

    if @reservation.valid?
      @stay_days = (@reservation.check_out - @reservation.check_in).to_i
      @total_price = @stay_days * @reservation.room.price * @reservation.number_of_people
    else
      @room = Room.find(@reservation.room_id)
      render "rooms/show", status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(
      :check_in,
      :check_out,
      :number_of_people,
      :room_id
      )
  end
end
