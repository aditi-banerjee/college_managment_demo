# frozen_string_literal: true
require 'roo'
require 'spreadsheet'
require 'roo-xls'

class UploadFeeStructureJob < ActiveJob::Base
  queue_as :default

  def perform(upload_fee_structure)
    puts "=-=-=-=-=-=-=-=-=-"
    puts upload
    puts "=-=-=-=-=-==-=-=-==-"
    # upload_fee_structure = UploadFeeStructure.find_by(id: id)
    # if upload_fee_structure
    #   success = 0
    #   failed  = 0
      begin
        upload_fee_structure.update(status: "I")

        spreadsheet = open_file(upload_fee_structure.upload)
        header      = spreadsheet.row(1)
        new_header  = header

        new_sheet   = Spreadsheet::Workbook.new
        new_sheet.create_worksheet name: upload_fee_structure.upload_file_name

        worksheet = new_sheet.worksheet(0)
        worksheet.insert_row(0, new_header.push("Errors"))
        success = 0
        failed  = 0

        (2..spreadsheet.last_row).each do |i|
          row = Hash[[header, spreadsheet.row(i).push("Errors")].transpose]
          new_upload_fee_structure_data = Fee.import_data(row)
          new_row_index = worksheet.last_row_index + 1
          puts "-=--0=-=0-=-=-=0"
          puts Fee.import_data(row)
          puts new_upload_fee_structure_data
          puts "-=--0=-=0-=-=-=0"

          worksheet.insert_row(
            new_row_index,
            spreadsheet.row(i).push(new_upload_fee_structure_data)
          )

          (new_upload_fee_structure_data =="success") ? success = success + 1 : failed = failed + 1
        end

        old_path = upload_fee_structure.upload.path
        new_path = old_path.split("/")
        new_path.pop()
        temp_old_file_name = File.basename(upload_fee_structure.upload.original_filename, ".*")
        new_file = "#{temp_old_file_name}_completed_#{upload_fee_structure.id}.xls"
        new_sheet.write("#{new_path.join("/")}/#{new_file}")

        upload_fee_structure.update(
          status: "P",
          total_record: (success + failed),
          number_of_success: success,
          number_of_fail: failed
        )
      rescue => e
        puts "Error: #{e}"
        puts "Backtrace: #{e.backtrace}"

        upload_fee_structure.update(
          number_of_success: success,
          number_of_fail: failed,
          status: 'F',
          fail_error: e.message
        )
      end
    puts "Job Ended to insert Excel Data for store having id = #{upload_fee_structure.id}"
  end

  def open_file(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end