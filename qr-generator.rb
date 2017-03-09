require 'sinatra'
require 'barby'
require 'barby/barcode'
require 'barby/barcode/qr_code'
require 'barby/outputter/png_outputter'
require 'base64'
require 'chunky_png'
require 'rqrcode'

get '/' do
	@title = "Campaign URL & QRCode"
  erb :index, :layout => :layout
end

post '/generator' do
	@url = "#{params[:url]}/?utm_source=#{params[:source]}&utm_campaign=#{params[:medium]}&utm_medium=#{params[:name]}"
	erb :generator, :layout => :layout
end

# QR Code Generator Helper
def generate_qr(qrcode)
  generate_qr = Barby::QrCode.new(qrcode, level: :q)
  base64_output = Base64.encode64(generate_qr.to_png({ xdim: 5 }))
	"data:image/png;base64,#{base64_output}"
end
