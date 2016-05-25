class BaseSerializer < ActiveModel::Serializer
  #delegate :params, to: :scope

  def include_associations?
    if scope[:embed]
      embed = scope[:embed].split(',') 
      return true if embed.include?('associations')
    end
  end
end