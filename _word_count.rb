#!/usr/bin/env ruby

require 'fileutils'
require 'yaml'
require 'open3'

if ARGV.empty?
  puts "Prints <post title>;<word count> for a Jekyll post"
  puts "Usage: ruby _word_count.rb <Jekyll-Post-Path>"
  puts "Note: relies on python3 and pip3 to install markdown-work-count"
  exit 1
end

begin
  post_path = ARGV[0]

  full_text = File.read(post_path)

  sections = full_text.split(/^---\s*$/)
  sections.delete("")
  raise StandardError.new "Failed to correctly extract YAML and Markdown" unless sections.size >= 2

  front_matter = sections[0]
  markdown = sections[1]

  title = YAML.load(front_matter)["title"]

  FileUtils.mkdir_p("tmp")
  File.write("tmp/post.markdown", markdown)

  `pip3 install markdown-word-count`
  count, status = Open3.capture2("mwc tmp/post.markdown")

  puts "#{title};#{count}"

rescue StandardError => e
  STDERR.puts "-- ERROR: Could not process #{post_path}"
  STDERR.puts e.message
  STDERR.puts 
  STDERR.puts "\tat #{e.backtrace.join("\n\tat ")}"
end
