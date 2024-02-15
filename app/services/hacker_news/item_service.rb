module HackerNews
  class ItemService
    attr_reader :client
    pattr_initialize :id do
      @client = Client.new
    end

    def call
      client.handle_response client.item(id)
    end
  end
end
