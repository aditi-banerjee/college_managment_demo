class Fee < ApplicationRecord

  #
  # Associations
  #
  has_many(
    :trades
  )

  #
  #Validations
  #
  validates(
    :amount,
    presence: true,
    format:{
      with: /\A\d{1,6}(\.\d{0,2})?\z/
    }
  )

  validates(
    :duration,
    presence: true
  )

  def self.export_file_xsl(fees)
    fee = Axlsx::Package.new
    fee.workbook do |wb|
      wb.use_autowidth = true
      wb.add_worksheet name: 'fee' do |sheet|
        sheet.add_row [
          "Id",
          "Duration",
          "Amount"
        ]
        fees.each do |fee|
          sheet.add_row [
            fee.id,
            fee.duration,
            fee.amount
          ]
        end
      end
    end
    fee.serialize("#{Rails.root}/tmp/Fee.xlsx")
  end

  def self.import_data(row)
    errors = []
    fee = Fee.find_or_initialize_by(id: row["Id"])
    fee.duration                = row["Duration"]
    fee.amount                  = row ["Amount"]
    fee.save
    if fee.save
      errors << "success"
    else
      errors << fee.get_errors
    end
    return errors.uniq.compact.reject(&:blank?).size > 1 ? errors.uniq.compact.reject(&:blank?) - ["success"] : errors.uniq.compact.reject(&:blank?)
  end

end
