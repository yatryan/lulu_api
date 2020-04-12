module LuluApi
  class PrintJob
    attr_accessor :contact_email, :external_id, :line_items, :production_delay, :shipping_address, :shipping_level
    
    def initialize
      production_delay = 120
    end
  end
end