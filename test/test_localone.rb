require 'helper'

class TestLocalone < Test::Unit::TestCase
  should 'support #with on an array' do
    %w{ doug bob }.with do |a|
      assert_equal "doug and bob", a.join(' and ')
    end
  end

  should 'support Kernel.let' do
    assert_equal 'abcdef', let(:a=>'abc', :b=>'def'){ [a, b].join }
  end
end
