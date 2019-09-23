class AgendasController < ApplicationController
   #before_action :set_agenda, only: %i[show edit update destroy]
   before_action :set_agenda, only:[:destroy]
   before_action :permit_destroy, only:[:destroy]

  def index
    @agendas = Agenda.all
  end

  def new
    @team = Team.friendly.find(params[:team_id])
    @agenda = Agenda.new
  end

  def create
    @agenda = current_user.agendas.build(title: params[:title])
    @agenda.team = Team.friendly.find(params[:team_id])
    current_user.keep_team_id = @agenda.team.id
    if current_user.save && @agenda.save
      redirect_to dashboard_url, notice: 'アジェンダ作成に成功しました！'
    else
      render :new
    end
  end

  def destroy
    #binding.pry
    if @agenda.destroy
      DeleteMailer.delete_mail(@agenda, @email).deliver
      redirect_to dashboard_url, notice: "削除しました"
    end
  end

  private

  def set_agenda
    @agenda = Agenda.find(params[:id])
  end

  def agenda_params
    params.fetch(:agenda, {}).permit %i[title description]
  end

  def permit_destroy
    @agenda = Agenda.find(params[:id])
    #binding.pry
    redirect_to dashboard_path, notice:"権限がありません" unless @current_user.id == @agenda.team.owner_id || @current_user.id == @agenda.user_id
  end
end
