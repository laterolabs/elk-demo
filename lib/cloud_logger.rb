module CloudLogger
  def self.log_request(request, token:)
    logger.info({token: token,
      message: request.body.read,
      type: :request,
      url: request.url,
      method: request.request_method
    }.to_json)
  end

  def self.log_response(response)
    logger.info({
      message: response.body.body,
      type: :response,
      code: response.status,
      content_type: response.content_type
    }.to_json)
  end

  def self.logger
    @logger ||= CloudWatchLogger.new({
      access_key_id: ENV['ACCESS_KEY_ID'],
      secret_access_key: ENV['SECRET_ACCESS_KEY']
    }, 'cloudwatch-elk-demo')
  end
end
