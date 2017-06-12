Sidekiq.configure_server do |config|
  config.redis = {
    url: "redis://#{ENV['REDIS_SERVER']}:#{ENV['REDIS_PORT']}/#{ENV['REDIS_DB']}",
    namespace: 'demo-college'
  }
end
Sidekiq.configure_client do |config|
  config.redis = {
    url: "redis://#{ENV['REDIS_SERVER']}:#{ENV['REDIS_PORT']}/#{ENV['REDIS_DB']}",
    namespace: 'demo-college'
  }
end
