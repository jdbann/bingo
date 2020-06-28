module RoundsHelper
  def round_duration
    if Rails.env.test?
      1
    else
      20
    end
  end
end
