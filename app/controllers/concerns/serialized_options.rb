module SerializedOptions
  extend ActiveSupport::Concern
  # pass in required resources to get them included in options hash
  def include_resources(resources = [])
    options = {}
    options[:include] = []
    resources.each do |resource|
      options[:include] += [resource]
    end
    options
  end
  
  def include_links(self_link, next_link, prev_link)
    options ={}
    options[:links]=
      {
          self: self_link,
          next: next_link,
          prev: prev_link
      }
    options
  end
end
