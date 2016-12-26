require_relative 'env_file_consolidator'
require_relative 'env_file_sorter'

module Dotenvious
  module CLI
    class Main
      def run
        EnvFileConsolidator.new.run
        if ARGV[0].to_s == '--sort'
          EnvFileSorter.new.run
        end
      end
    end
  end
end
