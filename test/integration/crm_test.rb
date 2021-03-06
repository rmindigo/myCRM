require "selenium-webdriver"
require "rspec"
require "browserstack/local"

describe "Get the title" do


	before(:each) do
	    # Input capabilities
		caps = Selenium::WebDriver::Remote::Capabilities.new
		caps["browser"] = "IE"
		caps["browser_version"] = "11.0"
		caps["os"] = "Windows"
		caps["os_version"] = "10"
		caps["browserstack.debug"] = "true"
		caps["browserstack.local"] = "true"
		caps["name"] = "Testing MyCrm"
		caps["build"] = "Demo Build"

		# Set Local connection via code binding
		caps["browserstack.local"] = "true"
		@bs_local = BrowserStack::Local.new
		@bs_local.start({ "key" => "qFbvcfiNLF6J3F387xwv", "force" => true})


		@driver = Selenium::WebDriver.for(:remote,
		  :url => "http://robroskop1:qFbvcfiNLF6J3F387xwv@hub-cloud.browserstack.com/wd/hub",
		  :desired_capabilities => caps)
	    @base_url = "http://localhost:3000/"
	    @accept_next_alert = true
	    @driver.manage.timeouts.implicit_wait = 30
	 end
	 
	 after(:each) do
	    @driver.quit  
	    @bs_local.stop
	 end

	it 'check title' do 
		@driver.navigate.to @base_url
		title = @driver.title
		expect(title).to match "MyCrm"
	end

	it 'sign up' do
		@driver.navigate.to @base_url

		click_here = @driver.find_element(:id, "click_here")

		click_here.click

		# sleep(3)

		source = @driver.page_source

		expect(source).to include('Sign up') 

		email = @driver.find_element(:id, 'user_email')

		email.send_keys 'ryaan980r@pick.co'

		pswd = @driver.find_element(:id, 'user_password')

		pswd.send_keys 'changeme'

		pswdConfirm = @driver.find_element(:id, 'user_password_confirmation')

		pswdConfirm.send_keys 'changeme'

		submit = @driver.find_element(:name, 'commit')

		submit.click

		source = @driver.page_source

		expect(source).to include('Contacts') 

		
	end
end



