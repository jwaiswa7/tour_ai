ActiveAdmin.register Assistant do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :description, :remote_id, :model, :instructions, :temperature
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :remote_id, :model, :instructions, :temperature]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  actions :all

  index do
    column :name
    column :description
    column :model
    column :temperature
    actions
  end
end
