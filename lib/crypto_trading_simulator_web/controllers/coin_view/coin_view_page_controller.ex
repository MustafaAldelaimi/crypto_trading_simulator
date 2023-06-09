defmodule CryptoTradingSimulatorWeb.CoinViewPageController do
  use CryptoTradingSimulatorWeb, :controller
  require Logger
  require HTTPoison
  require Poison
  import Ecto.Query

  # def index(conn, _params) do
  #   render(conn, :index)
  # end

  # def show(conn, %{"id" => id}) do
  #   user = Repo.get(User, id)
  #   render(conn, "show.html", user: user)
  # end


  def show(conn, %{"symbol" => symbol, "id" => id}) do
    response = HTTPoison.get!("https://min-api.cryptocompare.com/data/pricemultifull?fsyms=#{symbol}&tsyms=GBP")
    data = Poison.decode!(response.body)
    # IO.inspect(data)

    full_name_response = HTTPoison.get!("https://min-api.cryptocompare.com/data/all/coinlist")
    full_name_data = Poison.decode!(full_name_response.body)
    full_data = full_name_data["Data"][symbol]
    full_name = full_data["FullName"]
    image_url = "https://www.cryptocompare.com/#{full_data["ImageUrl"]}"
    description = full_data["Description"]

    buy_url = "/buy/#{id}/#{symbol}"
    sell_url = "/sell/#{id}/#{symbol}"
    back_url = "/home/#{id}"

    response = HTTPoison.get!("https://min-api.cryptocompare.com/data/v2/news/?lang=EN")
    news_data = Poison.decode!(response.body)["Data"]
    coin_news = Enum.filter(news_data, fn x ->
      categories = String.split(x["categories"], "|")
      Enum.any?(categories, &(&1 == symbol))
    end)

    render(conn, "show.html",
      coin_news: coin_news,
      back_url: back_url,
      buy_url: buy_url,
      sell_url: sell_url,
      description: description,
      image_url: image_url,
      full_name: full_name,
      data: data,
      user_id: id
    )
  end

end
