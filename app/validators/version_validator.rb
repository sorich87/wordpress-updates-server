class VersionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, new_value)
    values = new_value.split('.') unless new_value.nil?

    if values.nil? || values.length < 1
      record.errors.add(attribute, :incorrect_version_number_format)
    else
      values.each do |part|
        if part !~ /^\d+$/
          record.errors.add(attribute, :incorrect_version_number_format)
          break
        end
      end
    end
  end
end