class UserMailer < ApplicationMailer
  def welcome_mail(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Lyrical Labyrinth')
  end

  def article_create_mail(user)
    @user = user
    mail(to: @user.email, subject: 'Your article was published') do |format|
      format.html
      format.text
    end
  end
end
