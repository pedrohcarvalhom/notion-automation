module Clients
  class BaseHttp
    def get(endpoint:, query: {}, headers: {})
      raise NotImplementedError, 'This method must be implemented by the subclass'
    end

    def post(endpoint:, body: {}, headers: {})
      raise NotImplementedError, 'This method must be implemented by the subclass'
    end

    def put(endpoint:, body: {}, headers: {})
      raise NotImplementedError, 'This method must be implemented by the subclass'
    end

    def delete(endpoint:, body: {}, headers: {})
      raise NotImplementedError, 'This method must be implemented by the subclass'
    end
  end
end
