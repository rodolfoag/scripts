#!/usr/bin/ruby

# Author: Rodolfo Goncalves
# github.com/rodolfoag
# Create a zip file with the updated files since N commits

require 'git'

filename = "latest_#{File.basename(Dir.pwd)}.zip"
num_commits = 0
target_dir = "~/tmp/"

if ARGV.length > 2
  puts "Maximum of two arguments allowed"
  exit 0
elsif ARGV.length == 1
  if ARGV[0].to_i == 0
    target_dir = ARGV[0]
  else
    num_commits = ARGV[0].to_i
  end
elsif ARGV.length == 2
  num_commits = ARGV[0].to_i
  target_dir = ARGV[1]
end

#puts "num_commits: #{num_commits}, target_dir: #{target_dir}"

# get git log
g = Git.open(Dir.pwd)
logs = g.log
commit = logs[num_commits + 1]

# git archive -o ../latest.zip some-commit $(git diff --name-only earlier-commit some-commit)
command = "git archive -o #{target_dir}#{filename} #{commit.sha} $(git diff --name-only HEAD #{commit.sha})"

puts command

exec(command)
