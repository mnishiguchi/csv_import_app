# frozen_string_literal: true

class CitiesController < ApplicationController
  before_action :set_city, only: %i[show edit update destroy]

  # DELETE /cities/clear
  def clear
    count = City.delete_all
    respond_to do |format|
      format.html { redirect_to cities_url, notice: "#{count} cities were successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # POST /cities/import
  def import
    if params[:file].blank?
      flash.now[:info] = "Please specify a csv file"
      @cities = City.all.order(:city)
      render(:index) && return
    end

    count = City.import_csv(params[:file].path)
    if count.present?
      flash[:success] = "#{count} cities were successfully uploaded"
      redirect_to cities_url
    elsif
      flash.now[:danger] = "Couldn't upload the file"
      @cities = City.all.order(:city)
      render :index
    end
  end

  # GET /cities
  # GET /cities.json
  # GET /cities.csv
  def index
    @cities = City.all.order(:city)

    respond_to do |format|
      format.html {}
      format.json {}
      format.csv { send_data @cities.to_csv, filename: "cities-#{Date.today}.csv" }
    end
  end

  # GET /cities/1
  # GET /cities/1.json
  def show; end

  # GET /cities/new
  def new
    @city = City.new
  end

  # GET /cities/1/edit
  def edit; end

  # POST /cities
  # POST /cities.json
  def create
    @city = City.new(city_params)

    respond_to do |format|
      if @city.save
        format.html { redirect_to cities_url, notice: "#{@city.city} was successfully created." }
        format.json { render :show, status: :created, location: @city }
      else
        format.html { render :new }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cities/1
  # PATCH/PUT /cities/1.json
  def update
    respond_to do |format|
      if @city.update(city_params)
        format.html { redirect_to cities_url, notice: "#{@city.city} was successfully updated." }
        format.json { render :show, status: :ok, location: @city }
      else
        format.html { render :edit }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    @city.destroy
    respond_to do |format|
      format.html { redirect_to cities_url, notice: "#{@city.city} was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_city
    @city = City.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def city_params
    params.require(:city).permit(:city, :description)
  end
end
