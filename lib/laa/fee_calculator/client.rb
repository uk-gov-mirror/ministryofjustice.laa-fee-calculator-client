module LAA
  module FeeCalculator
  	class Client
      attr_reader :connection
      
      def initialize
        @connection = Connection.new
      end

      def ping
        connection.get('/')
        true
      end
  	end	 
  end
end
