class SetupController < ApplicationController
  include Wicked::Wizard

  before_filter :require_admin
  before_filter :setup_complete?

  steps :define_car, :collect_car_number, :collect_admin_number, :finish

  def show
    case step
    when :define_car
      @car = Car.new
    when :collect_car_number
      @car = Car.first
      @number = build_number
      @countries = PhoneNumberRegion.country_options
      @area_codes = PhoneNumberRegion.area_code_options
    when :collect_admin_number
      @car = Car.first
      @sharer = Sharer.new
    end

    render_wizard
  end

  def update
    case step
    when :define_car
      @car = Car.new(car_params)
      @car.save
      model = @car
    when :collect_car_number
      @car = Car.first

      if params[:car].present?
        @car.update_attributes(car_number_params)

        model = @car
      else
        @number = PhoneNumberRegion.new(phone_number_region_params)

        if @number.valid?
          buyer = BuysNumbers.new(area_code: @number.area_code, country: @number.country, url: txts_url, client: client)
          bought_number = buyer.buy_number
          model = @car

          @car.number = bought_number
        else
          model = @number
        end
      end
    when :collect_admin_number
      @sharer = Sharer.new(sharer_params)
      model = @sharer
      @sharer.save
      @sharer.admin!

      gateway.deliver(from: Car.first.number, to: @sharer.number, body: "Hello!")
    end

    render_wizard model
  end

  private
  def car_params
    params.require(:car).permit(:description, :location_information, :lockbox_information)
  end

  def car_number_params
    params.require(:car).permit(:number)
  end

  def build_number
    PhoneNumberRegion.new
  end

  def phone_number_region_params
    params.require(:phone_number_region).permit(:area_code, :country)
  end

  def sharer_params
    params.require(:sharer).permit(:name, :number)
  end

  def setup_complete?
    redirect_to root_path unless setup_required?
  end
end

class PhoneNumberRegion
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :country, :area_code

  def self.countries_with_codes
    Country.all.map(&:last).map{|abbr| Country.new(abbr)}.select{|c| c.country_code.present?}
  end

  def self.countries
    countries_with_codes.map(&:alpha2)
  end

  validates :country, presence: true, inclusion: {in: countries}

  def self.country_options
    countries_with_codes.map{|c| ["#{c.name} (+#{c.country_code})", c.alpha2] }.sort_by(&:first)
  end

  def self.area_codes
    Area.area_codes.map(&:first)
  end

  validates :area_code, absence: true, unless: :in_nanp?
  validates :area_code, presence: true, inclusion: {in: area_codes}, if: :in_nanp?

  def self.area_code_options
    Area.area_codes.map do |code_and_area|
      code, area = code_and_area
      ["#{code} (#{area})", code]
    end
  end

  def in_nanp?
    country_object = Country[country]

    if country_object.present?
      country_object.country_code == "1"
    else
      false
    end
  end

  def save
    valid?
  end
end
