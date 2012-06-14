class VersionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, new_value)
    old_value = record.send("#{attribute}_was")

    if record.send("#{attribute}_changed?")
      if !old_value.nil? && !old_value.blank? && PHPVersioning.compare(old_value, new_value) >= 0
        record.errors.add(attribute, :not_higher_version_number)
      end
    end
  end
end
