#!/usr/bin/env ruby

def execute(_, code)
  puts _.instance_eval(code)
rescue Errno::EPIPE
  exit
end

single_line = ARGV[0] == '-l'
lines = $stdin.readlines
code = ARGV.drop(single_line ? 1 : 0).join(' ')
single_line ? lines.each { |l| execute(l, code) } : execute(lines, code)