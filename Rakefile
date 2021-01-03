# frozen_string_literal: true

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['lib/**/solution.rb']
  t.options = '-v'
  t.ruby_opts = %w[-W0]
end

task default: :test
