class ShiftAdminMailer < ApplicationMailer
  default from: 'from@example.com'

  def shift_admin_mail(team)
    @team = team
    @email = team.owner.email
    mail to: @email, subject:"あなたがチームリーダーになりました"
  end
end
