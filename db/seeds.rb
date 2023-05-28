require 'uri'
require 'net/http'
require 'json'

api_key = '6369c64a'
imdb_ids = ['tt0068646', 'tt0118694', 'tt0433035', 'tt1077258', 'tt0082533', 'tt0090021', 'tt0052357', 'tt0060196', 'tt0091059','tt0026138', 'tt0089254','tt0070297' ]
# imdb_ids = ['tt0083658', 'tt0076786', 'tt16154056', 'tt0089218', 'tt0064116', 'tt0064116', 'tt0106308', 'tt0049223', 'tt0385004', 'tt0816692', 'tt0087332', 'tt0373074', 'tt0373074', 'tt3563338', 'tt9587390', 'tt0094625', 'tt16992456' ]

imdb_ids.each do |imdb_id|
  url = URI("http://www.omdbapi.com/?i=#{imdb_id}&apikey=#{api_key}&type=movie")
  http = Net::HTTP.new(url.host, url.port)
  request = Net::HTTP::Get.new(url)

  response = http.request(request)
  data = JSON.parse(response.body)

  if data['Response'] == 'True'
    Movie.create(
      title: data['Title'],
      overview: data['Plot'],
      poster_url: "http://img.omdbapi.com/?i=#{data['imdbID']}&h=600&apikey=#{api_key}",
      rating: rand(1.0..10.0).round(1)
    )
  else
    puts "Error: #{data['Error']}"
  end
end
