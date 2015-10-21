class Customer::ExportXls
  HEADERS = [:id, :name, :age, :address, :tel]
  HEADERS_EXCEPT = HEADERS + [:created_at, :updated_at]

  class << self
    def perform company
      {prepend: HEADERS}
    end

    private
    def headers company
      [HEADERS.map{|item| Company.human_attribute_name item}, fields(company)]
    end

    def fields company
      HEADERS.map{|header| company.send(header).to_s}
    end
  end
end
