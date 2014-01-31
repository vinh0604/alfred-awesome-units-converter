#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require "./bundle/bundler/setup"
require "alfred"

Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback
  query = ARGV.join(" ").strip
  value = query.partition('=').last

  if query.start_with? 'copy'
    IO.popen('pbcopy', 'w+') { |f| f << value }
    puts "Copied '#{value}' to your clipboard."
    next
  end
end



