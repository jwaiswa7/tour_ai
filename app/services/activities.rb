class Activities < ApplicationService
  def call
    activities
  end

  private

  def activities
    JSON.parse (
        File.read('lib/data/ea_activities.json')
      )
  end
end