class JobApplicationsController < ApplicationController

  # before_filter :find_all_job_applications
   before_filter :find_page

  def new
    @job_application = JobApplication.new
    @job = Job.find(params[:job_id])
    present(@page)
  end

  def create
      @job_application = JobApplication.new(params[:job_application])
      @job = @job_application.job
      respond_to do |format|
        if @job_application.save
          flash[:notice] = 'Job application was successfully created.'
              begin
                JobMailer.deliver_notification(@job_application, request)
              rescue
                logger.warn "There was an error delivering an inquiry notification.\n#{$!}\n"
              end
          format.html { redirect_to(@job_application) }
        else
          format.html { render :action => "new" }
        end
      end
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @jobs in the line below:
  end
  
  def show 
    @job_application = JobApplication.find(params[:id])
    @job = @job_application.job
    present(@page)
    respond_to do |format|
      format.html { render :action => 'show' }
      format.xml  { render :xml => @future_student }
    end
  end

protected

  def find_all_job_applications
    @jobs = Job.find(:all, :order => "position ASC")
  end

  def find_page
    @page = Page.find_by_link_url("/jobs")
  end

end
