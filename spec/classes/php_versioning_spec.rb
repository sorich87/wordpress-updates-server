require 'spec_helper'

describe PHPVersioning do
	let(:equal_versions) { [['1.2', '1.2'], ['1.2', '1-2'], ['1.2.9', '1.2-9'], ['1.2-alpha', '1.2-alpha'], ['1.2-dev', '1.2+dev']] }
	let(:unequal_versions) { [['1.2', '1.3'], ['1.2', '1-3'], ['1.2.9', '1.3-0'], ['1.2-alpha', '1.2-beta'], ['1.2-dev', '1.2+alpha']] }

	it 'return 0 if the first version equals the second' do
		equal_versions.each do |v1, v2|
			PHPVersioning.compare(v1, v2).should == 0
		end
	end

	it 'return -1 if the first version is lower than the second' do
		unequal_versions.each do |v1, v2|
			PHPVersioning.compare(v1, v2).should == -1
		end
	end

	it 'return 1 if the first version is higher than the second' do
		unequal_versions.each do |v1, v2|
			PHPVersioning.compare(v2, v1).should == 1
		end
	end

end
