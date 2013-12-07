module GoCoin
  class InvalidRequestError < GoCoinError
    attr_accessor :param

    def initialize(message, http_status=nil, http_body=nil, json_body=nil)
      super(message, http_status, http_body, json_body)
      @param = param
    end
  end
end