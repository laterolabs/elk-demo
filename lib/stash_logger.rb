module StashLogger
  def log_request(request, token:)
    logger.info LogStash::Event.new(
      token: token,
      message: request.body.read,
      type: :request,
      url: request.url,
      method: request.request_method
    )
  end

  def log_response(response)
    logger.info LogStash::Event.new(
      message: response.body.body,
      type: :response,
      code: response.status,
      content_type: response.content_type
    )
  end

  def self.logger
    @logger ||= LogStashLogger.new(
      type: :tcp,
      host: 'localhost',
      port: 5000
    )
  end
end
