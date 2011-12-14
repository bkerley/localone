# -*- coding: utf-8 -*-
require 'helper'

class TestLocalone < Test::Unit::TestCase
  context 'with' do
    should 'work on an array' do
      %w{ doug bob }.with do |a|
        assert_equal "doug and bob", a.join(' and ')
      end
    end
  end

  context 'Kernel.let' do
    should 'support work in a naïve way' do
      assert_equal 'abcdef', let(:a=>'abc', :b=>'def'){ [a, b].join }
    end

    should 'work with local variables' do
      canary = rand(36**10).to_s(36)
      out = let(a: 'aaaa', b: 'bbbb'){ "#{a}#{canary}#{b}"}

      assert_equal "aaaa#{canary}bbbb", out
    end

    should 'work with instance variables' do
      @canary = rand(36**10).to_s(36)
      out = let(a: 'aaaa', b: 'bbbb'){ "#{a}#{@canary}#{b}"}

      assert_equal "aaaa#{@canary}bbbb", out
    end
  end
end
