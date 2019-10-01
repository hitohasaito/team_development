class DeleteMailer < ApplicationMailer
  default from: 'from@example.com'

  def delete_mail(agenda)
    @agenda = agenda
    @email = @agenda.team.members.pluck(:email)
    
    mail to: @email, subject: 'アジェンダが削除されました'
  end
end
