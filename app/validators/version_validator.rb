class VersionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, new_value)
    values = new_value.split('.') unless new_value.nil?
    old_value = record.send("#{attribute}_was")

    if new_value !~ /^(?:(\d+)\.)?(?:(\d+)\.)?(\*|\d+)$/
      record.errors.add(attribute, :incorrect_version_number_format)
    elsif record.send("#{attribute}_changed?")
      if !old_value.nil? && !old_value.blank? && PHPVersioning.compare(old_value, new_value) == 1
        record.errors.add(attribute, :not_higher_version_number)
      end
    end
  end
end