require "selenium-webdriver"
require "rspec"
require "browserstack/local"

describe "Get the title" do


	before(:each) do
	    # Input capabilities
		caps = Selenium::WebDriver::Remote::Capabilities.new
		caps["browser"] = "IE"
		caps["browser_version"] = "7.0"
		caps["os"] = "Windows"
		caps["os_version"] = "XP"
		caps["browserstack.debug"] = "true"
		caps["browserstack.local"] = "true"
		caps["name"] = "Testing MyCrm"

		# Set Local connection via code binding
		caps["browserstack.local"] = "true"
		@bs_local = BrowserStack::Local.new
		@bs_local.start({ "key" => "W63dFTbQLjYpNpHq6giv", "force" => true})


		@driver = Selenium::WebDriver.for(:remote,
		  :url => "http://ryanmindigo1:W63dFTbQLjYpNpHq6giv@hub-cloud.browserstack.com/wd/hub",
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

		email.send_keys 'ryanmmm03218r@pick.co'

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



