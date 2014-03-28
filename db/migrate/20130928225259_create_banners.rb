class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :title
      t.string :link
      t.string :contents
      t.string :banner_image

      t.timestamps
    end
  end
end
