#!/usr/bin/env ruby

def execute(_, code)
  puts _.instance_eval(&code)
rescue Errno::EPIPE
  exit
end

single_line = ARGV[0] == '-l'
expr = ARGV.drop(single_line ? 1 : 0).join(' ')
code = eval("Proc.new { #{expr} }")
single_line ? STDIN.each { |l| execute(l.chomp, code) } : execute(STDIN.readlines, code)
