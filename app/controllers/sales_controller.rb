class SalesController < ApplicationController
  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.total = @sale.value.to_i - @sale.discount.to_i
    if @sale.tax == 1
      @sale.total = @sale.value - (@sale.value * 1.19)
      @sale.tax = 19
    end
     if @sale.save
      redirect_to sales_done_path, notice: "El registro fue almacenado con éxito!" 
     end
  end

  def done
    @sales = Sale.all
  end

  private 
	def sale_params
		params.require(:sale).permit(:cod, :detail, :category, :value, :discount, :tax)
	end
  
end
