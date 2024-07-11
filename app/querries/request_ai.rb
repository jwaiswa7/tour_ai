class RequestAi
  # def initialize(itinerary_id: nil)
  #   begin
  #     @itinerary = Itinerary.find(itinerary_id) 
  #   rescue ActiveRecord::RecordNotFound
  #     @itinerary = nil
  #   end
  # end

  def initialize
    puts 'Request Ai'
  end

  def call
    # return if itinerary.nil?
    save_run_request
    return_message
  end

  private

  attr_accessor :thread

  def return_message
    get_message['data'].first['content'].first['text']['value']
  end

  def get_message
    @get_message ||= Ai::GetMessages.call(
      thread_id: create_run[:thread_id],
      run_id: create_run[:run_id]
    )
  end

  def create_run
    @create_run ||= Ai::SendMessage.call(message: message)
  end

  def save_run_request
    RunRequest.create(
      thread_id: create_run[:thread_id],
      run_id: create_run[:run_id]
    )
    puts create_run
  end

  def message
    "List for me 5 tour destinations in Entebbe Uganda.  Return some information of about 30 words on Lake Victoria Hotel and price for a room"
  end
end