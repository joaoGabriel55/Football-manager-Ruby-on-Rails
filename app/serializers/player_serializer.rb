class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :plays_for

  def plays_for
    object.team.present? ? object.team.name : 'Without club'
  end
end
