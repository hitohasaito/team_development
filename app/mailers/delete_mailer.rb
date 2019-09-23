class DeleteMailer < ApplicationMailer
  default from: 'from@example.com'

  def delete_mail(agenda,email)
    @agenda = agenda
    #binding.pry
    @member = @agenda.team.members
    @email = @member.select(:email)

    mail to: @email, subject: 'アジェンダが削除されました'
  end
end
