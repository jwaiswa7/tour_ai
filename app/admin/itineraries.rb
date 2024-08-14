ActiveAdmin.register Itinerary do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :start_date, :end_date, :budget, :number_of_people, :accomodation_type, :engagement_level, :weather, :notes, :ai_response, :interest_list, :destination_list
  #
  # or
  #
  # permit_params do
  #   permitted = [:start_date, :end_date, :budget, :number_of_people, :accomodation_type, :engagement_level, :weather, :notes, :ai_response, :interest_list, :destination_list]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  index do
    column :start_date
    column :end_date
    column :number_of_people
    actions
  end

  filter :start_date
end
