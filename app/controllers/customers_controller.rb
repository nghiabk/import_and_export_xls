class CustomersController < ApplicationController
  def index
    @customers = Customer.all
    respond_to do |format|
      format.html
      format.xls{send_data @customers.to_xls}
    end 
  end

  def show
    @customer = Customer.find params[:id]
    respond_to do |format|
      format.html
      format.xls do
        send_data(
          [Customer.new].to_xls(except: Customer::HEADERS_EXCEPT,  
          prepend: [Customer::HEADERS, Customer.perform(@customer)]), 
          type: "application/excel; charset=utf-8; header=present",
          filename: "#{@customer.full_name} #{Time.now.strftime("%Y/%m/%d %H:%M:%S")}.xls"
        )
      end
    end
  end

  def edit
    @customer = Customer.find params["id"]
  end

  def update
    @customer = Customer.find params["id"]
    @customer = Customer.import params["customer"]["file"], @customer
    redirect_to customer_path
  end
end
