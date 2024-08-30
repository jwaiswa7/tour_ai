class QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index

  end

  def create
    # ai_response = Ai::ChatBot::SendMessage.call(thread_id: question_params[:thread_id], message: question_params[:question])
    @question = question_params[:question]
    @answer = ai_response["data"][0]["content"][0]["text"]["value"]
  end

  private

  def question_params
    params.require(:question).permit(:question, :thread_id)
  end

  def ai_response
    {"object"=>"list", "data"=>[{"id"=>"msg_dmdqthtBgMKCbTPUQ36L3HRL", "object"=>"thread.message", "created_at"=>1724835708, "assistant_id"=>"asst_IP0QIGADUYeZXYWkB4xxX1Tl", "thread_id"=>"thread_YYt2zxvmaFfAIHP3ho9nksdm", "run_id"=>"run_ZEzWPfwf2BgYlbcDyRrE7QZx", "role"=>"assistant", "content"=>[{"type"=>"text", "text"=>{"value"=>"Great choice! Kenya is a beautiful country with a rich cultural heritage and stunning landscapes. Here are 5 popular tourist destinations in Kenya:\n\n1. **Maasai Mara National Reserve** – Famous for the Great Migration, wildlife viewing, and the Maasai culture.\n2. **Amboseli National Park** – Known for its stunning views of Mount Kilimanjaro and large elephant herds.\n3. **Lamu Island** – A serene and ancient Swahili town with beautiful beaches and historic architecture.\n4. **Lake Nakuru National Park** – Famous for its flocks of flamingos and diverse bird species.\n5. **Nairobi** – The capital city with attractions like the Nairobi National Park, David Sheldrick Wildlife Trust, and Karen Blixen Museum.\n\nPlease choose one or more destinations from the list above or feel free to enter your own preferred destinations.", "annotations"=>[]}}], "attachments"=>[], "metadata"=>{}}, {"id"=>"msg_CbA7QR8hdQ96DIQ1FXWbGSRR", "object"=>"thread.message", "created_at"=>1724835706, "assistant_id"=>nil, "thread_id"=>"thread_YYt2zxvmaFfAIHP3ho9nksdm", "run_id"=>nil, "role"=>"user", "content"=>[{"type"=>"text", "text"=>{"value"=>"I would like to visit Kenya", "annotations"=>[]}}], "attachments"=>[], "metadata"=>{}}], "first_id"=>"msg_dmdqthtBgMKCbTPUQ36L3HRL", "last_id"=>"msg_CbA7QR8hdQ96DIQ1FXWbGSRR", "has_more"=>false}
  end

  # def ai_response
  #   client = OpenAI::Client.new
  #   client.messages.list(thread_id: 'thread_lE7DzgszZYjZ6CVtbq9txiJg', parameters: { order: 'asc' })
  # end
end
