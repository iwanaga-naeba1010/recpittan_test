# frozen_string_literal: true

require 'google/apis/sheets_v4'

class Google::Spreadsheets
  def initialize
    @service = Google::Apis::SheetsV4::SheetsService.new
    @service.authorization = authorize
  end

  def authorize
    json_key = JSON.generate(
      private_key: "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC4Kz0qTFVbYui6\nJH+GKd+a/jKcrh8OZEp3HKb1bWNvIuIfpArBSsN5zQ6dHMNn8hb/3zvijM/vOiJW\noEirtZsFQN8ljKfzXZydz/Wou8I5vyqVzsF1CgUMf3m4GuTpBf5ZdnztwsKVTqsX\nIFTVnfNQgsXMed4Ke7L4his/HxtjcFXQ8/Rcx7wIbA94BPb9wmaOzfBR/E60jepk\nBtdt3R/yZU1B2YaS7k6DuXQ7dyhprfMii+qE6MdbhSxM8paMH/Zk4BUGFM0ar4eC\naEcMQyjTI1zn4bQnD+58OS5lC7+de/U19VLSXhMEmgxv69rcErbbcbkerz32YtzQ\nVbXEzVHFAgMBAAECggEAAS9Qn+eJ+MuZf8gEsr7+D2RJYrN8UOiSJOmyDpPjzOah\nvB520MIA1wsoFyGHF4/rJG88Dpzy3GyaMGPv7Ls5sOdWnPK6wEzckWeWwVhPL2OW\nnyuz2TZ2oaipqDd1+MqvwT6EXb6w4uvFkGBXCfnMT+NmgdK49UuofC3lNpNnUG6m\nE4NS0doUFi9ZhwVHgkMrveWXE7VB+swZd2GaV21nO6RIIJ2AiFKaofJ6AE1JumHV\n9QEDdnyX2rU7biFJT0l++XMGwivE54xBaMtTGyqS1zRgy9j+28W6ruXA8irxWDpQ\ndyFR4FAmiLLtWlrAC+qT8oi3TReqXD3YxlYBRWxJBwKBgQDySd+Jd4bhOZSZVfAZ\n6598tiwt8LXEeK4V2xGv6xYEf2B6nR8n7I2wwHyVCGAS2paxgZxyj4zt6tTOpqF4\nj/pfmKdkyAzPFe5F5+v+ZHH4Hz0SSJvMokaKEhk7JM6Clu8IEgrP6Oe/CSU8V+IK\nTRXZbt9K4nZirTcX0k6Lm7ODtwKBgQDCl10u8zdhLNlZ4dlAb66JAhi5M/9SgVfC\nGjI6E0gA0Wj6FlywfbAq8AtHnpkdKZr/7VRyA6xgKwIPKDegKJ7oj224573vRm4W\nlgzxc32hPWeExNIfXDT8TXB5miMbMnFBzP21SnotAwsBLclDevifdLkSC2be+YP9\n+jRVmf2uYwKBgQCbyWok/qjISnjEuyAd2oX67zuq8lo9kQcGYIyX24WVsL09Oafd\nyNk2LB4uyWrU1J4OVnNcqfaIx/S7RyMN3S20p/gB8itiQAysADqaoMUzMArZpbwf\nsLvAbXCxubHa/+eD/e3bzzqrd9rsWOmri/Mfko2andBXFF8XPw9n7t5XMwKBgGJN\nvVF+pTd+RL9XjT00LmQgnwTQ8+dmWENCoKUeIH3pTLMqoOC4XksSwWAJCyjkX91y\ns/p1SJu8nmmx04ghfUXXT4Ld7+H1HqBiZV+FDK5sKuOz2sLk/g+Hv45vA9U1gmnP\neUwgt+ANbX3G96oTcY58lRI8mFeEjd28jLvB85opAoGAOIncn1S7tcGqwo10AtNE\nYTQAGmwwTp/KyGE2dCh9BG2NsflLObYL6c1InGPFV3zWaJ8W6vC/8XSZn4FNkVb1\nSRS67QhptTnIJ1GzTtZ8ZElRo0c7sfWHX6yfAoZ8/WdepA4VljEIdaPIzlDG9MhP\nSk7BcYBfs2QpMuADFEBZiJ8=\n-----END PRIVATE KEY-----\n", # rubocop:disable Layout/LineLength
      client_email: '190051669742-compute@developer.gserviceaccount.com'
    )

    json_key_io = StringIO.new(json_key)

    authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io:,
      scope: ['https://www.googleapis.com/auth/spreadsheets']
    )
    authorizer.fetch_access_token!
    authorizer
  end

  def get_values(spreadsheet_id, ragne)
    @service.get_spreadsheet_values(spreadsheet_id, ragne)
  end
end
