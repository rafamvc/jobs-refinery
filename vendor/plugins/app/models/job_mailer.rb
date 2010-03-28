class JobMailer < ActionMailer::Base

  def notification(job_application, request)
    subject     "New Job Application from your website"
    recipients  InquirySetting.notification_recipients.value
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    sent_on     Time.now
    body        :job_application => job_application
  end

end
