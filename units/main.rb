#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require "./bundle/bundler/setup"
require "alfred"
require "ruby-units"
require 'net/http'
require 'json'
require 'uri'

File.open( './currencies.json', "r" ) do |f|
  CURRENCIES = JSON.load(f)
end

# Add result to Alfred feedback
def add_result(fb, result)
  fb.add_item({
    :uid      => ""                     ,
    :title    => "#{result}"          ,
    :subtitle => "Copy to clipboard."        ,
    :arg      => "copy=#{result}" ,
    :valid    => "yes",
  })
end

# Add error to Alfred feedback
def add_error(fb)
  fb.add_item({
    :uid      => ""                     ,
    :title    => "Unit is not recognized."          ,
    :subtitle => ""        ,
    :arg      => "" ,
    :valid    => "no",
  })
end

# Get correct currency code from code
def get_currency(code)
  if code.nil? || code.empty?
    return nil
  end

  if CURRENCIES.keys.include?(code.upcase)
    return code.upcase
  end

  currency = CURRENCIES.keys.find { |c| CURRENCIES[c]['symbol'].downcase == code.downcase }

  currency
end

# Call API for currency exchange
def call_api(quantity, from_currency, to_currency, fb)
  quantity ||= 1

  result = Net::HTTP.get(URI.parse("http://rate-exchange.appspot.com/currency?q=#{quantity}&from=#{from_currency}&to=#{to_currency}"))

  begin
    result = JSON.parse(result)

    if result['err']
      add_error(fb)
    else
      add_result(fb, result['v'])
    end
  rescue
    add_error(fb)
  end
end

Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback

  begin
    result = Unit("#{ARGV[0]} #{ARGV[1]}").to("#{ARGV[-1]}").scalar.to_f
    add_result(fb, result)
  rescue
    from_currency = get_currency(ARGV[1])
    to_currency = get_currency(ARGV[-1])

    if from_currency && to_currency
      call_api(ARGV[0], from_currency, to_currency, fb)
    else
      add_error(fb)
    end
  end

  puts fb.to_xml
end



