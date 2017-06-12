class ExportFilesController < ApplicationController
def export_file
    @fees = Fee.all
    Fee.export_file_xsl(@fees)
    file = "#{Rails.root}/tmp/Fee.xlsx"
    send_file file, type: "application/xlsx", filename: "Fee.xlsx"
  end
end