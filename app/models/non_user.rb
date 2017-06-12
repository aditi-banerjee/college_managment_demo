class NonUser < ApplicationRecord

  def from_json(entry)
    begin
      NonUser.create!(JSON.load(entry.get_input_stream.read))
    rescue => e
      warn e.message
    end
  end

end
