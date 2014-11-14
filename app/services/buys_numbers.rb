class BuysNumbers
  def initialize(options)
    @client = options[:client]
    @country = options[:country]
    @area_code = options[:area_code]
    @url = options[:url]
  end

  def buy_number
    list_options = @area_code.present? ? {area_code: @area_code} : {}

    chosen_number = @client.account.available_phone_numbers.get(@country).local.list(list_options).first
    @client.account.incoming_phone_numbers.create(phone_number: chosen_number.phone_number, sms_url: @url)

    chosen_number.phone_number
  end
end
