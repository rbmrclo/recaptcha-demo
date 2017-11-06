require 'rack'
require 'rack/server'
require 'net/http'
require 'uri'
require 'json'

SITE_VERIFY_URL          = 'https://www.google.com/recaptcha/api/siteverify'
SITE_SECRET              = '6LfeHx4UAAAAAFWXGh_xcL0B8vVcXnhn9q_SnQ1b'
RECAPTCHA_RESPONSE_PARAM = 'g-recaptcha-response'

class Handler
  attr_reader :request

  ROUTES = {
    "/"         => :root,
    "/feedback" => :feedback
  }

  def initialize(env)
    @env     = env
    @headers = { 'Content-Type' => 'text/html' }
    @action  = ROUTES[@env["PATH_INFO"]]
    @request = Rack::Request.new(@env)
  end

  def serve
    ROUTES.values.include?(@action) ? send(@action) : render_404
  end

  def root
    [200, @headers, [File.open('public/index.html', File::RDONLY).read % ""]]
  end

  def feedback
    captcha_response = @request.params[RECAPTCHA_RESPONSE_PARAM]

    uri       = URI.parse(SITE_VERIFY_URL)
    uri.query = URI.encode_www_form({ secret: SITE_SECRET, response: captcha_response })

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    response = http.get(uri.request_uri)
    json = JSON.parse(response.body)

    message = json["success"] ? "Thanks for the feedback!" : "There was an error"

    [200, @headers, [File.open('public/index.html', File::RDONLY).read % message]]
  end

  def render_404
    [404, @headers, File.open('public/404.html', File::RDONLY)]
  end
end

class App
  def self.call(env)
    Handler.new(env).serve
  end
end

Rack::Server.start :app => App
