module PollsHelper
  def redirect_path
    @redirect_path ||= begin
      redirect_path = params[:redirect_path]
      redirect_path if allowable_redirect_paths.include? redirect_path
    end
  end

  def allowable_redirect_path?
    redirect_path.present?
  end

  # Avoid open redirect vulnerabilities.
  # For example: a phishing scam, where phishers would send an email with a
  # link http://www.domain.com/polls/feeds?redirect_path=http://malicious.com.
  # The unsuspecting user would first be asked to authenticate, then, redirected
  # to http://malicious.domain.com after authentication. We could assign
  # redirect_url to session, but this is fine for our code challenge.
  def allowable_redirect_paths
    @allowable_redirect_paths ||= [root_path, recommended_news_path]
  end
end
