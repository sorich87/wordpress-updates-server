class VersionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, new_value)
    return unless record.send("#{attribute}_changed?")

    old_value = record.send("#{attribute}_was")

    record.errors.add(attribute, :not_higher_version_number) if PHPVersioning.compare(old_value, new_value) >= 0
  end
end
