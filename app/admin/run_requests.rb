ActiveAdmin.register RunRequest do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :itinerary_id, :thread_id, :run_id, :message
  #
  # or
  #
  # permit_params do
  #   permitted = [:itinerary_id, :thread_id, :run_id, :message]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  actions :index, :show
end
