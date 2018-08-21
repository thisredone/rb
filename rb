#!/usr/bin/env ruby
File.join(Dir.home, '.rbrc').tap { |f| load f if File.exists?(f) }

def execute(_, code)
  puts _.instance_eval(&code)
rescue Errno::EPIPE
  exit
end

single_line = ARGV.delete('-l')
code = eval("Proc.new { #{ARGV.join(' ')} }")
single_line ? STDIN.each { |l| execute(l.chomp, code) } : execute(STDIN.each_line, code)
