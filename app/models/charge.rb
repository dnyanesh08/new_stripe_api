class Charge < ActiveRecord::Base
    
    belongs_to :user
     
    def process_charge
    
	customer = Stripe::Customer.create( 
	           email: current_user.email,
	           card: card_token)



	Stripe::Charge.create( customer: customer.id,
	  amount: @amount,
	  description:'pay',
	  currency: 'usd')
  end	

end
