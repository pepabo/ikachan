# -*- coding: utf-8 -*-
require 'test_helper'
require_relative '../lib/ikachan'

class IkachanTest < Test::Unit::TestCase
  def setup
    Ikachan.url = "http://irc.example.com:4649"
    Ikachan.channel = "#example"
  end

  def test_join
    http = mock('http')
    http.stub_everything
    http.expects(:request)
    Net::HTTP.expects(:new).with('irc.example.com', 4649).returns(http)

    req = mock('req')
    req.stub_everything
    req.expects(:form_data=).with do |params|
      params['channel'] == '#example'
    end
    Net::HTTP::Post.expects(:new).with('/join').returns(req)

    Ikachan.join
    assert true
  end

  def test_notice
    Ikachan.expects(:join)

    http = mock('http')
    http.stub_everything
    http.expects(:request)
    Net::HTTP.expects(:new).with('irc.example.com', 4649).returns(http)

    req = mock('req')
    req.stub_everything
    req.expects(:form_data=).with do |params|
      (params['channel'] == '#example') && (params['message'] == 'foo bar buzz')
    end
    Net::HTTP::Post.expects(:new).with('/notice').returns(req)

    Ikachan.notice('foo bar buzz')
  end

  def test_privmsg
    Ikachan.expects(:join)

    http = mock('http')
    http.stub_everything
    http.expects(:request)
    Net::HTTP.expects(:new).with('irc.example.com', 4649).returns(http)

    req = mock('req')
    req.stub_everything
    req.expects(:form_data=).with do |params|
      (params['channel'] == '#example') && (params['message'] == 'foo bar buzz')
    end
    Net::HTTP::Post.expects(:new).with('/privmsg').returns(req)

    Ikachan.privmsg('foo bar buzz')
  end

  def test_rescue_timeout_error
    Ikachan.expects(:join)

    http = stub('http')
    http.stub_everything
    http.stubs(:request).raises(TimeoutError, 'timeout error!')
    Net::HTTP.expects(:new).with('irc.example.com', 4649).returns(http)

    req = stub('req')
    req.stub_everything
    Net::HTTP::Post.expects(:new).with('/notice').returns(req)

    assert_nothing_raised do
      Ikachan.notice('foo bar buzz')
    end
  end

  def test_rescue_socket_error
    Ikachan.expects(:join)

    http = stub('http')
    http.stub_everything
    http.stubs(:request).raises(SocketError, 'connection error!')
    Net::HTTP.expects(:new).with('irc.example.com', 4649).returns(http)

    req = stub('req')
    req.stub_everything
    Net::HTTP::Post.expects(:new).with('/notice').returns(req)

    assert_nothing_raised do
      Ikachan.notice('foo bar buzz')
    end
  end
end
