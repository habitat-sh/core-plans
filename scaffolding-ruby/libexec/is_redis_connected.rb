#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require "#{Dir.pwd}/config/environment.rb"

begin
  Redis.new(url: ENV['REDIS_URL']).keys
rescue => e
  abort "Redis connection failed: #{e}"
end
