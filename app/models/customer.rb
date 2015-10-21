class Customer < ActiveRecord::Base
  HEADERS = %w(id first_name last_name age address tel 
    email birth_day job)
  HEADERS_EXCEPT = HEADERS + %w(created_at updated_at)

  def full_name
    "#{first_name} #{last_name}"
  end

  class << self
    def perform customer
      HEADERS.map{|header| customer.send(header)}
    end

    def import file, customer
      return unless (spreadsheet = open_spreadsheet file)
      header = spreadsheet.row 1
      row = Hash[[header, spreadsheet.row(2)].transpose]
      HEADERS.each do |field|
        customer.send "#{field}=", row[field]
      end
      customer.save
    end

    def open_spreadsheet file
      case File.extname File.basename file.path
      when ".csv" then Roo::Csv.new file.path
      when ".xls" then Roo::Excel.new file.path
      when ".xlsx" then Roo::Excelx.new file.path
      end
    end
  end  
end
