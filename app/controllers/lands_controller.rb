class LandsController < ApplicationController
  before_action :set_land, only: [:show, :edit, :update, :destroy]

  def home
    
  end

  # GET /lands
  # GET /lands.json
  def index
    @lands = Land.all.paginate(:page => params[:page], :per_page =>20)
    @lands = @lands.where(bedrooms: params["bedrooms"]) if params["bedrooms"].present?
    @lands = @lands.where(bathrooms: params["bathrooms"]) if params["bathrooms"].present?
    @lands = @lands.where(neighborhood: params["neighborhood"]) if params["neighborhood"].present?
    @lands = @lands.where("price > ?", params["min_price"]) if params["min_price"].present?
    @lands = @lands.where("price < ?", params["max_price"]) if params["max_price"].present?
    @lands = @lands.where("sqft > ?", params["min_square_footage"]) if params["min_square_footage"].present?
    @lands = @lands.where("sqft < ?", params["max_square_footage"]) if params["max_square_footage"].present?
    @lands = @lands.where(cats: params["cats"]) if params["cats"].present?
    @lands = @lands.where(dogs: params["dogs"]) if params["dogs"].present?
    @lands = @lands.where(w_d_in_units: params["washer_driyer_in_units"]) if params["washer_driyer_in_units"].present?
    @lands = @lands.where(street_parking: params["street_parking"]) if params["street_parking"].present?
  end

  # GET /lands/1
  # GET /lands/1.json
  def show
    @images = @land.images
  end

  # GET /lands/new
  def new
    @land = Land.new
  end

  # GET /lands/1/edit
  def edit
  end

  # POST /lands
  # POST /lands.json
  def create
    @land = Land.new(land_params)

    respond_to do |format|
      if @land.save
        format.html { redirect_to @land, notice: 'Land was successfully created.' }
        format.json { render :show, status: :created, location: @land }
      else
        format.html { render :new }
        format.json { render json: @land.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lands/1
  # PATCH/PUT /lands/1.json
  def update
    respond_to do |format|
      if @land.update(land_params)
        format.html { redirect_to @land, notice: 'Land was successfully updated.' }
        format.json { render :show, status: :ok, location: @land }
      else
        format.html { render :edit }
        format.json { render json: @land.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lands/1
  # DELETE /lands/1.json
  def destroy
    @land.destroy
    respond_to do |format|
      format.html { redirect_to lands_url, notice: 'Land was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_land
      @land = Land.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def land_params
      params.require(:land).permit(:heading, :body, :price, :neigborhood, :external_url, :timestamp)
    end
end
