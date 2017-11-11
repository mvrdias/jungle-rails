class UserMailer < ApplicationMailer
default from: 'no-reply@jungle.com'

def welcome_email(order)
    @order = order

    mail(to: @order.email, subject: "Thanks for your order #{@order.id}")
  end
end
