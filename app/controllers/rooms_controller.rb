class RoomsController < ApplicationController
  def top
  end

  def index
    @rooms = current_user.rooms
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to room_path(@room), notice: "施設を作成しました"
    else
      flash.now[:alert] = "施設登録に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def search
    @area = params[:area]
    @keyword = params[:keyword]

    allowed_areas = [ "東京", "大阪", "京都", "札幌" ]

    if params[:area].present? && !allowed_areas.any? { |a| params[:area].include?(a) }
      @rooms = Room.none
      return
    end

    @rooms = Room.all

    if params[:area].present?
      @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
    end

    if @keyword.present?
      @rooms = @rooms.where("name LIKE ? OR description LIKE ?", "%#{@keyword}%", "%#{@keyword}%")
    end
  end

  def destroy
    @room = current_user.rooms.find(params[:id])
    @room.destroy
    redirect_to rooms_path, notice: "施設を削除しました"
  end


  private

  def room_params
    params.require(:room).permit(
      :name,
      :description,
      :price,
      :address,
      :image
    )
  end
end
