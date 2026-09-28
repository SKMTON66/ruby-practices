# frozen_string_literal: true

require 'optparse'
require_relative 'file_entry'

class LsCommand
  COLUMN_COUNT = 3

  def initialize(argv)
    @argv = argv
  end

  def run
    options['l'] ? long_format : normal_format
  end

  private

  def options
    @options ||= @argv.getopts('a', 'r', 'l')
  end

  def files
    base_files = options['a'] ? Dir.entries('.').sort : Dir.glob('*')
    @files ||= options['r'] ? base_files.reverse : base_files
  end

  def file_entries
    @file_entries ||= files.map { |file| FileEntry.new(file) }
  end

  def normal_format
    rows = create_rows
    format_rows(rows)
  end

  def create_rows
    row_count = (files.size / COLUMN_COUNT) + (files.size % COLUMN_COUNT)
    files.each_slice(row_count).to_a.map do |slice_files|
      slice_files << nil while slice_files.size < row_count
      slice_files
    end
  end

  def format_rows(rows)
    normal_print_width = calc_max_width(files) + 4
    rows.transpose.map do |row_files|
      row_files.compact.map { |file| file.ljust(normal_print_width) }.join
    end
  end

  def calc_max_width(strings)
    strings.max_by(&:length).length
  end

  def long_format
    total_line = "total #{file_entries.sum(&:blocks)}"
    link_count_width = calc_max_width(file_entries.map(&:link_count)) + 1
    user_name_width = calc_max_width(file_entries.map(&:user_name)) + 1
    group_name_width = calc_max_width(file_entries.map(&:group_name)) + 2
    file_size_width = calc_max_width(file_entries.map(&:file_size)) + 2
    lines = file_entries.map do |entry|
      "#{entry.file_type}#{entry.permissions}"\
      "#{entry.link_count.rjust(link_count_width)}"\
      "#{entry.user_name.rjust(user_name_width)}"\
      "#{entry.group_name.rjust(group_name_width)}"\
      "#{entry.file_size.rjust(file_size_width)}"\
      "#{entry.time_date}"\
      "#{entry.name}"
    end
    [total_line] + lines
  end
end
