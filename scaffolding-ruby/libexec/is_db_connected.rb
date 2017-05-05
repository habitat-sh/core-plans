#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require "#{Dir.pwd}/config/environment.rb"

begin
  ActiveRecord::Base.connection.active?
rescue => e
  abort "Database connection failed: #{e}"
end
