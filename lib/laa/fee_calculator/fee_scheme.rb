# frozen_string_literal: true

require 'laa/fee_calculator/has_manyable'

module LAA
  module FeeCalculator
    class FeeScheme < OpenStruct
      include HasManyable
      extend Forwardable
      def_delegators :connection, :get

      has_many :advocate_types
      has_many :scenarios
      has_many :offence_classes
      has_many :fee_types
      has_many :units
      has_many :modifier_types

      def calculate(**options)
        uri = "fee-schemes/#{id}/calculate/"
        uri = Addressable::URI.parse(uri)
        uri.query_values = options.except(:id)

        json = get(uri).body
        JSON.parse(json)['amount']
      rescue Faraday::ClientError => err
        # TODO: logging

      end

      private

      def connection
        @connection ||= Connection.instance
      end
    end
  end
end
