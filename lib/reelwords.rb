#!/usr/bin/env ruby

# morgan.sziraki@gmail.com
# Tue 25 Mar 2024 18:19:20 GMT

require 'optparse'
require 'yaml'

class ReelWords

  def initialize(options)
    puts options
  end

end

# if running as a script
if __FILE__ == $0
  options = {}

  OptionParser.new do |opts|
    opts.banner = "Usage: SCRIPT_NAME [options]\n  *** Only GET method supported. ***"
    opts.on('-o', '--option Key=Value', 'an Option') do |o|
      begin
        raise StandardError.new 'Warning: Options must be supplied in "-o OptionKey" or "-o OptionKey=OptionValue" format.'
      rescue
          puts 'Finally Saved!'

      #  using else statement
      else
        puts 'Else block execute because of no exception raise'

        # using ensure statement
        ensure
          puts 'ensure block execute'
      end
      (k, v) = o.split('=')
      options[k] = (v.nil?) ? true : v
    end

    opts.on_tail('-h', '--help') {
      puts opts
      exit
    }
  end.parse!

  obj = ReelWords.new(options)
end
