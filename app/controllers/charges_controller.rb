class ChargesController < ApplicationController
  before_action :authenticate_user! 
   


def index

   # @charge = Charge.all.where(id:[current_user.id])

    @charge = Charge.all.where("email = ?", current_user.email)


end  

def show

  @charge = Charge.find(params[:email])

end  
  

def new

  @charge = Charge.new

end

def create
  # Amount in cents
    
 
  @charge = Charge.new (charge_params)

  @amount = 1000

 
  customer = Stripe::Customer.create(
    :email => current_user.email,
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Pay',
    :currency    => 'usd'
  )
   
     
  if charge["paid"] == true
     @charge.save
     redirect_to charges_path
  #Save customer to the db
  end 
  
rescue Stripe::CardError => e
  flash[:error] = e.message
  render :new
end

def charge_params

  params.require(:charge).permit(:first_name, :email, :amount, :currency, :description)

end


end


