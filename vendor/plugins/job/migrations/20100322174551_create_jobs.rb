class CreateJobs < ActiveRecord::Migration

  def self.up
    create_table :jobs do |t|
      t.string :job_title
      t.text :description
      t.text :desired_skills
      t.text :required_skills
      t.string :employment_terms
      t.string :hours
      t.integer :position
      t.boolean :enabled
      t.timestamps
    end

    add_index :jobs, :id

    create_table :job_applications do |t|
      t.string :job_id
      t.string :name
      t.string :phone
      t.string :email
      t.text :cover_letter
      t.string :resume_file_name
      t.string :resume_content_type
      t.integer :resume_file_size
      t.datetime :resume_updated_at
      t.timestamps
    end

    add_index :job_applications, :id
    add_index :job_applications, :job_id
    
    User.find(:all).each do |user|
      user.plugins.create(:title => "Jobs", :position => (user.plugins.maximum(:position) || -1) +1)
    end

    page = Page.create(
      :title => "Jobs",
      :link_url => "/jobs",
      :deletable => false,
      :position => ((Page.maximum(:position, :conditions => "parent_id IS NULL") || -1)+1),
      :menu_match => "^/jobs(\/|\/.+?|)$"
    )
    RefinerySetting.find_or_set(:default_page_parts, ["Body", "Side Body"]).each do |default_page_part|
      page.parts.create(:title => default_page_part, :body => nil)
    end
  end

  def self.down
    UserPlugin.destroy_all({:title => "Jobs"})

    Page.find_all_by_link_url("/jobs").each do |page|
      page.link_url, page.menu_match = nil
      page.deletable = true
      page.destroy
    end
    Page.destroy_all({:link_url => "/jobs"})

    drop_table :jobs
    drop_table :job_applications
  end

end
