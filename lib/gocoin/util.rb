module GoCoin
  module Util

    class << self

      def symbolize_names(object)
        case object
        when Hash
          new = {}
          object.each do |key, value|
            key = (key.to_sym rescue key) || key
            new[key] = symbolize_names(value)
          end
          new
        when Array
          object.map { |value| symbolize_names(value) }
        else
          object
        end
      end

      def hash_to_url_params(hash)
        hash.map{|k,v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}"}.join("&")
      end

    end

  end
end