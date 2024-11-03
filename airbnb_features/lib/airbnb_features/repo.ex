defmodule AirbnbFeatures.Repo do
  use Ecto.Repo,
    otp_app: :airbnb_features,
    adapter: Ecto.Adapters.Postgres
end
