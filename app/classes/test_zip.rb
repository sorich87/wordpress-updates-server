require 'zip/zip'
class TestZip
  def initialize(file)
    @zip = Zip::ZipFile.open(file)

    file = ""
    @zip.each do |z_file|
      if z_file.to_s == "automated-editor/AutomatedEditor.php"
        file = z_file
        break
      end
    end

    entry = @zip.get_entry(file)
    input_stream = entry.get_input_stream

    putsit(input_stream)
  end

  def putsit(stream)
    stream.each_with_index do |line, index|
      puts "#{index}: #{line}"
    end
  end
end
