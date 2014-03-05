class NewRankDecorator < Raddar::Notifications::BaseDecorator
  def mailer_subject
    t 'mailers.new_rank.subject', rank: rank
  end

  def text
    render 'ranks/notification', rank: rank, universe: universe
  end

  def redirect_path
    universe_path(universe)
  end

  private

  def universe
    object.notifiable.universe
  end

  def rank
    object.notifiable
  end
end
