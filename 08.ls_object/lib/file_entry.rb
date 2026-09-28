# frozen_string_literal: true

require 'etc'

class FileEntry
  FILE_TYPE_TABLE = {
    '01' => 'p',
    '02' => 'c',
    '04' => 'd',
    '06' => 'b',
    '10' => '-',
    '12' => 'l',
    '14' => 's'
  }.freeze

  PERMISSION_TABLE = {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }.freeze

  attr_reader :name, :file_type, :permissions, :link_count, :user_name, :group_name, :file_size, :time_date, :blocks

  def initialize(path)
    @name = path
    file_stat = File.stat(path)

    file_mode = file_stat.mode.to_s(8).rjust(6, '0')
    @file_type = FILE_TYPE_TABLE[file_mode[0, 2]]
    @permissions = file_mode[-3, 3].chars.map { |n| PERMISSION_TABLE[n] }.join
    @link_count = file_stat.nlink.to_s
    @user_name = Etc.getpwuid(file_stat.uid).name
    @group_name = Etc.getgrgid(file_stat.gid).name
    @file_size = file_stat.size.to_s
    @time_date = file_stat.mtime.strftime(' %_m %e %R ')
    @blocks = file_stat.blocks
  end
end
