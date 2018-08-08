class V1::UserProcessor < JSONAPI::Processor
  before_replace_fields do
  end

  before_remove_resource do
  end

  before_show_related_resources do
    byebug
  end

  before_get_related_resource do
    byebug
  end
end