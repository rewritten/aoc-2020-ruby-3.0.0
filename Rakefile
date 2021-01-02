# frozen_string_literal: true

require 'rake/testtask'
require 'minitest/test'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['lib/**/solution.rb']
end

task default: :test
