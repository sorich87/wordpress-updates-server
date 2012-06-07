class ImmutableValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :immutable_attribute) if record.send("#{attribute}_changed?")
  end
end