require "readline"

class Mrdbg

def set_loglevel l
	@loglevel = l
end

def initialize
	@loglevel = 3
end

def set_red s
	return "#{RED}#{s}#{COLOREND}"
end

def set_blue s
        return "#{BLUE}#{s}#{COLOREND}"
end

def set_yellow s
        return "#{YELLOW}#{s}#{COLOREND}"
end

def set_bold s
        return "#{BOLD}#{s}#{BOLDEND}"
end

def d(s)
	color_s = "\033[1m\033[33m"
	color_f = "\033[0m\033[22m"
	line= (caller.first.split ":")[1]
	puts "#{color_s}#{Time.new.strftime("%H:%M:%S")} line:#{line} -- #{s.to_s}#{color_f}"
end
def l(n,s)
   	if n <= @loglevel then
		color_s = "\033[1m\033[34m"
		color_f = "\033[0m\033[22m"
		space = " " * n
		puts "#{color_s}#{Time.new.strftime("%H:%M:%S")} #{space} #{s.to_s}#{color_f}"
   	end
end
def e(n,s)
	color_s = "\033[1m\033[31m"
	color_f = "\033[0m\033[22m"
	space = " " *n
	puts "#{color_s}#{Time.new.strftime("%H:%M:%S")} #{space} #{s.to_s}#{color_f}"
end
def b bind
        color_s = "\033[1m\033[31m"
        color_f = "\033[0m\033[22m"
        line= (caller.first.split ":")[1]
	vars = (eval('local_variables',bind) | eval('instance_variables',bind)).map{|v| "#{v.to_s}= #{eval(v.to_s,bind)}"}.join ";"
        puts "#{color_s}#{Time.new.strftime("%H:%M:%S")} line:#{line} -- #{vars}#{color_f}"
	begin
		print "\033[31m"
		begin
			s = Readline.readline("dbg> ",true).strip
			if s == "" then break end
			eval ("puts ' = ' + (#{s}).to_s"),bind
		rescue => e
			puts " > Error ocurred: \033[1m#{e.backtrace[0]}: #{e.message}\033[22m"
		end while true
	ensure
		print "\033[0m"
	end
end
def x bind
        color_s = "\033[1m\033[33m"
        color_f = "\033[0m\033[22m"
        puts "#{color_s}Execuation mode: #{color_f}"
        begin
                print "\033[33m"
                begin
                  s = Readline.readline("exe> ",true).strip
                  if s == "" then break end
                  eval ("puts ' = ' + (#{s}).to_s"),bind
                rescue => e
                  puts " > Error ocurred: \033[1m#{e.backtrace[0]}: #{e.message}\033[22m"
                end while true
        ensure
                print "\033[0m"
        end
end
end
