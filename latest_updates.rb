#!/usr/bin/ruby

# Author: Rodolfo Goncalves
# github.com/rodolfoag
# Create a zip file with files updates in the lastest commit into ~/tmp/

require 'git'

filename = "latest_#{File.basename(Dir.pwd)}.zip"
target_dir = "~/tmp/"

command = "git archive -o #{target_dir}#{filename} HEAD $(git diff --name-only HEAD^)"

puts "#{filename} generated at #{target_dir}" if system(command)
