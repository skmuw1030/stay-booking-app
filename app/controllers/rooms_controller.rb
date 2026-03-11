class RoomsController < ApplicationController
  def rop
  end


  def index
    @rooms = Room.all
  end
end
