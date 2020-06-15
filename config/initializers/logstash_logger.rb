# Logger can take a string message, a hash, a LogStash::Event, an object, or a JSON string as input.
# {
#   "message":"Some Message",
#   "@timestamp":"2015-01-29T10:43:32.196-05:00",
#   "@version":"1",
#   "severity":"INFO",
#   "host":"hostname"
# }
# LogStashLogger.new(
#   type: :tcp,
#   host: ENV['LOGSTASH_HOST'] || 'localhost',
#   poty: ENV['LOGSTASH_PORT'] || 5000
# )
