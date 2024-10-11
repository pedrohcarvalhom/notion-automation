module Clients
  class Ai
    def assist(prompt:, **options, &block)
      raise NotImplementedError, 'This method must be implemented by the subclass'
    end
  end
end
