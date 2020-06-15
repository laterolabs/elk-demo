class ApplicationLoggerMiddleware
  attr_reader :logger

  def initialize(app)
    @app = app
    case Rails.configuration.middle_logger.name
    when 'CloudWatchLogger' then @logger = ::CloudLogger
    when 'LogStashLogger' then @logger = ::StashLogger
    else raise StandardError
    end
  end

  def call(env)
    @request = Rack::Request.new(env)
    stash_request(determine_token(env))

    status, headers, body = @app.call(env)

    @response = Rack::Response.new(body, status, headers)
    stash_response

    [status, headers, body]
  end

  private

  attr_accessor :request, :response

  def stash_request(token)
    logger.log_request(@request, token: token)
  end

  def stash_response
    logger.log_response(@response)
  end

  def determine_token(env)
    auth = env['HTTP_AUTHORIZATION']
    return unless auth

    token_hash = ActionController::HttpAuthentication::Digest.decode_credentials(auth)
    token_hash['Token token']
  end
end
