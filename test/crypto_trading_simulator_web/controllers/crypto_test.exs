defmodule CryptoTradingSimulator.UserTest do
# alias Plug.Crypto
  alias CryptoTradingSimulator.User, as: User
  alias CryptoTradingSimulator.Crypto, as: Crypto
  alias CryptoTradingSimulator.Repo, as: Repo
#   use Ecto.Schema
    use ExUnit.Case

      setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Repo, { :shared, self() })
  end

  test "user has many cryptos" do
    user = %{name: "John", email: "[john@example.com](mailto:john@example.com)"} |> Repo.insert!()


    # crypto1 = %Crypto{coin: "BTC", symbol: "BTC", amount: 0.1, invested: 100.0} |> Repo.insert!()
    # crypto2 = %Crypto{coin: "ETH", symbol: "ETH", amount: 1.0, invested: 50.0} |> Repo.insert!()

    # IO.puts(user)

    # user = Repo.preload(user, :cryptos)

    # assert user.cryptos |> length() == 2
    # assert user.cryptos |> Enum.member?(crypto1)
    # assert user.cryptos |> Enum.member?(crypto2)
  end
end
