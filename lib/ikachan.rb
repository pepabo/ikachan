# -*- coding: utf-8 -*-
require 'net/http'
require 'uri'
require 'pathname'
require 'active_support/all'

module Ikachan
  mattr_accessor :url, :channel

  module_function

  def join
    request('/join', { 'channel' => @@channel })
  end

  def notice(message)
    join
    request('/notice', { 'channel' => @@channel, 'message' => message })
  end

  def uri_for(path = nil)
    uri = URI.parse("#{@@url}/#{path}")
    uri.path = Pathname.new(uri.path).cleanpath.to_s
    uri
  end

  def request(path, params)
    begin
      uri = uri_for(path)

      http = Net::HTTP.new(uri.host, uri.port)
      http.open_timeout = http.read_timeout = 10

      req = Net::HTTP::Post.new(uri.path)
      req.form_data = params

      http.request(req)
    rescue StandardError, TimeoutError => e
      logger.warn("#{e.class} #{e.message}")
    end
  end

  def logger
    @@_logger ||= Rails.logger
  end
end
