class CollageImage < ApplicationRecord
  has_attached_file :image,
                    styles: {
                              medium: "300x300>",
                              thumb:  "100x100>"
                            }
  validates_attachment :image,
                        content_type: {
                          content_type: [
                            "image/jpeg",
                            "image/jpg",
                            "image/png",
                            "image/gif"
                          ]
                        }
end
