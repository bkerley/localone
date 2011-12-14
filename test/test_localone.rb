# -*- coding: utf-8 -*-
require 'helper'

class TestLocalone < Test::Unit::TestCase
  should 'support #with on an array' do
    %w{ doug bob }.with do |a|
      assert_equal "doug and bob", a.join(' and ')
    end
  end

  should 'support Kernel.let in a naïve way' do
    assert_equal 'abcdef', let(:a=>'abc', :b=>'def'){ [a, b].join }
  end

  should 'support Kernel.let with local variables' do
    canary = rand(36**10).to_s(36)
    out = let(a: 'aaaa', b: 'bbbb'){ "#{a}#{canary}#{b}"}

    assert_equal "aaaa#{canary}bbbb", out
  end

  should 'support Kernel.let with instance variables' do
    @canary = rand(36**10).to_s(36)
    out = let(a: 'aaaa', b: 'bbbb'){ "#{a}#{@canary}#{b}"}

    assert_equal "aaaa#{@canary}bbbb", out
  end
end
